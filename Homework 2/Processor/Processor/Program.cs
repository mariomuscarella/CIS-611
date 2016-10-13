/**
  *    -----Name: Mario Muscarella
  *    -----ID: 2478702
  *    -----Description : Lab 2: Simulating a Simple Query Processor that evaluates
  *                              a SQL Query in Select-From-Where
**/

using System;
using System.Collections.Generic;
using System.Data;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Processor
{
    class Program
    {
        static void Main(string[] args)
        {
            // Adding table's data into table.
            string path =
            Directory.GetParent(Directory.GetCurrentDirectory()).Parent.FullName;
            string filepath_EMPLOYEE = path + @"\CSV\Employee.csv";
            DataTable EMPLOYEE = CSVtoDataTable(filepath_EMPLOYEE);
            string filepath_DEPARTMENT = path + @"\CSV\Department.csv";
            DataTable DEPARTMENT = CSVtoDataTable(filepath_DEPARTMENT);

            // variables for Selection Step
            string selection_tablename;
            string selection_column_name;
            string selection_final_table;
            DataTable step1table = new DataTable();
            //string selection_oprator;
            string selection_number;

            // variable for Join Step
            string join_table2, join_col1, join_col2, join_final_table;
            DataTable step2table = new DataTable();

            // variable for Projection Step
            string[] projection = new string[10];
            int j = 0;

            //Reading Input file.
            string line;
            string[] lines = new string[3];
            StreamReader sr = new StreamReader(path + @"\Input.txt");
            while ((line = sr.ReadLine()) != null)
            {
                string[] words = line.Split(' ');
                for (int i = 0; i < words.Length; i++)
                {
                    //Reading file based on input and specific keyword
                    //Step1: Selection In which at end we have a result

                    if (words[i] == "Selection")
                    {
                        i++;
                        selection_tablename = words[i];
                        i++;
                        selection_column_name = words[i];
                        i++;
                        i++;
                        selection_number = words[i];
                        i++;
                        selection_final_table = words[i];
                        DataTable table = new
                DataTable(selection_final_table.ToString());
                        string emp = "EMPLOYEE";
                        string dep = "DEPARTMENT";
                        if (selection_tablename == emp)
                            table = selection(EMPLOYEE, selection_column_name,
                        selection_number);
                        else if (selection_tablename == dep)
                            table = selection(DEPARTMENT, selection_column_name, selection_number);
                        step1table = table.Copy();
                        Console.WriteLine("//After execution of step 1");
                        ShowTable(step1table); //
                        break;

                    }
                    if (words[i] == "Join")
                    {
                        i++;
                        i++;
                        join_table2 = words[i];
                        i++;
                        join_col1 = words[i];
                        i++;
                        i++;
                        join_col2 = words[i];
                        i++;
                        join_final_table = words[i];
                        step2table = new DataTable(join_final_table.ToString());
                        string dep = "DEPARTMENT";

                        if (join_table2 == dep)
                            step2table = MergeTables(step1table, DEPARTMENT, "DNO");
                        Console.WriteLine("//After execution of step 2");
                        ShowTable(step2table);
                        break;
                    }
                    if (words[i] == "Projection")
                    {
                        i++; i++;
                        projection[j] = words[i];
                        j++; i++;
                        projection[j] = words[i];
                        j++; i++;
                        projection[j] = words[i];
                        j++; i++;
                        projection[j] = words[i];
                        j++; i++;
                        projection[j] = words[i];
                        j++; i++;
                        DataTable table = new DataTable(words[i]);
                        table = projection_final(step2table, projection);
                        Console.WriteLine("//After execution of step 3");
                        ShowTable(table);
                    }
                }
            }
        }

        /**   MethodName  : projection_final
              Description : Return table depending on projection
              Input       : Table name
              Output      : Table with specific column names
          */
        private static DataTable projection_final(DataTable tb, string[] selected_column)
        {
            DataTable temp_table = new DataTable();
            temp_table = tb.Copy();
            int flag = 1;
            foreach (DataColumn c in tb.Columns)
            {
                for (int i = 0; i < selected_column.Length; i++)
                {
                    if (c.ColumnName == selected_column[i])
                    {
                        flag = 1;
                        break;
                    }
                    else
                        flag = 0;
                }
                if (flag == 0)
                {
                    temp_table.Columns.Remove(c.ColumnName);
                }
            }
            return temp_table;
        }

        /**  MethodName  : MergeTables
             Description : Return table depending two tabe join
             Input       : Table names and column name
             Output      : Whole table with all data
         */
        private static DataTable MergeTables(DataTable dtFirst, DataTable dtSecond, string CommonColumn)
        {
            DataTable dtResults = dtFirst.Clone();
            int count = 0;
            for (int i = 0; i < dtSecond.Columns.Count; i++)
            {
                if (!dtFirst.Columns.Contains(dtSecond.Columns[i].ColumnName))
                {
                    dtResults.Columns.Add(dtSecond.Columns[i].ColumnName, dtSecond.Columns[i].DataType);
                    count++;
                }
            }

            DataColumn[] columns = new DataColumn[count];
            int j = 0;
            for (int i = 0; i < dtSecond.Columns.Count; i++)
            {
                if (!dtFirst.Columns.Contains(dtSecond.Columns[i].ColumnName))
                {
                    columns[j++] = new DataColumn(dtSecond.Columns[i].ColumnName, dtSecond.Columns[i].DataType);
                }
            }

            dtResults.BeginLoadData();
            foreach (DataRow dr in dtFirst.Rows)
            {
                dtResults.Rows.Add(dr.ItemArray);
            }
            foreach (DataRow dr in dtSecond.Rows)
            {
                foreach (DataRow dr1 in dtResults.Rows)
                {
                    if (dr1[CommonColumn].ToString().Equals(dr[CommonColumn].ToString()))
                    {
                        foreach (DataColumn c in columns)
                        {
                            dr1[c.ColumnName] = dr[c.ColumnName];
                        }
                    }
                }
            }
            dtResults.EndLoadData();
            return dtResults;
        }

        /**   MethodName  : selection
              Description : Return table depending on table name, column name 	and number
              Input       : Table names, column name and number
              Output      : Table which are on specific condition
          */
        private static DataTable selection(DataTable tablename, string column_name, string number)
        {
            Console.WriteLine("//Displaying Data from table at beginning");
            int x_row = 0;
            string[] temp_row = new string[10];
            DataTable temp_table = new DataTable();
            //DataColumn column = new DataColumn;
            //DataRow row;
            foreach (DataColumn c in tablename.Columns)
            {
                temp_table.Columns.Add(c.ToString());
                Console.Write("{0,-14}", c.ColumnName);
            }
            Console.WriteLine();

            foreach (DataRow r in tablename.Rows)
            {
                int flag = 0;
                x_row = 0;
                foreach (DataColumn c in tablename.Columns)
                {
                    temp_row[x_row] = r[c].ToString();
                    Console.Write("{0,-14}", r[c]);
                    x_row++;
                    if (c.ColumnName == column_name)
                    {
                        if (r[c].ToString() == number)
                        {
                            flag++;
                        }
                    }
                }
                if (flag >= 1)
                {
                    temp_table.ImportRow(r);
                }
                Console.WriteLine();
            }
            return temp_table;

        }

        /**   MethodName  : CSVtoDataTable
              Description : Return table and converts csv file to C#
              Input       : CSV file path
              Output      : Returns C# Datateble
          */
        private static DataTable CSVtoDataTable(string filepath)
        {
            StreamReader sr = new StreamReader(filepath);
            string[] headers = sr.ReadLine().Split(',');
            DataTable dt = new DataTable();
            foreach (string header in headers)
            {
                dt.Columns.Add(header);
            }
            while (!sr.EndOfStream)
            {
                string[] rows = sr.ReadLine().Split(',');
                DataRow dr = dt.NewRow();
                for (int i = 0; i < headers.Length; i++)
                {
                    dr[i] = rows[i];
                }
                dt.Rows.Add(dr);
            }
            return dt;
        }

        /**   MethodName  : ShowTable
              Description : Print table in output
              Input       : Data Table
              Output      : Shows table
          */
        private static void ShowTable(DataTable table)
        {

            //Console.WriteLine();
            Console.WriteLine("-----------------------------------------------------------------------------------------------------");
            foreach (DataColumn col in table.Columns)
            {
                Console.Write("{0,-14}", col.ColumnName);
            }
            Console.WriteLine();

            foreach (DataRow row in table.Rows)
            {
                foreach (DataColumn col in table.Columns)
                {
                    Console.Write("{0,-14}", row[col]);
                }
                Console.WriteLine();
            }
            Console.WriteLine();
        }
        private static void ToPrintConsole(DataTable dataTable)
        {
            // Print top line
            Console.WriteLine(new string('-', 75));

            // Print col headers
            var colHeaders = dataTable.Columns.Cast<DataColumn>().Select(arg => arg.ColumnName);
            foreach (String s in colHeaders)
            {
                Console.Write("| {0,-20}", s);
            }
            Console.WriteLine();

            // Print line below col headers
            Console.WriteLine(new string('-', 75));

            // Print rows
            foreach (DataRow row in dataTable.Rows)
            {
                foreach (Object o in row.ItemArray)
                {
                    Console.Write("| {0,-20}", o.ToString());
                }
                Console.WriteLine();
            }

            // Print bottom line
            Console.WriteLine(new string('-', 75));
        }

    }
}
