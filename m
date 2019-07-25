From: piotr.krzysztof.gawel <piotr.krzysztof.gawel@gmail.com>
Date: Thu, 25 Jul 2019 20:04:24 +0200
Subject: [LTP] [PATCH] tst_timer: fix verification of execution time
In-Reply-To: <20190725144450.GB24513@rei.lan>
Message-ID: <5d39ef2b.1c69fb81.d3010.b8ef@mx.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,Oops. I missed that. Please reject this patch.BR, PiotrWys?ano z mojego smartfona Samsung Galaxy.
-------- Oryginalna wiadomo?? --------Od: Cyril Hrubis <chrubis@suse.cz> Data: 25.07.2019  16:45  (GMT+01:00) Do: Piotr Gawel <piotr.krzysztof.gawel@gmail.com> DW: ltp@lists.linux.it Temat: Re: [LTP] [PATCH] tst_timer: fix verification of execution time Hi!> Each sample needs to be in range:>???? t < s[i] < t + threshold> Thus for i from the interval [d...n]:>???? (n-d)*t < sum(s[d...n]) < (n-d)*(t + threshold)> This patch fixes that check.As far as I can tell the function compute_treshold() multiplies thethreshold per call by keep_samples already, so it's a threashold per runnot a treshold per call, or do I miss something?> Signed-off-by: Piotr Gawel <piotr.krzysztof.gawel@gmail.com>> --->? lib/tst_timer_test.c | 2 +->? 1 file changed, 1 insertion(+), 1 deletion(-)> > diff --git a/lib/tst_timer_test.c b/lib/tst_timer_test.c> index f6459e5..4508e29 100644> --- a/lib/tst_timer_test.c> +++ b/lib/tst_timer_test.c> @@ -306,7 +306,7 @@ void do_timer_test(long long usec, unsigned int nsamples)>? 		samples[nsamples-1], samples[0], median,>? 		1.00 * trunc_mean / keep_samples, discard);>? > -	if (trunc_mean > (nsamples - discard) * usec + threshold) {> +	if (trunc_mean > keep_samples * (usec + threshold)) {>? 		tst_res(TFAIL, "%s slept for too long", scall);>? 		if (!print_frequency_plot)> -- > 2.7.4> > > -- > Mailing list info: https://lists.linux.it/listinfo/ltp-- Cyril Hrubischrubis@suse.cz
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190725/2c4d35e6/attachment.htm>
