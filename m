From: Li Wang <liwang@redhat.com>
Date: Thu, 6 Feb 2020 15:01:08 +0800
Subject: [LTP] [PATCH] syscalls/getrandom02: lower bufsize if low on
 entropy
In-Reply-To: <1751041821.5968536.1580913131753.JavaMail.zimbra@redhat.com>
References: <7843cc36a04deb034e9479a139f535e5fa5f3135.1580894017.git.jstancek@redhat.com>
 <CAEemH2fnu9nZiGDfa5LTTMA0a_-PJ35fjjLdZ2vXYNGRJqHfVA@mail.gmail.com>
 <1751041821.5968536.1580913131753.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2eycvuJkqvTj=8R=aRqRGxhb=n3BzpeAaaCk8M4oJELsg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Feb 5, 2020 at 10:32 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > >
> > > @@ -37,11 +39,17 @@ static int check_content(unsigned char *buf, int
> nb)
> > >  static void verify_getrandom(unsigned int n)
> > >  {
> > >         unsigned char buf[256];
> > > +       int bufsize = 64, entropy_avail;
> > >
> >
> > I'm not sure why here initialize bufsize as 64? can you explain more?
>
> That would be the default, unless we know we have enough entropy.
>
> I picked 64 as it matches 'random_read_wakeup_bits'. Assuming we can get
> 1bit/s entropy, then potentially worst case of waiting 4x for 64bit,
> it should still fit within default 300 seconds.
>

That sounds reasonable. Thanks for the analysis.

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200206/521ada62/attachment.htm>
