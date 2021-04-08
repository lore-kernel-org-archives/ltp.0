From: Li Wang <liwang@redhat.com>
Date: Thu, 8 Apr 2021 17:27:47 +0800
Subject: [LTP] [PATCH v3 1/4] lib: Add proper filesystem skiplist
In-Reply-To: <YG7DUS1lObVjsrBo@yuki>
References: <20210317105318.32017-1-chrubis@suse.cz>
 <20210317105318.32017-2-chrubis@suse.cz>
 <CAEemH2frh1iyW9SrVJkwXT9nrHt1C+WUmQUcNb=mCota9_xKAA@mail.gmail.com>
 <YG7DUS1lObVjsrBo@yuki>
Message-ID: <CAEemH2cv-zWyKTiq4qRxH4b5Yneyv+mixyzXZik42wMbX+ANTw@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Thu, Apr 8, 2021 at 4:52 PM Cyril Hrubis <chrubis@suse.cz> wrote:

> Hi!
> > Do you think it necessary to rename 'enum tst_fs_type' to distinguish
> with
> > 'fs_type'?
> >
> > As it is quite similar to the 'fs_type*' series function and structure,
> > that might mess up
> > the code (we even have the same name function: tst_fs_type). So, I'd like
> > to suggest
> > use 'enum tst_fs_status' or 'enum tst_fs_item', or anything else.
>
> What about enum 'tst_fs_impl' as for filesystem implementation?
>

Fine.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210408/54845e27/attachment-0001.htm>
