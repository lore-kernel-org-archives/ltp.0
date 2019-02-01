From: Li Wang <liwang@redhat.com>
Date: Fri, 1 Feb 2019 14:59:06 +0800
Subject: [LTP] [PATCH 2/2] readdir02: use invalid DIR stream descriptor
In-Reply-To: <20190128151622.GA10646@rei.lan>
References: <20181220090811.21514-1-liwang@redhat.com>
 <20181220090811.21514-2-liwang@redhat.com>
 <20190128151622.GA10646@rei.lan>
Message-ID: <CAEemH2dC2M2UgnzbKK=WRnKjrP6UKOB6AierxE=hMbRmSn=Vcw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jan 28, 2019 at 11:19 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> >
> > In this patch, I simply modify the test to use an exist FILE *
> > stream to simulate the invalid directory stream descriptor. Then
> > it won't hit the use-after-free issue any more.
>
> Actually I think that the best we can do here is to delete the testcase
> because:
>
> * Casting FILE* to DIR* is IMHO invoking even worse undefined behavior
>   than the original test that called readdir() on closed DIR*
>

Why say this? Does this CASTING will do something more bad? AFAICT that
changing an variable of one data type into another, and the worst
harmness is to loss of information in the variable so we'd better avoid
that. But in this test we only need a invalid DIR* for readdir() tesst, it
does *not* really care about the pointer content I guess?



>
> * We do cover the EBADF for getents() syscalls getents02 test
>

I'm sorry, I don't find this testcase in LTP, or did I miss anything?

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190201/b5f0bd6a/attachment-0001.html>
