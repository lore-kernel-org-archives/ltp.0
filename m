From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 22 Apr 2020 15:18:01 +0200
Subject: [LTP] [PATCH V3 1/2] tst_timer: Add support for kernel's 64 bit
 timespec
In-Reply-To: <20200421154006.GA14036@yuki.lan>
References: <cover.1587033556.git.viresh.kumar@linaro.org>
 <08a307591b531593bbaa5b1e8a4c841e80493937.1587033556.git.viresh.kumar@linaro.org>
 <20200421154006.GA14036@yuki.lan>
Message-ID: <20200422131801.GA9146@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> I've cleaned up and simplified these changes + wrote a simple test and
> pushed the result, thanks a lot for your effors.

> Can you please rebase the test changes on the top of these changes? It
> should be merely cosmetical, function names have changes etc.

include/tst_timer.h is broken on gcc 4, which we have in Travis (CentOS 6).
I don't know how to fix this, but maybe fix is trivial.
Or is it time to finally drop this oldest distro? If it's easy to fix, I'd
postpone dropping CentOS 6 after release (some embedded distros/projects might
still use old compilers).

gcc -g -O2 -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -W -Wall -D_FORTIFY_SOURCE=2 -I../../include -I../../include -I../../include/old/   -L../../lib  test_timer.c   -lltp -o test_timer
In file included from test_timer.c:11:
../../include/tst_timer.h: In function ?tst_ts_from_timespec?:
../../include/tst_timer.h:214: error: unknown field ?libc_ts? specified in initializer
../../include/tst_timer.h:214: warning: missing braces around initializer
../../include/tst_timer.h:214: warning: (near initialization for ?t.<anonymous>?)
../../include/tst_timer.h:215: warning: missing initializer
../../include/tst_timer.h:215: warning: (near initialization for ?t.<anonymous>.libc_ts.tv_nsec?)
../../include/tst_timer.h:215: error: unknown field ?libc_ts? specified in initializer
../../include/tst_timer.h:215: warning: excess elements in struct initializer
../../include/tst_timer.h:215: warning: (near initialization for ?t?)
make: *** [test_timer] Error 1

$ gcc --version
gcc (GCC) 4.4.7 20120313 (Red Hat 4.4.7-18)

Kind regards,
Petr
