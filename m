From: Greg Hackmann <ghackmann@google.com>
Date: Mon, 3 Dec 2018 14:20:25 -0800
Subject: [LTP] [PATCH 1/2] getrlimit/getrlimit03: add configure-time
 check for struct ulimit64
In-Reply-To: <20181203212505.GA2022@x230>
References: <20181203190148.93108-1-ghackmann@google.com>
 <20181203212505.GA2022@x230>
Message-ID: <98a5058e-939b-3fb5-4f78-4e11f6901e0e@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 12/03/2018 01:25 PM, Petr Vorel wrote:
> Glibc and uclibc-ng define struct rlimit64 only #ifdef __USE_LARGEFILE64.

Makes sense.  I ran into this issue with bionic, which doesn't require 
-D_LARGEFILE64_SOURCE for these kinds of definitions.

> Would it make sense to change autoconf test to AC_COMPILE_IFELSE and pass -D_LARGEFILE64_SOURCE to it?
> + Use it in Makefile, of course.
> 
> 
> Kind regards,
> Petr
> 

I'm honestly not that familiar with autotools, so I'm not sure I follow 
this.  Are you suggesting that we assume struct rlimit64 is defined 
(possibly conditionally on -D_LARGEFILE64_SOURCE), and we really ought 
to probe whether -D_LARGEFILE64_SOURCE is required to make it visible?
