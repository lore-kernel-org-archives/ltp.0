From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Date: Thu, 3 Jun 2021 12:50:36 +0200
Subject: [LTP] [sched/pelt] e906550aca:
 WARNING:at_kernel/sched/fair.c:#update_blocked_averages
In-Reply-To: <20210602064526.GB9872@xsang-OptiPlex-9020>
References: <20210602064526.GB9872@xsang-OptiPlex-9020>
Message-ID: <56316b95-3ec5-74e6-a4f7-d91aea022abe@arm.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/06/2021 08:45, kernel test robot wrote:

[...]

> kern :warn : [   40.989618] WARNING: CPU: 2 PID: 253 at kernel/sched/fair.c:8029 update_blocked_averages (kbuild/src/consumer/kernel/sched/fair.c:8029 kbuild/src/consumer/kernel/sched/fair.c:8065 kbuild/src/consumer/kernel/sched/fair.c:8152) 

Hit something like this on my Ubuntu i7-7567U as well.

With more debugging:

[    7.388006] WARNING: CPU: 1 PID: 926 at kernel/sched/fair.c:8029 update_blocked_averages+0x30d/0x7e0
...
[    7.388167] path=/autogroup-2 load_avg=1 util_avg=0 runnable_avg=1

IMHO, this is because this patch needs:

(1) sched/pelt: ensure that *_sum is always synced with *_avg (2021-06-03 Vincent Guittot)

https://lkml.kernel.org/r/20210601085832.12626-1-vincent.guittot@linaro.org

(2) sched/fair: Keep load_avg and load_sum synced (2021-06-03 Vincent Guittot)

tip/sched/urgent 7c7ad626d9a0

Using both patches underneath makes this warning go away.

