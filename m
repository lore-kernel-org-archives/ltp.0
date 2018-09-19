From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 19 Sep 2018 09:48:21 +0200
Subject: [LTP] [PATCH] statx: fix compile errors with glibc<2.28
In-Reply-To: <20180919044813.22875-1-liwang@redhat.com>
References: <20180919044813.22875-1-liwang@redhat.com>
Message-ID: <20180919074821.GB28540@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> glibc 2.28 has shipped with a wrapper for the statx() system call.
> Currently the build is broken against it, because sys/stat.h suddenly
> declares all the same types that lapi/stat.h does.  Fix it by taking
> the sys/stat.h ones if glibc>=2.28.
> 
>   include/lapi/stat.h:26:8: error: redefinition of ???struct statx_timestamp???
>   include/lapi/stat.h:73:8: error: redefinition of ???struct statx???

What's wrong with the configure checks we do have?

See m4/ltp-statx.m4:

AC_CHECK_TYPES([struct statx],,,[[#include <sys/stat.h>]])
AC_CHECK_TYPES([struct statx_timestamp],,,[[#include <sys/stat.h>]])

That should check exactly if these structures are defined and export the
HAVE_STRUCT_* macros?

-- 
Cyril Hrubis
chrubis@suse.cz
