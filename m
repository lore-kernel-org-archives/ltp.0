Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1RNftS-0007ZB-UN
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 07:14:50 +0000
Received: from mx3-phx2.redhat.com ([209.132.183.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RNftR-0003k0-VB
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 07:14:50 +0000
Date: Tue, 08 Nov 2011 02:14:40 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <f8f55a57-966a-4523-ae6a-94179b2636bc@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4EB89D0C.1080100@cn.fujitsu.com>
MIME-Version: 1.0
Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was forked
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



----- Original Message -----
> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> To: "Jan Stancek" <jstancek@redhat.com>
> Cc: ltp-list@lists.sourceforge.net
> Sent: Tuesday, November 8, 2011 4:07:56 AM
> Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was forked
> 
> On 11/07/2011 08:53 PM, Jan Stancek wrote:
> 
> > 
> > If start_server() fails, then pid will end up with -1 and
> > cleanup() will do kill(-1, SIGKILL), which kills everything
> > this process can kill.
> > 
> > Change the test to kill pid (child) only when it successfully
> > creates one.
> > 
> 
> 
> Yeah, but this can't fix the problem in this case?
> 
> recvmsg01    1  TBROK  :  server bind failed: errno=???(98): Address
> already in use
> recvmsg01    2  TBROK  :  Remaining cases broken
> 

I'm not sure I follow you here.
In case you described start_server() returns -1,
so pid = -1, and cleanup won't do kill(-1, SIGKILL).

Regards,
Jan

> 
> Thanks
> -Wanlong Gao
> 
> > Signed-off-by: Jan Stancek <jstancek@redhat.com>
> > ---
> >   testcases/kernel/syscalls/recvmsg/recvmsg01.c |    5 +++--
> >   1 files changed, 3 insertions(+), 2 deletions(-)
> > 
> > 
> 
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
