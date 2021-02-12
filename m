From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 12 Feb 2021 17:02:23 +0100
Subject: [LTP] [PATCH 2/2] keyctl05: TCONF on FIPS mode
In-Reply-To: <20210202130441.17861-2-pvorel@suse.cz>
References: <20210202130441.17861-1-pvorel@suse.cz>
 <20210202130441.17861-2-pvorel@suse.cz>
Message-ID: <YCamj5IAuyPMOcBo@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	int is_asymmetric = !strcmp(type, "asymmetric");
> +
>  	TEST(add_key(type, "desc", payload, plen, KEY_SPEC_SESSION_KEYRING));
>  	if (TST_RET < 0) {
> +		if (TST_ERR == EINVAL && is_asymmetric && tst_fips_enabled()) {
                                                          ^
							  I guess that
							  we can save
							  the value in
							  test setup
							  instead of
							  re-reading it
							  on every
							  iteration.

Other than that it looks good to me.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

> +			tst_res(TCONF, "key size not allowed in FIPS mode");
> +			return;
> +		}
>  		if (TST_ERR == ENODEV) {
>  			tst_res(TCONF, "kernel doesn't support key type '%s'",
>  				type);
>  			return;
>  		}
> -		if (TST_ERR == EBADMSG && !strcmp(type, "asymmetric")) {
> +		if (TST_ERR == EBADMSG && is_asymmetric) {
>  			tst_res(TCONF, "kernel is missing x509 cert parser "
>  				"(CONFIG_X509_CERTIFICATE_PARSER)");
>  			return;
>  		}
> -		if (TST_ERR == ENOENT && !strcmp(type, "asymmetric")) {
> +		if (TST_ERR == ENOENT && is_asymmetric) {
>  			tst_res(TCONF, "kernel is missing crypto algorithms "
>  				"needed to parse x509 cert (CONFIG_CRYPTO_RSA "
>  				"and/or CONFIG_CRYPTO_SHA256)");
> -- 
> 2.30.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
