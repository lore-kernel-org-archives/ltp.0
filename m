From: Han Pingtian <hanpt@linux.vnet.ibm.com>
Date: Tue, 15 Mar 2016 09:28:20 +0800
Subject: [LTP] question about signal handling in tst_sig()
In-Reply-To: <20160314134321.GD600@rei.lan>
References: <20160314081907.GA3579@localhost.localdomain>
 <20160314132827.GC600@rei.lan> <20160314134321.GD600@rei.lan>
Message-ID: <20160315012820.GB3579@localhost.localdomain>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Mar 14, 2016 at 02:43:21PM +0100, Cyril Hrubis wrote:
> Hi!
> > > Looks like in tst_sig(), if _SC_SIGRT_MIN defined, all realtime signals
> > > won't be set an handler:
> > > 
> > > 125 #ifdef _SC_SIGRT_MIN
> > > 126                 if (sig >= sigrtmin && sig <= sigrtmax)
> > > 127                         continue;
> > > 128 #endif
> > > 
> > > but, if it wasn't defined, then all realtime signals will be set an
> > > handler:
> > > 
> > > 134 #if !defined(_SC_SIGRT_MIN) && defined(__SIGRTMIN) &&
> > > defined(__SIGRTMAX)
> > > 135                         /* Ignore all real-time signals */
> > > 136                 case __SIGRTMIN:
> > > 137                 case __SIGRTMIN + 1:
> > > ...
> 
> And also there is a break down after the long list of cases.
> 
> 
> So it looks like:
> 
> * if _SC_SIGRT_MIN is defined we have a POSIX compilant system
>   and we skip realtime signals in the if at line 125.
> 
> * Otherwise if system is not POSIX compilant but __SIGRTMIN and
>   __SIGRTMAX is defined, we skip them in the hack in the switch()
> 
Thanks so much, I just noticed that there is a "break;" at line 206 ...

