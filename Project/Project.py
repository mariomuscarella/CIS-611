# Project
# Building a Simple Query Optimizer with Performance Evaluation Experiment 
# on Query Rewrite Optimization

import Opt_Choose_Best_Plan as op

executionStepsQ1 = []
with open("InputQ1.txt", "r") as reader:

    for line in reader:
        #print "line: ", line
        temp = []
        for word in line.split():
            #print "Word: ", word
            if word == "->":
                continue

            temp.append(word)
        executionStepsQ1.append(temp)

executionStepsRQ1 = []
with open("InputRQ1.txt", "r") as reader:

    for line in reader:
        temp = []
        for word in line.split():
            if word == "->":
                continue

            temp.append(word)
        executionStepsRQ1.append(temp)


Q1 = op.Opt_Choose_Best_Plan(executionStepsQ1)
RQ1 = op.Opt_Choose_Best_Plan(executionStepsRQ1)


Q1time = int(Q1.QueryPlan.totalCost * 12 / 1000)
Q1Secs = Q1time % 60
Q1time/= 60
Q1Min = Q1time % 60
Q1hours = Q1time % 24


RQ1time = int(RQ1.QueryPlan.totalCost * 12 / 1000)
RQ1Secs = RQ1time % 60
RQ1time/= 60
RQ1Min = RQ1time % 60
RQ1hours = RQ1time % 24

iterator = 0
print "Q1"

with open("InputQ1.txt", "r") as reader:

    for line in reader:
        if "Join" in line:
            print line.rstrip('\n')
        else:
            print line.rstrip('\n')

print "\n\nTotal IO Cost: ", Q1.QueryPlan.totalCost
print "Total time in (hour:min:sec): ",Q1hours, ":",Q1Min, ":",Q1Secs

iterator = 0
print "\n\nRQ1"
with open("InputRQ1.txt", "r") as reader:

    for line in reader:
        if "Join" in line:
            print line.rstrip('\n'),"    ", RQ1.QueryPlan.steps[iterator]
            iterator += 1
        else:
            print line.rstrip('\n')

print "Total IO Cost: ", RQ1.QueryPlan.totalCost
print "Total time in (hour:min:sec): ",RQ1hours, ":",RQ1Min, ":",RQ1Secs

print "\n\nBest"
if Q1.QueryPlan.totalCost < RQ1.QueryPlan.totalCost:
    print "Q1"
    with open("InputQ1.txt", "r") as reader:

        for line in reader:
            if "Join" in line:
                print line.rstrip('\n')
            else:
                print line.rstrip('\n')

    print "\n\nTotal IO Cost: ", Q1.QueryPlan.totalCost
    print "Total time in (hour:min:sec): ",Q1hours, ":",Q1Min, ":",Q1Secs

else:
    iterator = 0
    print "\n\nRQ1"
    with open("InputRQ1.txt", "r") as reader:

        for line in reader:
            if "Join" in line:
                print line.rstrip('\n'),"    ", RQ1.QueryPlan.steps[iterator]
                iterator += 1
            else:
                print line.rstrip('\n')

    print "Total IO Cost: ", RQ1.QueryPlan.totalCost
    print "Total time in (hour:min:sec): ",RQ1hours, ":",RQ1Min, ":",RQ1Secs
