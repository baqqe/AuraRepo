from dagster import AssetExecutionContext#, asset_group
from dagster_dbt import DbtCliResource, dbt_assets

from .project import AuraDbt_project


#@asset_group(group_name="AuraDbt_assets")
@dbt_assets(manifest=AuraDbt_project.manifest_path)
def AuraDbt_dbt_assets(context: AssetExecutionContext, dbt: DbtCliResource):
    yield from dbt.cli(["build"], context=context).stream()
    
