Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F624F43834
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 15:20:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7007B3E71F5
	for <ltp@archiver.kernel.org>; Wed, 15 Apr 2026 17:20:35 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C15E3E5BB2
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 17:20:16 +0200 (CEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0FF872001A7
 for <ltp@lists.linux.it>; Wed, 15 Apr 2026 17:20:14 +0200 (CEST)
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63FDF4mR1832986; Wed, 15 Apr 2026 15:20:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=Af01ivoeuYFqSYJayCOFLzVYnU73OQ
 T+qO+B8PcBH38=; b=YB6Gq5AvQBWDXNe3WXn+YYqupUwTLj3iLue76HorY3+yCl
 0FECmFs1Q4AjvKsjbKN0LqKpR15tYL4awyCSCjFfkrpjLi6AKusl755hzrq2kJHS
 AoiwAN3H/TEbozBMhh2ZwsfPqnaHNedSX52kk4Iv4SN6snVQtmgrqI2KsrrzBdpz
 Ze3nnsIhcKeyiev8hQACsycmKTJtfUvNIL4GgmXZxhfM4W13XQzxvdHQe9pgCO4D
 Y5kBiDtdbrBkvpw+jls5bFMhci42M36pkd71i3l2m4sddl8DdZ+3hibfwWyXdEP4
 jglKTdAOWqLP3rhUEJObNMETJYP2vofTbhjNSSIw==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dh89rgtm0-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 15:20:12 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 63FDt2tE025643;
 Wed, 15 Apr 2026 15:20:11 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dg2ujpkd1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 15 Apr 2026 15:20:11 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63FFKARQ26870518
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 15 Apr 2026 15:20:10 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 11FE120049;
 Wed, 15 Apr 2026 15:20:10 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E41FB20040;
 Wed, 15 Apr 2026 15:20:09 +0000 (GMT)
Received: from li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com (unknown
 [9.52.197.53]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 15 Apr 2026 15:20:09 +0000 (GMT)
Date: Wed, 15 Apr 2026 17:20:08 +0200
From: Jan Polensky <japo@linux.ibm.com>
To: Li Wang <wangli.ahau@gmail.com>, Soma Das <somadas1@linux.ibm.com>
Message-ID: <ad-sqJXCYZpBAKM0@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
References: <53f26493-09fc-4f8b-9751-24d2c2e80697@linux.ibm.com>
 <ad5jSSYZJS0FdZva@li-276bd24c-2dcc-11b2-a85c-945b6f05615c.ibm.com>
 <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CANgNiRyTovPjVq01n7sCNhbNdYNp6nSvWcpVV_8aC3+kBX0edg@mail.gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE1MDE0MiBTYWx0ZWRfX4IN9oEcS/bD7
 +3PJT4LwtMMf0wj25UOD39ycyXJzmqSOS3mm0Q3U6yETsbvgF3m/IVlzj3hn3aJr8qNRvsQvzz9
 wfkiZE9WbT8sQ0rVscaj10Sy8vFNUPwPwvKJlwXKPANHTra4rAZLAQPM4lFANhXa7RyHSGgCQUV
 dSrgpLbx+mBIC8bD9Euwxu9/5Iuvt5VQDYR3AefnduSbmA31bHrzoieUxPDXTB0R0QN5nW3/Deg
 SHUM/sAXHKF70ijBB/Mb/SMJFGtN6HyBiKJB9e7nyg8cCx7WBdwK72J7btkuhj9U8CsuwdLCjmk
 u2RNg6soeMIfbG+h5Rj1I2GSWTJ+O3sDLemHunNbZrNrOOBya9vd8x2571qjgFsn34mMluQEDAU
 /RD6P1jdO41qjebo9V8scqk880F8OKUxugy+LZf+E4GoHGIHUoSqThAoABNe+Rrljn7CZMfzinp
 8j5E1pNDTVejOIlpQbg==
X-Proofpoint-ORIG-GUID: FmOAEovk6aA4xJ9z3cuDbby8_Ol1LBpa
X-Proofpoint-GUID: SDTjYoCJFVmD1z3H8yWtHaNBPRGIRZ5F
X-Authority-Analysis: v=2.4 cv=fYidDUQF c=1 sm=1 tr=0 ts=69dfacac cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=svtOvR90bENhbL-BqmcA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-15_01,2026-04-13_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 phishscore=0
 bulkscore=0 priorityscore=1501 spamscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604150142
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] sched_football: fix false failures on many-CPU
 systems
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: jstultz@google.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Apr 15, 2026 at 05:52:11PM +0800, Li Wang wrote:
> Hi Soma and Jan,
>
> > > 1. RT throttling freezes all SCHED_FIFO threads simultaneously. On
> > > release, the kernel does not always reschedule the highest-priority
> > > thread first on every CPU, so offense briefly runs and increments
> > > the_ball before defense is rescheduled. Fix by saving and disabling
> > > sched_rt_runtime_us in setup and restoring it in a new cleanup
> > > callback.
>
> Make sense, and like the AI-reviewer points out LTP provides an option
> to save_restore it automatically.
>
> > > 2. Offense and defense threads were unpinned, allowing the scheduler
> > > to migrate them freely. An offense thread could land on a CPU with
> > > no defense thread present and run unchecked. Fix by passing a CPU
> > > index as the thread arg and calling sched_setaffinity() at thread
> > > start. Pairs are distributed round-robin (i % ncpus) so each
> > > offense thread shares its CPU with a defense thread.
>
> This is a good thought, as for SCHED_FIFO it manages the corresponding
> runqueue for each CPU and simply picks the higher priority task to run.
> So pinning the threads to each CPU makes sense, but maybe we could
> only pin the defense because:
>
> With N defense threads pinned one per CPU, every CPU has a defense
> thread at priority 30 permanently runnable. The offense threads at priority
> 15, regardless of which CPU the scheduler places them on, will always find
> a higher-priority defense thread on the same CPU's runqueue. Since
> SCHED_FIFO strictly favors the higher-priority runnable task, offense can
> never be picked.
>
> Pinning offense as well would be redundant, it doesn't matter where offense
> lands, because defense already covers every CPU. This also has the advantage
> of letting the scheduler freely migrate offense threads without
> affecting the test
> outcome, which avoids interfering with the kernel's load balancing logic during
> the test.
>
> And, I'd suggest using tst_ncpus_available() instead of get_numcpus()
> when distributing defense threads across CPUs, in case some CPUs are
> offline. Pinning a defense thread to an offline CPU would leave that
> CPU uncovered and allow offense to run unchecked. See:
>
> Also, the short usleep() after setting kickoff_flag, which was originally
> there to give the RT load balancer time to distribute threads across CPUs,
> can now be removed, since defense is already pinned to every CPU and
> coverage is guaranteed without any extra settling time.
>
> -       if (tst_check_preempt_rt())
> -               usleep(20000);
> -       else
> -               usleep(2000000);
>
>
> > > 3. game_over was never reset between iterations, causing all threads
> > > to exit immediately on reruns (-i N), making the test a no-op.
> > > Fix by resetting both kickoff_flag and game_over at the top of
> > > do_test().
>
> Good catch.
>
> > > 4. sched_setscheduler() failure for the referee was silently ignored.
> > > If the call fails the test produces meaningless results. Fix by
> > > checking the return value and calling tst_brk(TBROK) on failure.
>
> +1
>
> > Tested-by: Jan Polensky <japo@linux.ibm.com>
>
> Thanks, can you re-test it based on what my above revision suggests?
>
> --
> Regards,
> Li Wang

Hi Li, hi Soma,

@Li: I incorporated your suggested changes and re-tested. Works fine for
me on the same machine as before.

	./sched_football -i 10
    [snip]
    Summary:
    passed   10
    failed   0
    broken   0
    skipped  0
    warnings 0

Tested-by: Jan Polensky <japo@linux.ibm.com>

@Soma: Feel free to pick it up, the diff/patch is attached below.
Please note the additional join_threads() call, it is needed if you run the test like:

	./sched_football -i 10

It seems the threads do not terminate correctly without it.

diff --git a/testcases/realtime/func/sched_football/sched_football.c b/testcases/realtime/func/sched_football/sched_football.c
index 43bac9468693..be0334da812e 100644
--- a/testcases/realtime/func/sched_football/sched_football.c
+++ b/testcases/realtime/func/sched_football/sched_football.c
@@ -118,23 +118,17 @@ void *thread_defense(void *arg)
 }

 /* This is the offensive team. They're trying to move the ball */
-void *thread_offense(void *arg)
+void *thread_offense(void *arg LTP_ATTRIBUTE_UNUSED)
 {
-	struct thread *t = (struct thread *)arg;
-	int cpu = (int)(intptr_t)t->arg;
-	cpu_set_t cpuset;
-
 	prctl(PR_SET_NAME, "offense", 0, 0, 0);

 	/*
-	 * Pin to the same CPU as the paired defense thread so there is
-	 * always a higher-priority defense thread locally available to
-	 * preempt this one without requiring cross-CPU migration.
+	 * Offense threads are not pinned. With defense threads pinned one per
+	 * CPU at priority 30, every CPU has a higher-priority defense thread
+	 * runnable. Offense at priority 15 can never be picked by SCHED_FIFO
+	 * regardless of which CPU it lands on. Leaving offense unpinned avoids
+	 * interfering with the kernel's load balancing logic.
 	 */
-	CPU_ZERO(&cpuset);
-	CPU_SET(cpu, &cpuset);
-	if (sched_setaffinity(0, sizeof(cpuset), &cpuset) != 0)
-		tst_brk(TBROK | TERRNO, "sched_setaffinity failed for offense on CPU %d", cpu);

 	pthread_barrier_wait(&start_barrier);
 	while (!tst_atomic_load(&kickoff_flag))
@@ -169,10 +163,6 @@ void referee(int game_length)

 	tst_atomic_store(0, &the_ball);
 	tst_atomic_store(1, &kickoff_flag);
-	if (tst_check_preempt_rt())
-		usleep(20000);
-	else
-		usleep(2000000);

 	/* Watch the game */
 	while ((now.tv_sec - start.tv_sec) < game_length) {
@@ -199,10 +189,10 @@ static void do_test(void)
 	int i;

 	if (players_per_team == 0)
-		players_per_team = get_numcpus();
+		players_per_team = tst_ncpus_available();

 	/* actual CPU count used for affinity assignment, independent of players_per_team */
-	ncpus = get_numcpus();
+	ncpus = tst_ncpus_available();

 	tst_res(TINFO, "players_per_team: %d game_length: %d",
 	       players_per_team, game_length);
@@ -227,10 +217,8 @@ static void do_test(void)
 	priority = 15;
 	tst_res(TINFO, "Starting %d offense threads at priority %d",
 	       players_per_team, priority);
-	/* i % ncpus distributes threads round-robin across CPUs; the CPU index is
-	 * passed as the thread arg so offense and defense pairs share the same CPU */
 	for (i = 0; i < players_per_team; i++)
-		create_fifo_thread(thread_offense, (void *)(intptr_t)(i % ncpus), priority);
+		create_fifo_thread(thread_offense, NULL, priority);

 	/* Start the defense */
 	priority = 30;
@@ -248,6 +236,7 @@ static void do_test(void)

 	referee(game_length);

+	join_threads();
 	pthread_barrier_destroy(&start_barrier);
 }



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
