From: Li Wang <liwang@redhat.com>
Date: Fri, 15 Feb 2019 16:40:49 +0800
Subject: [LTP] [PATCH 2/2] readdir02: use invalid DIR stream descriptor
In-Reply-To: <20190207125129.GB9277@rei>
References: <20181220090811.21514-1-liwang@redhat.com>
 <20181220090811.21514-2-liwang@redhat.com>
 <20190128151622.GA10646@rei.lan>
 <CAEemH2dC2M2UgnzbKK=WRnKjrP6UKOB6AierxE=hMbRmSn=Vcw@mail.gmail.com>
 <20190207125129.GB9277@rei>
Message-ID: <CAEemH2fg49o0CZ67mW4o8+ekoU47=Aa5jn-=S8CpyAFs-p4LLg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Sorry for late reply, since it was China holidays in past two weeks.

On Thu, Feb 7, 2019 at 8:51 PM Cyril Hrubis <chrubis@suse.cz> wrote:

>
> > AFAICT that changing an variable of one data type into another, and
> > the worst harmness is to loss of information in the variable so we'd
> > better avoid that. But in this test we only need a invalid DIR* for
> > readdir() tesst, it does *not* really care about the pointer content I
> > guess?
>
> Not at all, both FILE and DIR are typedefs to C structures, which are
> just chunks of memory, by doing this you are basically passing random
> data to the call because all it does when the C library gets the fd from
> these strucutres is that it takes bytes from at some offest in the chunk
> of memory. There are no abstract types, methods or objects in C, just
> chunks of memory.
>
>
Ok, I got the point, thanks for the explanation. I will help to rewrite a
new patch for readdir02 deleting.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190215/9363425b/attachment.html>
