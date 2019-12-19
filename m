From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2019 17:15:00 +0800
Subject: [LTP] [PATCH RFC] sync_file_range02: remove the toplimit of
 write back
In-Reply-To: <CAFA6WYOBbH8UbwrK1f3ZQjGuqHJqGZxhQ-N0w1mpBHz0bnPG1w@mail.gmail.com>
References: <20191218082826.25083-1-liwang@redhat.com>
 <2104821569.17247635.1576661091375.JavaMail.zimbra@redhat.com>
 <CAFA6WYN1ssqCzCqvT=9=DLjZdQz8OnH7+YBi8VGo7XLRdNLyvg@mail.gmail.com>
 <CAEemH2eRhmozt5OiT6z-YBjJUBNaGZgQVQRh40hNpKcq2d4-aw@mail.gmail.com>
 <CAFA6WYOBbH8UbwrK1f3ZQjGuqHJqGZxhQ-N0w1mpBHz0bnPG1w@mail.gmail.com>
Message-ID: <CAEemH2eXvZB9uCuZFsc2uMAt5k2F_gfgXCqch58juMsJn4Gr4w@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Dec 19, 2019 at 4:52 PM Sumit Garg <sumit.garg@linaro.org> wrote:

> ...
> >> To avoid similar scenarios, I suggested to add a "sync()" call just
> >> prior to test here [1]. And I couldn't reproduce the failure in
> >> 1000-times run with 4.19 kernel.
> >
> >
> > Yes, that makes sense to me.
> >
>
> Would you mind to give it a try and check if you could reproduce the
> failure?
>

Actually, I haven't had one time to reproduce it. This failure was reported
by CI jobs and very low frequency occurred. The fix is based on a
discussion with FS developer analysis.

But I would have a try with this patch(+ sync()).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191219/b20347a7/attachment.htm>
