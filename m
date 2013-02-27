Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1UAi90-0000HU-G1
	for ltp-list@lists.sourceforge.net; Wed, 27 Feb 2013 14:38:06 +0000
Date: Wed, 27 Feb 2013 15:38:45 +0100
From: chrubis@suse.cz
Message-ID: <20130227143845.GA2178@rei>
References: <605746806.1323310.1360671766487.JavaMail.root@redhat.com>
	<51218CB1.8040709@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51218CB1.8040709@cn.fujitsu.com>
Subject: Re: [LTP] open posix testsuite and names of testcases
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
To: Wanlong Gao <gaowanlong@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> >>> I'm not against renaming sources, just thinking if there is less
> >>> intrusive way to achieve same result. I believe all Makefiles are
> >>> generated,
> >>> so other option that comes to mind would be to modify
> >>> scripts/generate-makefiles.sh.
> >>> Any thoughts about this approach?
> >>
> >> We can hack the script to generate Makefiles that include the dir
> >> name
> >> into the binary name which would be less intrusive but on the other
> >> hand
> >> that would break the rule that foo.c generates foo.run_test...
> > 
> > Caspar, Wanlong, any preference / thoughts?
> 
> I vote to changing the rule of generating the Makefiles, it's simple
> and the simple rule change is easy to be accepted. Agree?

Ok. I will look into this and hopefully commit a patch soon enough.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Everyone hates slow websites. So do we.
Make your web apps faster with AppDynamics
Download AppDynamics Lite for free today:
http://p.sf.net/sfu/appdyn_d2d_feb
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
