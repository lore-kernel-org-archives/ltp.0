Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1NHqGI-0002O5-KK
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 02:57:14 +0000
Received: from adelie.canonical.com ([91.189.90.139])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHqGC-0001ez-Qe
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 02:57:14 +0000
Received: from hutte.canonical.com ([91.189.90.181])
	by adelie.canonical.com with esmtp (Exim 4.69 #1 (Debian))
	id 1NHqG6-0007iX-DZ
	for <ltp-list@lists.sourceforge.net>; Tue, 08 Dec 2009 02:57:02 +0000
Received: from 75-27-138-126.lightspeed.austtx.sbcglobal.net ([75.27.138.126]
	helo=[192.168.1.70]) by hutte.canonical.com with esmtpsa
	(TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32) (Exim 4.69)
	(envelope-from <paul.larson@canonical.com>) id 1NHqG6-0000K0-2T
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 02:57:02 +0000
From: Paul Larson <paul.larson@canonical.com>
Date: Mon, 07 Dec 2009 20:56:59 -0600
Message-ID: <1260241019.1107.17.camel@plars-t500>
Mime-Version: 1.0
Subject: [LTP] make install... doesn't
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
To: LTP-ML <ltp-list@lists.sourceforge.net>

Was trying to build ltp today, which sadly, seems to be a bit more
complicated than it once was.  The make install completed without
errors, but noticed at the end that I didn't even have a testcases/bin
directory!  As I watched the make install output I noticed that
everything in testcases was getting built with the 'all' target, but
never install.

My make-foo is quite rusty, but I'm guessing that this change from
changeset b2e46ed73e9601ecad1044d37a85c97ba0ca42ce (if you are following
git, It was from around Nov 30 if not) seems to be a likely culprit:
-.SECONDEXPANSION:
-$(INSTALL_TARGETS) include-install lib-install: %-install:
$(abs_top_builddir)/$$*
-       $(MAKE) -C $* -f "$(abs_top_srcdir)/$*/Makefile" install 
+$(INSTALL_TARGETS) include-install lib-install:
+       $(MAKE) -C "$(subst -install,,$@)" \
+               -f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile"
all
 
Thanks,
Paul Larson


------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
