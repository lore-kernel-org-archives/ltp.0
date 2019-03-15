From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 15 Mar 2019 10:43:08 +0100
Subject: [LTP] [PATCH 2/6] crypto/af_alg01: new regression test for hmac
 nesting bug
In-Reply-To: <20190221053026.18489-3-ebiggers@kernel.org>
References: <20190221053026.18489-1-ebiggers@kernel.org>
 <20190221053026.18489-3-ebiggers@kernel.org>
Message-ID: <20190315094308.GC4990@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Eric,

> +static void run(void)
> +{
> +	/* try several different unkeyed hash algorithms */
> +	static const char * const hash_algs[] = {
> +		"md5", "md5-generic",
> +		"sha1", "sha1-generic",
> +		"sha224", "sha224-generic",
> +		"sha256", "sha256-generic",
> +		"sha3-256", "sha3-256-generic",
> +		"sha3-512", "sha3-512-generic",
> +	};
> +	size_t i;
FYI: We usually use struct tcase with .tcnt = ARRAY_SIZE(tcases)
instead of for loop, but it's only a minor detail.

> +
> +	for (i = 0; i < ARRAY_SIZE(hash_algs); i++)
> +		test_with_hash_alg(hash_algs[i]);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = run,
> +};


Kind regards,
Petr
