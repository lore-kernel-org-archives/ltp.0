From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 15 May 2017 06:03:50 -0400 (EDT)
Subject: [LTP] [PATCH v2] [RFC] pselect01: Tune thresholds
In-Reply-To: <20170512141658.26810-1-chrubis@suse.cz>
References: <20170512141658.26810-1-chrubis@suse.cz>
Message-ID: <495691788.11461692.1494842630946.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +
> +/*
> + * The threshold per one syscall is computed as a sum of:
> + *
> + *  250 us                 - accomodates for context switches, etc.
> + *  2*monotonic_resolution - accomodates for granurality of the
> CLOCK_MONOTONIC
> + *  slack_per_scall        - 0.1% of the sleep capped on 100ms
> + *                           which is slack allowed in kernel
> + *
> + * We also allow for outliners, i.e. add some number to the threshold in
> case
> + * that the number of iteration is small. For large enoung number of
> iterations
> + * outliners are averaged out.
> + */
> +static int compute_threshold(long long requested_us, unsigned int
> iterations)
> +{
> +	unsigned int slack_per_scall = MIN(100000, requested_us / 1000);

Hi,

while looking at fs/select.c I noticed that it also takes
current->timer_slack_ns into account and uses that if 
slack is smaller. Would it make sense to add ...?
  slack_per_scall = MAX(slack_per_scall, prctl(PR_GET_TIMERSLACK) / 1000);
The default is 50us, so maybe the 250us in formula covers this already?

v2 looks good to me, and my KVM guest ran test successfully for hours.

Regards,
Jan

> +
> +	return (250 + 2 * monotonic_resolution + slack_per_scall) * iterations
> +		+ (iterations > 1 ? 0 : 1500);
> +}
> +
