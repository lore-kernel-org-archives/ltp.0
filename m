Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chrubis@suse.de>) id 1RoFdY-0000wt-2c
	for ltp-list@lists.sourceforge.net; Fri, 20 Jan 2012 14:40:16 +0000
Date: Fri, 20 Jan 2012 15:52:28 +0100
From: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20120120145228.GA15964@saboteur.suse.cz>
References: <4F17D4D0.9090200@cn.fujitsu.com>
	<f1c1b1b8-3e46-4e00-9c9e-7e9ef02f4117@zmail16.collab.prod.int.phx2.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1c1b1b8-3e46-4e00-9c9e-7e9ef02f4117@zmail16.collab.prod.int.phx2.redhat.com>
Subject: Re: [LTP] [PATCH v3 1/8] A library used to test memcg
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
Cc: LTP List <ltp-list@lists.sourceforge.net>

Hi!
> 1. file mode of new test cases is 644, existing one (memcg_function_test) is 755.
> I'm not sure if installation process takes care of this, I put them to testcases/bin
> directly (I was lazy), so I had to "chmod a+x" new ones to run them.

The build system install files as 775 (see include/mk/env_post.mk)
unless you set INSTALL_MODE to something else in the corresponding
Makefile, but it's better to have correct permissions in the git
repository as well.

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
