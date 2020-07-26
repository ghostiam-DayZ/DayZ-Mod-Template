[WorkbenchPluginAttribute("Build Mod", "Build the active loaded mod", "alt+1", "", {"ResourceManager", "ScriptEditor"})]
class DeployModTool: DayZTool {
    string BatchFile;

    void DeployModTool() {
        BatchFile = GetWorkDriveDirectory() + "..\\BuildMod.bat";
    }

    override void Run() {
        RunDayZBat(BatchFile, false);
    }
}