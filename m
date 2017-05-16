From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 16 May 2017 10:38:56 +0200
Subject: [LTP] [RFC] [PATCH v2] lib32: Add support for linking 32bit
	programs on 64bit
In-Reply-To: <20170406124641.30179-1-chrubis@suse.cz>
References: <20170406124641.30179-1-chrubis@suse.cz>
Message-ID: <87lgpx8acf.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

Cyril Hrubis writes:

> This is proof of concept for building 32bit testcases on 64bit platform.
>
> What we do is:
>
> * Configure test if compiler supports -m32
>
> * Configure test if compiler supports atomic operations with -m32
>   (we have to use fallbacks in tst_atomic.h otherwise)
>
> * The directory lib32 contains symlinks of minimal set of sources
>   needed to link newlib testcase + Makefile.
>
> * The testcases.mk builds 32bit library as well if
>   32bit compiler was installed (-m32 configure test was succesful)
>
> * And finally the env_post.mk switches between adding -L path to lib or
>   lib32 depeding on if -m32 was passed in global CFLAGS and/or in the
>   target specific CFLAGS

I'm not sure if this has already been taken into account, but on aarch64
gcc does not recognise the -m32 switch and compilation fails if the test
case has added -m32 to its CFLAGS.

-- 
Thank you,
Richard.
