#!/bin/bash
#
# Author : Sharad Kumar Chhetri
# Date Of Creation : 1-Nov-2014
# Version  : 1.0
# Description : It checks the no. of instances available in ELB . When the instances count do not matches as per desire value it will send alert.
# Blog : http://sharadchhetri.com
# 

### Supportive URL : http://docs.aws.amazon.com/AWSSimpleQueueService/latest/SQSGettingStartedGuide/AWSCredentials.html ###

export AWS_ACCESS_KEY_ID="XXXXXXXXXXXXXXXXXXX"
export AWS_SECRET_ACCESS_KEY="YYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYYY"

#### For getting Region infromation,Reference URL: http://docs.aws.amazon.com/general/latest/gr/rande.html

REGION=us-west-1

## In ELB_NAME - Provide name of ELB

ELB_NAME=ProductionELB

## In INSTANCE_COUNT give the value of desired number of Instances should be in ELB

INSTANCE_COUNT=4

## The ELB_INSTANCE_COUNT gives output of no. of  instances attached in ELB
ELB_INSTANCE_COUNT=$(aws --region $REGION elb describe-load-balancers --load-balancer-names $ELB_NAME --output text|grep INSTANCES|wc -l)


if [ "$ELB_INSTANCE_COUNT" == "$INSTANCE_COUNT" ]
then
echo "OK: Total no. of instances $ELB_INSTANCE_COUNT found in ELB $ELB_NAME"
exit 0
else
if [ "$ELB_INSTANCE_COUNT" != "$INSTANCE_COUNT" ]
then
echo "CRIT: Number of instances in ELB $ELB_NAME do not matches with desired value"
exit 2
fi
fi

