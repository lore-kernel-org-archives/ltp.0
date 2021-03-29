From: Eric Biggers <ebiggers@kernel.org>
Date: Mon, 29 Mar 2021 11:53:07 -0700
Subject: [LTP] [PATCH] crypto_user02: Find a valid template
In-Reply-To: <20210315130349.1155389-1-lkml@jv-coder.de>
References: <20210315130349.1155389-1-lkml@jv-coder.de>
Message-ID: <YGIiE5/DnjXrcHzK@gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 15, 2021 at 02:03:49PM +0100, Joerg Vehlow wrote:
> From: Joerg Vehlow <joerg.vehlow@aox-tech.de>
> 
> The test requires a crypto template, that is not in use by someone else,
> otherwise deleting it is not possible.
> This adds a list of templates, that are tested in order, until one is found,
> that can be used for the test, otherwise TCONF is returned.
> 
> Signed-off-by: Joerg Vehlow <joerg.vehlow@aox-tech.de>

Generally looks good.  A few nits below.

> +/*
> + * List of possible templates to use try (not exhaustive).
> + * The template has to be valid (i.e. the drivers must exists
> + * and be a valid combination) and it has to be deleteable.
> + * To be deletable it cannot be used by someone else.
> + * The first algorithm, that fullfils the criteria is used for the test.
> + */
> +static const char* TEMPLATE_CANDIDATES[] = {
> +	"hmac(sha1-generic)",
> +	"hmac(sha224-generic)",
> +	"hmac(sha256-generic)",
> +	"hmac(sha384-generic)",
> +	"hmac(md5-generic)"
> +};

"template" means something like "hmac" by itself.  This probably should be
called something like ALGORITHM_CANDIDATES, and similarly template => algorithm
in a couple places below.

Also it should be 'const char * const', not just 'const char *'.

>  static void setup(void)
>  {
> +	int rc;
> +	unsigned i;
> +	struct crypto_user_alg alg, alg_out;

alg_out is unused.

> +	if (!template) {
> +		tst_brk(TCONF, "No viable template found");
> +	}

Single-line statements shouldn't have braces like this.

- Eric
