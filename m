From: Sandeep Patil <sspatil@google.com>
Date: Tue, 6 Nov 2018 08:13:12 -0800
Subject: [LTP] [PATCH 4/5] syscalls/chmod05: Use new ltp library
In-Reply-To: <20181106160119.GE3014@rei.lan>
References: <20181105235019.254846-1-sspatil@google.com>
 <20181105235019.254846-5-sspatil@google.com>
 <20181106155524.GC259383@sspatil-workstation.mtv.corp.google.com>
 <20181106160119.GE3014@rei.lan>
Message-ID: <20181106161312.GD259383@sspatil-workstation.mtv.corp.google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 06, 2018 at 05:01:19PM +0100, Cyril Hrubis wrote:
> Hi!
> > > -void cleanup(void)
> > > -{
> > > -	if (setegid(0) == -1)
> > > -		tst_resm(TWARN | TERRNO, "setegid(0) failed");
> > > -	if (seteuid(0) == -1)
> > > -		tst_resm(TWARN | TERRNO, "seteuid(0) failed");
> > > -
> > 
> > It looks like I need to do this in some cleanup function for the new test.
> > Otherwise the library cleanup won't be able to delete the tmpdir. Let me
> > rework this..
> 
> Actually the temporary directory cleanup in the new library is executed
> from the parent process, the actuall test is executed from a forked
> child so it shouldn't matter what euid and egid the child process ends
> up with.

Well too late, I added it again :). Anyway, this patch suffered from build
errors too. Turns out 'make install' doesn't build things again so I missed
them. I have fixed them up now and reset, feel free to delete the cleanup
function I added there (will respond there too)

 -ssp

> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> You received this message because you are subscribed to the Google Groups "kernel-team" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to kernel-team+unsubscribe@android.com.
> 
