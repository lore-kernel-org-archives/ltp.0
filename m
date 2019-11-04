From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Nov 2019 12:13:23 -0500 (EST)
Subject: [LTP] [PATCH] read_all_sys: skip debugfs
In-Reply-To: <20191104160951.GB5683@rei.lan>
References: <4e93b0d943960d957b71bdb998b33ad30424b07c.1572881777.git.jstancek@redhat.com>
 <20191104155900.GA5683@rei.lan> <20191104160951.GB5683@rei.lan>
Message-ID: <865262542.10390848.1572887603246.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > >  read_all_dev read_all -d /dev -p -q -r 10
> > >  read_all_proc read_all -d /proc -q -r 10
> > > -read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count
> > > +read_all_sys read_all -d /sys -q -r 10 -e /sys/power/wakeup_count -e
> > > '/sys/kernel/debug/*'
> > 
> > Do we even support multiple parameters for the same option?
> > 
> > I looked that the library code and I would say that we will replace the
> > value with each iteration which means that we will effectively use the
> > last one.
> 
> Maybe we should even catch the case where user passed one option twice with:

Or WARN that option might be overwritten. Anyway, it sounds like good idea.

> 
> diff --git a/lib/tst_test.c b/lib/tst_test.c
> index c7b46d0d5..e1c841585 100644
> --- a/lib/tst_test.c
> +++ b/lib/tst_test.c
> @@ -468,6 +468,9 @@ static void parse_topt(unsigned int topts_len, int opt,
> char *optarg)
>         if (i >= topts_len)
>                 tst_brk(TBROK, "Invalid option '%c' (should not happen)",
>                 opt);
>  
> +       if (*(toptions[i].arg))
> +               tst_brk(TBROK, "Option already set!");
> +
>         *(toptions[i].arg) = optarg ? optarg : "";
>  }
> 
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

