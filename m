Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by 335xhf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <gomuthuk@linux.vnet.ibm.com>) id 1MNmru-00087J-0T
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 12:00:22 +0000
Received: from e28smtp03.in.ibm.com ([59.145.155.3])
	by 3b2kzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1MNmrk-0006HD-89
	for ltp-list@lists.sourceforge.net; Mon, 06 Jul 2009 12:00:16 +0000
Message-ID: <4A51E745.3060105@linux.vnet.ibm.com>
Date: Mon, 06 Jul 2009 17:30:05 +0530
From: gowrishankar <gomuthuk@linux.vnet.ibm.com>
MIME-Version: 1.0
References: <4A51CEDC.6080605@linux.vnet.ibm.com> <4A51E253.200@st.com>
In-Reply-To: <4A51E253.200@st.com>
Subject: Re: [LTP] [PATCH] cgroups: conditionally enable building cgroup
	tests
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
To: Francesco RUNDO <francesco.rundo@st.com>
Cc: ltp-list@lists.sf.net

Hi Francesco,

Francesco RUNDO wrote:
> Hi Gowri,
> 
> I've already fixed the same issue you reported. I've tested it successfully.
> 
> Subrata has already merged my patch (please, find it in attachment).
> 
> Please, check it before to submit another patch.
> 

I had already seen your patch and generated mine on top of Jun release (which
has your fix for CROSS_COMPILE).Your patch could not help in a scenario where 
kernel has cgroup support but cgroupstat.h file is missing in base OS, and
build failed. And hence, I am proposing this patch.

Thanks,
Gowri

> Thanks
> Regards
> Francesco Rundo
> 
> gowrishankar wrote:
>> Hi Subrata,
>> Please accept the patch below.
>>
>> Thanks,
>> Gowri
>> ---
>> cgroups: conditionally enable building cgroup tests
>>
>> controllers tests gets included into default ltp build if "/proc/cgroup"
>> exists. It stops the ltp build in realtime kernel environment where 
>> kernel
>> is new and supports cgroups, but necessary file "linux/cgroupstats.h" 
>> may not
>> exist in the base OS (like RHEL5.3). So configure command enables the 
>> build,
>> but actual build fails, due to missing header file.
>>
>> Below patch proposes new symbol LTP_CHECK_CGROUPSTATS to check for 
>> header file
>> "linux/cgroupstats.h" and include controllers in the list of tests to 
>> build.
>>
>> Tested the patch in non-RT as well as RT environment for the changes.
>>
>> Signed-off-by: Gowrishankar <gowrishankar.m@in.ibm.com>
>> Tested-by: Gowrishankar <gowrishankar.m@in.ibm.com>
>> ---
>>
>> ------------------------------------------------------------------------
>>
>> Index: ltp-full-20090630/m4/ltp-cgroupstats.m4
>> ===================================================================
>> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
>> +++ ltp-full-20090630/m4/ltp-cgroupstats.m4	2009-07-03 13:41:55.000000000 +0530
>> @@ -0,0 +1,9 @@
>> +dnl
>> +dnl LTP_CHECK_CGROUPSTATS
>> +dnl ----------------------------
>> +dnl
>> +AC_DEFUN([LTP_CHECK_CGROUPSTATS],
>> +[dnl
>> +AC_CHECK_HEADERS(linux/cgroupstats.h,[LTP_CHECK_CGROUPSTATS_HEADER=yes])
>> +AC_SUBST(LTP_CHECK_CGROUPSTATS_HEADER)
>> +])
>> Index: ltp-full-20090630/configure.ac
>> ===================================================================
>> --- ltp-full-20090630.orig/configure.ac	2009-07-03 13:59:48.000000000 +0530
>> +++ ltp-full-20090630/configure.ac	2009-07-03 14:00:14.000000000 +0530
>> @@ -21,5 +21,6 @@
>>  LTP_CHECK_SELINUX
>>  LTP_CHECK_CRYPTO
>>  LTP_CHECK_TASKSTATS
>> +LTP_CHECK_CGROUPSTATS
>>
>>  AC_OUTPUT
>> Index: ltp-full-20090630/testcases/kernel/Makefile
>> ===================================================================
>> --- ltp-full-20090630.orig/testcases/kernel/Makefile	2009-07-03 14:01:25.000000000 +0530
>> +++ ltp-full-20090630/testcases/kernel/Makefile	2009-07-03 14:02:42.000000000 +0530
>> @@ -1,6 +1,12 @@
>> -SUBDIRS = power_management numa containers controllers connectors include fs io ipc mem pty sched security syscalls timers
>> +include ../../config.mk
>> +
>> +SUBDIRS = power_management numa containers connectors include fs io ipc mem pty sched security syscalls timers
>>  UCLINUX_SUBDIRS = include syscalls
>>
>> +ifeq ($(LTP_CHECK_CGROUPSTATS_HEADER),yes)
>> +	SUBDIRS+= controllers
>> +endif
>> +
>>  all:
>>  	@set -e; for i in $(SUBDIRS); do $(MAKE) -C $$i ; done
>>
>>   
>> ------------------------------------------------------------------------
>>
>> ------------------------------------------------------------------------------
>>   
>> ------------------------------------------------------------------------
>>
>> _______________________________________________
>> Ltp-list mailing list
>> Ltp-list@lists.sourceforge.net
>> https://lists.sourceforge.net/lists/listinfo/ltp-list
>>   


------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
