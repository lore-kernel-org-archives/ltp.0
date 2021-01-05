From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 5 Jan 2021 12:12:05 +0100
Subject: [LTP] [PATCH] cpio_tests.sh: Fix failure with BusyBox cpio
In-Reply-To: <20201222171033.GB126602@pevik>
References: <20201221110120.26165-1-radoslav.kolev@suse.com>
 <20201222171033.GB126602@pevik>
Message-ID: <X/RJhbNBfja6/Snr@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Radoslav,

...
> > +
> > +if cpio 2>&1 | grep -q '\-o\sCreate (requires -H newc)'; then
Thanks for your fix, merged with these changes:

* grep for BusyBox because some older versions does not contain the
hint, but actually require it.

* move things to setup function due my following commit, which cannot be
outside API functions (setup/test function):
And check for -o (which is on BusyBox optional).

Kind regards,
Petr
