From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 22 Oct 2019 16:19:46 +0200
Subject: [LTP] [PATCH v2 1/2] lib: Add support for test tags
In-Reply-To: <20191022140757.29713-2-chrubis@suse.cz>
References: <20191022140757.29713-1-chrubis@suse.cz>
 <20191022140757.29713-2-chrubis@suse.cz>
Message-ID: <20191022141946.GA16121@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

> +	fprintf(stderr, "Options\n");
> +	fprintf(stderr, "-------\n\n");
I still would remove this extra new line:
	fprintf(stderr, "-------\n");
> +
>  	for (i = 0; i < ARRAY_SIZE(options); i++)
>  		fprintf(stderr, "%s\n", options[i].help);

> @@ -424,6 +430,28 @@ static void print_help(void)
>  		fprintf(stderr, "%s\n", tst_test->options[i].help);
>  }

> +static void print_test_tags(void)
> +{
> +	unsigned int i;
> +	const struct tst_tag *tags = tst_test->tags;
> +
> +	printf("\nTags\n");
> +	printf("----\n\n");
And here:
	printf("----\n");

Otherwise LGTM.

Kind regards,
Petr
