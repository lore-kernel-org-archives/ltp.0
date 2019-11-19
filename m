From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Nov 2019 22:03:48 +0800
Subject: [LTP] [PATCH] tst_fill_fs: enhance the filesystem filling
 routine
In-Reply-To: <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
References: <20191119094156.20348-1-liwang@redhat.com>
 <1860355560.12961927.1574161647388.JavaMail.zimbra@redhat.com>
Message-ID: <CAEemH2cN8qv_YpsFKJazcOKEvgfjXpacZOV_Er-0bjK86=6VpQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Nov 19, 2019 at 7:07 PM Jan Stancek <jstancek@redhat.com> wrote:

>
>
> ----- Original Message -----
> > -             while (len) {
> > +             while (len >= fi.f_bsize) {
>
> Let's say f_bsize is 512, and len is 1023. We hit ENOSPC for 1023,
> len for next round is 511. Loop ends, but we never tried write with
> f_bsize or smaller value.
>
> I think we should try len < fi.f_bsize@least once.
>

Good point. At least for len = fi.f_bsize.


>
> >                       ret = write(fd, buf, MIN(len, sizeof(buf)));
> >
> >                       if (ret < 0) {
> > +                             if (errno == ENOSPC) {
> > +                                     len /= 2;
> > +                                     continue;
> > +                             }
>
> The return below (in original code) doesn't appear to be reachable now.
>

Yes, but it doesn't make much sense there, maybe we could remove that part
directly?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191119/e94973b4/attachment.htm>
