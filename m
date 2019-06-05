From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 5 Jun 2019 17:02:48 +0200
Subject: [LTP] [PATCH 2/2] inotify: Add SAFE_MYINOTIFY_ADD_WATCH() helper
In-Reply-To: <CAEemH2fLHFmNL57Hm5oU8MNoUN72brqz7fO-fOY_GGTxrAEpPQ@mail.gmail.com>
References: <20190605072126.19856-1-pvorel@suse.cz>
 <20190605072126.19856-2-pvorel@suse.cz>
 <CAEemH2doAQ7=b-zutgHnY469rz-JThw0E_3b4o79zx+n2-uX_A@mail.gmail.com>
 <20190605141613.GA3965@dell5510>
 <CAEemH2fLHFmNL57Hm5oU8MNoUN72brqz7fO-fOY_GGTxrAEpPQ@mail.gmail.com>
Message-ID: <20190605150248.GA25885@x230>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

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
Thanks for pointing it out. I was surprised why this is there.
I'll note it in git commit.

...
> You patch set looks good.

> Sorry for the error in judgment, that remind me it's time to go to bed
> now:).
Really, thanks a lot for a review! (I'll add your ack).

Kind regards,
Petr
