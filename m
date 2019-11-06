From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Nov 2019 16:26:34 +0100
Subject: [LTP] [PATCH v2 1/2] lib: Add support for test tags
In-Reply-To: <20191022141946.GA16121@dell5510>
References: <20191022140757.29713-1-chrubis@suse.cz>
 <20191022140757.29713-2-chrubis@suse.cz>
 <20191022141946.GA16121@dell5510>
Message-ID: <20191106152634.GA12403@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > +	fprintf(stderr, "Options\n");
> > +	fprintf(stderr, "-------\n\n");
> I still would remove this extra new line:
> 	fprintf(stderr, "-------\n");
> > +
> >  	for (i = 0; i < ARRAY_SIZE(options); i++)
> >  		fprintf(stderr, "%s\n", options[i].help);
> 
> > @@ -424,6 +430,28 @@ static void print_help(void)
> >  		fprintf(stderr, "%s\n", tst_test->options[i].help);
> >  }
> 
> > +static void print_test_tags(void)
> > +{
> > +	unsigned int i;
> > +	const struct tst_tag *tags = tst_test->tags;
> > +
> > +	printf("\nTags\n");
> > +	printf("----\n\n");
> And here:
> 	printf("----\n");

Changed as you suggested and pushed whole patchset, many thanks for
reviews.

-- 
Cyril Hrubis
chrubis@suse.cz
