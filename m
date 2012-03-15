Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1S82c1-0007IX-WA
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 04:48:30 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1S82c0-0002yh-Mm
	for ltp-list@lists.sourceforge.net; Thu, 15 Mar 2012 04:48:29 +0000
Message-ID: <4F616F4A.3040506@cn.fujitsu.com>
Date: Thu, 15 Mar 2012 12:25:46 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4F61650D.2060308@casparzhang.com>
	<1331783585-18980-1-git-send-email-gaowanlong@cn.fujitsu.com>
	<4F6169B5.9020205@casparzhang.com>
In-Reply-To: <4F6169B5.9020205@casparzhang.com>
Subject: Re: [LTP] [PATCH V3] readlink03: fix return value for the syscall
	readlink()
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
Cc: LTP list <ltp-list@lists.sourceforge.net>

On 03/15/2012 12:01 PM, Caspar Zhang wrote:

> Hi,
> 
> On 03/15/2012 11:53 AM, Wanlong Gao wrote:
>> Since commit http://git.kernel.org/linus/65cfc672
>> which added O_PATH support to the *at() calls, the error return for readlink/readlinkat
>> for the empty pathname has switched from ENOENT to EINVAL. And this patch merged to linux v2.6.39,
>> So LTP commit https://github.com/linux-test-project/ltp/commit/0cc7514
>> fix this with the kernel version v2.6.39 compared.
>>
>> But recently, commit http://git.kernel.org/linus/1fa1e7f6
>> which ensure we return ENOENT for the empty pathname for normal lookups.
>>
>> Now, the patch whitch switch the return value back again is already queued for
>> 3.0 and 3.1 stable release.
>>
>> So, if the return value is EINVAL for empty pathname, it may be a kernel bug, so we
>> needn't to check the kernel version but return the "kernel bug" INFO to LTP the users.
> 
> Hmmm, picky advice: wrapper the line <= 73 character in commit message.


OK.

> 
>>
>> Signed-off-by: Wanlong Gao <gaowanlong@cn.fujitsu.com>
>> Acked-by: Jan Stancek <jstancek@redhat.com>
>> ---
> 
> [snip]
> 
>> +				if ((strncmp(test_desc, "Symlink Pathname is empty", 25) == 0) &&
>> +				     TEST_ERRNO == EINVAL)
>> +					tst_resm(TWARN, "It may be a Kernel Bug, see the patch:\n"
> 
> picky advice #2: I think without this \n we can still get a good-looking
> warning message.
> 
>> +						 "http://git.kernel.org/linus/1fa1e7f6\n");
> 
> I guess \n in this line should be removed.


Sure, I was brain-dead.

Thanks,
Wanlong Gao

> 
> How do you think?
> 
> Thanks,
> Caspar
> 



------------------------------------------------------------------------------
This SF email is sponsosred by:
Try Windows Azure free for 90 days Click Here 
http://p.sf.net/sfu/sfd2d-msazure
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
