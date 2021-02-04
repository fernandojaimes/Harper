import boto3
import texttable as tt
from classes.instance import Instance

def get_instance_data(instances_list):
    vms_info = []

    for instance in instances_list:
        name = instance['Instances'][0]['Tags'][0]['Value']
        identifier = instance['Instances'][0]['InstanceId']
        state = instance['Instances'][0]['State']['Name']
        public_dns = instance['Instances'][0]['PublicDnsName']
        vms_info.append(Instance(name, identifier, state, public_dns))
    return vms_info

def get_values(instances_list, key):
    values = []
    for instance in instances_list:
        values.append(getattr(instance, key))
    return values

def generate_table(instances_list): 
    tab = tt.Texttable()
    headings = ["Name", "State", "Public DNS", "Instance ID"]
    tab.header(headings)

    names = get_values(instances_list, "name")
    identifiers = get_values(instances_list, "identifier")
    states = get_values(instances_list, "state")
    public_dns_list = get_values(instances_list, "public_dns")
    
    for row in zip(names, identifiers, public_dns_list, states):
        tab.add_row(row)

    s = tab.draw()
    print(s)

def main():
    ec2_client = boto3.client('ec2')
    instances_information = ec2_client.describe_instances()
    instances_list = get_instance_data(instances_information['Reservations'])
    generate_table(instances_list)

if __name__ == "__main__":
    main()
