Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jstancek@redhat.com>) id 1RNgS8-0004tz-Ex
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 07:50:40 +0000
Received: from mx4-phx2.redhat.com ([209.132.183.25])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1RNgS7-0005X5-Dh
	for ltp-list@lists.sourceforge.net; Tue, 08 Nov 2011 07:50:40 +0000
Date: Tue, 08 Nov 2011 02:50:27 -0500 (EST)
From: Jan Stancek <jstancek@redhat.com>
Message-ID: <fd23b1ea-f8c6-45ba-8591-78444e165a36@zmail16.collab.prod.int.phx2.redhat.com>
In-Reply-To: <4EB8D85D.1060602@cn.fujitsu.com>
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
> Sent: Tuesday, November 8, 2011 8:21:01 AM
> Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was forked
> 
> On 11/08/2011 03:14 PM, Jan Stancek wrote:
> 
> > 
> > 
> > ----- Original Message -----
> >> From: "Wanlong Gao" <gaowanlong@cn.fujitsu.com>
> >> To: "Jan Stancek" <jstancek@redhat.com>
> >> Cc: ltp-list@lists.sourceforge.net
> >> Sent: Tuesday, November 8, 2011 4:07:56 AM
> >> Subject: Re: [LTP] [PATCH] recvmsg01: kill child only if one was
> >> forked
> >>
> >> On 11/07/2011 08:53 PM, Jan Stancek wrote:
> >>
> >>>
> >>> If start_server() fails, then pid will end up with -1 and
> >>> cleanup() will do kill(-1, SIGKILL), which kills everything
> >>> this process can kill.
> >>>
> >>> Change the test to kill pid (child) only when it successfully
> >>> creates one.
> >>>
> >>
> >>
> >> Yeah, but this can't fix the problem in this case?
> >>
> >> recvmsg01    1  TBROK  :  server bind failed: errno=???(98):
> >> Address
> >> already in use
> >> recvmsg01    2  TBROK  :  Remaining cases broken
> >>
> > 
> > I'm not sure I follow you here.
> > In case you described start_server() returns -1,
> > so pid = -1, and cleanup won't do kill(-1, SIGKILL).
> > 
> 
> 
> Yeah, I understood you.
> 
> But we wanna fix the case to TPASS but not TBROK, do we?

True, but until we have such fix, we should at least make it
less annoying when it fails.

> So, I mean that the issues of this case is not only what you said.

I didn't actually get to see yet what those are, because those
TBROK messages didn't make it to log:

<<<test_start>>>
tag=recvmsg01 stime=1320555319
cmdline="recvmsg01"
contacts=""
analysis=exit
<<<test_output>>>
<<<execution_status>>>
initiation_status="ok"
duration=0 termination_type=signaled termination_id=9 corefile=no
cutime=0 cstime=0
<<<test_end>>>

Regards,
Jan

------------------------------------------------------------------------------
RSA(R) Conference 2012
Save $700 by Nov 18
Register now
http://p.sf.net/sfu/rsa-sfdev2dev1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
