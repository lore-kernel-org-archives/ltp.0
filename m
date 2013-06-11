Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <sulfurfff@gmail.com>) id 1UmVK4-0000O3-Bl
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 20:37:44 +0000
Received: from mail-we0-f173.google.com ([74.125.82.173])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UmVK3-0004Zc-5U
	for ltp-list@lists.sourceforge.net; Tue, 11 Jun 2013 20:37:44 +0000
Received: by mail-we0-f173.google.com with SMTP id x54so5390403wes.18
	for <ltp-list@lists.sourceforge.net>;
	Tue, 11 Jun 2013 13:37:37 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 11 Jun 2013 15:37:36 -0500
Message-ID: <CANXECd4nytMbMBtrnnD+aaEaE1NMQ8+x=gO7qCFrEFcFBGBUCg@mail.gmail.com>
From: =?UTF-8?Q?Ismael_Farf=C3=A1n?= <sulfurfff@gmail.com>
Subject: [LTP] Help compiling in AIX 6.1
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
To: ltp-list@lists.sourceforge.net

Hello list

We have this AIX 6.1 box running LTP 2005-something. Now I'm trying to
compile 20130109 without much luck.

I'm running this without much luck:

./configure
gmake

Any ideas?



ltp-full-20130109/ ~$ gmake
/tmp/ltp-full-20130109/include/mk/env_pre.mk:100: -n: A file or
directory in the path name does not exist.
/tmp/ltp-full-20130109/include/mk/env_pre.mk:101: -n: A file or
directory in the path name does not exist.
/tmp/ltp-full-20130109/include/mk/automake.mk:115: target `-n' given
more than once in the same rule.
Makefile:107: warning: overriding commands for target `-n'
/tmp/ltp-full-20130109/include/mk/automake.mk:117: warning: ignoring
old commands for target `-n'
Makefile:182: warning: overriding commands for target `-n'
Makefile:107: warning: ignoring old commands for target `-n'
Makefile:188: warning: overriding commands for target `-n'
Makefile:182: warning: ignoring old commands for target `-n'
Makefile:187: target `-n' given more than once in the same rule.
Makefile:187: target `-n' given more than once in the same rule.
Makefile:187: target `-n' given more than once in the same rule.
Makefile:187: target `-n' given more than once in the same rule.
if git describe >/dev/null 2>&1; then \
        git describe > "Version"; \
else \
        cp VERSION "Version"; \
fi
gmake: Circular -n <- -n dependency dropped.
gmake: Circular -n <- -n dependency dropped.
gmake: Circular -n <- -n dependency dropped.
gmake: Circular -n <- -n dependency dropped.
gmake: Circular -n <- -n dependency dropped.
gmake: Circular -n <- -n dependency dropped.
install -m 00755 "/tmp/ltp-full-20130109/-n" "-n"
install: 0653-233 File 00755 was not found.
gmake: *** [-n] Error 2




--
Do not let me induce you to satisfy my curiosity, from an expectation,
that I shall gratify yours. What I may judge proper to conceal, does
not concern myself alone.

------------------------------------------------------------------------------
This SF.net email is sponsored by Windows:

Build for Windows Store.

http://p.sf.net/sfu/windows-dev2dev
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
