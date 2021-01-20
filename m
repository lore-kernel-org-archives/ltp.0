From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 20 Jan 2021 10:39:09 +0100
Subject: [LTP] [PATCH] cpio_tests.sh: Fix failure with BusyBox cpio
In-Reply-To: <6007D97A.9010804@cn.fujitsu.com>
References: <20201221110120.26165-1-radoslav.kolev@suse.com>
 <20201222171033.GB126602@pevik> <X/RJhbNBfja6/Snr@pevik>
 <6007D97A.9010804@cn.fujitsu.com>
Message-ID: <YAf6Pe8lf0BN18t4@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Zhu,

> Hi Petr
> > Hi Radoslav,

> > ...
> > > > +
> > > > +if cpio 2>&1 | grep -q '\-o\sCreate (requires -H newc)'; then
> > Thanks for your fix, merged with these changes:

> > * grep for BusyBox because some older versions does not contain the
> > hint, but actually require it.

> > * move things to setup function due my following commit, which cannot be
> > outside API functions (setup/test function):
> > And check for -o (which is on BusyBox optional).
> On my test environment, just executing cpio with no arguments will only
> output:
> cpio: You must specify one of -oipt options.
> Try `cpio --help' or `cpio --usage' for more information.
Thanks for a report and sorry for a regression. I'll fix it with --help (that is
compatible for both cpio from GNU and for busybox cpio implementation.

> So the result of cpio01_sh is changed from PASS to CONF after commit
> 5910bdb65c.
> Is there any difference in the output from executing this command on your
> environment?

> Best Regards
> Feiyu Zhu

> > Kind regards,
> > Petr




