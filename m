From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 15 Jul 2021 11:29:52 +0200
Subject: [LTP] [PATCH] syscalls/fanotify: Fix running tests in a loop
In-Reply-To: <CAOQ4uxj_vJVXTJex1W1cAJ_LQkbNqUnasuiUTsp=Bgrznm472A@mail.gmail.com>
References: <20210714180840.160798-1-amir73il@gmail.com>
 <YO/e3wcY8oXyFCO5@pevik>
 <CAOQ4uxj_vJVXTJex1W1cAJ_LQkbNqUnasuiUTsp=Bgrznm472A@mail.gmail.com>
Message-ID: <YPAAEPZMOnGWfWG6@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

...
> > FYI both fixes prolonged running for about 100% (comparing with runs on master
> > which don't fail). Of course, that's not a problem at all, it's just interesting
> > for me how simple closing of file descriptor can be expensive.

> Nice observation! LTP is not the only test suite that observed this issue. See:
> https://lore.kernel.org/linux-fsdevel/CAC-ggsFLmFpz5Y=-9MMLwxuO2LOS9rhpewDp_-u2hrT9J79ryg@mail.gmail.com/

> In order to fix that issue we will need some LTP helpers to take care of closing
> fanotify/inotify fds in batches for loop runs, which is kind of what
> happened before
> the fd leak fix only the batch was infinite...

> Attached sample patch for fanotify18.
> You will need to run some more experiments to see if it is worth it or not
> and then if it is worth it, probably generalize the helpers.

Thanks for detailed info and patch. I'm going to merge the original patch as
it's not an issue to run tests slower (more important is to actually fix the
issue) and have look into your patchset whether it's worth of adding it.

Kind regards,
Petr
