From: Alexey Kodanev <alexey.kodanev@oracle.com>
Date: Fri, 20 Apr 2018 17:04:16 +0300
Subject: [LTP] [PATCH v3 2/2] network/in6_02: Rewrite to the new library
In-Reply-To: <20180420072122.16897-2-pvorel@suse.cz>
References: <20180420072122.16897-1-pvorel@suse.cz>
 <20180420072122.16897-2-pvorel@suse.cz>
Message-ID: <3e9d5d4f-18f8-51b3-746c-e64a6cf4cf68@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 20.04.2018 10:21, Petr Vorel wrote:
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
Hi Petr,
...
> -/* if_nametoindex tests */
> -void n2itest(void)
> +static void if_nametoindex_test(void)
>  {
>  	unsigned int i;
>  	char ifname[IF_NAMESIZE], *pifn;
>  
> -	for (i = 0; i < N2I_COUNT; ++i) {
> -		if (n2i[i].name == NULL) {
> -			tst_resm(TCONF, "LHOST_IFACES not defined or invalid, skip testing it");
> -			return;
> +	tst_res(TINFO, "IPv6 if_nametoindex() test");
> +
> +	for (i = 0; i < ARRAY_SIZE(test_case); i++) {
> +		if (test_case[i].name == NULL) {
> +			tst_res(TCONF, "LHOST_IFACES not defined or invalid");
> +			continue;
...
>  
> -/* if_indextoname tests */
> -void i2ntest(void)
> +static void if_indextoname_test(void)
>  {
>  	unsigned int i;
>  
> +	tst_res(TINFO, "IPv6 if_indextoname() test");
> +
>  	/* some low-numbered indexes-- likely to get valid interfaces here */
> -	for (i = 0; i < I2N_LOWCOUNT; ++i)
> -		if (!sub_i2ntest(i))
> +	for (i = 0; i < I2N_LOWCOUNT; i++)
> +		if (!sub_if_indextoname_test(i))
>  			return;	/* skip the rest, if broken */
>  	/* some random ints; should mostly fail */
> -	for (i = 0; i < I2N_RNDCOUNT; ++i)
> -		if (!sub_i2ntest(rand()))
> +	for (i = 0; i < I2N_RNDCOUNT; i++)
> +		if (!sub_if_indextoname_test(rand()))
>  			return;	/* skip the rest, if broken */
>  
> -	tst_resm(TPASS, "if_indextoname() tests succeed");
> +	tst_res(TPASS, "if_indextoname() test succeed");
                                                 ^
                                             succeeded?

>  }...
> -	for (i = 0; pini[i].if_index; ++i) {
> +	for (i = 0; pini[i].if_index; i++) {
... 
> +	/*
> +	 * we need to leak at least a page to detect a leak; 1 byte per call
>  	 * will be detected with getpagesize() calls.
>  	 */
>  	freenicount = getpagesize();
> -	for (i = 0; i < freenicount; ++i) {
> +	for (i = 0; i < freenicount; i++) {

Hmm, looks like you are intentionally changing '++i' with 'i++' for
the all 'for' loops in this patch, any good reason to do that?


Other than that, the patch looks good.
