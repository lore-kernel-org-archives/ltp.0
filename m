Return-Path: <ltp-list-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <metan@suse.de>) id 1WPuBl-00080g-70
	for ltp-list@lists.sourceforge.net; Tue, 18 Mar 2014 13:36:17 +0000
Date: Tue, 18 Mar 2014 14:35:54 +0100
From: chrubis@suse.cz
Message-ID: <20140318133554.GA12227@rei>
References: <1392894122.2053.11.camel@G08JYZSD130126>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1392894122.2053.11.camel@G08JYZSD130126>
Subject: Re: [LTP] [PATCH] modify_ldt/modify_ldt03.c: add a new test
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
To: Zeng Linggang <zenglg.jy@cn.fujitsu.com>
Cc: ltp-list <ltp-list@lists.sourceforge.net>

Hi!
> +#include "config.h"
> +#include "test.h"
> +#include "usctest.h"
> +
> +TCID_DEFINE(modify_ldt03);

This macro is primarily used to define right TCID when compiling two
tests from one source (the _16 ones). There is no need to use it
otherwise.

> +int TST_TOTAL = 1;
> +
> +#if defined(__i386__) && defined(HAVE_MODIFY_LDT)
> +
> +#ifdef HAVE_ASM_LDT_H
> +#include <asm/ldt.h>
> +#endif
> +extern int modify_ldt(int, void *, unsigned long);
> +
> +#include <asm/unistd.h>
> +#include <string.h>
> +#include <sys/wait.h>
> +#include <errno.h>
> +#include "safe_macros.h"
> +
> +static unsigned long bytecount = 10;

Where did you get this number from? Is this sizeof(struct user_desc) ?

> +static void *ptr;

Do you need to allocate the memory, wouldn't char buf[bytecount] do the
same?

-- 
Cyril Hrubis
chrubis@suse.cz

------------------------------------------------------------------------------
Learn Graph Databases - Download FREE O'Reilly Book
"Graph Databases" is the definitive new guide to graph databases and their
applications. Written by three acclaimed leaders in the field,
this first edition is now available. Download your free book today!
http://p.sf.net/sfu/13534_NeoTech
_______________________________________________
Ltp-list mailing list
Ltp-list@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/ltp-list
