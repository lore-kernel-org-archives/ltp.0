Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <lizf@cn.fujitsu.com>) id 1P5zWI-0000RG-Qy
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 11:29:18 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1P5zWD-0003ps-3U
	for ltp-list@lists.sourceforge.net; Wed, 13 Oct 2010 11:29:18 +0000
Message-ID: <4CB59825.7060504@cn.fujitsu.com>
Date: Wed, 13 Oct 2010 19:29:41 +0800
From: Li Zefan <lizf@cn.fujitsu.com>
MIME-Version: 1.0
References: <4C85A88D.10700@cn.fujitsu.com>		<1285689961.11429.12.camel@subratamodak.linux.ibm.com>	<1286954486.4893.15.camel@subratamodak.linux.ibm.com>	<4CB55FE6.6000604@cn.fujitsu.com>
	<4CB5615C.4070406@cn.fujitsu.com>
In-Reply-To: <4CB5615C.4070406@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH v2] Add ftrace-stress-test to LTP
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list@lists.sourceforge.net

Li Zefan wrote:
> Li Zefan wrote:
>> Subrata Modak wrote:
>>> Li,
>>>
>>> Can you kindly fix the below issues and send me a new patch ?
>>>
>> Sure, I will.
>>
> 
> At a first glance, the kernel bug doesn't seem to come from ftrace,
> at least not directly from it.
> 
> Question:
> 
> Can you trigger this bug in latest kernel (2.6.36-rc7)? If you
> haven't tried it, could you test it? Thanks!
> 

I got a patch from Peter, though he's not sure about the bug yet.
So could you try this?

Note, I don't know if this patch can be applied to 2.6.35-4..

======================

(From Peter)

Hrmm, not something I've seen before.. but since the migration thread
and stop_machine are involved, does the below patch which rewrites the
migration-thread/stop_macehine/scheduler interaction cure this?

This patch is probably .37 fodder, but who knows..

---
Subject: sched: Create special class for stop/migrate work
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Wed Sep 22 13:53:15 CEST 2010

In order to separate the stop/migrate work thread from the SCHED_FIFO
implementation, create a special class for it that is of higher priority
than SCHED_FIFO itself.

This currently solves a problem where cpu-hotplug consumes so much cpu-time
that the SCHED_FIFO class gets throttled, but has the bandwidth replenishment
timer pending on the now dead cpu.

It is also required for when we add the planned deadline scheduling class
above SCHED_FIFO, as the stop/migrate thread still needs to transcent those
tasks.

Tested-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Peter Zijlstra <a.p.zijlstra@chello.nl>
LKML-Reference: <1285165776.2275.1022.camel@laptop>
---
 kernel/sched.c          |   54 ++++++++++++++++++++----
 kernel/sched_stoptask.c |  108 ++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/stop_machine.c   |    8 ++-
 3 files changed, 158 insertions(+), 12 deletions(-)

Index: linux-2.6/kernel/sched.c
===================================================================
--- linux-2.6.orig/kernel/sched.c
+++ linux-2.6/kernel/sched.c
@@ -486,7 +486,7 @@ struct rq {
 	 */
 	unsigned long nr_uninterruptible;
 
-	struct task_struct *curr, *idle;
+	struct task_struct *curr, *idle, *stop;
 	unsigned long next_balance;
 	struct mm_struct *prev_mm;
 
@@ -1837,7 +1837,7 @@ static inline void __set_task_cpu(struct
 
 static const struct sched_class rt_sched_class;
 
-#define sched_class_highest (&rt_sched_class)
+#define sched_class_highest (&stop_sched_class)
 #define for_each_class(class) \
    for (class = sched_class_highest; class; class = class->next)
 
@@ -1917,10 +1917,41 @@ static void deactivate_task(struct rq *r
 #include "sched_idletask.c"
 #include "sched_fair.c"
 #include "sched_rt.c"
+#include "sched_stoptask.c"
 #ifdef CONFIG_SCHED_DEBUG
 # include "sched_debug.c"
 #endif
 
+void sched_set_stop_task(int cpu, struct task_struct *stop)
+{
+	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
+	struct task_struct *old_stop = cpu_rq(cpu)->stop;
+
+	if (stop) {
+		/*
+		 * Make it appear like a SCHED_FIFO task, its something
+		 * userspace knows about and won't get confused about.
+		 *
+		 * Also, it will make PI more or less work without too
+		 * much confusion -- but then, stop work should not
+		 * rely on PI working anyway.
+		 */
+		sched_setscheduler_nocheck(stop, SCHED_FIFO, &param);
+
+		stop->sched_class = &stop_sched_class;
+	}
+
+	cpu_rq(cpu)->stop = stop;
+
+	if (old_stop) {
+		/*
+		 * Reset it back to a normal scheduling class so that
+		 * it can die in pieces.
+		 */
+		old_stop->sched_class = &rt_sched_class;
+	}
+}
+
 /*
  * __normal_prio - return the priority that is based on the static prio
  */
@@ -3720,17 +3751,13 @@ pick_next_task(struct rq *rq)
 			return p;
 	}
 
-	class = sched_class_highest;
-	for ( ; ; ) {
+	for_each_class(class) {
 		p = class->pick_next_task(rq);
 		if (p)
 			return p;
-		/*
-		 * Will never be NULL as the idle class always
-		 * returns a non-NULL p:
-		 */
-		class = class->next;
 	}
+
+	BUG(); /* the idle class will always have a runnable task */
 }
 
 /*
@@ -4659,6 +4686,15 @@ static int __sched_setscheduler(struct t
 	 */
 	rq = __task_rq_lock(p);
 
+	/*
+	 * Changing the policy of the stop threads its a very bad idea
+	 */
+	if (p == rq->stop) {
+		__task_rq_unlock(rq);
+		raw_spin_unlock_irqrestore(&p->pi_lock, flags);
+		return -EINVAL;
+	}
+
 #ifdef CONFIG_RT_GROUP_SCHED
 	if (user) {
 		/*
Index: linux-2.6/kernel/stop_machine.c
===================================================================
--- linux-2.6.orig/kernel/stop_machine.c
+++ linux-2.6/kernel/stop_machine.c
@@ -287,11 +287,12 @@ static int cpu_stopper_thread(void *data
 	goto repeat;
 }
 
+extern void sched_set_stop_task(int cpu, struct task_struct *stop);
+
 /* manage stopper for a cpu, mostly lifted from sched migration thread mgmt */
 static int __cpuinit cpu_stop_cpu_callback(struct notifier_block *nfb,
 					   unsigned long action, void *hcpu)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO - 1 };
 	unsigned int cpu = (unsigned long)hcpu;
 	struct cpu_stopper *stopper = &per_cpu(cpu_stopper, cpu);
 	struct task_struct *p;
@@ -304,13 +305,13 @@ static int __cpuinit cpu_stop_cpu_callba
 				   cpu);
 		if (IS_ERR(p))
 			return NOTIFY_BAD;
-		sched_setscheduler_nocheck(p, SCHED_FIFO, &param);
 		get_task_struct(p);
+		kthread_bind(p, cpu);
+		sched_set_stop_task(cpu, p);
 		stopper->thread = p;
 		break;
 
 	case CPU_ONLINE:
-		kthread_bind(stopper->thread, cpu);
 		/* strictly unnecessary, as first user will wake it */
 		wake_up_process(stopper->thread);
 		/* mark enabled */
@@ -325,6 +326,7 @@ static int __cpuinit cpu_stop_cpu_callba
 	{
 		struct cpu_stop_work *work;
 
+		sched_set_stop_task(cpu, NULL);
 		/* kill the stopper */
 		kthread_stop(stopper->thread);
 		/* drain remaining works */
Index: linux-2.6/kernel/sched_stoptask.c
===================================================================
--- /dev/null
+++ linux-2.6/kernel/sched_stoptask.c
@@ -0,0 +1,108 @@
+/*
+ * stop-task scheduling class.
+ *
+ * The stop task is the highest priority task in the system, it preempts
+ * everything and will be preempted by nothing.
+ *
+ * See kernel/stop_machine.c
+ */
+
+#ifdef CONFIG_SMP
+static int
+select_task_rq_stop(struct rq *rq, struct task_struct *p,
+		    int sd_flag, int flags)
+{
+	return task_cpu(p); /* stop tasks as never migrate */
+}
+#endif /* CONFIG_SMP */
+
+static void
+check_preempt_curr_stop(struct rq *rq, struct task_struct *p, int flags)
+{
+	resched_task(rq->curr); /* we preempt everything */
+}
+
+static struct task_struct *pick_next_task_stop(struct rq *rq)
+{
+	struct task_struct *stop = rq->stop;
+
+	if (stop && stop->state == TASK_RUNNING)
+		return stop;
+
+	return NULL;
+}
+
+static void
+enqueue_task_stop(struct rq *rq, struct task_struct *p, int flags)
+{
+}
+
+static void
+dequeue_task_stop(struct rq *rq, struct task_struct *p, int flags)
+{
+}
+
+static void yield_task_stop(struct rq *rq)
+{
+	BUG(); /* the stop task should never yield, its pointless. */
+}
+
+static void put_prev_task_stop(struct rq *rq, struct task_struct *prev)
+{
+}
+
+static void task_tick_stop(struct rq *rq, struct task_struct *curr, int queued)
+{
+}
+
+static void set_curr_task_stop(struct rq *rq)
+{
+}
+
+static void switched_to_stop(struct rq *rq, struct task_struct *p,
+			     int running)
+{
+	BUG(); /* its impossible to change to this class */
+}
+
+static void prio_changed_stop(struct rq *rq, struct task_struct *p,
+			      int oldprio, int running)
+{
+	BUG(); /* how!?, what priority? */
+}
+
+static unsigned int
+get_rr_interval_stop(struct rq *rq, struct task_struct *task)
+{
+	return 0;
+}
+
+/*
+ * Simple, special scheduling class for the per-CPU stop tasks:
+ */
+static const struct sched_class stop_sched_class = {
+	.next			= &rt_sched_class,
+
+	.enqueue_task		= enqueue_task_stop,
+	.dequeue_task		= dequeue_task_stop,
+	.yield_task		= yield_task_stop,
+
+	.check_preempt_curr	= check_preempt_curr_stop,
+
+	.pick_next_task		= pick_next_task_stop,
+	.put_prev_task		= put_prev_task_stop,
+
+#ifdef CONFIG_SMP
+	.select_task_rq		= select_task_rq_stop,
+#endif
+
+	.set_curr_task          = set_curr_task_stop,
+	.task_tick		= task_tick_stop,
+
+	.get_rr_interval	= get_rr_interval_stop,
+
+	.prio_changed		= prio_changed_stop,
+	.switched_to		= switched_to_stop,
+
+	/* no .task_new for stop tasks */
+};




------------------------------------------------------------------------------
Beautiful is writing same markup. Internet Explorer 9 supports
standards for HTML5, CSS3, SVG 1.1,  ECMAScript5, and DOM L2 & L3.
Spend less time writing and  rewriting code and more time creating great
experiences on the web. Be a part of the beta today.
http://p.sf.net/sfu/beautyoftheweb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
