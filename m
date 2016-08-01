From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 1 Aug 2016 11:23:56 +0200
Subject: [LTP] test specific command line options
In-Reply-To: <1842886039.9326772.1469708591634.JavaMail.zimbra@redhat.com>
References: <20160728081249.GA4664@bogon>
 <1842886039.9326772.1469708591634.JavaMail.zimbra@redhat.com>
Message-ID: <20160801092356.GB6899@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > From the doc I read:
> > 
> > ... The 'arg' is where 'optarg' is stored upon match. If option has no
> > parameter it's set to non-'NULL' value if option was present.
> > 
> > But looks like if a option was present which has no parameter, the 'arg'
> > will set to NULL?
> 
> You're right, that looks like a BUG. If you don't provide colon,
> then "arg" stays NULL, but doc say it should be non-NULL:

Looks like my mistake.

> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index 4f417ea345e7..0b99bedd8d81 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -384,6 +384,7 @@ static void parse_topt(unsigned int topts_len, int opt, char *optarg)
>  {
>         unsigned int i;
>         struct tst_option *toptions = tst_test->options;
> +       static char *match = "";
>  
>         for (i = 0; i < topts_len; i++) {
>                 if (toptions[i].optstr[0] == opt)
> @@ -393,7 +394,10 @@ static void parse_topt(unsigned int topts_len, int opt, char *optarg)
>         if (i >= topts_len)
>                 tst_brk(TBROK, "Invalid option '%c' (should not happen)", opt);
>  
> -       *(toptions[i].arg) = optarg;
> +       if (optarg)
> +               *(toptions[i].arg) = optarg;
> +       else
> +               *(toptions[i].arg) = match;

I would do something as:

	*(toptions[i].arg) = optarg ? optarg : "";

-- 
Cyril Hrubis
chrubis@suse.cz
