From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 15 Apr 2020 11:30:38 +0200
Subject: [LTP] [RFC PATCH 1/8] lib: Fix linking error multiple TCID
 definitions with -fno-common
In-Reply-To: <20200415092809.20240-2-pvorel@suse.cz>
References: <20200415092809.20240-1-pvorel@suse.cz>
 <20200415092809.20240-2-pvorel@suse.cz>
Message-ID: <20200415093038.GA12705@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +extern const char *TCID;

Do we really need this extern or can we remove it?

>  #endif	/* TST_TEST_H__ */
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index e502c2c1a..64cd3ac33 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -32,6 +32,11 @@
>  #include "old_device.h"
>  #include "old_tmpdir.h"

-- 
chrubis@suse.cz
