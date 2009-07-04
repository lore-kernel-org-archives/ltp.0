Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.124]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1MMzq5-0006E0-LD
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2009 07:39:13 +0000
Received: from an-out-0708.google.com ([209.85.132.247])
	by 1b2kzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1MMzq1-0001ZQ-3e
	for ltp-list@lists.sourceforge.net; Sat, 04 Jul 2009 07:39:13 +0000
Received: by an-out-0708.google.com with SMTP id c38so1180803ana.37
	for <ltp-list@lists.sourceforge.net>;
	Sat, 04 Jul 2009 00:39:08 -0700 (PDT)
MIME-Version: 1.0
Date: Sat, 4 Jul 2009 00:39:08 -0700
Message-ID: <364299f40907040039y15f642b1ue8d92b1823a12821@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: [LTP] subdir make with LTP
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
To: Mike Frysinger <vapier@gentoo.org>, Nate Straz <nate-ltp@refried.org>, Subrata Modak <subrata@linux.vnet.ibm.com>
Cc: LTP list <ltp-list@lists.sourceforge.net>

Hi Mike, Nate, and Subrata,
    Although some people may be unhappy with this change, I was
thinking of `breaking' subdirectory based make operations with LTP as
this would overcomplicate the make system logic a great deal with a
bunch of cookie cutter logic that will grow stale and become a pain to
maintain.
    Is this something that would be a desired feature moving forward
or something we can official drop?
    Subdir based Make would still function by specifying srcdir= on
the command line, but doing a bare command like the following:

    cd testcases/kernel/syscalls && make all

    would fail.
Thanks,
-Garrett

------------------------------------------------------------------------------
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
