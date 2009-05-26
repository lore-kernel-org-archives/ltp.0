Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 235xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <srinivass@in.ibm.com>) id 1M8wXA-0006Fp-CP
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 13:17:36 +0000
Received: from e28smtp05.in.ibm.com ([59.145.155.5])
	by 1b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M8wX6-0007ZC-4u
	for ltp-list@lists.sourceforge.net; Tue, 26 May 2009 13:17:36 +0000
In-Reply-To: <1243268077.6752.23.camel@subratamodak.linux.ibm.com>
References: <OF0C37E154.CA4A0A35-ON652575C1.00256153-652575C1.0025D2AB@in.ibm.com>
	<1243268077.6752.23.camel@subratamodak.linux.ibm.com>
Message-ID: <OF77108762.11730212-ON652575C2.0043DF42-652575C2.004498B7@in.ibm.com>
From: Srinivasan Subramanian3 <srinivass@in.ibm.com>
Date: Tue, 26 May 2009 17:56:51 +0530
MIME-Version: 1.0
Subject: Re: [LTP] LTP on System z: runltp segfaults on RHEL 4
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
Cc: ltp-list@lists.sf.net

Hi Subrata,

I ran runltp with syscalls command file, then ran the pan with gdb.. here
is the output for the same

   [root@t63lp24 ltp-intermediate-20090521]# gdb pan/ltp-pan
   GNU gdb Red Hat Linux (6.3.0.0-1.162.el4rh)
   Copyright 2004 Free Software Foundation, Inc.
   GDB is free software, covered by the GNU General Public License, and you
   are
   welcome to change it and/or distribute copies of it under certain
   conditions.
   Type "show copying" to see the conditions.
   There is absolutely no warranty for GDB.  Type "show warranty" for
   details.
   This GDB was configured as "s390x-redhat-linux-gnu"...Using host
   libthread_db library "/lib64/tls/libthread_db.so.1".

   (gdb) r pan/ltp-pan 0 -e -S 2 10 -a srinivass@in.ibm.com -n $$ -p -f
   /tmp/ltp-lOGaG20871-srini/alltests -l
   /root/ltp-intermediate-20090521/results/LTP_RUN_ON-2009_May_26-05PM-srini.log
 -o
   /root/ltp-intermediate-20090521/results/LTP_RUN_ON-2009_May_26-05PM-srini.out
 -C
   /root/ltp-intermediate-20090521/output/LTP_RUN_ON-2009_May_26-5PM-srini.failed
   Starting program: /root/ltp-intermediate-20090521/pan/ltp-pan
   pan/ltp-pan 0 -e -S 2 10 -a srinivass@in.ibm.com -n $$ -p -f
   /tmp/ltp-lOGaG20871-srini/alltests -l
   /root/ltp-intermediate-20090521/results/LTP_RUN_ON-2009_May_26-05PM-srini.log
 -o
   /root/ltp-intermediate-20090521/results/LTP_RUN_ON-2009_May_26-05PM-srini.out
 -C
   /root/ltp-intermediate-20090521/output/LTP_RUN_ON-2009_May_26-5PM-srini.failed

   Program received signal SIGSEGV, Segmentation fault.
   0x00000200000ed198 in vfprintf () from /lib64/tls/libc.so.6


Thanks &
---------------------------------
Best Regards,
Srinivasan S,
Linux on System z, LTC
srinivass@in.ibm.com
srinivass@linux.vnet.ibm.com
----------------------------------


|------------>
| From:      |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Subrata Modak <subrata@linux.vnet.ibm.com>                                                                                                        |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| To:        |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Srinivasan Subramanian3/India/IBM@IBMIN                                                                                                           |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Cc:        |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |ltp-list@lists.sf.net                                                                                                                             |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Date:      |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |05/25/2009 09:42 PM                                                                                                                               |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
|------------>
| Subject:   |
|------------>
  >--------------------------------------------------------------------------------------------------------------------------------------------------|
  |Re: [LTP] LTP on System z: runltp segfaults on RHEL 4                                                                                             |
  >--------------------------------------------------------------------------------------------------------------------------------------------------|





Can you also provide a little info on running pan through gdb ?

Regards--
Subrata

On Mon, 2009-05-25 at 12:20 +0530, Srinivasan Subramanian3 wrote:
> Hello all,
>
> When i ran the runltp script on a RHEL4.8 (64 bit machine) on System z,
it
> seg faulted..
>
> Running tests.......
> ./runltp: line 166: 20024 Segmentation fault      ${LTPROOT}/pan/ltp-pan
> $QUIET_MODE -e -S $INSTANCES $DURATION -a $$ -n $$ $PRETTY_PRT -f
> ${TMP}/alltests $LOGFILE $OUTPUTFILE $FAILCMDFILE
> INFO: ltp-pan reported some tests FAIL
> LTP Version: LTP-20090430
>
> uname -r
> 2.6.9-89.EL
>
> cat /etc/issue
> Red Hat Enterprise Linux AS release 4 (Nahant Update 8)
>
> Thanks in advance &
> ---------------------------------
> Best Regards,
> Srinivasan S,
> Linux on System z, LTC
> srinivass@in.ibm.com
> srinivass@linux.vnet.ibm.com
> ----------------------------------
>
>
>
>
>
------------------------------------------------------------------------------

> Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
> is a gathering of tech-side developers & brand creativity professionals.
Meet
> the minds behind Google Creative Lab, Visual Complexity, Processing, &
> iPhoneDevCamp asthey present alongside digital heavyweights like
Barbarian
> Group, R/GA, & Big Spaceship. http://www.creativitycat.com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list





------------------------------------------------------------------------------
Register Now for Creativity and Technology (CaT), June 3rd, NYC. CaT
is a gathering of tech-side developers & brand creativity professionals. Meet
the minds behind Google Creative Lab, Visual Complexity, Processing, & 
iPhoneDevCamp asthey present alongside digital heavyweights like Barbarian
Group, R/GA, & Big Spaceship. http://www.creativitycat.com 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
