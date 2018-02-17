

[ -x ~/.ssh/id_rsa ] && echo id_rsa exists already && exit 1

read -p "Enter Clustername: " CLUSTER_NAME

ssh-keygen -t rsa -b 4096 -C "bootstrap@${CLUSTER_NAME}" \
   && eval $(ssh-agent -s) \
   && ssh-add ~/.ssh/id_rsa \
   && echo "add following string to all machines you want to reach via ssh:" \
   && cat ~/.ssh/id_rsa.pub
