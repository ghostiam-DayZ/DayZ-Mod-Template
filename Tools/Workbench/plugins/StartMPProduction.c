[WorkbenchPluginAttribute("Start Local MP Like Prod", "Launches the game and server, automatically connects", "alt+shift+4", "", {"ResourceManager", "ScriptEditor"})]
class LaunchLocalMPProdModTool: DayZTool {
    string BatchFile;

    void LaunchLocalMPProdModTool() {
        BatchFile = GetWorkDriveDirectory() + "..\\StartMPProduction.bat";
    }

    override void Run() {
        RunDayZBat(BatchFile, false);
    }
}