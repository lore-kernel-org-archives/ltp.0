From: Li Wang <liwang@redhat.com>
Date: Mon, 3 Aug 2020 16:47:50 +0800
Subject: [LTP] [PATCH v1 2/2] libs/libltpnewipc: Add libmsgctl.c into
 new ipc library
In-Reply-To: <320f25e9-f0e7-73a9-fe43-284befcce1e2@cn.fujitsu.com>
References: <1595911224-12470-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1595911224-12470-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200729143451.GG7152@yuki.lan>
 <320f25e9-f0e7-73a9-fe43-284befcce1e2@cn.fujitsu.com>
Message-ID: <CAEemH2dAGGFt6esH4srVec=6HCVt3j+Bn1UOdTACwg_5xj1htA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Xu,

On Thu, Jul 30, 2020 at 3:00 PM Yang Xu <xuyang2018.jy@cn.fujitsu.com>
wrote:

> Hi Cyril
>
>
> > Hi!
> >> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> >> ---
> >>   include/libnewipc.h           |  28 ++++------
> >>   libs/libltpnewipc/libnewipc.c | 101 ++++++++++++++++++++++++++++++++--
> >>   2 files changed, 109 insertions(+), 20 deletions(-)
> >
> > Just FYI we do not have to put all the code into a single *.c file, we
> > can have as many as we want in the library directory...
> I remember you have some comments on my previous patach as below:
> ------------------------------
> So unless we plan to use it from different tests it does not make much
> sense to export it to the top level include and libs.
>
> Or alternatively we do have libltpnewipc we can pust put the
> libnewmsgctl.c to that directory and with that we will have a single
> System V IPC helper library.
> ------------------------------
>
> So I merge libnewmsgctl.c into libnewipc.c.
>
> ps: IMO, libnewipc has only three functions(getipckey,get_used_queues,
> probe_free_addr) ,It's hard to call it a LIBS library. Can we put it
> into lib directory and named it as tst_ipc.c?
> @LI, What do you think about this?
>

I have no objection to this.

The reason to move it to LIBS is to support both new and old test cases in
same directory, so if you're going to move back into the general LTP lib,
we have to convert all the old-tests into new API. Then it will be fine.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200803/33a860d8/attachment.htm>
