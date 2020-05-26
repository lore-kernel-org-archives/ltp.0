From: Li Wang <liwang@redhat.com>
Date: Tue, 26 May 2020 09:13:01 +0800
Subject: [LTP] [PATCH] hugemmap05: check if the reserving hpages as
 expected
In-Reply-To: <20200525190233.GA21052@dell5510>
References: <20200525105410.4328-1-liwang@redhat.com>
 <20200525190233.GA21052@dell5510>
Message-ID: <CAEemH2dx1FecjOvVKdewTd0PBjCsin=6RuG5esCP-0+Zp_ichw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, May 26, 2020 at 3:02 AM Petr Vorel <pvorel@suse.cz> wrote:

> Hi Li,
>
> > To get rid of TBROK on small box:
> >   hugemmap05.c:88: BROK: mmap((nil),201326592,3,1,6,0) failed: ENOMEM
> (12)
>
> > And, reduce the reserved testing huge pages to 2, it also works well.
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>

Thanks for your review.

>
> Nice speedup :)
> Maybe add some constant for size (2), as it's used on 3 places?
>

Good suggestion, I added a 'NR_HPAGES' definition and pushed.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200526/65fd1a89/attachment.htm>
