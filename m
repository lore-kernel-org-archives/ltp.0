From: Li Wang <liwang@redhat.com>
Date: Thu, 26 Nov 2020 10:17:14 +0800
Subject: [LTP] [PATCH 01/10] lib: Introduce more TEST_* macros
In-Reply-To: <20201125155716.GA5358@yuki.lan>
References: <20201113131428.13199-1-chrubis@suse.cz>
 <20201113131428.13199-2-chrubis@suse.cz>
 <20201113202828.GA2229@pevik>
 <CAEemH2fXD-gFF_7PogAPB1txUrgQmmzeK8p=MaMSn1zam0YeVg@mail.gmail.com>
 <20201119130824.GC12628@yuki.lan> <20201125131803.GB30149@yuki.lan>
 <CAEemH2dWwLD-J+cP6mJ3LAHcbGBtZ+ZaUMBiBZBDBsyK-q8Zww@mail.gmail.com>
 <20201125155716.GA5358@yuki.lan>
Message-ID: <CAEemH2fLWzGYfiaGfBNd+x29Ts-sO31JRRF+-UH-g=GRd0aGFw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Nov 25, 2020 at 11:56 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > > Is anyone against pushing this initial patchset as it is?
> > >
> >
> > Another bit of concern I have is the TEST_FAIL might cause
> > confusion in code reading. It looks like the test will be failed here
> > but in finish the test report pass, maybe we'd better tell people the
> > failure is expected?
> > (that was just my feeling on TEST_FAIL at the first glance)
> >
> > Or rename them to:
> >
> > TEST_EXP_PASS
> > TEST_EXP_FAIL
> > TEST_EXP_FD
>
> Fair enough, let's rename them like this.
>
> Any other concerns?
>

No more from me, thank you.
-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20201126/cdad67fd/attachment.htm>
