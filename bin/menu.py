#!/usr/bin/python3

import click

@click.command()
@click.argument('argument')
def menu(argument):
    if ('start' == argument):
        click.echo('Exec docker start')
    elif ('stop' == argument): 
        click.echo('Exec docker stop')
    elif ('ls' == argument): 
        click.echo('Execute get instances script')
    else:
        click.echo("Just nothing")

if __name__ == '__main__':
    menu()
    
