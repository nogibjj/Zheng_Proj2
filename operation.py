#!/usr/bin/env python3

from email.policy import default
import pandas as pd
import click

global df

# build a click group
@click.group()
def cli():
    """Operations available for the dataset"""


# build a click command
@cli.command()
@click.option(
    "--csv_file",
    default="",
    help="Print the info of the dataset",
)
def cli_info(csv_file):
    df = pd.read_csv(csv_file)
    """Show the whole data set"""
    print(df.info())


@cli.command()
@click.option(
    "--csv_file",
    help="Show n lines from the head of the dataset",
)
def cli_head(csv_file):
    df = pd.read_csv(csv_file)
    """Show n lines from the head of the dataset"""
    print(df.head())

@cli.command()
@click.option(
    "--csv_file",
    help="Show the sorted data set",
)
def cli_sort(csv_file):
    df = pd.read_csv(csv_file)
    """Show the sorted data set"""
    print(df.sort_index())

@cli.command()
@click.option(
    "--csv_file",
    help="Remove the zero values in the data set",
)
def cli_clean(csv_file):
    df = pd.read_csv(csv_file)
    """Remove the zero values in the data set"""
    new_df = df.dropna()
    print(new_df.info())
    

# run the CLI
if __name__ == "__main__":
    cli()

