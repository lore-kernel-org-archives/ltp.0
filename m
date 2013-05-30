Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Ui2eU-0005fV-F4
	for ltp-list@lists.sourceforge.net; Thu, 30 May 2013 13:12:22 +0000
Date: Thu, 30 May 2013 15:13:35 +0200
From: chrubis@suse.cz
Message-ID: <20130530131334.GA5336@rei.suse.cz>
References: <1369398051-2772-1-git-send-email-alexey.kodanev@oracle.com>
	<20130528143707.GA4229@rei> <51A4C663.7010506@oracle.com>
	<20130528154334.GB4229@rei> <51A5E74C.5000002@oracle.com>
	<20130530110759.GA16265@rei.suse.cz> <51A747E8.7070105@oracle.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <51A747E8.7070105@oracle.com>
Subject: Re: [LTP] Device firmware loading test
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
To: alexey.kodanev@oracle.com
Cc: Vasily Isaenko <vasily.isaenko@oracle.com>, ltp-list@lists.sourceforge.net

Hi!
> > The problem with device-drivers directory is that the code there is
> > broken (unmaintained since 2009 or so) and the make (from the top
> > directory) doesn't go there. It should be cleaned/removed/fixed but
> > nobody had time to look at the tests and decide what to do with them.
> >
> > Otherwise the destination fits well enough.
> As I understand from README file in that directory, these tests should 
> not be run automatically. It explains why make doesn't go there. But the 
> firmware loading test can be (preferably should be) run automatically. 
> That way, may be change directory to .../testcases/kernel/firmware?

Hmm, so the test tests userspace API for firmware loading but needs
helper kernel module, am I right?. In that case kernel/firmware/ should
be ok as well.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Introducing AppDynamics Lite, a free troubleshooting tool for Java/.NET
Get 100% visibility into your production application - at no cost.
Code-level diagnostics for performance bottlenecks with <2% overhead
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap1
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
