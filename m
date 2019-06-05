From: Li Wang <liwang@redhat.com>
Date: Wed, 5 Jun 2019 22:40:02 +0800
Subject: [LTP] [PATCH 2/2] inotify: Add SAFE_MYINOTIFY_ADD_WATCH() helper
In-Reply-To: <20190605141613.GA3965@dell5510>
References: <20190605072126.19856-1-pvorel@suse.cz>
 <20190605072126.19856-2-pvorel@suse.cz>
 <CAEemH2doAQ7=b-zutgHnY469rz-JThw0E_3b4o79zx+n2-uX_A@mail.gmail.com>
 <20190605141613.GA3965@dell5510>
Message-ID: <CAEemH2fLHFmNL57Hm5oU8MNoUN72brqz7fO-fOY_GGTxrAEpPQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Jun 5, 2019 at 10:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> thanks for your review.
>
> > If test exit with TBROK the reap_wd will never get a chance to set as 1,
> > and the cleanup() also make no sense in tst_brk() calling.
> No, that's a "flag" for cleanup function which is run always (no matter
> whether
> tst_brk() was called). See cleanup() and mount_flag in [1].
>

You are right. And seems the problem is only exist in original code, it put
reap_wd in wrong place and mislead my sight.

       if ((wd = myinotify_add_watch(fd_notify, DIR_PATH, IN_ALL_EVENTS)) <
0) {
               tst_brk(TBROK | TERRNO,
                       "inotify_add_watch (%d, " DIR_PATH ", IN_ALL_EVENTS)
failed",
                       fd_notify);
               reap_wd = 1;
       };


> > > with reap_wd defined in inotify.h there could be also
> > > SAFE_MYINOTIFY_RM_WATCH().
> And my suggestion above was to handle this flag in inotify.h. Than it'd
> make
> sense to add also SAFE_MYINOTIFY_RM_WATCH().
>

You patch set looks good.

Sorry for the error in judgment, that remind me it's time to go to bed
now:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190605/3ed111b1/attachment.html>
