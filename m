From: Pankaj Vinadrao Joshi <Pankaj.VJ@exaleapsemi.com>
Date: Fri, 17 Apr 2020 08:25:19 +0000
Subject: [LTP] CPU scheduler tweaking
In-Reply-To: <MAXPR0101MB146818D05980CCA8D2162996EED90@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB146818D05980CCA8D2162996EED90@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <MAXPR0101MB14682145A869C861F69F90B3EED90@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,
I have tried to tweak the kernel scheduler by changing the runtime kernel scheduling sysctl parameter like granularity,latency and i am setting cpu affinity to  CPU 1.
I am using perf tool for monitoring the scheduler the different scheduler parameters like runtime,avg-delay.

i have set,

kernel.sched_autogroup_enabled = 1
kernel.sched_cfs_bandwidth_slice_us = 5000
kernel.sched_child_runs_first = 0
kernel.sched_latency_ns = 2000000
kernel.sched_migration_cost_ns = 500000
kernel.sched_min_granularity_ns = 4000000
kernel.sched_nr_migrate = 32
kernel.sched_rr_timeslice_ms = 100
kernel.sched_rt_period_us = 1000000
kernel.sched_rt_runtime_us = 950000
kernel.sched_schedstats = 0
kernel.sched_tunable_scaling = 1
kernel.sched_util_clamp_max = 1024
kernel.sched_util_clamp_min = 1024
kernel.sched_wakeup_granularity_ns = 10000000


I have few concerns about scheduler tweaking

1) After tweaking kernel scheduler at which parameter where i should look for so that i can decide my CPU scheduler is performing good or bad???

2) i am setting cpu affinty to cpu 1 but i am able to see some migration when my application is running, i am giving following commands

$sudo perf sched record ./thread-workload-benchmark accum 1 unrollaccum8 1
here,thread-work-benchmark is my app and accum 1 is the cpu 1 on which i am spawning workload

$ sudo perf sched latency -s max

940828.125071 [0001]   s     thread-workload[7386]               0.011      0.000    587.990      R  next: kworker/1:1[25382]
  940828.125076 [0001]   s     kworker/1:1-eve[25382]            587.990      1.489      0.005      K  next: thread-workload[7386]
  940828.135578 [0001]    m      thread-workload[7386]                                            migrated: kworker/u8:1-ev[6803] cpu 2 => 3
  940828.135584 [0001]         thread-workload[7386]                                            awakened: kworker/u8:1-ev[6803]
  940828.135609 [0001]         thread-workload[7386]                                            awakened: systemd[1]
  940828.135626 [0001]         thread-workload[7386]                                            awakened: Xorg[32003]
  940828.205068 [0001]         thread-workload[7386]                                            awakened: kworker/1:1-eve[25382]
  940828.209065 [0001]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.209069 [0001]   s     thread-workload[7386]               0.005      0.000     83.992      R  next: kworker/1:1[25382]
  940828.209076 [0001]   s     kworker/1:1-eve[25382]             83.992      4.001      0.007      K  next: thread-workload[7386]
  940828.343223 [0001]    m      thread-workload[7386]                                            migrated: TeamViewer_Desk[6579/6576] cpu 1 => 2
  940828.343227 [0001]         thread-workload[7386]                                            awakened: TeamViewer_Desk[6579/6576]
  940828.365067 [0001]         thread-workload[7386]                                            awakened: kworker/1:1-eve[25382]
  940828.369067 [0001]   s     thread-workload[7386]               0.007      0.000    159.990      R  next: kworker/1:1[25382]
  940828.369074 [0003]      m    swapper                                                          migrated: thread-workload[7386] cpu 1 => 3
  940828.369079 [0003]     i   <idle>                              0.021      0.000      3.983      I  next: thread-workload[7386]
  940828.370626 [0003]         thread-workload[7386]                                            awakened: teamviewerd[1895/1891]
  940828.371479 [0003]      m    thread-workload[7386]                                            migrated: TeamViewer_Desk[6585/6576] cpu 3 => 0
  940828.371482 [0003]         thread-workload[7386]                                            awakened: TeamViewer_Desk[6585/6576]
  940828.373500 [0003]      m    thread-workload[7386]                                            migrated: TeamViewer_Desk[6576] cpu 3 => 1
  940828.373503 [0003]         thread-workload[7386]                                            awakened: TeamViewer_Desk[6576]
  940828.398184 [0003]      m    thread-workload[7386]                                            migrated: Timer[5210/5197] cpu 3 => 0
  940828.398188 [0003]         thread-workload[7386]                                            awakened: Timer[5210/5197]
  940828.416132 [0003]      m    thread-workload[7386]                                            migrated: TeamViewer_Desk[6582/6576] cpu 3 => 0
  940828.416136 [0003]         thread-workload[7386]                                            awakened: TeamViewer_Desk[6582/6576]
  940828.417802 [0003]         thread-workload[7386]                                            awakened: teamviewerd[1897/1891]
  940828.493068 [0003]         thread-workload[7386]                                            awakened: kworker/3:2-eve[5907]
  940828.497068 [0003]     s   thread-workload[7386]               0.012      0.000    127.988      R  next: kworker/3:2[5907]
  940828.497074 [0001]    m      swapper                                                          migrated: thread-workload[7386] cpu 3 => 1
  940828.497080 [0001]   i     <idle>                              0.017      0.000      2.696      I  next: thread-workload[7386]
  940828.504429 [0001]    m      thread-workload[7386]                                            migrated: TeamViewer_Desk[6576] cpu 1 => 2
  940828.504437 [0001]         thread-workload[7386]                                            awakened: TeamViewer_Desk[6576]
  940828.509070 [0001]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.529068 [0001]         thread-workload[7386]                                            awakened: kworker/u8:1-ev[6803]
  940828.529072 [0001]         thread-workload[7386]                                            awakened: kworker/1:1-eve[25382]
  940828.533067 [0001]   s     thread-workload[7386]               0.011      0.000     35.987      R  next: kworker/1:1[25382]
  940828.533074 [0001]   s     kworker/1:1-eve[25382]            163.985      3.995      0.006      K  next: thread-workload[7386]
  940828.537067 [0001]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.561067 [0001]         thread-workload[7386]                                            awakened: kworker/1:1-eve[25382]
  940828.565071 [0001]   s     thread-workload[7386]               0.006      0.000     31.997      R  next: kworker/1:1[25382]
  940828.565079 [0001]   s     kworker/1:1-eve[25382]             31.997      4.004      0.007      K  next: thread-workload[7386]
  940828.581067 [0001]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.605069 [0001]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.625069 [0001]         thread-workload[7386]                                            awakened: kworker/1:1-eve[25382]
  940828.629069 [0001]   s     thread-workload[7386]               0.007      0.000     63.990      R  next: kworker/1:1[25382]
  940828.629075 [0003]      m    rcu_sched[11]                                                    migrated: thread-workload[7386] cpu 1 => 3
  940828.629080 [0003]     s   rcu_sched[11]                       7.989      0.001      0.014      K  next: thread-workload[7386]
  940828.641063 [0003]      m    thread-workload[7386]                                            migrated: rcu_sched[11] cpu 3 => 1
  940828.641065 [0003]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.644047 [0003]      m    thread-workload[7386]                                            migrated: TeamViewer_Desk[6595/6576] cpu 3 => 0
  940828.644050 [0003]         thread-workload[7386]                                            awakened: TeamViewer_Desk[6595/6576]
  940828.657066 [0003]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.665068 [0003]         thread-workload[7386]                                            awakened: rcu_sched[11]
  940828.685069 [0003]         thread-workload[7386]                                            awakened: kworker/3:2-eve[5907]
  940828.689072 [0003]     s   thread-workload[7386]               0.011      0.000     59.992      R  next: kworker/3:2[5907]
  940828.689078 [0001]    m      swapper                                                          migrated: thread-workload[7386] cpu 3 => 1



Though i have set affinity to cpu1 why it is getting migrated to another cpu like as shown in the report,sometimes it getting migrated to cpu3 or cpu0 ,i am not able to get that..can someone help me to figure it out??


Thanks!



-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200417/dd583a91/attachment-0001.htm>
