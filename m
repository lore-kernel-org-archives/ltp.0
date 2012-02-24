Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <penght@cn.fujitsu.com>) id 1S0kxL-0007Ok-28
	for ltp-list@lists.sourceforge.net; Fri, 24 Feb 2012 02:32:23 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S0kxI-0002w6-RR
	for ltp-list@lists.sourceforge.net; Fri, 24 Feb 2012 02:32:22 +0000
Message-ID: <4F46F6A8.3050600@cn.fujitsu.com>
Date: Fri, 24 Feb 2012 10:32:08 +0800
From: Peng Haitao <penght@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F33254B.9080204@cn.fujitsu.com>
	<20120223162841.GD5960@saboteur.suse.cz>
	<4F46DFBE.60208@cn.fujitsu.com> <4F46F2DF.7030001@casparzhang.com>
In-Reply-To: <4F46F2DF.7030001@casparzhang.com>
Subject: Re: [LTP] [PATCH] aio02: runfstests.sh should be deleted
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
To: Caspar Zhang <caspar@casparzhang.com>
Cc: ltp-list@lists.sourceforge.net


Caspar Zhang said the following on 2012-2-24 10:15:
> On 02/24/2012 08:54 AM, Peng Haitao wrote:
>>
>> Cyril Hrubis said the following on 2012-2-24 0:28:
>>> Hi!
>>>> runfstests.sh is creating temporary directory, which could be easily done
>>>> withing the test itself by using tst_tmpdir(), So runfstests.sh should be
>>>> deleted.
>>>
>>> This patch doesn't apply as well, probably mangled by your mail cliend
>>> too. Please resend.
>>>
>>
>> Sorry:(
>>
>> I resend the patch of v2, please apply.
>> Thanks. 
>>
> Still no luck with v2 :-(
> 
> $ git am -3 ~/Desktop/\[LTP\]\ \[PATCH\]\ aio02\:\ runfstests.sh\
> should\ be\ deleted.eml

maybe you are wrong?  The patch is really v2.

# git am -3 /home/pht/\[LTP\]\ \[PATCH\ v2\]\ aio02\ \ runfstests.sh\ should\ be\ deleted.eml
Applying: aio02: runfstests.sh should be deleted
#

Thanks.

-- 
Best Regards,
Peng

> Applying: aio02: runfstests.sh should be deleted
> Using index info to reconstruct a base tree...
> error: patch failed: runtest/io:1
> error: runtest/io: patch does not apply
> error: patch failed: testcases/kernel/io/aio/aio02/Makefile:27
> error: testcases/kernel/io/aio/aio02/Makefile: patch does not apply
> error: patch failed: testcases/kernel/io/aio/aio02/README:2
> error: testcases/kernel/io/aio/aio02/README: patch does not apply
> error: patch failed: testcases/kernel/io/aio/aio02/aio_tio.c:17
> error: testcases/kernel/io/aio/aio02/aio_tio.c: patch does not apply
> error: testcases/kernel/io/aio/aio02/cases/common.h: has been
> deleted/renamed
> error: patch failed: testcases/kernel/io/aio/aio02/main.c:23
> error: testcases/kernel/io/aio/aio02/main.c: patch does not apply
> error: testcases/kernel/io/aio/aio02/runfstests.sh: has been deleted/renamed
> Did you hand edit your patch?
> It does not apply to blobs recorded in its index.
> Cannot fall back to three-way merge.
> Patch failed at 0001 aio02: runfstests.sh should be deleted
> When you have resolved this problem run "git am --resolved".
> If you would prefer to skip this patch, instead run "git am --skip".
> To restore the original branch and stop patching run "git am --abort".
> 
> 
> ------------------------------------------------------------------------------
> Virtualization & Cloud Management Using Capacity Planning
> Cloud computing makes use of virtualization - but cloud computing 
> also focuses on allowing computing to be delivered as a service.
> http://www.accelacomm.com/jaw/sfnl/114/51521223/
> _______________________________________________
> Ltp-list mailing list
> Ltp-list@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/ltp-list
> 
> 


------------------------------------------------------------------------------
Virtualization & Cloud Management Using Capacity Planning
Cloud computing makes use of virtualization - but cloud computing 
also focuses on allowing computing to be delivered as a service.
http://www.accelacomm.com/jaw/sfnl/114/51521223/
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
