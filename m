From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 9 Jun 2020 02:48:48 -0400 (EDT)
Subject: [LTP] sched_rr_get_interval01 , sched_rr_get_interval02 ,
 sched_rr_get_interval03 testcase failure
In-Reply-To: <BMXPR01MB23445D894481BDFED050AD27EE820@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB23442B106F1292542BA7F85CEE850@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <1210169239.15186381.1591627929151.JavaMail.zimbra@redhat.com>
 <BMXPR01MB2344728D919729E8F7F007EBEE820@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <1150717403.15265201.1591683953555.JavaMail.zimbra@redhat.com>
 <BMXPR01MB23445D894481BDFED050AD27EE820@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <1242963582.15267570.1591685328616.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

----- Original Message ----- 

> sched_setscheduler(0, SCHED_FIFO, [1]) = -1 EPERM (Operation not permitted)

Thanks, that aligns with the theory.

> 2)
> root@exaleapsemi-r2:/opt/ltp# pu_mnt=$(mount | grep "type cgroup (.*cpu[,)]"
> | awk '{print $3}')
> root@exaleapsemi-r2:/opt/ltp# cpu_mnt=$(mount | grep "type cgroup (.*cpu[,)]"
> | awk '{print $3}')
> root@exaleapsemi-r2:/opt/ltp# p=$(cat /proc/self/cgroup | grep ":cpu[:,]" |
> sed "s/.*://")
> root@exaleapsemi-r2:/opt/ltp# cat $cpu_mnt/$p/cpu.rt_runtime_us
> cat: //system.slice/system-sshd.slice/cpu.rt_runtime_us: No such file or
> directory

> it didnt gave any info about cpu.rt_runtime_us??

That could be because your distro is mounting cgroup2.

# mount | grep cgroup

Do you see any change if you run following?

# echo $$ > /sys/fs/cgroup/cgroup.procs
# /opt/ltp/testcases/bin/sched_setparam02

