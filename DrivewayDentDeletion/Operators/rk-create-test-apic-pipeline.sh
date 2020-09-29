export NAMESPACE=cp4i
oc project $NAMESPACE
export BRANCH=main
export FORKED_REPO=https://github.com/rkatikal/cp4i-deployment-samples.git
./cicd-apply-test-apic-pipeline.sh -n $NAMESPACE -r $FORKED_REPO -b $BRANCH

