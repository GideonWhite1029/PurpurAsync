## PurpurAsync

### PurpurAsync is a Purpur fork aimed at asynchronous behavior and multithreading with the ability to run all Bukkit plugins
## Features
- **Async Pathfinding**
- **Support Virtual-Thread**
- **Parallel World Ticking** (by [SparklyPaper](https://github.com/SparklyPower/SparklyPaper/blob/ver/1.20.4/patches/server/0018-Parallel-world-ticking.patch))

> [!WARNING]
> Before using this kernel, familiarize yourself with all the bugs introduced by changing the parallelism of worlds - [link](https://gideonwhite1029.github.io/PurpurAsync/parallel-world-ticking.html)

## Build
To build a paperclip jar, you need to run the following command. You can find the jar in build/libs(Note: JDK17 or JDK21 is needed)

 ```shell
 ./gradlew applyPatches && ./gradlew createReobfPaperclipJar
```
## About Issue
When you meet any problems, just ask us, we will do our best to solve it, but remember to state your problem clear and provide enough logs etc.
## Contributing
This readme will eventually contain instructions regarding the patch system. For now, visit PurpurAsync's [CONTRIBUTING.md](https://gideonwhite1029.github.io/PurpurAsync/contributing.html).
## Thank you
Thanks to these projects below. PurpurAsync just mix some of their patches together.

- [Leaf](https://github.com/Winds-Studio/Leaf)
- [Gale](https://github.com/GaleMC/Gale)
- [Purpur](https://github.com/PurpurMC/Purpur)
- [Pufferfish](https://github.com/pufferfish-gg/Pufferfish)
- [SparklyPaper](https://github.com/SparklyPower/SparklyPaper)
- [Kaiiju](https://github.com/KaiijuMC/Kaiiju)
- [Leaves](https://github.com/LeavesMC/Leaves)
