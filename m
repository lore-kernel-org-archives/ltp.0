From: Jan Stancek <jstancek@redhat.com>
Date: Thu, 21 Nov 2019 03:45:02 -0500 (EST)
Subject: [LTP] [PATCH 1/3] perf_event_open02: migrate to newlib
In-Reply-To: <20191120122910.GD14963@rei.lan>
References: <cover.1574087532.git.jstancek@redhat.com>
 <53c6b3308d3e77fd95cae17b2a7ed1d4e8b2f60e.1574087532.git.jstancek@redhat.com>
 <20191120122910.GD14963@rei.lan>
Message-ID: <983876625.13285336.1574325902291.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



----- Original Message -----
> Hi!
> > @@ -312,15 +238,13 @@ static void cleanup(void)
> >  {
> >  	int i;
> >  
> > -	for (i = 0; i < n; i++) {
> > -		if (hwfd[i] > 0 && close(hwfd[i]) == -1)
> > -			tst_resm(TWARN | TERRNO, "close(%d) failed", hwfd[i]);
> > -		if (tskfd[i] > 0 && close(tskfd[i]) == -1)
> > -			tst_resm(TWARN | TERRNO, "close(%d) failed", tskfd[i]);
> > +	for (i = 0; i < ntotal; i++) {
> > +		SAFE_CLOSE(hwfd[i]);
> > +		SAFE_CLOSE(tskfd[i]);
> 
> Shouldn't we check that the hwfd[i] and tskfd[i] are > 0?
> 
> I guess that we may do SAFE_CLOSE(0) repeatedly here in a case that
> perf_event_open() failed somewhere in the middle of the setup().

I'll add check for -1, since 0 could be valid (even though it's unlikely).

> 
> Otherwise this is a nice cleanup, acked.

Thanks for review.

