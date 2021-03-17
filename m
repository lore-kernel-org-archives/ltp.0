From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Mar 2021 18:33:30 +0800
Subject: [LTP] [PATCH] open_posix: Remove hardcoded /tmp
In-Reply-To: <YFHTLDEka/Mi4xOL@yuki.lan>
References: <20210316130036.1838169-1-lkml@jv-coder.de>
 <CAEemH2dxiFi_6VUOpyaufkOecE8TCi-m8bVT=xY9GREzOfKW-A@mail.gmail.com>
 <4e99e625-07f1-e0c1-ab23-30f0ee8e59ef@jv-coder.de>
 <CAEemH2ej++f-e17ifn2eFqaQJmECgei62nXR7LnD-X1ypQ3czQ@mail.gmail.com>
 <dbebbb6b-b2d1-c95a-3a8d-d92aae7a83f3@jv-coder.de>
 <CAEemH2e5xZvJQSYgBXqhgEpqYyQyM=VTb6sWBJr0REzBDVnr5A@mail.gmail.com>
 <YFHR13zKL9XZtdya@yuki.lan> <6a27ab32-9402-bf37-8828-05c2d5ff9c9e@jv-coder.de>
 <YFHTLDEka/Mi4xOL@yuki.lan>
Message-ID: <CAEemH2c7g4xVp_OeiyG7hr6J4b0S2kw_kB7sCDP+Xuwfe9aPog@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 17, 2021 at 5:58 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > There are also some LTP_-macros in open posix (like
> LTP_ATTRIBUTE_UNUSED).
> > I wasn't sure if maybe full assimilation is targeted. That's why I used
> > LTP-prefix.
>
> Sigh, looks like we have things prefixed with LTP_ in posixtest.h, that
> should be fixed as well.
>

I will send a patch to fix all. Thanks!

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210317/5f14a574/attachment.htm>
