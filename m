From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 11 May 2017 11:54:45 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] pselect01: Tune thresholds
In-Reply-To: <20170505131855.32545-1-chrubis@suse.cz>
References: <20170505131855.32545-1-chrubis@suse.cz>
Message-ID: <2075581666.10581422.1494518085371.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> +static int compute_threshold(long long requested_us, unsigned int
> iterations)
> +{
> +	unsigned int slack_per_run = MIN(100000, requested_us / 1000);
> +
> +	return (40 + slack_per_run) * iterations + 20000 / (iterations/200 + 1);
> +}

  requested_us = tst_timespec_to_us(t->tv) * t->iterations;

If slack_per_run is slack of all iterations, why is it multiplied
again with number of iterations?

