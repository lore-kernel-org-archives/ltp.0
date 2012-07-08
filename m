Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <lxiang@redhat.com>) id 1Sn57S-0002Wq-7h
	for ltp-list@lists.sourceforge.net; Fri, 06 Jul 2012 09:46:34 +0000
Received: from mx1.redhat.com ([209.132.183.28])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Sn57M-0001bG-Hb
	for ltp-list@lists.sourceforge.net; Fri, 06 Jul 2012 09:46:34 +0000
Received: from int-mx01.intmail.prod.int.phx2.redhat.com
	(int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
	by mx1.redhat.com (8.14.4/8.14.4) with ESMTP id q669kMrx025246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jul 2012 05:46:22 -0400
Received: from wlan-5-140.nay.redhat.com (wlan-5-140.nay.redhat.com
	[10.66.12.140] (may be forged))
	by int-mx01.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP
	id q669kKxc019351
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <ltp-list@lists.sourceforge.net>; Fri, 6 Jul 2012 05:46:22 -0400
Message-ID: <4FF8D306.5090401@redhat.com>
Date: Sun, 08 Jul 2012 08:23:34 +0800
From: Lingzhu Xiang <lxiang@redhat.com>
MIME-Version: 1.0
References: <1e99528971ce08cfebd0bd9c2b3333295dc9efe4.1341705843.git.lxiang@redhat.com>
In-Reply-To: <1e99528971ce08cfebd0bd9c2b3333295dc9efe4.1341705843.git.lxiang@redhat.com>
Subject: Re: [LTP] [PATCH] timers: add a new test case leapsec_timer
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
To: LTP List <ltp-list@lists.sourceforge.net>

On 07/08/2012 08:09 AM, Lingzhu Xiang wrote:
> A bug in the hrtimer subsystem caused all TIMER_ABSTIME CLOCK_REALTIME
> timers to expire one second early during and after leap seconds, thus
> such sub-second timers expire immediately, causing load spikes if used
> in fast loops. Calling clock_was_set() reverts this state. See [1].
>
> [1]: http://lwn.net/Articles/504658/.
>
> This patch is a regression test for the bug, based on the test case
> provided by John Stultz from the above link, and also tries to recover
> from inconsistency caused by reproduction of the bug.

A sample test run looks like this:

leapsec_timer    0  TINFO  :  test start at 2012-07-08 
08:02:32.996771295 +0800
leapsec_timer    0  TINFO  :  now is     2012-07-08 08:02:32.996929883 +0800
leapsec_timer    0  TINFO  :  sleep till 2012-07-08 08:02:33.996929883 +0800
leapsec_timer    0  TINFO  :  now is     2012-07-08 08:02:33.996975957 +0800
leapsec_timer    0  TINFO  :  hrtimer early expiration is not detected.
leapsec_timer    0  TINFO  :  scheduling leap second 2012-07-09 
08:00:00.000000000 +0800
leapsec_timer    0  TINFO  :  setting time to        2012-07-09 
07:59:58.000000000 +0800
leapsec_timer    0  TINFO  :  2012-07-09 07:59:58.000080000 +0800 
adjtimex: clock synchronized
leapsec_timer    0  TINFO  :  2012-07-09 07:59:58.000101000 +0800 
adjtimex: clock synchronized
leapsec_timer    0  TINFO  :  2012-07-09 07:59:58.000119000 +0800 
adjtimex: insert leap second
leapsec_timer    0  TINFO  :  2012-07-09 07:59:58.000138000 +0800 
adjtimex: insert leap second
leapsec_timer    0  TINFO  :  2012-07-09 07:59:58.500174000 +0800 
adjtimex: insert leap second
leapsec_timer    0  TINFO  :  2012-07-09 07:59:59.000246000 +0800 
adjtimex: insert leap second
leapsec_timer    0  TINFO  :  2012-07-09 07:59:59.500320000 +0800 
adjtimex: insert leap second
leapsec_timer    0  TINFO  :  2012-07-09 07:59:59.000368000 +0800 
adjtimex: leap second in progress
leapsec_timer    0  TINFO  :  2012-07-09 07:59:59.500403000 +0800 
adjtimex: leap second in progress
leapsec_timer    0  TINFO  :  2012-07-09 08:00:00.000432000 +0800 
adjtimex: leap second has occurred
leapsec_timer    0  TINFO  :  2012-07-09 08:00:00.500457000 +0800 
adjtimex: leap second has occurred
leapsec_timer    0  TINFO  :  2012-07-09 08:00:01.000475000 +0800 
adjtimex: leap second has occurred
leapsec_timer    0  TINFO  :  2012-07-09 08:00:01.500489000 +0800 
adjtimex: leap second has occurred
leapsec_timer    0  TINFO  :  2012-07-09 08:00:02.000506000 +0800 
adjtimex: leap second has occurred
leapsec_timer    0  TINFO  :  now is     2012-07-09 08:00:02.500524432 +0800
leapsec_timer    0  TINFO  :  sleep till 2012-07-09 08:00:03.500524432 +0800
leapsec_timer    0  TINFO  :  now is     2012-07-09 08:00:02.500550236 +0800
leapsec_timer    1  TFAIL  :  hrtimer early expiration is detected.
leapsec_timer    0  TINFO  :  2012-07-09 08:00:02.500561000 +0800 
adjtimex: clock synchronized
leapsec_timer    0  TINFO  :  2012-07-09 08:00:02.500568000 +0800 
adjtimex: clock synchronized
leapsec_timer    0  TINFO  :  restoring time to 2012-07-08 
08:02:37.497346606 +0800
leapsec_timer    0  TINFO  :  now is     2012-07-08 08:02:37.497351161 +0800
leapsec_timer    0  TINFO  :  sleep till 2012-07-08 08:02:38.497351161 +0800
leapsec_timer    0  TINFO  :  now is     2012-07-08 08:02:38.497391392 +0800
leapsec_timer    0  TINFO  :  hrtimer early expiration is not detected.


As can be observed, the first timer before the leap second and third timer
after resetting time state worked as expected (early expiration not 
detected),
but the second timer after the leap second before resetting time state
returned unexpectedly early. Thus the above bug was reproduced.

Note that this test case might cause kernel freeze. Running with -c 5 will
highly increase the likelihood of that.

------------------------------------------------------------------------------
Live Security Virtual Conference
Exclusive live event will cover all the ways today's security and 
threat landscape has changed and how IT managers can respond. Discussions 
will include endpoint security, mobile security and the latest in malware 
threats. http://www.accelacomm.com/jaw/sfrnl04242012/114/50122263/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
