Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1W1IfG-0001ue-H2
	for ltp-list@lists.sourceforge.net; Thu, 09 Jan 2014 16:41:02 +0000
Date: Thu, 9 Jan 2014 17:40:36 +0100
From: chrubis@suse.cz
Message-ID: <20140109164036.GB8938@rei>
References: <1383899857-4669-1-git-send-email-stanislav.kholmanskikh@oracle.com>
	<20140108165606.GA2178@rei> <52CE3D43.7010204@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52CE3D43.7010204@oracle.com>
Subject: Re: [LTP] [PATCH] setregid02: invalid user value fix
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
To: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Cc: vasily.isaenko@oracle.com, ltp-list@lists.sourceforge.net

Hi!
> > Unfortunately I've found that in SLES user nobody has UID precisely
> > USHRT_MAX - 2 and the test fails :(
> >
> > Thinking of correct solution, we probably need some
> > tst_get_unused_uid(). What do you think?
> >
> 
> Hi! Ok, I will do it.
> 

Do you have some estimate when will the patch be ready? I would like to
have this fix included in the release, if possible.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today. 
http://pubads.g.doubleclick.net/gampad/clk?id=119420431&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
