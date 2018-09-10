From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Mon, 10 Sep 2018 13:46:50 +0200
Subject: [LTP] [PATCH v2 2/4] fzsync: Simplify API with start/end race
	calls and limit exec time
In-Reply-To: <20180910084442.17720-3-rpalethorpe@suse.com>
References: <20180910084442.17720-1-rpalethorpe@suse.com>
 <20180910084442.17720-3-rpalethorpe@suse.com>
Message-ID: <87va7d60d1.fsf@rpws.prws.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


Richard Palethorpe <rpalethorpe@suse.com> writes:

> +static inline void tst_upd_stat(struct tst_fzsync_stat *s,
> +				 float alpha,
> +				 float sample)
>  {
> -	tst_fzsync_time(&pair->b);
> +	s->avg = tst_exp_moving_avg(alpha, sample, s->avg);
> +	s->avg_dev = tst_exp_moving_avg(alpha,
> +					5fabs(s->avg - sample), s->avg_dev);
                                        ^ whoops

-- 
Thank you,
Richard.
