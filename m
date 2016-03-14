From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 14:28:28 +0100
Subject: [LTP] question about signal handling in tst_sig()
In-Reply-To: <20160314081907.GA3579@localhost.localdomain>
References: <20160314081907.GA3579@localhost.localdomain>
Message-ID: <20160314132827.GC600@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Looks like in tst_sig(), if _SC_SIGRT_MIN defined, all realtime signals
> won't be set an handler:
> 
> 125 #ifdef _SC_SIGRT_MIN
> 126                 if (sig >= sigrtmin && sig <= sigrtmax)
> 127                         continue;
> 128 #endif
> 
> but, if it wasn't defined, then all realtime signals will be set an
> handler:
> 
> 134 #if !defined(_SC_SIGRT_MIN) && defined(__SIGRTMIN) &&
> defined(__SIGRTMAX)
> 135                         /* Ignore all real-time signals */
> 136                 case __SIGRTMIN:
> 137                 case __SIGRTMIN + 1:
> ...
> 
> is that correct, or I missed something here? 

The loop goes over signal numbers from 1 to NSIG (which is defined in
system headers). Supposedly when _SC_SIGRT_MIN is not defined the system
does not support realtime signals and the NSIG has value of the highest
allocated (non-realtime) signal number.

-- 
Cyril Hrubis
chrubis@suse.cz
