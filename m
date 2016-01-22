From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 22 Jan 2016 06:16:28 -0500 (EST)
Subject: [LTP] LTP release
In-Reply-To: <20160121174101.GD19851@rei.lan>
References: <20160121174101.GD19851@rei.lan>
Message-ID: <1892563285.11092383.1453461388185.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it





----- Original Message -----
> From: "Cyril Hrubis" <chrubis@suse.cz>
> To: ltp@lists.linux.it
> Sent: Thursday, 21 January, 2016 6:41:02 PM
> Subject: [LTP] LTP release
> 
> Hi!
> Just now I'm testing last set of changes for cgroup_fj tests (in the end
> these were too bugy so I've did a partial rewrite) and once that is done
> and pushed the release is green from my side. Minus the ROD problem that
> I've posted earlier but that can be workarounded for the release.
> 
> What is the status from the rest of you?

Hi,

I did compile + run test (with subset of runtest files) on
RHEL5.6/RHEL6.2/6.7/7.2 (i386/x86_64/ppc64/s390x), which worked
OK with one exception below.

One issue I keep hitting is oom0X hang [1], but since it's there for
months we don't need to hold release for that (I don't have any
tested patch yet).

What I'm thinking is to introduce a parameter to control how many threads
we allow to race towards OOM. At the moment it's NCPU-1, which appears
to be too stressful for regular runtest files. It hangs kernels from
3.10 up to 4.4 and there's no fix atm.

[1] http://lists.linux.it/pipermail/ltp/2016-January/000807.html

> 
> Can we do the release on Monday or Tuesday?

Fine by me.

Regards,
Jan

> 
> --
> Cyril Hrubis
> chrubis@suse.cz
> 
> --
> Mailing list info: http://lists.linux.it/listinfo/ltp
> 
