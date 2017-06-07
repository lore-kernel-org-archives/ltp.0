From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Jun 2017 17:13:15 +0200
Subject: [LTP] [PATCH] Make getrusage04 be able to loop more times
In-Reply-To: <1496388495-30584-1-git-send-email-chuhu@redhat.com>
References: <1496388495-30584-1-git-send-email-chuhu@redhat.com>
Message-ID: <20170607151315.GA30168@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  int main(int argc, char *argv[])
>  {
>  	struct rusage usage;
> -	unsigned long ulast, udelta, slast, sdelta;
> +	unsigned long ulast, slast,  ulasts, slasts;
> +	long udelta, sdelta, udeltas, sdeltas;
>  	int i, lc;
>  	char msg_string[BUFSIZ];
>  
> @@ -104,28 +105,33 @@ int main(int argc, char *argv[])
>  		tst_count = 0;
>  		i = 0;
>  		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
> -		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> -			 usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
> +		tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
> +			 usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
> +				usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
>  		ulast = usage.ru_utime.tv_usec;
>  		slast = usage.ru_stime.tv_usec;
> +		ulasts = usage.ru_utime.tv_sec;
> +		slasts = usage.ru_stime.tv_sec;

This is getting ugly. Why not just:

	struct timeval ulast = usage.ru_utime;
	struct timeval slast = usage.ru_stime;


>  		while (i < RECORD_MAX) {
>  			SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
>  			udelta = usage.ru_utime.tv_usec - ulast;
>  			sdelta = usage.ru_stime.tv_usec - slast;
> +			udeltas = usage.ru_utime.tv_sec - ulasts;
> +			sdeltas = usage.ru_stime.tv_sec - slasts;
>  			if (udelta > 0 || sdelta > 0) {
>  				i++;
> -				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> -					 usage.ru_utime.tv_usec,
> -					 usage.ru_stime.tv_usec);
> -				if (udelta > 1000 + (BIAS_MAX * factor_nr)) {
> +				tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
> +					usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
> +					usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
> +				if (udelta > 1000 + (BIAS_MAX * factor_nr) && !udeltas) {
>  					sprintf(msg_string,
>  						"utime increased > %ldus:",
>  						1000 + BIAS_MAX * factor_nr);
>  					tst_brkm(TFAIL, cleanup, msg_string,
>  						 " delta = %luus", udelta);
>  				}
> -				if (sdelta > 1000 + (BIAS_MAX * factor_nr)) {
> +				if (sdelta > 1000 + (BIAS_MAX * factor_nr) && !sdeltas) {

Also why do we skipp the comparsion if seconds has changed?

Computing difference for twom timeval structures is not that
complicated. I can add a helper into include/tst_timer.h if you want.

>  					sprintf(msg_string,
>  						"stime increased > %ldus:",
>  						1000 + BIAS_MAX * factor_nr);
> @@ -135,6 +141,8 @@ int main(int argc, char *argv[])
>  			}
>  			ulast = usage.ru_utime.tv_usec;
>  			slast = usage.ru_stime.tv_usec;
> +			ulasts = usage.ru_utime.tv_sec;
> +			slasts = usage.ru_stime.tv_sec;
>  			busyloop(100000);
>  		}
>  	}
> -- 
> 1.8.3.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz
