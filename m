From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 28 Jun 2018 15:47:50 -0400 (EDT)
Subject: [LTP] [RFC] [PATCH] tst_timer: Add tst_timer_expired_ms()
In-Reply-To: <20180628092846.21204-1-chrubis@suse.cz>
References: <20180628092846.21204-1-chrubis@suse.cz>
Message-ID: <986909105.29606861.1530215270429.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Recently we were in the need of easy way to run a testcase for a given
> time interval. We nearly had everything in the timer library already but
> the problem was that the sampling function i.e. tst_timer_stop() and
> conversion functions e.g. tst_timer_elapsed_ms() were separated.
> 
> This commit adds a tst_timer_expired_ms() function that combines the
> sampling and comparsion, the intended usage is:
> 
> static void setup(void)
> {
> 	...
> 	tst_timer_check(CLOCK_MONOTONIC);
> 	...
> }
> 
> static void run(void)
> {
> 	...
> 
> 	tst_timer_start(CLOCK_MONOTONIC);
> 
> 	...
> 
> 	while (!tst_timer_expired_ms(5000)) {
> 		...
> 	}
> 
> 	...
> }
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> CC: Eric Biggers <ebiggers3@gmail.com>

ACK

I'm thinking if it's worth skipping also tst_timer_check(),
and adding some like "LTP_TIMER_ANY" that would pick first
available clockid for you.

Regards,
Jan
