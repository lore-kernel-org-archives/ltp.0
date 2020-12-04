From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 4 Dec 2020 14:47:55 +0100
Subject: [LTP] [PATCH v5 04/10] fanotify: Add helper for FAN_REPORT_FID
 support on fs
In-Reply-To: <CAOQ4uxhdW2x=gUD1D39Pc3Ke3QmkDUZswcLuA4djH6jcQZP_=w@mail.gmail.com>
References: <20201201174214.24625-1-pvorel@suse.cz>
 <20201201174214.24625-5-pvorel@suse.cz>
 <20201202154604.GD12342@yuki.lan> <X8fXG3ix4oq2Gab6@pevik>
 <CAOQ4uxhdW2x=gUD1D39Pc3Ke3QmkDUZswcLuA4djH6jcQZP_=w@mail.gmail.com>
Message-ID: <X8o+C0WZV8f8VONT@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

...
> > > Maybe this would be just easier to read as a macro:

> > > #define FANOTIFY_FAN_REPORT_FID_ERR_MSG(res_func, fail) do { \
> > >       if (fail == -1) \
> > >               res_func(TCONF, "FAN_REPORT_FID not supported in kernel?"); \
> > >       if (fail == -2) \
> > >               res_func(TCONF, ...); \
> > >       } while (0)


> Sorry, I ended up reverting that back to a function.
np, probably better anyway.

...
> > > The rest is good.

> > Both your comments fixed, patchset merged.

> > Thank you both for your patient review,

> > Amir, I'm sorry it took me that long.

> No worries.
> I know there was a lot of black magic behind all the flag checks
> that needed explanations.

> > Looking forward to your patchset :).


> Posted.
Thanks!

> Note that I only tested upstream, v5.8, v4.20 and not kernels
> without permission events support and not exfat.

> I trust you will help to fill those testing gaps.
Sure! I should get into that early next week.

> If I am not mistaken, before my fixes, fanotify10 was going to fail
> instead of TCONF on exfat/ntfs and kernel >= v5.9, but I did not check.
Don't fail on master on my openSUSE kernel 5.10.0-rc5-2.ge84a0b5-default

> Thanks,
> Amir.

Kind regards,
Petr
