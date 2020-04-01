From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 1 Apr 2020 12:14:55 +0200
Subject: [LTP] LTP compilation broken with -fno-common
In-Reply-To: <20200401093934.GA23773@yuki.lan>
References: <20200401083228.GA18685@dell5510> <20200401093934.GA23773@yuki.lan>
Message-ID: <20200401101455.GA12069@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

...
> Maybe we can add it with a weak linker attribute. What about this patch:

> diff --git a/include/tst_test.h b/include/tst_test.h
> index 259d87d60..352e2cd64 100644
> --- a/include/tst_test.h
> +++ b/include/tst_test.h
> @@ -322,9 +322,7 @@ int main(int argc, char *argv[])

>  #define TST_TEST_TCONF(message)                                 \
>          static struct tst_test test = { .tconf_msg = message  } \
> -/*
> - * This is a hack to make the testcases link without defining TCID
> - */
> -const char *TCID;
> +
> +extern const char *TCID;

>  #endif /* TST_TEST_H__ */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 73827d472..4ce8cc301 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -32,6 +32,11 @@
>  #include "old_device.h"
>  #include "old_tmpdir.h"

> +/*
> + * Hack to get TCID defined in newlib tests
> + */
> +const char *TCID __attribute__((weak));
> +
>  #define LINUX_GIT_URL "https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id="
>  #define CVE_DB_URL "https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-"

Yep working locally :).
https://travis-ci.org/github/pevik/ltp/builds/669619899

> I guess that we can even drop the TCID extern definition from the tst_test.h
> header if the weak attribute works fine.
Also this is working.
Let's wait for travis (also added -fno-common into CFLAGS for all jobs).
https://travis-ci.org/github/pevik/ltp/builds/669620839

Kind regards,
Petr
