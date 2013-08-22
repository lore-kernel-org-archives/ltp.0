Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VCR5j-0004Xd-29
	for ltp-list@lists.sourceforge.net; Thu, 22 Aug 2013 09:22:07 +0000
Date: Thu, 22 Aug 2013 11:22:09 +0200
From: chrubis@suse.cz
Message-ID: <20130822092208.GA12621@rei.ASUS>
References: <51E6272B.3020509@cn.fujitsu.com> <20130717120522.GB25145@rei>
	<51FA290E.1040804@cn.fujitsu.com> <20130812115309.GC24962@rei>
	<52158F02.9000105@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <52158F02.9000105@cn.fujitsu.com>
Subject: Re: [LTP] [PATCH 1/2] Add support for xfs quota tests
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
To: DAN LI <li.dan@cn.fujitsu.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi!
> > I've just pushed a patchset that implements this functionality.
> > (It has been finished previous week but I hold it util I had time to
> > test it properly)
> > 
> > Everybody please test this change and report any problems.
> 
> I got a little problem when using this function.
> 
> 
> Defaultly, the command mkfs.xfs will not write to the device if it suspects that
> there is a filesystem or partition table on the device already.
> So, i need to add the "-f" option for mkfs.xfs to force the formatting.
> 
> But, the command "mkfs dev -t xfs -f" does not work as expected.
> Could you please change it to "mkfs -t fs_type fs_opts dev" in tst_mkfs()?

I've created and pushed a patch that shuffles the params so that they
are in right order.

And I'm thinking if it actually would be better to add the -f parameter
in the tst_mkfs() if fs_type is xfs. As just now if you want to run any
of the tests that operate on a filesystem with xfs it fails in the same
way.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing Performance Central, a new site from SourceForge and 
AppDynamics. Performance Central is your source for news, insights, 
analysis and resources for efficient Application Performance Management. 
Visit us today!
http://pubads.g.doubleclick.net/gampad/clk?id=48897511&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
