modded class MissionGameplay {
    void GLog(string msg) {
        Print("[Ghost_MissionGameplay] " + msg);
    }

    ref MissionGameplayPrinter p;
    void MissionGameplay() {
        GLog("Started");
        p = new MissionGameplayPrinter();
    }
};

class MissionGameplayPrinter {
    void GLog(string msg) {
        Print("[Ghost_MissionGameplayPrinter] " + msg);
    }

    ref Timer t;
    void MissionGameplayPrinter() {
        t = new Timer();
        t.Run(5.0, this, "On_Timer", NULL, true);
    }

    void On_Timer() {
        GLog("Hi from Game");
    }
}
