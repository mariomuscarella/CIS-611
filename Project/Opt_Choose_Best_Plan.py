import math

class Opt_Choose_Best_Plan:

    def __init__(self, steps):
        self.executionSteps = steps
        self.QueryPlan = QueryExecution()
        self.tables = [table('t1',1000,204, 20), table('t2', 500,102,20), table('t3',2000,40,100)]
        self.correlated = False

        for step in steps:
            for i, part in enumerate(step):
                if part == "Correlated":
                    self.correlated= True
                if part == "Join":
                    if self.correlated:
                        self.QueryPlan.addCost(self.QueryPlan.totalCost * self.TNJ(step[i+1], step[i+2], step[i+3],step[i+4]))


                    else:
                        AllJoinOptions = self.testAllJoins( step[i+1] , step[i+2])
                        minVal = min(AllJoinOptions, key=AllJoinOptions.get)
                        self.QueryPlan.addExecutionStep(minVal)
                        self.QueryPlan.addCost(AllJoinOptions[minVal])
                        selectivity = float(step[len(step)-2])

                        NewTableName = step[len(step)-1]
                        NewTableSize = self.getTableSize(step[1]) * self.getTableSize(step[2]) * selectivity
                        self.tables.append(table(NewTableName, NewTableSize, None, None))
                        if minVal == "SMJL" or minVal == "SMJM":
                            self.changeSorted(NewTableName)
                elif part == "project":
                    self.QueryPlan.addCost(self.projection(step[i+1], step[i+2]))
                elif part == "GroupBy" or part == "Aggregate":
                    self.QueryPlan.addCost(self.Grouper(step))

    def changeSorted(self, tableToChange):
        for table in self.tables:
            if table.name == tableToChange:
                table.sorted == True

    def getSorted(self, tableToCheck):
        for table in self.tables:
            if table.name == tableToCheck:
                return table.sorted


    def Grouper(self, listSteps):
        if 'without' in listSteps:
            return self.getTableSize(self.tables[len(self.tables)-1].name)
        else:
            size = self.getTableSize(listSteps[1])
            self.tables.append(table(listSteps[len(listSteps)-1], size * float(listSteps[len(listSteps)-2]), None, None))
            if not listSteps[3] == "None":
                return 2*(self.getTableSize(listSteps[1])+self.getTableSize(listSteps[3]))
            else:
                return 2*(self.getTableSize(listSteps[1]))

    def getTableSize(self,tableName):
        for table in self.tables:
            if table.name == tableName:
                return table.tableSize

    def projection(self,CurrTable, newTable):
        tableSize = float(self.getTableSize(CurrTable))
        newTableSize = tableSize
        tempTable = table(newTable, newTableSize, None, None)
        self.tables.append(tempTable)
        if not self.getSorted(CurrTable):
            return 3*tableSize + math.log10(tableSize)
        else:
            return 2*tableSize

    def testAllJoins(self, table1, table2):
        Costs = {}
        Costs['PNL']  = self.PNL( table1, table2)
        Costs['BNJM'] = self.BNJM(table1, table2)
        Costs['SMJM'] = self.SMJM(table1, table2)
        Costs['HJM']  = self.HJM(table1, table2)
        Costs['HJL']  = self.HJL(table1, table2)
        Costs['BNJL'] = self.BNJL(table1, table2)
        Costs['SMJL'] = self.SMJL(table1, table2)
        return Costs

    def TNJ(self, left, right, selectivity, newTableName):
        for table1 in self.tables:
            if left == table1.name:
                left = table1
            if right == table1.name:
                right = table1

        newTupleSize = left.tupleSize + right.tupleSize
        NewTableSize = float(selectivity) * left.tableSize * right.tableSize * (newTupleSize/4096.0)
        self.tables.append(table(newTableName, NewTableSize, (4096/newTupleSize), newTupleSize))


        return left.tableSize + (left.numTuples*left.tableSize)*right.tableSize

    def PNL(self, temp1, temp2):
        costLeft = self.getTableSize(temp1)
        costRight = self.getTableSize(temp2)
        return min((costLeft + costLeft*costRight), (costRight + costRight*costLeft))

    def BNJM(self, temp1, temp2):
        buffer = 50
        costLeft = self.getTableSize(temp1)
        costRight = self.getTableSize(temp2)
        return min((costLeft + (costLeft/buffer)*costRight), (costRight + (costRight/buffer)*costLeft))

    def SMJM(self, temp1, temp2):
        buffer = 50
        costLeft = self.getTableSize(temp1)
        costRight = self.getTableSize(temp2)
        return 3*(costLeft + costRight)

    def HJM(self, temp1, temp2):
        buffer = 50
        costLeft = self.getTableSize(temp1)
        costRight = self.getTableSize(temp2)
        return 3*(costLeft + costRight)

    def HJL(self, temp1, temp2):
        buffer = 50
        costLeft = self.getTableSize(temp1)
        costRight = self.getTableSize(temp2)
        return 2*3*(costLeft + costRight)

    def BNJL(self, temp1, temp2):

        buffer = 30
        costLeft = self.getTableSize(temp1)
        costRight = self.getTableSize(temp2)

        return min((costLeft + (costLeft/buffer)*costRight), (costRight + (costRight/buffer)*costLeft))

    def SMJL(self, temp1, temp2):

        buffer = 30
        costLeft = self.getTableSize(temp1)
        costRight = self.getTableSize(temp2)
        return 3*(costLeft + costRight)

class table:
    def __init__(self,name, size, numTuples, tupeSize):
        self.pageSize = 4096
        self.blockSize = 100
        self.tableSize = size
        self.name = name
        self.sorted = False
        self.numTuples = numTuples
        self.tupleSize = tupeSize


class QueryExecution:
    def __init__(self):
        self.totalCost = 1
        self.steps = []

    def addCost(self, cost):
        self.totalCost += cost

    def addExecutionStep(self, step):
        self.steps.append(step)
