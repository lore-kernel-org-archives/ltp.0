From: Thomas Gleixner <tglx@linutronix.de>
Date: Wed, 29 Jun 2016 21:01:21 +0200 (CEST)
Subject: [LTP] [lkp] [signal] 98ea270c46: ltp.float_exp_log.fail
In-Reply-To: <20160628085608.GA31668@rei.suse.de>
References: <20160628030304.GJ19084@yexl-desktop>
 <20160628085608.GA31668@rei.suse.de>
Message-ID: <alpine.DEB.2.11.1606292100510.3707@nanos>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, 28 Jun 2016, Cyril Hrubis wrote:
> Looking at the test it creates a separate thread to handle signals which
> sleeps in sigwait() which is implemented in glibc via the sigtimedwait
> syscall with NULL timeout.
> 
> Looking at the patch the ktime_t timeout is initialized to 0 instead of
> MAX_SCHEDULE_TIMEOUT now so I guess that the call with NULL timeout does
> poll instead of sleeping in kernel waiting for signals to arrive. That
> should be fixed.

You're right. I misread the code...
