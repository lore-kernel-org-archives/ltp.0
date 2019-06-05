From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Jun 2019 17:18:39 +0200
Subject: [LTP] [PATCH 2/2] inotify: Add SAFE_MYINOTIFY_ADD_WATCH() helper
In-Reply-To: <CAEemH2fLHFmNL57Hm5oU8MNoUN72brqz7fO-fOY_GGTxrAEpPQ@mail.gmail.com>
References: <20190605072126.19856-1-pvorel@suse.cz>
 <20190605072126.19856-2-pvorel@suse.cz>
 <CAEemH2doAQ7=b-zutgHnY469rz-JThw0E_3b4o79zx+n2-uX_A@mail.gmail.com>
 <20190605141613.GA3965@dell5510>
 <CAEemH2fLHFmNL57Hm5oU8MNoUN72brqz7fO-fOY_GGTxrAEpPQ@mail.gmail.com>
Message-ID: <20190605151838.GA15712@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

> > > If test exit with TBROK the reap_wd will never get a chance to set as 1,
> > > and the cleanup() also make no sense in tst_brk() calling.
> > No, that's a "flag" for cleanup function which is run always (no matter
> > whether
> > tst_brk() was called). See cleanup() and mount_flag in [1].


> You are right. And seems the problem is only exist in original code, it put
> reap_wd in wrong place and mislead my sight.

>        if ((wd = myinotify_add_watch(fd_notify, DIR_PATH, IN_ALL_EVENTS)) <
> 0) {
>                tst_brk(TBROK | TERRNO,
>                        "inotify_add_watch (%d, " DIR_PATH ", IN_ALL_EVENTS)
> failed",
>                        fd_notify);
>                reap_wd = 1;
>        };

so I'll put into commit message:

    Also put reap_wd to correct place in inotify0[127].c
    (in original code it was in if clause after tst_brk() so it was
    1) unreachable 2) for detection it should have been after if (outside).

    Fixes: 04f2177b6, inotify0[12].c, 763d02824 (inotify07.c)

Acked-by: Li Wang <liwang@redhat.com>

Kind regards,
Petr
