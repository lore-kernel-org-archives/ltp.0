Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1VgwSR-0001eZ-Ns
	for ltp-list@lists.sourceforge.net; Thu, 14 Nov 2013 12:55:39 +0000
Date: Thu, 14 Nov 2013 13:55:24 +0100
From: chrubis@suse.cz
Message-ID: <20131114125524.GD13348@rei>
References: <1384395907-13886-1-git-send-email-penght@cn.fujitsu.com>
	<20131114122922.GA13348@rei>
	<187658148.31700134.1384433325925.JavaMail.root@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <187658148.31700134.1384433325925.JavaMail.root@redhat.com>
Subject: Re: [LTP] [PATCH] sigaction:16-1: leave it untested on the Linux
 kernel less than 2.6.22
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

Hi!
> > Or at least the testcases shouldn't be skipped by default.
> > If there is
> > enough interest in this feature we can add specific switch or make
> > target that skips tests that are known to fail on Linux. Skipping them
> > on default run is, in my opinion, wrong.
> 
> I don't have strong preference. I'd be OK also with a text file, which would
> list which ones fail, why, relevant kernel/glibc versions, etc.

Or a wiki page. I would love to see more LTP documentation...

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
