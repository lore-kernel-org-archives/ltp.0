Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X2dRm-0003GP-0P
	for ltp-list@lists.sourceforge.net; Thu, 03 Jul 2014 09:36:54 +0000
Date: Thu, 3 Jul 2014 11:36:32 +0200
From: chrubis@suse.cz
Message-ID: <20140703093632.GA1993@rei.scz.novell.com>
References: <1404122135-8089-1-git-send-email-wangxg.fnst@cn.fujitsu.com>
	<20140701122120.GA23601@rei.scz.novell.com>
	<53B51FAE.30807@cn.fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <53B51FAE.30807@cn.fujitsu.com>
Subject: Re: [LTP] [[RFC PATCH]] lib/tst_res.c: make tst_brkm() output more
 informative message
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
To: Xiaoguang Wang <wangxg.fnst@cn.fujitsu.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> OK, I'll add the informative message for tst_brkm() and tst_resm(), but not for
> tst_resm(TPASS), because most of test cases will succeed and will output too many
> redundant messages, users maybe unhappy...

OK

> >>From a technical point, maybe I would just use tst_brkm_ instead of
> > tst_brkm_d, otherwise it looks correct.
> 
> what about _tst_brkm() and _tst_resm()?

Names that start with underscore are reserved for libc implementation so
I would rather go for the names with underscore at the end.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Open source business process management suite built on Java and Eclipse
Turn processes into business applications with Bonita BPM Community Edition
Quickly connect people, data, and systems into organized workflows
Winner of BOSSIE, CODIE, OW2 and Gartner awards
http://p.sf.net/sfu/Bonitasoft
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
