From: Li Wang <liwang@redhat.com>
Date: Tue, 24 Mar 2020 21:08:05 +0800
Subject: [LTP] [PATCH 1/3] accept4: Use tst_variant
In-Reply-To: <20200324065343.GA24724@dell5510>
References: <20200323224933.2613658-1-petr.vorel@gmail.com>
 <20200323230305.GA2696136@x230> <20200324065343.GA24724@dell5510>
Message-ID: <CAEemH2e_aN-MAKhUyfug5e8tXYbR-qb3Twv+s3n=KOr-YydCRQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Tue, Mar 24, 2020 at 2:54 PM Petr Vorel <pvorel@suse.cz> wrote:

> Hi,
>
> > > I guess __NR_socketcall is for x86 and other old architectures,
> > > but we still want to use it, right?
>
> > Maybe I should have kept just 2 variants (libc implementation and only
> one
> > syscall implementation) and chose the correct syscall implementation with
> > #ifdef SYS_ACCEPT4
>
> > Or is there arch which supports both syscall variants?
> OK, I can answer myself: ppc64le is example of arch which support both
> __NR_accept4 and __NR_socketcall SYS_ACCEPT4.
>

That's right, I just verified it on my ppc64le(rhel8) platform, so we can
keep the 3 variants test.

For your patchset:
Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20200324/33144ed9/attachment.htm>
