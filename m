From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Mar 2021 14:20:51 +0800
Subject: [LTP] [PATCH] open_posix: Remove hardcoded /tmp
In-Reply-To: <4e99e625-07f1-e0c1-ab23-30f0ee8e59ef@jv-coder.de>
References: <20210316130036.1838169-1-lkml@jv-coder.de>
 <CAEemH2dxiFi_6VUOpyaufkOecE8TCi-m8bVT=xY9GREzOfKW-A@mail.gmail.com>
 <4e99e625-07f1-e0c1-ab23-30f0ee8e59ef@jv-coder.de>
Message-ID: <CAEemH2ej++f-e17ifn2eFqaQJmECgei62nXR7LnD-X1ypQ3czQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Wed, Mar 17, 2021 at 2:12 PM Joerg Vehlow <lkml@jv-coder.de> wrote:

> Hi,
> > It'd be great if a passing string end with the suffix "_", be used to
> > clearly distinguish the PID number.
> >
> > Something like:
> > LTP_GET_TMP_FILENAME(tmpfname, "pts_aio_cancel_1_1_");
> >
> > This comment applies to all of the changing files in this patch, or we
> > can modify it in the macro prototype.
> Is this really of any use? I was also thinking about removing the prefix
> part of the filename completely.
>

In fact useless, and nobody cares about the temp file name.
But that'll make naming make some sense or tidy, IMO.


> I just decided to keep it, so files, that are not deleted automatically
> can be identified as belonging to the test.
> If I would implement this, then only in the macro definition.
>

If I was the author, prefer to do that in macro definition too:).

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210317/b37ddf8e/attachment.htm>
