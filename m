Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <subrata@linux.vnet.ibm.com>) id 1OB7KQ-0005z4-NQ
	for ltp-list@lists.sourceforge.net; Sun, 09 May 2010 14:17:58 +0000
Received: from e32.co.us.ibm.com ([32.97.110.150])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1OB7KO-0001c8-FY
	for ltp-list@lists.sourceforge.net; Sun, 09 May 2010 14:17:58 +0000
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o49EAftg031836
	for <ltp-list@lists.sourceforge.net>; Sun, 9 May 2010 08:10:41 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id o49EHkLF150952
	for <ltp-list@lists.sourceforge.net>; Sun, 9 May 2010 08:17:46 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o49EHkJC029032
	for <ltp-list@lists.sourceforge.net>; Sun, 9 May 2010 08:17:46 -0600
From: Subrata Modak <subrata@linux.vnet.ibm.com>
In-Reply-To: <20100507143632.GC22099@us.ibm.com>
References: <1273081434-22034-1-git-send-email-danms@us.ibm.com>
	<1273225268.6042.8.camel@subratamodak.linux.ibm.com>
	<877hnfyebf.fsf@caffeine.danplanet.com>
	<20100507143632.GC22099@us.ibm.com>
Date: Sun, 09 May 2010 19:47:27 +0530
Message-Id: <1273414659.6709.0.camel@subratamodak.linux.ibm.com>
Mime-Version: 1.0
Subject: Re: [LTP] [PATCH] NetNS test fixes
Reply-To: subrata@linux.vnet.ibm.com
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
To: "Serge E. Hallyn" <serue@us.ibm.com>, Dan Smith <danms@us.ibm.com>
Cc: ltp-list@lists.sourceforge.net

On Fri, 2010-05-07 at 09:36 -0500, Serge E. Hallyn wrote:
> Quoting Dan Smith (danms@us.ibm.com):
> > SM> Can you please ack this patch.
> > 
> > Ack the revised one below instead :)
> > 
> > By the way, these tests appear to start up sshd for no reason other
> > than possibly checking that basic sockets work in the netns.  Given
> > the frailty and required setup of the "ftp" test, I think it would be
> > better to replace it with a test using netcat and then yank the sshd
> > bits from the ping tests.
> 
> Ack that.
> 
> > Dan Smith
> > IBM Linux Technology Center
> > email: danms@us.ibm.com
> > 
> > NetNS test fixes (v2)
> > 
> > This patch fixes a couple of netns test issues that cause invalid failures
> > relating to exiting with a status variable that doesn't exist.  It also
> > fixes an instance of inverted logic and a failure to exec sshd with the
> > full path (as required).
> > 
> > Additionally, it makes the common child exec function more descriptive of
> > what it tried to do and why it failed to ease debugging.
> > 
> > Changes in v2:
> > - Initialize status=0 at the top of child_1.sh to prevent overshadowing
> >   a (meaningless) sshd failure
> > 
> > Signed-off-by: Dan Smith <danms@us.ibm.com>
> 
> Acked-by: Serge E. Hallyn <serue@us.ibm.com>

Thats Great. Thanks :-)

Regards--
Subrata

> 
> thanks,
> -serge


------------------------------------------------------------------------------

_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
