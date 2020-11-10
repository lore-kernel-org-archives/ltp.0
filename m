From: Li Wang <liwang@redhat.com>
Date: Tue, 10 Nov 2020 13:54:30 +0800
Subject: [LTP] [PATCH v3 2/2] syscalls/iopl,
 ioperm: Check for SecureBoot lockdown
In-Reply-To: <20201109164605.25965-2-mdoucha@suse.cz>
References: <20201109164605.25965-1-mdoucha@suse.cz>
 <20201109164605.25965-2-mdoucha@suse.cz>
Message-ID: <CAEemH2egUaO=ebaRFOZDNCZYi1QKZN168xE=_J_U_yoBH5PyLQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 10, 2020 at 12:46 AM Martin Doucha <mdoucha@suse.cz> wrote:

> ...
>
>  include $(top_srcdir)/include/mk/testcases.mk
>
> +CFLAGS                 += $(EFIVAR_CFLAGS)
> +LDLIBS                 += $(EFIVAR_LIBS)
>

Where can we get the value of these two variables? Shouldn't we
add AC_SUBST() in the m4 file?



> --- a/testcases/kernel/syscalls/ioperm/ioperm02.c
> +++ b/testcases/kernel/syscalls/ioperm/ioperm02.c
> @@ -22,6 +22,7 @@
>  #include <pwd.h>
>  #include "tst_test.h"
>  #include "tst_safe_macros.h"
> +#include "tst_secureboot.h"
>
>  #if defined __i386__ || defined(__x86_64__)
>  #include <sys/io.h>
> @@ -45,6 +46,10 @@ static struct tcase_t {
>
>  static void setup(void)
>  {
> +       /* ioperm() is restricted under kernel lockdown. */
> +       if (tst_lockdown_enabled() || tst_secureboot_enabled() > 0)
> +               tst_brk(TCONF, "Kernel is locked down, skip this test");
>

The ioperm02 is an error test for ioperm(), it doesn't matter without the
lockdown/secure-boot status. Better to remove this from setup().

iopl02 as well.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201110/bdfdaaa4/attachment.htm>
