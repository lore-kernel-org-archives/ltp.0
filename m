Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from
	<jbeckenbach=ltp-list=lists.sourceforge.net=jmtqtyzj@lancope.com>)
	id 1X7qX8-00020e-Ek
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 18:35:58 +0000
Received: from smtp-out3.electric.net ([72.35.12.183])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1X7qX6-0001i3-DU
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 18:35:58 +0000
Received: from 1X7pRe-0006wg-UZ by out3b.electric.net with emc1-ok (Exim
	4.80.1) (envelope-from <jbeckenbach@lancope.com>) id 1X7pRf-0006yZ-TV
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 10:26:15 -0700
Received: from [209.182.184.2] (helo=LCHQEX03.lancope.local)
	by out3b.electric.net with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.80.1) (envelope-from <jbeckenbach@lancope.com>)
	id 1X7pRe-0006wg-UZ
	for ltp-list@lists.sourceforge.net; Thu, 17 Jul 2014 10:26:14 -0700
From: Joseph Beckenbach <jbeckenbach@lancope.com>
Date: Thu, 17 Jul 2014 17:26:11 +0000
Message-ID: <4506ACC2AE90484D87F9A883BA36C21C2ADEFFAA@LCHQEX03.lancope.local>
Content-Language: en-US
MIME-Version: 1.0
Subject: [LTP] Apparent trouble with HEAD of LTP
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
To: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Greetings, Cyril, all!

I just pulled down LTP source (source-forge link to ltp-master.zip) and unpacked to start some testing.
However, I cannot get past ./configure ... since crafting ./configure failed to expand LTP_CHECK_FORTIFY_SOURCE (and all the LTP_CHECK_*)
which appear in m4/ltp-*.m4 files.  Compilations fail because this then provokes lots of '@foo@' expansions to not occur in include/mk/config.mk and include/mk/features.mk.

The most recent commit was "configure.ac: Add AC_CONFIG_MACRO_DIR" which I think is causing my trouble.

This is on (several instances of) a Debian 7.6 system.  All tools cited in ./INSTALL are present and at least as recent as called out in that documentation.
Googling provides a year-old thread on autoconf / autoconfigure.ac mentioning AC_CONFIG_MACRO_DIR [0]
which suggests libtool needs to figure in somehow -- and libtool package / executable libtoolize are *not* present on this system.
Given it appears this project's configuration sequence runs through ./aclocal.m4,
recent autoconf documentation [1] suggests to me that this macro does not justify dropping "-I m4"
(given we have no top-level Makefile.am involved).

And indeed, manually backing out just the include/mk/automake.mk one-line change done by commit "edbae29d774e30967bee74463ad505ff9a81f87d" unblocks me.

Am I missing something?  Is the documentation missing something?  Is the `make autotools` step missing something?
Color me "confused but able to progress".
Thanks!

Joseph
Joseph Beckenbach, senior QA engineer : Automation

[0] https://bbs.archlinux.org/viewtopic.php?pid=1258673 

[1] https://www.gnu.org/software/autoconf/manual/autoconf-2.65/html_node/Input.html


------------------------------------------------------------------------------
Want fast and easy access to all the code in your enterprise? Index and
search up to 200,000 lines of code with a free copy of Black Duck
Code Sight - the same software that powers the world's largest code
search on Ohloh, the Black Duck Open Hub! Try it now.
http://p.sf.net/sfu/bds
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
