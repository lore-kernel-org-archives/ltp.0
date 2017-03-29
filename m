From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Wed, 29 Mar 2017 14:48:00 +0200
Subject: [LTP] [RFC] [PATCH] lib32: Add support for linking 32bit
 programs on 64bit
In-Reply-To: <20170328100114.29730-1-chrubis@suse.cz>
References: <20170328100114.29730-1-chrubis@suse.cz>
Message-ID: <20170329144800.3258e1a5@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Metan,

On Tue, 28 Mar 2017 12:01:14 +0200
"Cyril Hrubis" <chrubis@suse.cz> wrote:

> This is proof of concept for building 32bit testcases on 64bit platform.
> 
> What we do is:
> 
> * Configure test if compiler supports -m32
>   TODO: Does 32bit compiler accept -m32?
>         If so, we should fail the test on 32bit
> 	platforms by default.
> 

Yes it does accept -m32. I think the best thing to do is call
tst_kernelbits(), as you suggested, at runtime anyway, as someone might be
running a 32bit compiler on a 64bit kernel and/or cross compiling.

Also it turns out that I am using some C syntax which is not accepted by GCC
4.3.4. This is annoying considering the tests compile fine with -std=C99 on
GCC 6.

Thank you,
Richard.
