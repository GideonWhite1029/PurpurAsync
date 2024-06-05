# Configuration Files

PurpurAsync does not have its own separate configuration file, so all settings are contained in the `purpur.yml` file. (In the future, there may be a separate config file if it gets too big)

### `purpur.yml`

```yaml
purpurasync:
    use-virtual-thread-for-async-scheduler: false # Use virtual threads for Asynchronous Scheduler
    asyncpathfinding:
      enabled: false # Enable asynchronous pathfinding for mobs
      max-threads: 0 # Number of threads used (Recommended - 5)
      keepalive: 60 # Time to maintain activity (in ticks)
```

### `sparklypaper.yml`

```yaml
parallel-world-ticking:
  threads: 8 # Number of threads for parallel world operation (Default - 8)
```
