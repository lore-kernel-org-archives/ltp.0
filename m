From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2020 16:02:57 +0800
Subject: [LTP] [PATCH] tst_device: use raw syscall in the tst_device.h
In-Reply-To: <20200109074537.GA12486@dell5510>
References: <20200109071510.11223-1-liwang@redhat.com>
 <20200109074537.GA12486@dell5510>
Message-ID: <CAEemH2dEfE5A8Dipu671TgzU0MxHF9hTRVeTNgMsi-igPbrDMA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Petr,

On Thu, Jan 9, 2020 at 3:45 PM Petr Vorel <pvorel@suse.cz> wrote:

> ...
> > Cc: Petr Vorel <pvorel@suse.cz>
> BTW I wonder if my sieve filter is bad, because I didn't get this mail or
> git
> send-email didn't sent it.
>

I guess that might because of your email filter configuration, the
Cc'ed name will be kicked out if he/she has subscribed to the mailing list,
especially for my Gmail-client always do that.

This is git-send-email log FYI:
----------------------------
$ git send-email 0001-tst_device-use-raw-syscall-in-the-tst_device.h.patch
--to ltp@lists.linux.it
0001-tst_device-use-raw-syscall-in-the-tst_device.h.patch
(body) Adding cc: Petr Vorel <pvorel@suse.cz> from line 'Cc: Petr Vorel <
pvorel@suse.cz>'
(body) Adding cc: Cyril Hrubis <chrubis@suse.cz> from line 'Cc: Cyril
Hrubis <chrubis@suse.cz>'
OK. Log says:
Server: smtp.corp.redhat.com
MAIL FROM:<liwang@redhat.com>
RCPT TO:<ltp@lists.linux.it>
RCPT TO:<pvorel@suse.cz>
RCPT TO:<chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
To: ltp@lists.linux.it
Cc: Petr Vorel <pvorel@suse.cz>,
Cyril Hrubis <chrubis@suse.cz>
Subject: [PATCH] tst_device: use raw syscall in the tst_device.h
Date: Thu,  9 Jan 2020 15:15:10 +0800
Message-Id: <20200109071510.11223-1-liwang@redhat.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Result: 250


> > Cc: Cyril Hrubis <chrubis@suse.cz>
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Nice, thanks for a fix. + Note about _XOPEN_SOURCE below.
>

Thanks for the quick reply.


>
> Tested-by: Petr Vorel <pvorel@suse.cz>
> https://travis-ci.org/pevik/ltp/builds/634613112
> NOTE: it works, failures to Debian testing are caused by bug in libtirpc
> 1.2.5,
> fixed in a86b4ff Add authdes_seccreate() stub [1].
>
> ...

> +#define _GNU_SOURCE
> >  #define _XOPEN_SOURCE 600
> If we define _GNU_SOURCE we probably don't need _XOPEN_SOURCE 600, do we?
>

Ah, right. I will remove it in patch merging.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200109/d54007f0/attachment.htm>
