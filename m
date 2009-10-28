Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.121]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <njoly@pasteur.fr>) id 1N34g7-0007gE-2F
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 09:18:51 +0000
Received: from maroilles.sis.pasteur.fr ([157.99.64.223]
	helo=mail-interne3.pasteur.fr)
	by 29vjzd1.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1N34g2-0007EY-Lb
	for ltp-list@lists.sourceforge.net; Wed, 28 Oct 2009 09:18:51 +0000
Date: Wed, 28 Oct 2009 10:18:32 +0100
From: Nicolas Joly <njoly@pasteur.fr>
Message-ID: <20091028091832.GA441933@medusa.sis.pasteur.fr>
References: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <8368651DACC1964480F951191B94A078016A156A@svexch01.mvista.com>
Subject: Re: [LTP] [PATCH][ppoll01]  fix testcase 1,
	5: pass correct value for sigset_t for mips
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

On Tue, Oct 27, 2009 at 06:32:34PM -0700, Henry Yei wrote:
> All,
> 
> The patch attached  for ppoll01:
> 
> cleans up spacing and code style
> 
> removes unneeded/broken debug option parsing
> 
> if test fails, it prints out the last failed errno, rather than just the last errno(which may have been successful)
> 
> passes in correct size of sigset_t for mips

Hi,

While you are on this one, can you cleanup the test file creation. It
currently tries to create test files in the diretory where the ppoll
executable comes from, instead of the test tmp dir ... which is just
wrong.

	static char *progdir;

        progdir = strdup(av[0]);
        progdir = dirname(progdir);

        TEST(fd = setup_file(progdir, "test.file", fpath));
        if (fd < 0)
                return 1;

progdir should be removed, and "." used instead.

Thanks.

-- 
Nicolas Joly

Biological Software and Databanks.
Institut Pasteur, Paris.

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
