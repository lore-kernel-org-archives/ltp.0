From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 May 2016 18:32:32 +0200
Subject: [LTP] [PATCH V2 9/9] ftrace_stress: cleanup and use ltp API
In-Reply-To: <1857309330.43401385.1462376568052.JavaMail.zimbra@redhat.com>
References: <1460966656-28328-1-git-send-email-chuhu@redhat.com>
 <1460966656-28328-5-git-send-email-chuhu@redhat.com>
 <1460966656-28328-6-git-send-email-chuhu@redhat.com>
 <1460966656-28328-7-git-send-email-chuhu@redhat.com>
 <1460966656-28328-8-git-send-email-chuhu@redhat.com>
 <1460966656-28328-9-git-send-email-chuhu@redhat.com>
 <1460966656-28328-10-git-send-email-chuhu@redhat.com>
 <20160504145630.GE12244@rei.lan>
 <1857309330.43401385.1462376568052.JavaMail.zimbra@redhat.com>
Message-ID: <20160504163232.GA22657@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > > diff --git
> > > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> > > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> > > index fbaceb8..6090a91 100755
> > > ---
> > > a/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> > > +++
> > > b/testcases/kernel/tracing/ftrace_test/ftrace_stress/ftrace_tracing_max_latency.sh
> > > @@ -15,12 +15,13 @@
> > >  
> > >  MAX_LATENCY=100000
> > >  
> > > -for ((; ;))
> > > -{
> > > -	for ((i = 0; i < $MAX_LATENCY; i += 400))
> > > -	{
> > > +while true; do
> > > +	i=0;
> > > +	while [ $i -lt $MAX_LATENCY ]; do
> > >  		echo $i > "$TRACING_PATH"/tracing_max_latency
> > > -	}
> > > +		i=$((i + 400))
> > > +	done
> > >  
> > >  	sleep 1
> > > -}
> > > +
> > > +Vdone
> >    ^
> >    Typo?
> 
> Here it is weird, I checked my repo and my email in ltp list, there is no char 'V',
> I will have a deeper check.

Looks like this was a typo on my side. I've must have pressed the key by
accident when I was editing a reply to the email. Sorry for the
confusion.

-- 
Cyril Hrubis
chrubis@suse.cz
