class CfgPatches {
    class Ghost_MyFirstMod {
        units[] = {};
        weapons[] = {};
        requiredVersion = 0.1;
        requiredAddons[] = {
            "DZ_Data"
        };
    };
};

class CfgMods {
    class Ghost_MyFirstMod {
        dir = "Ghost/MyFirstMod";
        picture = "";
        action = "";
        hideName = 0;
        hidePicture = 1;
        name = "MyFirstMod";
        credits = "GhostIAm";
        author = "GhostIAm";
        authorID = "76561197993153055";
        version = "0.0.0";
        extra = 0;
        type = "mod";

        dependencies[] = {
            "Game",
            "World",
            "Mission"
        };

        class defs {
            class missionScriptModule {
                value = "";
                files[] = {
                    "Ghost/MyFirstMod/Scripts/5_Mission"
                };
            };
        };
    };
};
