from buildUT3Mod import *

buildUT3mod(os.getenv("UT3PATH"), "ClientScripts", ["src\\shared", "src\\ut3"], ["UnrealUtilityLib", "SpaceGameCoreLib"], [])
