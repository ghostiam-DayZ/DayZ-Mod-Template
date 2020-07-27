[WorkbenchPluginAttribute("Format Code", "Format Code", "shift+alt+f", "", {"ResourceManager", "ScriptEditor"})]
class FormatCodeTool: DayZTool {
    string BatchFile;
    void FormatCodeTool() {
        BatchFile = GetWorkDriveDirectory() + "..\\FormatCode.bat";
    }

    override void Run() {
        RunDayZBat(BatchFile, true);
    }
}