From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 17 Oct 2017 15:29:45 +0200
Subject: [LTP] [PATCH v4 04/14] m4: Fix libaio detection on 32-bit cross
 build
In-Reply-To: <20171016154205.4814-5-pvorel@suse.cz>
References: <20171016154205.4814-1-pvorel@suse.cz>
 <20171016154205.4814-5-pvorel@suse.cz>
Message-ID: <20171017132945.GA31490@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +		AC_TRY_LINK(... AC_DEFINE(HAVE_IO_SET_EVENTFD) ...)
                 ^
		 Is this a forgotten placeholder?

>  		AC_TRY_LINK([#include <stdio.h>
>                               #include <libaio.h>
>  		            ],
> -                            [io_set_eventfd(NULL, 0); return 0;
> -			    ],
> -			    [AC_DEFINE(HAVE_IO_SET_EVENTFD)
> -			     AC_MSG_RESULT(yes)],
> -                            [AC_MSG_RESULT(no)])],
> -		AIO_LIBS="")])
> -AC_SUBST(AIO_LIBS)
> +		            [io_set_eventfd(NULL, 0); return 0;],
> +		            [AC_DEFINE(HAVE_IO_SET_EVENTFD, 1, [Define to 1 if you have `io_set_eventfd' function.])])

Okay this AC_TRY_LINK() actually works, but does not produce any output,
notice the AC_MSG_CHECKING() and AC_MSG_RESULT() in the original code.

I was going to suggest to use AC_CHECK_LIB() but the io_set_eventfd() is
inline function defined in the header so we have to stuck with
AC_TRY_LINK().

We also seem to have duplicit libaio.h check in configure.ac.

-- 
Cyril Hrubis
chrubis@suse.cz
