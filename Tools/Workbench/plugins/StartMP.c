[WorkbenchPluginAttribute("Start Local MP", "Launches the game and server, automatically connects", "alt+4", "", {"ResourceManager", "ScriptEditor"})]
class LaunchLocalMPModTool: DayZTool {
    string BatchFile;

    void LaunchLocalMPModTool() {
        BatchFile = GetWorkDriveDirectory() + "..\\StartMP.bat";
    }

    override void Run() {
        RunDayZBat(BatchFile, false);
    }
}