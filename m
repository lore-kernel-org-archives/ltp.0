Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <michal.simek@petalogix.com>) id 1NQLjP-0003FG-CA
	for ltp-list@lists.sourceforge.net; Thu, 31 Dec 2009 14:10:27 +0000
Received: from mail-fx0-f222.google.com ([209.85.220.222])
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NQLjG-0004C0-Ph
	for ltp-list@lists.sourceforge.net; Thu, 31 Dec 2009 14:10:26 +0000
Received: by fxm22 with SMTP id 22so15910822fxm.2
	for <ltp-list@lists.sourceforge.net>;
	Thu, 31 Dec 2009 06:09:55 -0800 (PST)
Message-ID: <4B3CA234.7060402@petalogix.com>
Date: Thu, 31 Dec 2009 14:08:04 +0100
From: Michal Simek <michal.simek@petalogix.com>
MIME-Version: 1.0
References: <4B38DCFA.9000502@petalogix.com>
	<9E3BA855-8CA7-414D-9622-2949FAD0416A@gmail.com>
	<4B39C071.2010100@petalogix.com>
	<563FBE44-4156-44F0-BA0C-BE46488AD847@gmail.com>
In-Reply-To: <563FBE44-4156-44F0-BA0C-BE46488AD847@gmail.com>
Subject: Re: [LTP] Autotools
Reply-To: michal.simek@petalogix.com
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
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

My source is up-to-date - I did clean cvs copy again for sure.

[monstr@monstr ltp]$ ls -la m4/
total 72
drwxrwxr-x  3 monstr monstr 4096 Dec 31 13:53 .
drwxrwxr-x 19 monstr monstr 4096 Dec 31 13:55 ..
drwxrwxr-x  2 monstr monstr 4096 Dec 31 13:53 CVS
-rw-rw-r--  1 monstr monstr 1115 Oct  9 19:55 GNUmakefile
-rw-rw-r--  1 monstr monstr 1482 Oct  9 19:55 ltp-cap.m4
-rw-rw-r--  1 monstr monstr  221 Jul  6 17:34 ltp-cgroupstats.m4
-rw-rw-r--  1 monstr monstr  191 Oct  9 19:55 ltp-crypto.m4
-rw-rw-r--  1 monstr monstr 1519 Oct 19 00:36 ltp-eventfd.m4
-rw-rw-r--  1 monstr monstr 1200 Nov 18  2008 ltp-modify_ldt.m4
-rw-rw-r--  1 monstr monstr 1216 Dec 23 01:05 ltp-numa.m4
-rw-rw-r--  1 monstr monstr 1466 Dec 20 00:38 ltp-ptrace.m4
-rw-rw-r--  1 monstr monstr 2024 Dec 20 01:36 ltp-quota.m4
-rw-rw-r--  1 monstr monstr 1225 Mar 16  2009 ltp-selinux.m4
-rw-rw-r--  1 monstr monstr 2794 Dec 20 01:39 ltp-signalfd.m4
-rw-rw-r--  1 monstr monstr 1429 Nov 30 13:26 ltp-signal.m4
-rw-rw-r--  1 monstr monstr 1416 Oct 17 08:53 ltp-taskstats.m4
-rw-rw-r--  1 monstr monstr  975 Oct 17 04:43 ltp-unshare.m4
-rw-rw-r--  1 monstr monstr   37 Jan 18  2009 Makefile.am


[monstr@monstr ltp]$ aclocal -I m4 --verbose
aclocal: found macro AC_PROG_AR in configure.ac: 22
aclocal: found macro AC_PROG_STRIP in configure.ac: 26
aclocal: found macro LTP_CHECK_SYSCALL_UNSHARE in m4/ltp-unshare.m4: 25
aclocal: found macro LTP_CHECK_TASKSTATS in m4/ltp-taskstats.m4: 19
aclocal: found macro _LTP_CHECK_TASKSTATS_FREEPAGES in 
m4/ltp-taskstats.m4: 30
aclocal: found macro LTP_CHECK_SYSCALL_SIGNALFD in m4/ltp-signalfd.m4: 38
aclocal: found macro _LTP_CHECK_SYSCALL_SIGNALFD_FUNCTION in 
m4/ltp-signalfd.m4: 52
aclocal: found macro _LTP_CHECK_SYSCALL_SIGNALFD_HEADER in 
m4/ltp-signalfd.m4: 59
...
and many others - which is ok. But

[monstr@monstr ltp]$ autoreconf -I m4 --install --verbose
autoreconf: Entering directory `.'
autoreconf: configure.ac: not using Gettext
autoreconf: running: aclocal -I m4
autoreconf: configure.ac: tracing
autoreconf: configure.ac: adding subdirectory 
testcases/kernel/syscalls/libevent to autoreconf
autoreconf: Entering directory `testcases/kernel/syscalls/libevent'
autoreconf: configure.in: not using Gettext
aclocal: couldn't open directory `m4': No such file or directory
autoreconf: aclocal failed with exit status: 1

seems to me that is problem with tools versions. :-(

Michal





Garrett Cooper wrote:
> Yeah, I usually don't top-post, but emailing via smartphones is fun, 
> so... :)
> 
> It sounds like your sources are incomplete -- 1) do you have an m4 
> directory at the top of the source tree and 2) is it populated with m4 
> files?
> 
> Thanks,
> -Garrett
> 
> PS your tools' versions look ok.
> 
> On Dec 29, 2009, at 12:40 AM, Michal Simek <michal.simek@petalogix.com> 
> wrote:
> 
>> Hi,
>> sorry for head quoting but it is better for your phone.:-)
>> I have interesting fault.
>> aclocal -I m4     works
>> but
>> autoreconf -I m4
>> aclocal: couldn't open directory `m4': No such file or directory
>> autoreconf: aclocal failed with exit status: 1
>>
>> Which versions do you use?
>> autoconf - 2.65
>> automake - 1.11
>> m4 - 1.4.13
>>
>> Thanks,
>> Michal
>>
>> Garrett Cooper wrote:
>>> Michal,
>>>    Just invoke autoreconf -I m4 and you'll get your desired result. 
>>> No commit required (except maybe another 'recipe' in INSTALL -- which 
>>> I'd be more than happy to do after the 5th when I have real Internet 
>>> access ;]...). The problem with your proposed method is that it was 
>>> skipping a large number of autoconf portability tests in the .m4 
>>> files, thus the configuration was pretty minimal...
>>> Cheers!
>>> -Garrett
>>> Sent from my iPhone
>>> On Dec 28, 2009, at 8:29 AM, Michal Simek 
>>> <michal.simek@petalogix.com> wrote:
>>>> Hi Garret,
>>>>
>>>> I am trying to configure LTP properly.
>>>> First thing which seems to me weird is that in INSTALL is for "Using 
>>>> autoconf" command make autotools
>>>>
>>>> autoreconf --install
>>>>
>>>> There are some warnings which could be fixed.
>>>>
>>>> then I am running
>>>>
>>>> ./configure --prefix=/tmp/
>>>>
>>>> and I see there
>>>>
>>>> ./configure: line 4566: LTP_CHECK_CAPABILITY_SUPPORT: command not found
>>>> ./configure: line 4567: LTP_CHECK_CRYPTO: command not found
>>>> ./configure: line 4568: LTP_CHECK_LINUX_PTRACE: command not found
>>>> ./configure: line 4569: LTP_CHECK_SELINUX: command not found
>>>> ./configure: line 4570: LTP_CHECK_SIGNAL: command not found
>>>> ./configure: line 4571: LTP_CHECK_SYSCALL_EVENTFD: command not found
>>>> ./configure: line 4572: LTP_CHECK_SYSCALL_MODIFY_LDT: command not found
>>>> ./configure: line 4573: LTP_CHECK_SYSCALL_NUMA: command not found
>>>> ./configure: line 4574: LTP_CHECK_SYSCALL_QUOTACTL: command not found
>>>> ./configure: line 4575: LTP_CHECK_SYSCALL_SIGNALFD: command not found
>>>> ./configure: line 4576: LTP_CHECK_SYSCALL_UNSHARE: command not found
>>>> ./configure: line 4577: LTP_CHECK_TASKSTATS: command not found
>>>>
>>>> ./configure: line 4759: REALTIME_CHECK_PRIO_INHERIT: command not found
>>>> ./configure: line 4760: REALTIME_CHECK_ROBUST_APIS: command not found
>>>>
>>>> + there are some missing dependency in configure.ac file. This patch 
>>>> should add them. I just grep whole LTP source - maybe some are not 
>>>> important.
>>>>
>>>> diff --git a/configure.ac b/configure.ac
>>>> index 52f3381..7a72b36 100644
>>>> --- a/configure.ac
>>>> +++ b/configure.ac
>>>> @@ -39,11 +39,26 @@ AC_CHECK_HEADERS([ \
>>>>    linux/mempolicy.h \
>>>>    linux/module.h \
>>>>    linux/netlink.h \
>>>> +    linux/ptrace.h \
>>>> +    linux/cgroupstats.h \
>>>> +    linux/taskstats.h \
>>>> +    linux/types.h \
>>>>    sys/acl.h \
>>>>    sys/epoll.h \
>>>>    sys/inotify.h \
>>>> +    sys/ptrace.h \
>>>> +    sys/reg.h \
>>>> +    asm/ldt.h \
>>>> +    asm/ptrace.h \
>>>>    sys/jfsdmapi.h \
>>>>    sys/prctl.h \
>>>> +    sys/epoll.h \
>>>> +    sys/ptrace.h \
>>>> +    sys/reg.h \
>>>> +    sys/stat.h \
>>>> +    sys/time.h \
>>>> +    sys/types.h \
>>>> +    sys/vfs.h \
>>>> ])
>>>>
>>>>
>>>> and then run make - there previous fault in configure caused that 
>>>> there are wrong symbols in Makefiles - for example for my case.
>>>>
>>>> microblaze-unknown-linux-gnu-gcc: @SELINUX_LIBS@: No such file or 
>>>> directory
>>>>
>>>> which is caused by problems in configure.
>>>>
>>>> Thanks for fixing,
>>>> Michal
>>>>
>>>> -- 
>>>> Michal Simek, Ing. (M.Eng)
>>>> PetaLogix - Linux Solutions for a Reconfigurable World
>>>> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: 
>>>> +61-7-30090663
>>
>>
>> -- 
>> Michal Simek, Ing. (M.Eng)
>> PetaLogix - Linux Solutions for a Reconfigurable World
>> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663


-- 
Michal Simek, Ing. (M.Eng)
PetaLogix - Linux Solutions for a Reconfigurable World
w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

------------------------------------------------------------------------------
This SF.Net email is sponsored by the Verizon Developer Community
Take advantage of Verizon's best-in-class app development support
A streamlined, 14 day to market process makes app distribution fast and easy
Join now and get one step closer to millions of Verizon customers
http://p.sf.net/sfu/verizon-dev2dev 
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
