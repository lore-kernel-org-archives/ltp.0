From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 9 Apr 2020 10:04:19 -0400 (EDT)
Subject: [LTP] [PATCH v2] add_key05: Avoid race with key garbage
 collection
In-Reply-To: <20200409112645.643-1-rpalethorpe@suse.com>
References: <20200409112645.643-1-rpalethorpe@suse.com>
Message-ID: <1033986999.7818590.1586441059205.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> --- a/testcases/kernel/syscalls/add_key/add_key05.c
> +++ b/testcases/kernel/syscalls/add_key/add_key05.c
> @@ -10,6 +10,10 @@
>   * This is also a regression test for
>   * commit a08bf91ce28e ("KEYS: allow reaching the keys quotas exactly")
>   * commit 2e356101e72a ("KEYS: reaching the keys quotas correctly")
> + *
> + * If you run this test with -i > 10 then expect to see some sporadic
> failures

Since test is using 2 users per iteration, should above say -i > 5?

> + * where add_key fails with EDQUOT. Keys are freed asynchronously and we
> only
> + * create up to 10 users to avoid race conditions.
>   */
>  
>  #include <stdio.h>
> @@ -18,47 +22,53 @@
>  #include "tst_test.h"
>  #include "lapi/keyctl.h"
>  
> +#define MAX_USERS 10
> +
>  static char *user_buf;
> -static const char *username = "ltp_add_key05";
> -static int user_added;
> -struct passwd *ltpuser;
> -static char fmt[1024];
> +static uid_t ltpuser[MAX_USERS];
> +
> +static unsigned int usern;
> +static volatile unsigned int useri;

I don't see why volatile is needed here. Other than that rest looks
reasonable to me. 

Acked-by: Jan Stancek <jstancek@redhat.com>

