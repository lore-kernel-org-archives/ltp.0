From: Li Wang <liwang@redhat.com>
Date: Wed, 29 Jul 2020 11:14:08 +0800
Subject: [LTP] [PATCH v2 1/3] lib: add function to check for kernel
 lockdown
In-Reply-To: <20200728162207.332109-1-ernunes@redhat.com>
References: <20200728162207.332109-1-ernunes@redhat.com>
Message-ID: <CAEemH2d+EOzF8aKAkpsnUO1GqgPh3J40RBDXyBg0E5NC8nrSuw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks Erico for patch V2.

On Wed, Jul 29, 2020 at 12:23 AM Erico Nunes <ernunes@redhat.com> wrote:

> Some syscalls are not available if the kernel is booted using the
> 'lockdown' feature. That can cause some tests to report fail, showing
> a message like:
>
>   Lockdown: iopl01: iopl is restricted; see man kernel_lockdown.7
>
> This patch adds a function that can be used by tests to check for this
> case, so it can be handled accordingly.
>
> Signed-off-by: Erico Nunes <ernunes@redhat.com>
> ---
> ...
> +int tst_lockdown_enabled(void)
> +{
> +       char line[BUFSIZ];
> +       const char *lockdown_path = "/sys/kernel/security/lockdown";
>

I prefer to add a macro definition in the header file instead of this ^.
    #define PATH_LOCKDOWN  "/sys/kernel/security/lockdown"

Considering some distribution's LSM feature has not aligned with the
mainline kernel, so I think this method is enough to detect the lockdown
status at currently, if some new changes happening then we can help improve
the function as well.

Anyway, the whole patchset looks good, if nobody has objection I will help
merge it one day later.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200729/0be13990/attachment.htm>
