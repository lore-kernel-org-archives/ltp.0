Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <risrajak@linux.vnet.ibm.com>) id 1NdH3u-0002CX-7G
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 05:49:02 +0000
Received: from e28smtp02.in.ibm.com ([122.248.162.2])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1NdH3s-0008EM-Kz
	for ltp-list@lists.sourceforge.net; Fri, 05 Feb 2010 05:49:02 +0000
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp02.in.ibm.com (8.14.3/8.13.1) with ESMTP id o155mpsD017690
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Feb 2010 11:18:51 +0530
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o155mo4Y2347184
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Feb 2010 11:18:51 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
	by d28av03.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o155moA2016072
	for <ltp-list@lists.sourceforge.net>; Fri, 5 Feb 2010 16:48:50 +1100
Message-ID: <4B6BB142.8020303@linux.vnet.ibm.com>
Date: Fri, 05 Feb 2010 11:18:50 +0530
From: Rishikesh <risrajak@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <364299f41002042052p28f48b22i58b16e9cf14bf13f@mail.gmail.com>
In-Reply-To: <364299f41002042052p28f48b22i58b16e9cf14bf13f@mail.gmail.com>
Subject: Re: [LTP] Race in utimensat.sh
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
To: Garrett Cooper <yanegomi@gmail.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 02/05/2010 10:22 AM, Garrett Cooper wrote:
>      There's a race condition somewhere in utimensat.sh from what I've
> seen where one of the processes executes and then it blocks
> indefinitely [I was stracing the script and it was blocking on a
> wait(2) call]. Have others seen similar issues?
>    
Hi Garret,

I tested with 2.6.32 kernel and i did not face this issue. Below is the 
resule.

Also glibc-2.11.1-0.1.3 .

@List, Please inform us if you are facing the issue with package & 
kernel version mentioned by garret.

...
============================================================

tv_sec should be ignored if tv_nsec is UTIME_OMIT or UTIME_NOW
***** Testing times=={ UTIME_NOW, UTIME_NOW } case *****
Pathname test
Owner=nobody; perms=-rw-------; EFAs=---
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the 
same file
./utimensat01 -q /tmp/ltp-yMUOddEzJT/utimensat_tests/utimensat.test_file 
1 n 1 n
EXPECTED: SUCCESS y  y
RESULT:   SUCCESS 1265348846 1265348846
PASSED test 98

***** Testing times=={ UTIME_OMIT, UTIME_OMIT } case *****
Pathname test
Owner=nobody; perms=-rw-------; EFAs=---
cp: `/opt/ltp/testcases/bin/utimensat01' and `./utimensat01' are the 
same file
./utimensat01 -q /tmp/ltp-yMUOddEzJT/utimensat_tests/utimensat.test_file 
1 o 1 o
EXPECTED: SUCCESS n  n
RESULT:   SUCCESS 0 0
PASSED test 99

============================================================

Linux mhs21a 2.6.32 #1 SMP 2010-01-25 17:19:14 +0100 x86_64 x86_64 
x86_64 GNU/Linux
Fri Feb  5 11:17:27 IST 2010
Total tests: 99; passed: 99; failed: 0
<<<execution_status>>>
initiation_status="ok"
duration=5 termination_type=exited termination_id=0 corefile=no
cutime=162 cstime=308
<<<test_end>>>
INFO: ltp-pan reported all tests PASS
LTP Version: LTP-20100131

        ###############################################################"

             Done executing testcases."
             LTP Version:  LTP-20100131
        ###############################################################"

mhs21a:/opt/ltp #

Fri Feb  5 10:39:19 IST 2010
Total tests: 99; passed: 99; failed: 0


Thanks
Rishi

> gcooper@orangebox /scratch/ltp $ emerge --info
> Portage 2.1.7.16 (default/linux/amd64/10.0, gcc-4.3.4,
> glibc-2.10.1-r1, 2.6.31-gentoo-r6 x86_64)
> =================================================================
> System uname: Linux-2.6.31-gentoo-r6-x86_64-Intel-R-_Core-TM-2_Quad_CPU_Q9400_@_2.66GHz-with-gentoo-1.12.13
> Timestamp of tree: Sat, 30 Jan 2010 09:30:01 +0000
> app-shells/bash:     4.0_p35
> dev-java/java-config: 2.1.9-r2
> dev-lang/python:     2.6.4
> sys-apps/baselayout: 1.12.13
> sys-apps/sandbox:    1.6-r2
> sys-devel/autoconf:  2.13, 2.63-r1
> sys-devel/automake:  1.9.6-r2, 1.10.2
> sys-devel/binutils:  2.18-r3
> sys-devel/gcc-config: 1.4.1
> sys-devel/libtool:   2.2.6b
> virtual/os-headers:  2.6.27-r2
>
> Thanks,
> -Garrett
>
> ------------------------------------------------------------------------------
> The Planet: dedicated and managed hosting, cloud storage, colocation
> Stay online with enterprise data centers and the best network in the business
> Choose flexible plans and management services without long-term contracts
> Personal 24x7 support from experience hosting pros just a phone call away.
> http://p.sf.net/sfu/theplanet-com
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
>    


------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
