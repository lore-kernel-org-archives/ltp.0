From: Li Wang <liwang@redhat.com>
Date: Tue, 12 Jan 2021 16:34:24 +0800
Subject: [LTP] [PATCH v5 2/3] Add tst_secureboot_enabled() helper
 function
In-Reply-To: <20210111161103.22433-2-mdoucha@suse.cz>
References: <20210111161103.22433-1-mdoucha@suse.cz>
 <20210111161103.22433-2-mdoucha@suse.cz>
Message-ID: <CAEemH2e_5gCmtieHVDiXRv27=hPA+ZOyH+vRSjkhnRO5e=ZcxA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jan 12, 2021 at 12:11 AM Martin Doucha <mdoucha@suse.cz> wrote:

> Also check for SecureBoot status in tst_lockdown_enabled() if the lockdown
> sysfile is not available/readable and the kernel is configured to enable
> lockdown automatically under SecureBoot.
>
> Signed-off-by: Martin Doucha <mdoucha@suse.cz>
> ---
>
> Changes since v1:
> - check whether machine is in EFI mode first
>
> Changes since v2:
> - move tst_secureboot_enabled() code to a separate header file
> - move EFIVAR_CFLAGS and EFIVAR_LIBS out of global CFLAGS and LDLIBS
>
> Changes since v3:
> - rewritten using direct read from /sys/ (without libefivar)
>
>  include/tst_lockdown.h |  1 +
>  lib/tst_lockdown.c     | 38 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 39 insertions(+)
>
> diff --git a/include/tst_lockdown.h b/include/tst_lockdown.h
> index 78eaeccea..172a7daf5 100644
> --- a/include/tst_lockdown.h
> +++ b/include/tst_lockdown.h
> @@ -5,6 +5,7 @@
>
>  #define PATH_LOCKDOWN  "/sys/kernel/security/lockdown"
>
> +int tst_secureboot_enabled(void);
>  int tst_lockdown_enabled(void);
>
>  #endif /* TST_LOCKDOWN_H */
> diff --git a/lib/tst_lockdown.c b/lib/tst_lockdown.c
> index e7c19813c..a753ca752 100644
> --- a/lib/tst_lockdown.c
> +++ b/lib/tst_lockdown.c
> @@ -9,14 +9,52 @@
>  #include "tst_test.h"
>  #include "tst_safe_macros.h"
>  #include "tst_safe_stdio.h"
> +#include "tst_kconfig.h"
>  #include "tst_lockdown.h"
>

We have to include the "tst_private.h" header file otherwise compiler
failed to build it.

For the series:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210112/d42c5acc/attachment.htm>
