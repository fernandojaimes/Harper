class Instance:
    def __init__(self, name, state, identifier, public_dns):
        self.name = name
        self.state = state
        self.identifier = identifier
        self.public_dns = public_dns
    
    def get_name(self):
        return self.name

    def get_state(self):
        return self.state

    def get_identifier(self):
        return self.identifier

    def get_public_dns(self):
        return self.public_dns

    def print_data(self):
        print("""
                Name: {}
                State: {}
                Identifier: {}
                Public DNS: {}
              """.format(self.name, self.state, self.identifier, self.public_dns))
