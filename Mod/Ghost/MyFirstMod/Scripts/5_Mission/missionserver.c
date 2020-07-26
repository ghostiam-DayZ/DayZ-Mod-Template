modded class MissionServer {
    void GLog(string msg) {
        Print("[Ghost_MissionServer] " + msg);
    }

    ref MissionServerPrinter p;
    void MissionServer() {
        GLog("Started");
        p = new MissionServerPrinter();
    }
};

class MissionServerPrinter {
    void GLog(string msg) {
        Print("[Ghost_MissionServerPrinter] " + msg);
    }

    ref Timer t;
    void MissionServerPrinter() {
        t = new Timer();
        t.Run(5.0, this, "On_Timer", NULL, true);
    }

    void On_Timer() {
        GLog("Hi from Game Server");
    }
}
