Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Tnhnu-0005YT-2N
	for ltp-list@lists.sourceforge.net; Wed, 26 Dec 2012 03:37:14 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Tnhns-0001s2-KS
	for ltp-list@lists.sourceforge.net; Wed, 26 Dec 2012 03:37:14 +0000
Message-ID: <50DA70F9.9000402@cn.fujitsu.com>
Date: Wed, 26 Dec 2012 11:37:29 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <1356420335-4204-1-git-send-email-jshao@redhat.com>
	<50D958CA.4010406@casparzhang.com>
	<1356434591.8314.36.camel@station.monson>
	<50DA679D.7010502@casparzhang.com>
In-Reply-To: <50DA679D.7010502@casparzhang.com>
Subject: Re: [LTP] [PATCH] pidns30 pidns31: syscall mq_open() failed
 EFAULT(Bad address)
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
To: Monson Shao <jshao@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/26/2012 10:57 AM, Caspar Zhang wrote:
> On 12/25/2012 07:23 PM, Monson Shao wrote:
>> On Tue, 2012-12-25 at 15:42 +0800, Caspar Zhang wrote:
>>> On 12/25/2012 03:25 PM, Monson Shao wrote:
>>>> 'man 3 mq_open' said mq_open() can take 2 or 4 arguments, but the implement
>>>> syscall(__NR_mq_open, ...) takes 4, according to [1].
>>>>
>>>> Manually tested on kernel-3.6.0 with glibc-2.16 .
>>>>
>>>> [1] glibc/sysdeps/unix/sysv/linux/mq_open.c:55
>>>
>>> will this change the result on old kernel/glibc?
>>>
>>> Caspar
>> I haven't tested it on old kernel/glibc, but 4 arguments should always
>> be acceptable, since this usage exists in the same file [2].
> 
> Makes sense.
> 
> Reviewed-by: Caspar Zhang <caspar@casparzhang.com>

Applied, thank you.

Wanlong Gao


------------------------------------------------------------------------------
LogMeIn Rescue: Anywhere, Anytime Remote support for IT. Free Trial
Remotely access PCs and mobile devices and provide instant support
Improve your efficiency, and focus on delivering more value-add services
Discover what IT Professionals Know. Rescue delivers
http://p.sf.net/sfu/logmein_12329d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
