#!/usr/bin/python3

import click
import os
import time

def start_container():
    os.system('docker start harper-cli > /dev/null')

    iterable = range(128)

    fill_char = click.style("#", fg="green")
    empty_char = click.style("-", fg="white", dim=True)
    label_text = "Starting container.."

    with click.progressbar(
            iterable=iterable,
            label=label_text,
            fill_char=fill_char,
            empty_char=empty_char
        ) as items:
        for item in items:
            time.sleep(0.023) # This is really hard work
    click.echo(
        "Harper is " +
        click.style("running.", fg="green") 
    )

def stop_container():
    os.system('docker stop harper-cli > /dev/null')

    iterable = range(128)

    fill_char = click.style("#", fg="green")
    empty_char = click.style("-", fg="white", dim=True)
    label_text = "Stopping container.."

    with click.progressbar(
            iterable=iterable,
            label=label_text,
            fill_char=fill_char,
            empty_char=empty_char
        ) as items:
        for item in items:
            time.sleep(0.023) # This is really hard work
    click.echo(
        "Harper is " +
        click.style("stopped.", fg="red") 
    )


@click.command()
@click.argument('argument')
def menu(argument):
    if ('start' == argument):
        start_container()
    elif ('stop' == argument): 
        stop_container()
    elif ('ls' == argument): 
        os.system('docker exec harper-cli bash -c "cd bin; python3 get-instances.py"')
    else:
        click.echo("Just nothing")

if __name__ == '__main__':
    menu()
    
