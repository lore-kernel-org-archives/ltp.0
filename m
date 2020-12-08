From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 8 Dec 2020 08:30:56 +0100
Subject: [LTP] [PATCH 3/5] syscalls/fanotify09: Read variable length
 events
In-Reply-To: <CAOQ4uxhWB6Gq2SinwbKJ=PmkO=EWtcvLoF71GDPit8V=B+17EQ@mail.gmail.com>
References: <20201204095930.866421-1-amir73il@gmail.com>
 <20201204095930.866421-4-amir73il@gmail.com>
 <X84VqaD4+FqAix5h@pevik>
 <CAOQ4uxiCtAJVyVau3un2AnMNmn1Yub18sG10YopLRySmLAcpnw@mail.gmail.com>
 <X846sHuckxS/lLEV@pevik>
 <CAOQ4uxhWB6Gq2SinwbKJ=PmkO=EWtcvLoF71GDPit8V=B+17EQ@mail.gmail.com>
Message-ID: <X88rsF3xHgtqzP3t@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Amir,

...
> > > The fix exists in the following patch, therefore I did not notice the
> > > mid series regression.
> > While this is valid to be added in this commit and I'll add it, it does not fix
> > our solution. I might not be clear: since this commit it's broken.
> > Thus any other tip?

> So both a mid series regression and full series regression.
> Lovely :)

> Following patch needs this fix:

> --- a/testcases/kernel/syscalls/fanotify/fanotify09.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify09.c
> @@ -280,6 +280,7 @@ static void test_fanotify(unsigned int n)

>                         event = (struct fanotify_event_metadata *)event_buf;
>                         verify_event(i, event, expect, "");
> +                       event = FAN_EVENT_NEXT(event, ret);

>                         for (; FAN_EVENT_OK(event, ret);
> FAN_EVENT_NEXT(event, ret)) {
>                                 if (event->fd != FAN_NOFD)

> Pushed full fix series (including un-posted inotify test) to:
> https://github.com/amir73il/ltp/commits/fsnotify-fixes

Thanks! I was wrong, next commit was broken due missing this,
as you had correctly fixed in your LTP fork.

Anyway, merged!

Kind regards,
Petr
