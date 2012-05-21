Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1SWOTF-0000hg-Uf
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 09:00:05 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1SWOTE-0006yu-IR
	for ltp-list@lists.sourceforge.net; Mon, 21 May 2012 09:00:05 +0000
Message-ID: <4FBA03C4.7020408@cn.fujitsu.com>
Date: Mon, 21 May 2012 16:58:44 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1337589516-9731-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4FBA01CE.5000407@casparzhang.com>
In-Reply-To: <4FBA01CE.5000407@casparzhang.com>
Subject: Re: [LTP] [PATCH] getcpu: remove the useless and improper kernel
 version check
Reply-To: gaowanlong@cn.fujitsu.com
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

On 05/21/2012 04:50 PM, Caspar Zhang wrote:

> On 05/21/2012 04:38 PM, Wanlong Gao wrote:
>> Now, kernel version up to 3.x, check for 2.6.x is useless.
> 
> The fix makes sense, however, "checking for 2.6.x" is still valid for
> old kernels (does LTP still support 2.4.x? I'm not sure...)


yes, you are right, as I said, the program itself already checked the
kernel version, check the kernel version at Makefile is conceptual wrong.

Thanks,
Wanlong Gao

> 
> Anyway,
> 
> Acked-by: Caspar Zhang <caspar@casparzhang.com>
> 
>> Additionally, we already checked the kernel version in the
>> program itself.
>> Meanwhile, check the kernel version at compiling time is wrong,
>> we may not do testing on the same machine as compiling.
>>
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>> ---
>>  testcases/kernel/syscalls/getcpu/Makefile |   14 --------------
>>  1 file changed, 14 deletions(-)
>>
>> diff --git a/testcases/kernel/syscalls/getcpu/Makefile b/testcases/kernel/syscalls/getcpu/Makefile
>> index b8bf68b..7a1a87a 100644
>> --- a/testcases/kernel/syscalls/getcpu/Makefile
>> +++ b/testcases/kernel/syscalls/getcpu/Makefile
>> @@ -19,18 +19,4 @@
>>  top_srcdir		?= ../../../..
>>  
>>  include $(top_srcdir)/include/mk/testcases.mk
>> -
>> -ifneq ($(shell uname -r | grep -c "^2\.6\.*"), 1)
>> -
>> -MAKE_TARGETS		:=
>> -
>> -.PHONY: no-all-install
>> -
>> -all install: no-all-install
>> -
>> -no-all-install:
>> -	@echo "Warning: Kernel doesn't support this test case"
>> -
>> -endif
>> -
>>  include $(top_srcdir)/include/mk/generic_leaf_target.mk
> 
> 



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
