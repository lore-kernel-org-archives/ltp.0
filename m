Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1V4Df1-0000Ar-0u
	for ltp-list@lists.sourceforge.net; Tue, 30 Jul 2013 17:24:35 +0000
Date: Tue, 30 Jul 2013 19:24:27 +0200
From: chrubis@suse.cz
Message-ID: <20130730172427.GB1999@rei.scz.novell.com>
References: <1C23526A7C42DB45BBF55B662C7C530E25B461FD20@BUNGLE.Emea.Arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1C23526A7C42DB45BBF55B662C7C530E25B461FD20@BUNGLE.Emea.Arm.com>
Subject: Re: [LTP] Where is defined TEST_ERRNO when 'make UCLINUX=1'?
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
To: Benoit Marcot <Benoit.Marcot@arm.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> I am building LTP for UCLINUX, and I went through an undefined symbol TEST_ERRNO with 'make UCLINUX=1'.
> 
> As far as I understand, making with 'UCLINUX=1' defines also _USC_LIB_ in lib/Makefile:
> 
> ifeq ($(UCLINUX),1)
> CFLAGS                  += -D_USC_LIB_
> endif
> 
> In include/usctest.h, if _USC_LIB_ is defined then TEST_ERRNO is declared as extern, hence still not defined:
> 
> #ifdef  _USC_LIB_
> extern int TEST_ERRNO;
> #else

That seems to be really messed up, so without UCLINUX the TEST_ERRNO is
defined in the header which is included in the test and in the library.
I wonder how that passes through the linker, that looks like
redefinition to me...

And with UCLINUX it's does not look to be defined anywhere.

Hmm, we should really clean up this part.

> Finally, the last place where TEST_ERRNO could be defined is in lib/parse_opts.c; if UNIT_TEST is somewhere defined:
> 
> #if UNIT_TEST
> int TEST_ERRNO;
> ...
> 
> So my questions are: should I compile with CFLAGS += -DUNIT_TEST=1? How to use parse_opts.c?
> 

If you define the UNIT_TEST the parse_opts.c will contain main() (it's
intended for testing the LTP lib interface only).

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Get your SQL database under version control now!
Version control is standard for application code, but databases havent 
caught up. So what steps can you take to put your SQL databases under 
version control? Why should you start doing it? Read more to find out.
http://pubads.g.doubleclick.net/gampad/clk?id=49501711&iu=/4140/ostg.clktrk
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
