Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Markos.Chandras@imgtec.com>) id 1VksMx-0007il-Cn
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 09:22:15 +0000
Received: from multi.imgtec.com ([194.200.65.239])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1VksMt-0003C3-Hh
	for ltp-list@lists.sourceforge.net; Mon, 25 Nov 2013 09:22:15 +0000
Message-ID: <529316BD.5090604@imgtec.com>
Date: Mon, 25 Nov 2013 09:22:05 +0000
From: Markos Chandras <Markos.Chandras@imgtec.com>
MIME-Version: 1.0
References: <1385130059-12150-1-git-send-email-markos.chandras@imgtec.com>
	<5292F8E3.4000903@cn.fujitsu.com>
In-Reply-To: <5292F8E3.4000903@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] ptrace: Fix build problems with glibc-2.18
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
To: gaowanlong@cn.fujitsu.com
Cc: ltp-list@lists.sourceforge.net

On 11/25/2013 07:14 AM, Wanlong Gao wrote:
> On 11/22/2013 10:20 PM, Markos Chandras wrote:
>> Since glibc-2.18, the struct ptrace_peeksiginfo_args is
>> also defined in sys/ptrace.h and conflicts with the definition
>> from the Linux kernel in linux/ptrace.h. We fix this by not
>> including the linux/ptrace.h header if the sys/ptrace.h header
>> defines the said struct. Fixes
>> https://github.com/linux-test-project/ltp/issues/6
>>
>> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
>> ---
>> Build tested on glibc-2.17 and glibc-2.18 systems
>> ---
>>   configure.ac                              | 4 ++++
>>   include/config.h.default                  | 3 +++
>>   testcases/kernel/syscalls/ptrace/ptrace.h | 4 +++-
>>   3 files changed, 10 insertions(+), 1 deletion(-)
>>
>> diff --git a/configure.ac b/configure.ac
>> index 4846afd..d427276 100644
>> --- a/configure.ac
>> +++ b/configure.ac
>> @@ -48,6 +48,10 @@ AC_CHECK_HEADERS([ \
>>       sys/prctl.h \
>>   ])
>>
>> +# glibc-2.18 defines ptrace_peeksiginfo_args in sys/ptrace.h which
>> +# conflicts with the one from linux kernel in linux/ptrace.h
>> +AC_CHECK_TYPES([struct ptrace_peeksiginfo_args],,,[#include <sys/ptrace.h>])
>
> We generally place this like checks to m4/*.
>
>> +
>>   # Tools knobs
>>
>>   # Expect
>> diff --git a/include/config.h.default b/include/config.h.default
>> index 96e25c4..f226333 100644
>> --- a/include/config.h.default
>> +++ b/include/config.h.default
>> @@ -167,6 +167,9 @@
>>   /* Define to 1 if the system has the type `struct modify_ldt_ldt_s'. */
>>   #undef HAVE_STRUCT_MODIFY_LDT_LDT_S
>>
>> +/* Define to 1 if the system has the type `struct ptrace_peeksiginfo_args'. */
>> +#undef HAVE_STRUCT_PTRACE_PEEKSIGINFO_ARG
>
> Missed an "S" here?
>
> Thanks,
> Wanlong Gao
>
>> +
>>   /* Define to 1 if `signo' is member of `struct signalfd_siginfo'. */
>>   #undef HAVE_STRUCT_SIGNALFD_SIGINFO_SIGNO
>>
>> diff --git a/testcases/kernel/syscalls/ptrace/ptrace.h b/testcases/kernel/syscalls/ptrace/ptrace.h
>> index f0767d7..4a43f01 100644
>> --- a/testcases/kernel/syscalls/ptrace/ptrace.h
>> +++ b/testcases/kernel/syscalls/ptrace/ptrace.h
>> @@ -19,7 +19,9 @@
>>   # include <asm/ptrace.h>
>>   #endif
>>   #ifdef HAVE_LINUX_PTRACE_H
>> -# include <linux/ptrace.h>
>> +# ifndef HAVE_STRUCT_PTRACE_PEEKSIGINFO_ARGS
>> +#  include <linux/ptrace.h>
>> +# endif
>>   #endif
>>   #undef FU_ia64_fpreg
>>   #undef FU_pt_all_user_regs
>>
>
Thanks for the review. I will send a v2 soon

-- 
markos


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
