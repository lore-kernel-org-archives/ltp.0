Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NPcQl-0007L1-HB
	for ltp-list@lists.sourceforge.net; Tue, 29 Dec 2009 13:48:11 +0000
Received: from mail-pw0-f43.google.com ([209.85.160.43])
	by sfi-mx-1.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NPcQg-0008SN-UL
	for ltp-list@lists.sourceforge.net; Tue, 29 Dec 2009 13:48:11 +0000
Received: by pwj11 with SMTP id 11so7348373pwj.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 29 Dec 2009 05:48:00 -0800 (PST)
References: <4B38DCFA.9000502@petalogix.com>
	<9E3BA855-8CA7-414D-9622-2949FAD0416A@gmail.com>
	<4B39C071.2010100@petalogix.com>
Message-Id: <563FBE44-4156-44F0-BA0C-BE46488AD847@gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <4B39C071.2010100@petalogix.com>
Mime-Version: 1.0 (iPhone Mail 7D11)
Date: Tue, 29 Dec 2009 05:47:50 -0800
Subject: Re: [LTP] Autotools
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
To: "michal.simek@petalogix.com" <michal.simek@petalogix.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Yeah, I usually don't top-post, but emailing via smartphones is fun,  
so... :)

It sounds like your sources are incomplete -- 1) do you have an m4  
directory at the top of the source tree and 2) is it populated with m4  
files?

Thanks,
-Garrett

PS your tools' versions look ok.

On Dec 29, 2009, at 12:40 AM, Michal Simek  
<michal.simek@petalogix.com> wrote:

> Hi,
> sorry for head quoting but it is better for your phone.:-)
> I have interesting fault.
> aclocal -I m4     works
> but
> autoreconf -I m4
> aclocal: couldn't open directory `m4': No such file or directory
> autoreconf: aclocal failed with exit status: 1
>
> Which versions do you use?
> autoconf - 2.65
> automake - 1.11
> m4 - 1.4.13
>
> Thanks,
> Michal
>
> Garrett Cooper wrote:
>> Michal,
>>    Just invoke autoreconf -I m4 and you'll get your desired result.  
>> No commit required (except maybe another 'recipe' in INSTALL --  
>> which I'd be more than happy to do after the 5th when I have real  
>> Internet access ;]...). The problem with your proposed method is  
>> that it was skipping a large number of autoconf portability tests  
>> in the .m4 files, thus the configuration was pretty minimal...
>> Cheers!
>> -Garrett
>> Sent from my iPhone
>> On Dec 28, 2009, at 8:29 AM, Michal Simek  
>> <michal.simek@petalogix.com> wrote:
>>> Hi Garret,
>>>
>>> I am trying to configure LTP properly.
>>> First thing which seems to me weird is that in INSTALL is for  
>>> "Using autoconf" command make autotools
>>>
>>> autoreconf --install
>>>
>>> There are some warnings which could be fixed.
>>>
>>> then I am running
>>>
>>> ./configure --prefix=/tmp/
>>>
>>> and I see there
>>>
>>> ./configure: line 4566: LTP_CHECK_CAPABILITY_SUPPORT: command not  
>>> found
>>> ./configure: line 4567: LTP_CHECK_CRYPTO: command not found
>>> ./configure: line 4568: LTP_CHECK_LINUX_PTRACE: command not found
>>> ./configure: line 4569: LTP_CHECK_SELINUX: command not found
>>> ./configure: line 4570: LTP_CHECK_SIGNAL: command not found
>>> ./configure: line 4571: LTP_CHECK_SYSCALL_EVENTFD: command not found
>>> ./configure: line 4572: LTP_CHECK_SYSCALL_MODIFY_LDT: command not  
>>> found
>>> ./configure: line 4573: LTP_CHECK_SYSCALL_NUMA: command not found
>>> ./configure: line 4574: LTP_CHECK_SYSCALL_QUOTACTL: command not  
>>> found
>>> ./configure: line 4575: LTP_CHECK_SYSCALL_SIGNALFD: command not  
>>> found
>>> ./configure: line 4576: LTP_CHECK_SYSCALL_UNSHARE: command not found
>>> ./configure: line 4577: LTP_CHECK_TASKSTATS: command not found
>>>
>>> ./configure: line 4759: REALTIME_CHECK_PRIO_INHERIT: command not  
>>> found
>>> ./configure: line 4760: REALTIME_CHECK_ROBUST_APIS: command not  
>>> found
>>>
>>> + there are some missing dependency in configure.ac file. This  
>>> patch should add them. I just grep whole LTP source - maybe some  
>>> are not important.
>>>
>>> diff --git a/configure.ac b/configure.ac
>>> index 52f3381..7a72b36 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -39,11 +39,26 @@ AC_CHECK_HEADERS([ \
>>>    linux/mempolicy.h \
>>>    linux/module.h \
>>>    linux/netlink.h \
>>> +    linux/ptrace.h \
>>> +    linux/cgroupstats.h \
>>> +    linux/taskstats.h \
>>> +    linux/types.h \
>>>    sys/acl.h \
>>>    sys/epoll.h \
>>>    sys/inotify.h \
>>> +    sys/ptrace.h \
>>> +    sys/reg.h \
>>> +    asm/ldt.h \
>>> +    asm/ptrace.h \
>>>    sys/jfsdmapi.h \
>>>    sys/prctl.h \
>>> +    sys/epoll.h \
>>> +    sys/ptrace.h \
>>> +    sys/reg.h \
>>> +    sys/stat.h \
>>> +    sys/time.h \
>>> +    sys/types.h \
>>> +    sys/vfs.h \
>>> ])
>>>
>>>
>>> and then run make - there previous fault in configure caused that  
>>> there are wrong symbols in Makefiles - for example for my case.
>>>
>>> microblaze-unknown-linux-gnu-gcc: @SELINUX_LIBS@: No such file or  
>>> directory
>>>
>>> which is caused by problems in configure.
>>>
>>> Thanks for fixing,
>>> Michal
>>>
>>> -- 
>>> Michal Simek, Ing. (M.Eng)
>>> PetaLogix - Linux Solutions for a Reconfigurable World
>>> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663
>
>
> -- 
> Michal Simek, Ing. (M.Eng)
> PetaLogix - Linux Solutions for a Reconfigurable World
> w: www.petalogix.com p: +61-7-30090663,+42-0-721842854 f: +61-7-30090663

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
