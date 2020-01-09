From: Petr Vorel <pvorel@suse.cz>
Date: Thu, 9 Jan 2020 09:21:02 +0100
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <CAEemH2dEfE5A8Dipu671TgzU0MxHF9hTRVeTNgMsi-igPbrDMA@mail.gmail.com>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109074537.GA12486@dell5510>
 <CAEemH2dEfE5A8Dipu671TgzU0MxHF9hTRVeTNgMsi-igPbrDMA@mail.gmail.com>
Message-ID: <20200109082102.GA15119@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> > > Cc: Petr Vorel <pvorel@suse.cz>
> > BTW I wonder if my sieve filter is bad, because I didn't get this mail or
> > git
> > send-email didn't sent it.


> I guess that might because of your email filter configuration, the
> Cc'ed name will be kicked out if he/she has subscribed to the mailing list,
> especially for my Gmail-client always do that.

> This is git-send-email log FYI:
> ----------------------------
> $ git send-email 0001-tst_device-use-raw-syscall-in-the-tst_device.h.patch
> --to ltp@lists.linux.it
> 0001-tst_device-use-raw-syscall-in-the-tst_device.h.patch
> (body) Adding cc: Petr Vorel <pvorel@suse.cz> from line 'Cc: Petr Vorel <
> pvorel@suse.cz>'
> (body) Adding cc: Cyril Hrubis <chrubis@suse.cz> from line 'Cc: Cyril
> Hrubis <chrubis@suse.cz>'
> OK. Log says:
> Server: smtp.corp.redhat.com
> MAIL FROM:<liwang@redhat.com>
> RCPT TO:<ltp@lists.linux.it>
> RCPT TO:<pvorel@suse.cz>
> RCPT TO:<chrubis@suse.cz>
> From: Li Wang <liwang@redhat.com>
> To: ltp@lists.linux.it
> Cc: Petr Vorel <pvorel@suse.cz>,
> Cyril Hrubis <chrubis@suse.cz>
> Subject: [PATCH] tst_device: use raw syscall in the tst_device.h
> Date: Thu,  9 Jan 2020 15:15:10 +0800
> Message-Id: <20200109071510.11223-1-liwang@redhat.com>
> X-Mailer: git-send-email 2.20.1
> MIME-Version: 1.0
> Content-Transfer-Encoding: 8bit

> Result: 250

Thank you for info. Sorry, my fault (I had filter to List-Id: and *also* to To:
(normally I use just List-Id:, which is what I want).

> > +#define _GNU_SOURCE
> > >  #define _XOPEN_SOURCE 600
> > If we define _GNU_SOURCE we probably don't need _XOPEN_SOURCE 600, do we?


> Ah, right. I will remove it in patch merging.
Thanks!

Kind regards,
Petr
