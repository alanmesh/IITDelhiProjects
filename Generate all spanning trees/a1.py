from unionfind import *
from pprint import pprint
import operator



def setup():
    #Get information from file
    theFile = open('new1.txt')
    rawData = theFile.read()
    theFile.close()
    
    #Split data string into list
    rawData = rawData.split('\n')
    rawData = filter(bool,rawData)
    
    cities = list()

    #Create and return sorted data in list
    data = list()
    for line in rawData:
        item = list()
        temp = line.split()
        item.extend([temp[0],temp[1],int(temp[2])])
        cities.extend([temp[0],temp[1]])
        data.append(item)

    return sorted(data, key=operator.itemgetter(2)),sorted(set(cities))

# Method to perform Kruskal's Algorithm    
def krus(data,cities):
    d1=data[:]
    d1=sorted(d1, key=operator.itemgetter(2))
    c1=cities[:]
    distance = 0
    mstList=list()

    result = list()
    c1 = init(c1)
    for edge in range(len(d1)):
        path = d1.pop(0)
        #If the two cities in the path do not have the same
        #canonical representative, join them together, then 
        #add path to result and calculate distance
        if find(c1,path[0]) != find(c1,path[1]):
            union(c1, path[0],path[1])
            mstList.append((path[0],path[1]))
            result.extend((path[0] + ' -> ' + path[1], '(' + str(path[2]) + ' miles)'))
            distance += path[2]
    return distance,mstList

data,cities = setup()
dCopy=data[:]

#pprint(cities)
distance,msL = krus(data,cities)
k = input("Enter k")

def setLow(listToZero, x,y):
	cop=listToZero[:]
	for i in range(0,len(listToZero)):
		
		t1,t2,t3=listToZero[i]
		if t1==x and t2==y or t2==x and t1==y:

			cop[i]=(t1,t2,0)
			break
	return cop

def setHigh(listToZero, x,y):
	cop=listToZero[:]
	for i in range(0,len(listToZero)):
		
		t1,t2,t3=listToZero[i]
		if t1==x and t2==y or t2==x and t1==y:

			cop[i]=(t1,t2,999)
			break
	return cop

print("Cost of minimum spanning tree: " + str(distance))
#dList=list();
#pprint(sorted(msL, key=operator.itemgetter(0)))

def getEdgeCost(data,x,y):
    cost=0
    for i in range(0,len(data)):
        t1,t2,c1= data[i]    
        if t1==x and t2==y or t2==x and t1==y:
            cost=c1
            break
    return cost
def getRealCost(data,mst):
    cost=0
    for i in range(0,len(mst)):
        x,y=mst[i]
        cost+=getEdgeCost(data,x,y)
    return cost



# Procedure for partition

def getNextPartition(mSet,dataSet):
    minCost=9999

    toRet=list()
    part=list()
    aList=list() #list of all the partiotion
          
    for i in range(len(mSet)-1,-1,-1):
        
        tList=dataSet[:]
        p,q= mSet[i]
        
        tList= setHigh(tList,p,q)
        for j in range(0,i):


            t1,t2=msL[j]
            tList=setLow(tList,t1,t2)
        #pprint(tList)   
       
        #tList=sorted(tList, key=operator.itemgetter(2))     
        tCopy=tList[:]
        dist,msl=krus(tCopy,cities)
        #pprint(msl)
        if(dist>=999):
            continue
       # pprint(dist)
        aList.append(tList)
    return aList

    



#t=getNextPartition(msL,dCopy)


def returnMinCostTFromP(partitionList):
	temp=partitionList[:]
	minCost=9999
	minTree=list()
	index=-1
	for i in range(0,len(temp)):
		costOfTree,msTree=krus(temp[i],cities)
		if costOfTree>999:
			print("max cost reached")
			temp.pop(i)
			partitionList.pop(i)
		if costOfTree<=minCost:
			minCost=costOfTree
			minTree=msTree[:]	
			index=i
	return index,minCost,minTree
newSet=set([])
gset=set([])

def searchTinList(tList,T):
	tsorted=sorted(T, key=operator.itemgetter(0))
	g=False
	for i in range (0,len(tList)):
		curT=sorted(tList[i], key=operator.itemgetter(0))
		if set(curT)==set(tsorted):
			g=True 

	return g

def updatePartition(partitionList):
	i=0
	exp=list()
	costarr=list()
	treeList=list()
	while len(partitionList)>0:
		#print ("i is "+ str(i))
		ind,minC,mTree=returnMinCostTFromP(partitionList)
		(a,b)=minC,getRealCost(data,mTree)
		t=(a,b)
		if searchTinList(treeList,mTree)==False:
			x=(b,sorted(mTree, key=operator.itemgetter(0)))
			exp.append(x)
			
			costarr.append(b)
			mCopy=mTree[:]


			treeList.append(mTree)
			

		newSet.add(t)
		
		#print(ind)
			

		#pprint(str(minC)+" "+str(getRealCost(data,mTree)))
		#pprint(len(partitionList))
		#print (getRealCost(data,mTree))
		partitonToExpand=partitionList.pop(ind)
		partitionList.extend(getNextPartition(mTree,partitonToExpand))

	return (sorted(exp, key=operator.itemgetter(0)))
	
	#for i in range (0,len(treeList)):
	#	pprint(sorted(treeList[i], key=operator.itemgetter(0)))
	#	pprint(costarr[i])
	
	

	


fpList=getNextPartition(msL,dCopy)


#pprint(fpList) #dlist after first partition
fin=updatePartition(fpList)

print(str(k)+"th min spanning tree is: ")
pprint(fin[k])
pprint("All the spanning trees are")
pprint(fin)


