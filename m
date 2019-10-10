From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 10 Oct 2019 13:44:52 +0200
Subject: [LTP] [PATCH] acct: fix version check on big endian system
In-Reply-To: <2126517382.5475715.1570692951519.JavaMail.zimbra@redhat.com>
References: <20191010063750.9605-1-pifang@redhat.com>
 <20191010064324.GA2615@dhcp-0-148.nay.redhat.com>
 <2126517382.5475715.1570692951519.JavaMail.zimbra@redhat.com>
Message-ID: <20191010114452.GC23153@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

> Can we incorporate ACCT_BYTEORDER into that check?

> Kernel appears to use it at least since 2.6.12-rc2. We would just need
> define it for !HAVE_STRUCT_ACCT_V3 case.

> diff --git a/include/lapi/acct.h b/include/lapi/acct.h
> index ebd65bbf4df7..112ee48d8aee 100644
> --- a/include/lapi/acct.h
> +++ b/include/lapi/acct.h
> @@ -64,6 +64,13 @@ enum {
>         ACORE = 0x08,
>         AXSIG = 0x10
>  };
> +
> +# if __BYTE_ORDER == __BIG_ENDIAN
> +# define ACCT_BYTEORDER  0x80
> +# elif __BYTE_ORDER == __LITTLE_ENDIAN
> +# define ACCT_BYTEORDER  0x00
> +# endif
> +
>  #endif /* HAVE_STRUCT_ACCT_V3 */

>  #endif /* LAPI_ACCT_H */
> diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
> index 7c2a270465c5..4d95aafec3e1 100644
> --- a/testcases/kernel/syscalls/acct/acct02.c
> +++ b/testcases/kernel/syscalls/acct/acct02.c
> @@ -142,7 +142,7 @@ static int verify_acct(void *acc, int elap_time)
>                 ret = 1;
>         }

> -       if (ACCT_MEMBER_V3(ac_version) != 3) {
> +       if (ACCT_MEMBER_V3(ac_version) != (3 | ACCT_BYTEORDER)) {
>                 tst_res(TINFO, "ac_version != 3 (%d)",
>                         ACCT_MEMBER_V3(ac_version));
>                 ret = 1;

FYI v2 merged. Sorry not adding your Suggested-by: and Acked-by: tags
(you weren't in Cc: for v2).

Kind regards,
Petr
