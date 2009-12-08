Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.123]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1NHx5n-0004Cx-3f
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:14:51 +0000
Received: from mail-gx0-f223.google.com ([209.85.217.223])
	by sfi-mx-3.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NHx5f-0008HR-M9
	for ltp-list@lists.sourceforge.net; Tue, 08 Dec 2009 10:14:51 +0000
Received: by gxk23 with SMTP id 23so2789566gxk.2
	for <ltp-list@lists.sourceforge.net>;
	Tue, 08 Dec 2009 02:14:38 -0800 (PST)
Mime-Version: 1.0 (Apple Message framework v1077)
From: Garrett Cooper <yanegomi@gmail.com>
In-Reply-To: <1260241019.1107.17.camel@plars-t500>
Date: Tue, 8 Dec 2009 02:14:25 -0800
Message-Id: <FDC655C5-24D7-4C87-9C9A-824A9FE4B40B@gmail.com>
References: <1260241019.1107.17.camel@plars-t500>
Subject: Re: [LTP] make install... doesn't
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
To: Paul Larson <paul.larson@canonical.com>
Cc: LTP-ML <ltp-list@lists.sourceforge.net>

On Dec 7, 2009, at 6:56 PM, Paul Larson wrote:

> Was trying to build ltp today, which sadly, seems to be a bit more
> complicated than it once was.  The make install completed without
> errors, but noticed at the end that I didn't even have a testcases/bin
> directory!  As I watched the make install output I noticed that
> everything in testcases was getting built with the 'all' target, but
> never install.
> 
> My make-foo is quite rusty, but I'm guessing that this change from
> changeset b2e46ed73e9601ecad1044d37a85c97ba0ca42ce (if you are following
> git, It was from around Nov 30 if not) seems to be a likely culprit:
> -.SECONDEXPANSION:
> -$(INSTALL_TARGETS) include-install lib-install: %-install:
> $(abs_top_builddir)/$$*
> -       $(MAKE) -C $* -f "$(abs_top_srcdir)/$*/Makefile" install 
> +$(INSTALL_TARGETS) include-install lib-install:
> +       $(MAKE) -C "$(subst -install,,$@)" \
> +               -f "$(abs_top_srcdir)/$(subst -install,,$@)/Makefile"
> all

Yes... s/all/install/ was a stupid typo :(.
-Garrett

------------------------------------------------------------------------------
Return on Information:
Google Enterprise Search pays you back
Get the facts.
http://p.sf.net/sfu/google-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
