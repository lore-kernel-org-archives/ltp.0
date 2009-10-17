Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <yanegomi@gmail.com>) id 1Mz1g6-0000BZ-CS
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 05:18:06 +0000
Received: from mail-pz0-f188.google.com ([209.85.222.188])
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1Mz1fz-0003oe-Ti
	for ltp-list@lists.sourceforge.net; Sat, 17 Oct 2009 05:18:06 +0000
Received: by pzk26 with SMTP id 26so2083177pzk.4
	for <ltp-list@lists.sourceforge.net>;
	Fri, 16 Oct 2009 22:17:54 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <8368651DACC1964480F951191B94A0780153D7BE@svexch01.mvista.com>
References: <8368651DACC1964480F951191B94A0780153D7BE@svexch01.mvista.com>
Date: Fri, 16 Oct 2009 22:17:54 -0700
Message-ID: <364299f40910162217w545c9108rbdac6e26fa0cf563@mail.gmail.com>
From: Garrett Cooper <yanegomi@gmail.com>
Subject: Re: [LTP] [LTP{PATCH][fs tests] modify tests to honor tmp directory
	passed into runltp, convert to LTP format
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
To: Henry Yei <hyei@mvista.com>
Cc: LTP Mailing List <ltp-list@lists.sourceforge.net>

On Fri, Oct 16, 2009 at 1:31 PM, Henry Yei <hyei@mvista.com> wrote:
> This is a set of patches for tests in the fs runtest file which make use of tst_tmpdir functions or alternatively, the base tmpdir set by the user. Some of the tests have been converted to LTP test format as well.
>
> Tests that are changed:
> fs_di
> fs_perms
> lftest
> linker01
> quota_remount_test01
> writetest

Note: linker01 is a bourne shell script now.
HTH,
-Garrett

------------------------------------------------------------------------------
Come build with us! The BlackBerry(R) Developer Conference in SF, CA
is the only developer event you need to attend this year. Jumpstart your
developing skills, take BlackBerry mobile applications to market and stay 
ahead of the curve. Join us from November 9 - 12, 2009. Register now!
http://p.sf.net/sfu/devconference
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
