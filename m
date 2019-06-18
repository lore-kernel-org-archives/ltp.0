From: Li Wang <liwang@redhat.com>
Date: Tue, 18 Jun 2019 11:07:04 +0800
Subject: [LTP] [PATCH v2 1/3] lib: adding .arch field in tst_test
	structure
In-Reply-To: <20190617214901.GC19347@x230>
References: <20190615042048.29839-1-liwang@redhat.com>
 <20190617214901.GC19347@x230>
Message-ID: <CAEemH2cAFUkmmiokVwvC5YvT1QoXaANxtCjFypnYS309ietX0g@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Jun 18, 2019 at 5:49 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > Testcases for specified arch should be limited on that only being
> supported
> > platform to run, we now create a function tst_on_arch to achieve this new
> > feature in LTP library.  All you need to run a test on the expected arch
> is
> > to set the '.arch' string in the 'struct tst_test' to choose the required
> > arch list. e.g. '.arch = "x86_64 i386"'.
> Just one note, strings are error prone. I wonder if defining constants and
> using
> array would be too complicated for this use case.
>

I thought about that array way, but it seems a bit complicted in using.
Yes, strings are easy to involve typo but we can make a check in library.

Thanks for review.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190618/0d4c72f7/attachment.html>
