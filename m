Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1X77s5-0008BF-2h
	for ltp-list@lists.sourceforge.net; Tue, 15 Jul 2014 18:54:37 +0000
Date: Tue, 15 Jul 2014 20:54:06 +0200
From: chrubis@suse.cz
Message-ID: <20140715185406.GA10046@rei>
References: <CAHTgTXWCNZzL+6ptrMgwR5d2UA4dcSka_C=off87axRqsgbm1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAHTgTXWCNZzL+6ptrMgwR5d2UA4dcSka_C=off87axRqsgbm1Q@mail.gmail.com>
Subject: Re: [LTP] GCC_WARN_OLDSTYLE build error
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
To: Vinson Lee <vlee@twopensource.com>
Cc: ltp-list@lists.sourceforge.net

Hi!
> This commit introduces a build error on CentOS 6 for me.
> 
> commit edbae29d774e30967bee74463ad505ff9a81f87d
> Author: Cyril Hrubis <chrubis@suse.cz>
> Date:   Tue Jul 15 14:57:27 2014 +0200
> 
>     configure.ac: Add AC_CONFIG_MACRO_DIR
> 
>     Otherwise macros in m4 directory are not found on autoreconf
> 
>     Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> 
> 
> gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W
> @GCC_WARN_OLDSTYLE@ -I.  -I../include -I../include -I../include
> -I../include  -c -o bytes_by_prefix.o bytes_by_prefix.c
> gcc: @GCC_WARN_OLDSTYLE@: No such file or directory

That looks like the variable from config.mk.in wasn't substitued
correctly.

Does it work when you readd the -I m4 to the automake.mk that this patch
has removed?

Does the 'make autotools' print any warnings for AC_CONFIG_MACRO_DIR?

-- 
Cyril Hrubis
chrubis@suse.cz

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
