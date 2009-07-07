Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <sripathik@in.ibm.com>) id 1MO4NV-0008Kr-Rv
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 06:42:09 +0000
Received: from e28smtp01.in.ibm.com ([59.145.155.1])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MO4NL-0001S2-MX
	for ltp-list@lists.sourceforge.net; Tue, 07 Jul 2009 06:42:09 +0000
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
	by e28smtp01.in.ibm.com (8.13.1/8.13.1) with ESMTP id n676fpvu032220
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 12:11:51 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n676fpbD2908222
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 12:11:51 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.13.1/8.13.3) with ESMTP id n676fovG010186
	for <ltp-list@lists.sourceforge.net>; Tue, 7 Jul 2009 16:41:51 +1000
From: Sripathi Kodi <sripathik@in.ibm.com>
Date: Tue, 7 Jul 2009 12:11:49 +0530
References: <200907031235.06805.sripathik@in.ibm.com>
	<1246895449.4887.51.camel@subratamodak.linux.ibm.com>
In-Reply-To: <1246895449.4887.51.camel@subratamodak.linux.ibm.com>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_t4uUKBHfFrgTT3l"
Message-Id: <200907071211.49294.sripathik@in.ibm.com>
Subject: Re: [LTP] [PATCH] realtime: Fix the pass criterion of pi_perf test
	case.
List-Id: Linux Test Project General Discussions
	<ltp-list.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=ltp-list>
List-Post: <mailto:ltp-list@lists.sourceforge.net>
List-Help: <mailto:ltp-list-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/ltp-list>,
	<mailto:ltp-list-request@lists.sourceforge.net?subject=subscribe>
Errors-To: ltp-list-bounces@lists.sourceforge.net
To: subrata@linux.vnet.ibm.com
Cc: ltp-list <ltp-list@lists.sourceforge.net>, gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

--Boundary-00=_t4uUKBHfFrgTT3l
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 06 July 2009 21:20:49 Subrata Modak wrote:
> On Fri, 2009-07-03 at 12:35 +0530, Sripathi Kodi wrote:
> > Hi,
> >
> > The pass criterion in pi_perf test case is wrong. It compares the minimum
> > amount of time taken by the low priority thread with the maximum amount
> > of time taken by the high priority thread to calculate the PI delay.
> > Obviously, these min and max don't necessarily happen in the same
> > iteration, resulting in a number of false failures. The correct way is to
> > compare the time taken by low and high priority threads in each iteration
> > and then find the maximum delay experienced by high priority thread
> > across the iterations. This patch implements the change. Additionally,
> > this patch removes lock_wait_dat array, which is not needed anymore as
> > well as makes a couple of messages easier to understand.
> >
> > This patch changes the messages displayed by this test case slightly.
> > They look like the following now:
> >
> > Low prio thread started
> > High prio thread started
> > Busy 0 started
> > Busy 1 started
> > Busy 2 started
> > Busy 3 started
> > Time taken for high prio thread to get the lock once released by low prio
> > thread
> > Min delay = 10 us
> > Max delay = 36 us
> > Average delay = 17.06 us
> > Standard Deviation = 8.11 us
> > Quantiles:
> > 99.0% < 36
> > Criteria: High prio lock wait time < (Low prio lock held time + 200 us)
> > Result: PASS
> >
> > I have tested this by running 1000 iterations of pi_perf test on a couple
> > of machines.
> >
> > Thanks,
> > Sripathi.
> >
> > ---
> >
> > realtime: Fix the pass criterion of pi_perf test case.
> >
> > Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
>
> Hi Sri,
>
> Is this based on the latest snapshot. I get the following failures:
>
> patching file testcases/realtime/func/pi_perf/pi_perf.c
> Hunk #1 FAILED at 1.
>
>
> Can you please resend ?

Sorry Subrata, the patch seems to be fine on my machine, but is going bad in my 
mail client. If you don't mind, I have attached the patch to this mail for 
now.

Thanks,
Sripathi.

--

realtime: Fix the pass criterion of pi_perf test case.

Signed-off-by: Sripathi Kodi <sripathik@in.ibm.com>
Acked-by: Will Schmidt <will_schmidt@vnet.ibm.com>
Acked-by: Gowrishankar <gowrishankar.m@linux.vnet.ibm.com>

<snip>

--Boundary-00=_t4uUKBHfFrgTT3l
Content-Type: text/x-patch; charset="UTF-8";
	name="pi_perf_criterion_fix_v2.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="pi_perf_criterion_fix_v2.patch"

diff -uprN ltp_cvs_3jul_org/testcases/realtime/func/pi_perf/pi_perf.c ltp_c=
vs_3jul/testcases/realtime/func/pi_perf/pi_perf.c
=2D-- ltp_cvs_3jul_org/testcases/realtime/func/pi_perf/pi_perf.c	2009-07-03=
 12:21:41.000000000 +0530
+++ ltp_cvs_3jul/testcases/realtime/func/pi_perf/pi_perf.c	2009-07-03 12:24=
:44.000000000 +0530
@@ -1,6 +1,6 @@
 /*************************************************************************=
*****
  *
=2D *   Copyright =C2=A9 International Business Machines  Corp., 2007, 2008
+ *   Copyright =C2=A9 International Business Machines  Corp., 2007, 2008, =
2009
  *
  *   This program is free software;  you can redistribute it and/or modify
  *   it under the terms of the GNU General Public License as published by
@@ -36,6 +36,8 @@
  *
  * HISTORY
  *     2007-Nov-20:    Initial version by Sripathi Kodi <sripathik@in.ibm.=
com>
+ *     2009-Jul-03:    Pass criteria corrected by Sripathi Kodi
+ *                                                      <sripathik@in.ibm.=
com>
  *
  *************************************************************************=
****/
=20
@@ -71,9 +73,9 @@ static unsigned int high_work_time =3D DEF
 static unsigned int busy_work_time;
 static int num_busy =3D -1;
=20
=2Dnsec_t low_unlock, high_get_lock;
+nsec_t low_unlock, max_pi_delay;
=20
=2Dstats_container_t lock_wait_dat, low_dat, cpu_delay_dat;
+stats_container_t low_dat, cpu_delay_dat;
 stats_container_t cpu_delay_hist;
 stats_quantiles_t cpu_delay_quantiles;
=20
@@ -165,10 +167,9 @@ void * low_prio_thread(void *arg)
=20
 void * high_prio_thread(void *arg)
 {
=2D	nsec_t high_start, high_spent, high_end;
+	nsec_t high_start, high_end, high_get_lock;
 	unsigned int i;
=20
=2D	stats_container_init(&lock_wait_dat, iterations);
 	stats_container_init(&cpu_delay_dat, iterations);
 	stats_container_init(&cpu_delay_hist, HIST_BUCKETS);
 	stats_quantiles_init(&cpu_delay_quantiles, (int)log10(iterations));
@@ -184,14 +185,11 @@ void * high_prio_thread(void *arg)
 		high_start =3D rt_gettime();
 		pthread_mutex_lock(&lock);
 		high_end =3D rt_gettime();
=2D		high_spent =3D high_end - high_start;
 		high_get_lock =3D high_end - low_unlock;
=20
 		busy_work_ms(high_work_time);
 		pthread_mutex_unlock(&lock);
=20
=2D		lock_wait_dat.records[i].x =3D i;
=2D		lock_wait_dat.records[i].y =3D high_spent / NS_PER_US;
 		cpu_delay_dat.records[i].x =3D i;
 		cpu_delay_dat.records[i].y =3D high_get_lock / NS_PER_US;
=20
@@ -206,14 +204,16 @@ void * high_prio_thread(void *arg)
 				"Latency (us)", "Samples", &cpu_delay_hist, "steps");
=20
 	printf("Time taken for high prio thread to get the lock once released by =
low prio thread\n");
=2D	printf("Min wait time =3D %ld us\n", stats_min(&cpu_delay_dat));
=2D	printf("Max wait time =3D %ld us\n", stats_max(&cpu_delay_dat));
=2D	printf("Average wait time =3D %4.2f us\n", stats_avg(&cpu_delay_dat));
+	printf("Min delay =3D %ld us\n", stats_min(&cpu_delay_dat));
+	printf("Max delay =3D %ld us\n", stats_max(&cpu_delay_dat));
+	printf("Average delay =3D %4.2f us\n", stats_avg(&cpu_delay_dat));
 	printf("Standard Deviation =3D %4.2f us\n", stats_stddev(&cpu_delay_dat));
 	printf("Quantiles:\n");
 	stats_quantiles_calc(&cpu_delay_dat, &cpu_delay_quantiles);
 	stats_quantiles_print(&cpu_delay_quantiles);
=20
+	max_pi_delay =3D stats_max(&cpu_delay_dat);
+
 	return NULL;
 }
=20
@@ -261,13 +261,11 @@ int main(int argc, char *argv[])
 	}
=20
 	join_threads();
=2D	printf("Low prio lock held time (min) =3D %ld us\n", stats_min(&low_dat=
));
=2D	printf("High prio lock wait time (max) =3D %ld us\n", stats_max(&lock_w=
ait_dat));
 	printf("Criteria: High prio lock wait time < "
 			"(Low prio lock held time + %d us)\n", (int)pass_criteria);
=20
 	ret =3D 0;
=2D	if (stats_max(&lock_wait_dat) > stats_min(&low_dat) + (int)pass_criteri=
a)
+	if (max_pi_delay > pass_criteria)
 		ret =3D 1;
=20
 	printf("Result: %s\n", ret ? "FAIL" : "PASS");

--Boundary-00=_t4uUKBHfFrgTT3l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

------------------------------------------------------------------------------
Enter the BlackBerry Developer Challenge  
This is your chance to win up to $100,000 in prizes! For a limited time, 
vendors submitting new applications to BlackBerry App World(TM) will have 
the opportunity to enter the BlackBerry Developer Challenge. See full prize 
details at: http://p.sf.net/sfu/blackberry
--Boundary-00=_t4uUKBHfFrgTT3l
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list

--Boundary-00=_t4uUKBHfFrgTT3l--

