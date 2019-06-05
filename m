From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Jun 2019 16:16:13 +0200
Subject: [LTP] [PATCH 2/2] inotify: Add SAFE_MYINOTIFY_ADD_WATCH() helper
In-Reply-To: <CAEemH2doAQ7=b-zutgHnY469rz-JThw0E_3b4o79zx+n2-uX_A@mail.gmail.com>
References: <20190605072126.19856-1-pvorel@suse.cz>
 <20190605072126.19856-2-pvorel@suse.cz>
 <CAEemH2doAQ7=b-zutgHnY469rz-JThw0E_3b4o79zx+n2-uX_A@mail.gmail.com>
Message-ID: <20190605141613.GA3965@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

thanks for your review.

> If test exit with TBROK the reap_wd will never get a chance to set as 1,
> and the cleanup() also make no sense in tst_brk() calling.
No, that's a "flag" for cleanup function which is run always (no matter whether
tst_brk() was called). See cleanup() and mount_flag in [1].

> > with reap_wd defined in inotify.h there could be also
> > SAFE_MYINOTIFY_RM_WATCH().
And my suggestion above was to handle this flag in inotify.h. Than it'd make
sense to add also SAFE_MYINOTIFY_RM_WATCH().

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/Test-Writing-Guidelines#a-word-about-the-cleanup-callback
