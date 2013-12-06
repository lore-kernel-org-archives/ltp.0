Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1Vok18-0007lB-V0
	for ltp-list@lists.sourceforge.net; Fri, 06 Dec 2013 01:15:42 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Vok17-0008Em-AX
	for ltp-list@lists.sourceforge.net; Fri, 06 Dec 2013 01:15:42 +0000
Message-ID: <52A11D9F.7040702@cn.fujitsu.com>
Date: Fri, 06 Dec 2013 08:43:11 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <e4485bb27118d14c0247d35fcea0f85458cda012.1386242514.git.jstancek@redhat.com>
In-Reply-To: <e4485bb27118d14c0247d35fcea0f85458cda012.1386242514.git.jstancek@redhat.com>
Subject: Re: [LTP] [PATCH] sendmsg01: use invalid but positive msg_namelen
 value
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
To: Jan Stancek <jstancek@redhat.com>
Cc: ltp-list@lists.sourceforge.net

On 12/05/2013 07:23 PM, Jan Stancek wrote:
> After following 2 kernel commits:
>   commit 1661bf364ae9c506bc8795fef70d1532931be1e8
>   Author: Dan Carpenter <dan.carpenter@oracle.com>
>   Date:   Thu Oct 3 00:27:20 2013 +0300
>     net: heap overflow in __audit_sockaddr()
> 
>   commit db31c55a6fb245fdbb752a2ca4aefec89afabb06
>   Author: Dan Carpenter <dan.carpenter@oracle.com>
>   Date:   Wed Nov 27 15:40:21 2013 +0300
>     net: clamp ->msg_namelen instead of returning an error
> 
> msg_namelen is treated as an unsigned value because of this
> condition, which compares signed and unsigned arguments:
> net/socket.c copy_msghdr_from_user()
>   if (kmsg->msg_namelen > sizeof(struct sockaddr_storage))
> 
> User-space (accordding to POSIX spec) defines it as
> "unsigned opaque integral type of length of at least 32 bits".
> 
> Passing -1 now has the effect as passing very large number
> and syscall completes successfully.
> 
> Change the test to use invalid, but positive value for
> "invalid to buffer length" testcase.

Nice log, thank you, pushed.

Wanlong Gao


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
