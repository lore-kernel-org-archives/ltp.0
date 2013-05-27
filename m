Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1Uh0RA-0003zD-PL
	for ltp-list@lists.sourceforge.net; Mon, 27 May 2013 16:38:20 +0000
Date: Mon, 27 May 2013 18:39:33 +0200
From: chrubis@suse.cz
Message-ID: <20130527163932.GA32583@rei>
References: <6A3DF150A5B70D4F9B66A25E3F7C888D070433E5@039-SN2MPN1-013.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6A3DF150A5B70D4F9B66A25E3F7C888D070433E5@039-SN2MPN1-013.039d.mgd.msft.net>
Subject: Re: [LTP] LTP: Compilation error for powerpc
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
To: Bhushan Bharat-R65777 <R65777@freescale.com>
Cc: "ltp-list@lists.sourceforge.net" <ltp-list@lists.sourceforge.net>

Hi!
> There are a number of good test cases which we run to test various
> features ( like ptrace/memory etc). I tried below steps and failed to
> compile successfully:
> 
> 1)
> cp include/mk/config.mk.default include/mk/config.mk
> 
> 2)
> vi include/mk/config.mk
> -AR                      := ar
> -CC                      := gcc
> +AR                      := /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/bin/powerpc-linux-gnu-ar
> +CC                      := /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/bin/powerpc-linux-gnu-gcc
> 
> 3)
> cp include/config.h.default include/config.h

Hmm you stil need a to set path to the headers and libraries. Unlike
kernel LTP needs libc headers and libraries to build.

There are some configure parameters for that but I do not know how to
set these. Perhaps somebody on the list knows better.

> 4)
> cd include/mk
> cp generic_leaf_target.inc generic_leaf_target.mk cp generic_trunk_target.inc generic_trunk_target.mk cd ../../

This is certainly wrong thing to do. The inc files are included from the
mk files.

> 5)
> Make
> 
> Getting error :
> 
> make[4]: Entering directory `/home/r65777/LTP/try/testcases/kernel/containers/libclone'
> /opt/freescale/usr/local/gcc-4.5.55-eglibc-2.11.55/powerpc-linux-gnu/bin/powerpc-linux-gnu-gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall  -I/home/r65777/LTP/try/testcases/kernel/include  -c -o libclone.o libclone.c In file included from libclone.h:31:0,
>                  from libclone.c:17:
> /home/r65777/LTP/try/testcases/kernel/include/linux_syscall_numbers.h:18:21: fatal error: cleanup.c: No such file or directory compilation terminated.
> make[4]: *** [libclone.o] Error 1
> make[4]: Leaving directory `/home/r65777/LTP/try/testcases/kernel/containers/libclone'
> make[3]: *** [libclone/libclone.a] Error 2
> make[3]: Leaving directory `/home/r65777/LTP/try/testcases/kernel/containers'
> make[2]: *** [all] Error 2
> make[2]: Leaving directory `/home/r65777/LTP/try/testcases/kernel'
> make[1]: *** [all] Error 2
> make[1]: Leaving directory `/home/r65777/LTP/try/testcases'
> make: *** [testcases-all] Error 2

That may be caused by the damage done by copying the inc files over the
mk files or anything else.

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Try New Relic Now & We'll Send You this Cool Shirt
New Relic is the only SaaS-based application performance monitoring service 
that delivers powerful full stack analytics. Optimize and monitor your
browser, app, & servers with just a few lines of code. Try New Relic
and get this awesome Nerd Life shirt! http://p.sf.net/sfu/newrelic_d2d_may
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
