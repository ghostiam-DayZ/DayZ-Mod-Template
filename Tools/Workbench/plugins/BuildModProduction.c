[WorkbenchPluginAttribute("Build Mod For Prod", "Build the active loaded mod", "alt+shift+1", "", {"ResourceManager", "ScriptEditor"})]
class DeployProdModTool: DayZTool {
    string BatchFile;

    void DeployProdModTool() {
        BatchFile = GetWorkDriveDirectory() + "..\\BuildModProduction.bat";
    }

    override void Run() {
        RunDayZBat(BatchFile, false);
    }
}