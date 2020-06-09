From: Jan Stancek <jstancek@redhat.com>
Date: Tue, 9 Jun 2020 02:25:53 -0400 (EDT)
Subject: [LTP] sched_rr_get_interval01 , sched_rr_get_interval02 ,
 sched_rr_get_interval03 testcase failure
In-Reply-To: <BMXPR01MB2344728D919729E8F7F007EBEE820@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
References: <BMXPR01MB23442B106F1292542BA7F85CEE850@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
 <1210169239.15186381.1591627929151.JavaMail.zimbra@redhat.com>
 <BMXPR01MB2344728D919729E8F7F007EBEE820@BMXPR01MB2344.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <1150717403.15265201.1591683953555.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi Jan Stancek,
> Thanks for your response.All of the following test are failing w.r.t sched
> 
> 1) sched_setparam02
> 2) sched_setparam03
> 3) sched_getscheduler01

That suggests it could be cpu.rt_runtime_us == 0, since all tests are
trying to use realtime scheduler.

> 
> root@exaleapsemi-r2:/opt/ltp# strace ./runltp -s sched_setparam02

Above doesn't help much, since you are not tracing child processes.

1. Can you run this instead:
 /opt/ltp# strace ./testcases/bin/sched_setparam02

2. Can you check what is the cpu.rt_runtime_us for pid that runs the test?

# cpu_mnt=$(mount | grep "type cgroup (.*cpu[,)]" | awk '{print $3}')
# p=$(cat /proc/self/cgroup | grep ":cpu[:,]" | sed "s/.*://")
# cat $cpu_mnt/$p/cpu.rt_runtime_us

