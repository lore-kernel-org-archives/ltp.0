Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <li.dan@cn.fujitsu.com>) id 1V41Ng-0005Cd-LG
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 04:17:52 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V41Ne-0003DH-Se
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 04:17:52 +0000
Received: from fnstmail02.fnst.cn.fujitsu.com (tang.cn.fujitsu.com [127.0.0.1])
	by tang.cn.fujitsu.com (8.14.3/8.13.1) with ESMTP id r6U4Hgg8026496
	for <ltp-list@lists.sourceforge.net>; Tue, 30 Jul 2013 12:17:43 +0800
Message-ID: <51F73E13.9040802@cn.fujitsu.com>
Date: Tue, 30 Jul 2013 12:16:19 +0800
From: DAN LI <li.dan@cn.fujitsu.com>
MIME-Version: 1.0
References: <51F7338D.4060804@cn.fujitsu.com> <51F735B2.5030007@cn.fujitsu.com>
In-Reply-To: <51F735B2.5030007@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] mount/mount06.c: fix a compile error
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 07/30/2013 11:40 AM, Wanlong Gao wrote:
> On 07/30/2013 11:31 AM, DAN LI wrote:
>>
>> The definitions of MS_PRIVATE and MS_MOVE were only added to glibc headers
>> in version 2.12.
>>
>> If the version of glibc is older than 2.12, define these two flags.
>>
>> Signed-off-by: DAN LI <li.dan@cn.fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/mount/mount06.c |    5 +++++
>>  1 files changed, 5 insertions(+), 0 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/mount/mount06.c b/testcases/kernel/syscalls/mount/mount06.c
>> index acfb22d..ab1a472 100644
>> --- a/testcases/kernel/syscalls/mount/mount06.c
>> +++ b/testcases/kernel/syscalls/mount/mount06.c
>> @@ -31,6 +31,11 @@
>>  #include "usctest.h"
>>  #include "safe_macros.h"
>>
>> +#if !(__GLIBC_PREREQ(2, 12))
> 
> Why not do like below?

I think it also clearly shows the reason why this definition should
exist here(glibc version related).

Regards,
DAN LI

> #ifndef MS_MOVE
> #define xxx
> #define xxx
> #endif
> 
> Wanlong Gao
> 
>> +#define MS_MOVE	8192
>> +#define MS_PRIVATE	(1 << 18)
>> +#endif
>> +
>>  #define MNTPOINT_SRC	"mnt_src"
>>  #define MNTPOINT_DES	"mnt_des"
>>  #define LINELENGTH	256
>>
> 
> 



------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
