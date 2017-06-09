From: Chunyu Hu <chuhu@redhat.com>
Date: Fri, 9 Jun 2017 03:42:01 -0400 (EDT)
Subject: [LTP] [PATCH] Make getrusage04 be able to loop more times
In-Reply-To: <20170607151315.GA30168@rei.suse.de>
References: <1496388495-30584-1-git-send-email-chuhu@redhat.com>
 <20170607151315.GA30168@rei.suse.de>
Message-ID: <2050137840.17454791.1496994121958.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: "Chunyu Hu" <chuhu@redhat.com>
> Cc: ltp@lists.linux.it
> Sent: Wednesday, June 7, 2017 11:13:15 PM
> Subject: Re: [LTP] [PATCH] Make getrusage04 be able to loop more times
> 
> Hi!
> >  int main(int argc, char *argv[])
> >  {
> >  	struct rusage usage;
> > -	unsigned long ulast, udelta, slast, sdelta;
> > +	unsigned long ulast, slast,  ulasts, slasts;
> > +	long udelta, sdelta, udeltas, sdeltas;
> >  	int i, lc;
> >  	char msg_string[BUFSIZ];
> >  
> > @@ -104,28 +105,33 @@ int main(int argc, char *argv[])
> >  		tst_count = 0;
> >  		i = 0;
> >  		SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
> > -		tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> > -			 usage.ru_utime.tv_usec, usage.ru_stime.tv_usec);
> > +		tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
> > +			 usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
> > +				usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
> >  		ulast = usage.ru_utime.tv_usec;
> >  		slast = usage.ru_stime.tv_usec;
> > +		ulasts = usage.ru_utime.tv_sec;
> > +		slasts = usage.ru_stime.tv_sec;
> 
> This is getting ugly. Why not just:
> 
> 	struct timeval ulast = usage.ru_utime;
> 	struct timeval slast = usage.ru_stime;

OK. I'll post a V2 for this.

> 
> 
> >  		while (i < RECORD_MAX) {
> >  			SAFE_GETRUSAGE(cleanup, RUSAGE_THREAD, &usage);
> >  			udelta = usage.ru_utime.tv_usec - ulast;
> >  			sdelta = usage.ru_stime.tv_usec - slast;
> > +			udeltas = usage.ru_utime.tv_sec - ulasts;
> > +			sdeltas = usage.ru_stime.tv_sec - slasts;
> >  			if (udelta > 0 || sdelta > 0) {
> >  				i++;
> > -				tst_resm(TINFO, "utime:%12luus; stime:%12luus",
> > -					 usage.ru_utime.tv_usec,
> > -					 usage.ru_stime.tv_usec);
> > -				if (udelta > 1000 + (BIAS_MAX * factor_nr)) {
> > +				tst_resm(TINFO, "utime:%lus %12luus; stime:%lus %12luus",
> > +					usage.ru_utime.tv_sec, usage.ru_utime.tv_usec,
> > +					usage.ru_stime.tv_sec, usage.ru_stime.tv_usec);
> > +				if (udelta > 1000 + (BIAS_MAX * factor_nr) && !udeltas) {
> >  					sprintf(msg_string,
> >  						"utime increased > %ldus:",
> >  						1000 + BIAS_MAX * factor_nr);
> >  					tst_brkm(TFAIL, cleanup, msg_string,
> >  						 " delta = %luus", udelta);
> >  				}
> > -				if (sdelta > 1000 + (BIAS_MAX * factor_nr)) {
> > +				if (sdelta > 1000 + (BIAS_MAX * factor_nr) && !sdeltas) {
> 
> Also why do we skipp the comparsion if seconds has changed?

OK. I'll try to consider second info in V2. 

> 
> Computing difference for twom timeval structures is not that
> complicated. I can add a helper into include/tst_timer.h if you want.

Do we have? I think we need something like below, not clear
about if this can be done with function or macro ;).

timval_minus(tv1, tv2) 
and
timeval_gt
timeval_lt
timeval_e

> 
> >  					sprintf(msg_string,
> >  						"stime increased > %ldus:",
> >  						1000 + BIAS_MAX * factor_nr);
> > @@ -135,6 +141,8 @@ int main(int argc, char *argv[])
> >  			}
> >  			ulast = usage.ru_utime.tv_usec;
> >  			slast = usage.ru_stime.tv_usec;
> > +			ulasts = usage.ru_utime.tv_sec;
> > +			slasts = usage.ru_stime.tv_sec;
> >  			busyloop(100000);
> >  		}
> >  	}
> > --
> > 1.8.3.1
> > 
> > 
> > --
> > Mailing list info: https://lists.linux.it/listinfo/ltp
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 

-- 
Regards,
Chunyu Hu

