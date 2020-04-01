From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Wed, 01 Apr 2020 11:16:37 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200401083228.GA18685@dell5510>
References: <20200401083228.GA18685@dell5510>
Message-ID: <87blobva4q.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi,
>
> LTP compilation breaks with -fno-common (we don't use as the default).
> This is the default for GCC 10, is there a way to fix it or do we need to disable it?
>
> Compilation on gcc-10 (or gcc-9 with CFLAGS="-fno-common":
>
> gcc-9 -Werror=implicit-function-declaration -fno-common -g -O2 -fno-strict-aliasing -pipe -Wall -W -Wold-style-definition -W  -I../../include -I../../include -I../../include/old/   -L../../lib  tst_checkpoint_wait_timeout.c   -lltp -o tst_checkpoint_wait_timeout
> /usr/lib64/gcc/x86_64-suse-linux/9/../../../../x86_64-suse-linux/bin/ld: ../../lib/libltp.a(tst_test.o):ltp.git/lib/../include/tst_test.h:325: multiple definition of `TCID'; /tmp/cc49yYO6.o:ltp.git/lib/tests/tst_strsig.c:27: first defined here
> /usr/lib64/gcc/x86_64-suse-linux/9/../../../../x86_64-suse-linux/bin/ld: ../../lib/libltp.a(tst_sys_conf.o):ltp.git/lib/../include/tst_test.h:325: multiple definition of `TCID'; /tmp/cc49yYO6.o:ltp.git/lib/tests/tst_strsig.c:27: first defined here
>
> It's somehow related to the "hack" in include/tst_test.h:
>
> /*
>  * This is a hack to make the testcases link without defining TCID
>  */
> extern const char *TCID;

Huh? This is defining the variable and with extern which looks correct
(at a glance):
https://gcc.gnu.org/gcc-10/porting_to.html

Possibly we need to clean the code up so this variable is not redefined
all over the place?
>
> Kind regards,
> Petr


-- 
Thank you,
Richard.
