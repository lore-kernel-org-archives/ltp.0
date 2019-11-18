From: Li Wang <liwang@redhat.com>
Date: Mon, 18 Nov 2019 14:38:55 +0800
Subject: [LTP] [PATCH] configure.ac: Fix --with* options
In-Reply-To: <20191118061634.GA21536@x230>
References: <20191113104149.42407-1-lkml@jv-coder.de>
 <CAEemH2eP-ibqs=Mc-aMYUxj7CJ-u9CUZnkD8=Ro_2td9StPVZQ@mail.gmail.com>
 <e506bf38-f1d9-6f9e-e4cd-6edf24f74cd9@jv-coder.de>
 <CAEemH2dWkKyx38HFNKDk6Lt1KiDYry9WVDx9Xzg7fVAkp3kOww@mail.gmail.com>
 <1c4d8fb5-58e4-5483-26c7-7ab38b5fbd9c@jv-coder.de>
 <CAEemH2dPwqX1FtNvF7=hxbAfVMz7i_u+TpUBaU1mqKhY-G0Vig@mail.gmail.com>
 <20191118061634.GA21536@x230>
Message-ID: <CAEemH2etxKzetDR+NW7+5WR=h=S6KAr_SSr+E-g_XRtUNyfmQg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Nov 18, 2019 at 2:16 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> > Well, I just saw adding new #TODO here and hoping to solve this
> together, a
> > simple way I was thinking is:
>
> > +AS_IF([test "x$with_bash" != xyes || test "x$with_python" != xyes],
> > +  [with_realtime_testsuite=no]
> > +)
>
> > Of course, It's fine to fix that in a separate patch!
>
> I'm for merging this. I just wonder if it's not better to remove
> $with_bash and
> $with_python (as part of this patch), if they're not working.
>

Me too. I think we could fix that in one patch. But as Joerg mentioned they
will be working on the #TODO. So maybe it doesn't matter to do right now or
later.

>
> BTW better, than fixing bash/shell would be to actually rewrote tests
> which are
> using python and bash to C or posix shell.
> https://github.com/linux-test-project/ltp/issues/547
>
> Kind regards,
> Petr
>
>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191118/c661b854/attachment-0001.htm>
