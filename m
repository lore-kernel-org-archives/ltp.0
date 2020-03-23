From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 23 Mar 2020 10:20:14 +0100
Subject: [LTP] [PATCH 1/2] lib: Implement SAFE_RUN() macro (new API only)
In-Reply-To: <edd8ed18-8cb3-2a13-7caa-a55c3447389a@cn.fujitsu.com>
References: <20200320134937.16616-1-pvorel@suse.cz>
 <edd8ed18-8cb3-2a13-7caa-a55c3447389a@cn.fujitsu.com>
Message-ID: <20200323092014.GA26702@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

> > +		tst_brk(TBROK, "%s:%d: %s failed (%d)", file, lineno, rc);
> typo, rc -> rval and  miss  argv[0].
> > +	}
> > +}
> > +#define SAFE_RUNCMD(argv, stdout_path, stderr_path) \
> > +	safe_run_cmd(__FILE__, __LINE__, NULL, (argv), (stdout_path), (stderr_path))
> I guess we don't need the third argument(NULL).

Thanks for catching these! I've sent v2 with your Reviewed-by: tag.

Kind regards,
Petr
