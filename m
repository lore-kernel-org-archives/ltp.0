From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Nov 2018 16:20:54 +0100
Subject: [LTP] [PATCH] syscalls/bind03: fix ret code behavior for v4.4
	backport
In-Reply-To: <20181107133840.20042-1-rafael.tinoco@linaro.org>
References: <20181107133840.20042-1-rafael.tinoco@linaro.org>
Message-ID: <20181120152053.GA10812@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Rafael,

> Recently added test bind03 has a corner case for bind(2). Because
> mainline patch 0fb44559ffd6 ("af_unix: move unix_mknod() out of
> bindlock") got backported to kernel v4.4 as commit 0492a033fb71, the
> corner case must be adapted to correct running kernel version.

...
>  	/*
> -	 * The behavious diverse according to kernel version
> -	 * for v4.10 or later, the expected error is EADDRINUSE,
> +	 * The behavior diverse according to kernel version
> +	 * for v4.4.47~3 or later, the expected error is EADDRINUSE,
>  	 * otherwise EINVAL.
>  	 */
> -	if (tst_kvercmp(4, 10, 0) < 0) {
> +	if (tst_kvercmp(4, 4, 48) < 0) {
>  		if (errno != EINVAL) {
>  			tst_res(TFAIL | TERRNO, "expected EINVAL");
>  			return;

I think this is a wrong approach as there are versions between v4.4 and 4.10
without this patch. IMHO we should accept both EINVAL and EADDRINUSE or accept
Junchi's solution [1].


Kind regards,
Petr

[1] https://patchwork.ozlabs.org/patch/968371/
