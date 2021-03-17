From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Mar 2021 17:14:45 +0800
Subject: [LTP] [PATCH] open_posix: Remove hardcoded /tmp
In-Reply-To: <dbebbb6b-b2d1-c95a-3a8d-d92aae7a83f3@jv-coder.de>
References: <20210316130036.1838169-1-lkml@jv-coder.de>
 <CAEemH2dxiFi_6VUOpyaufkOecE8TCi-m8bVT=xY9GREzOfKW-A@mail.gmail.com>
 <4e99e625-07f1-e0c1-ab23-30f0ee8e59ef@jv-coder.de>
 <CAEemH2ej++f-e17ifn2eFqaQJmECgei62nXR7LnD-X1ypQ3czQ@mail.gmail.com>
 <dbebbb6b-b2d1-c95a-3a8d-d92aae7a83f3@jv-coder.de>
Message-ID: <CAEemH2e5xZvJQSYgBXqhgEpqYyQyM=VTb6sWBJr0REzBDVnr5A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Joerg,

On Wed, Mar 17, 2021 at 3:58 PM Joerg Vehlow <lkml@jv-coder.de> wrote:

> Hi Li,
>
> > In fact useless, and nobody cares about the temp file name.
> > But that'll make naming make some sense or tidy, IMO.
> >
> >     I just decided to keep it, so files, that are not deleted
> >     automatically
> >     can be identified as belonging to the test.
> >     If I would implement this, then only in the macro definition.
> >
> >
> > If I was the author, prefer to do that in macro definition too:).
> If it makes you happy, I think this can be done while merging.
>

Patch applied with two minor tweaks. Thanks!

1. add "_pid-" subfix to the mark PID number
2. fix the "\ No newline at end of file" issue caused by your $EDITOR,
which points out by Cyril last email
http://lists.linux.it/pipermail/ltp/2021-March/021515.html

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210317/1595d684/attachment.htm>
