Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoEwq-0007vc-5c
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 13:56:08 +0000
Date: Fri, 20 Jan 2012 15:08:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120140818.GA13447@saboteur.suse.cz>
References: <4DFB221F.9070603@cn.fujitsu.com> <4E9F77F3.6010803@cn.fujitsu.com>
	<20111116143632.GD27683@saboteur.suse.cz>
	<4F14CC4F.3060201@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4F14CC4F.3060201@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH] cron: fix fail due to rsyslogd dead
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
To: Peng Haitao <penght@cn.fujitsu.com>
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> > That is a hard one with no appereantly correct soultion and I personally
> > think that Garrett is right on this one. The ideal solution would be 
> > making sure that the syslog test leaves the system in reasonable
> > state...
> > 
> 
> yeah, Thanks for you reply.
> 
> I send a patch to make sure that the syslog test leaves the system in 
> reasonable state. The patch is merged into v5-devel.
> commit id: http://git.adiscon.com/?p=rsyslog.git;a=commitdiff;h=167192666ba8905b83210ab7

Great, that is a good solution ;).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
