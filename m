From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 11 Oct 2017 14:52:36 +0200
Subject: [LTP] [PATCH 1/1] syscalls/ustat: Fix build for libc without
 ustat() support
In-Reply-To: <20171010152637.11194-1-pvorel@suse.cz>
References: <20171010152637.11194-1-pvorel@suse.cz>
Message-ID: <20171011125236.GB15968@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +#else /* systems without ustat() */
              ^
	      I think that we can avoid this comment, the TCONF message
	      below is clear enough...

> +#if defined(HAVE_SYS_USTAT_H) && defined(HAVE_USTAT)
> +#include <sys/ustat.h>

Logically following is bit cleaner, not that it matters that much:

#ifdef HAVE_USTAT
# ifdef HAVE_SYS_USTAT_H
#  include <sys/ustat.h>
# endif
...



-- 
Cyril Hrubis
chrubis@suse.cz
