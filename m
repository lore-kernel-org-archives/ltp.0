Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gaowanlong@cn.fujitsu.com>) id 1RNc3g-0001ws-Iy
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 03:09:08 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RNc3f-0006QS-2h
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 03:09:08 +0000
Message-ID: <4EB89D0C.1080100@cn.fujitsu.com>
Date: Tue, 08 Nov 2011 11:07:56 +0800
From: Wanlong Gao <gaowanlong@cn.fujitsu.com>
MIME-Version: 1.0
References: <4EB7D4D6.5000704@redhat.com>
In-Reply-To: <4EB7D4D6.5000704@redhat.com>
Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was forked
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

On 11/07/2011 08:53 PM, Jan Stancek wrote:

> 
> If start_server() fails, then pid will end up with -1 and
> cleanup() will do kill(-1, SIGKILL), which kills everything
> this process can kill.
> 
> Change the test to kill pid (child) only when it successfully
> creates one.
> 


Yeah, but this can't fix the problem in this case?

recvmsg01    1  TBROK  :  server bind failed: errno=???(98): Address already in use
recvmsg01    2  TBROK  :  Remaining cases broken


Thanks
-Wanlong Gao

> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>   testcases/kernel/syscalls/recvmsg/recvmsg01.c |    5 +++--
>   1 files changed, 3 insertions(+), 2 deletions(-)
> 
> 



------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
