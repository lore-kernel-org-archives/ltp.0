From: Li Wang <liwang@redhat.com>
Date: Mon, 1 Jul 2019 20:57:28 +0800
Subject: [LTP] [Kernel BUG?] SMSW operation get success on UMIP KVM guest
In-Reply-To: <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
 <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
Message-ID: <CAEemH2fqMpoiBo+asyawHsOWgdXy-ggV0mwQs9A9EJ1kh=uhAA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 1, 2019 at 8:02 PM Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 01/07/19 09:50, Li Wang wrote:
> > Hello there,
> >
> > LTP/umip_basic_test get failed on KVM UMIP
> > system(kernel-v5.2-rc4.x86_64). The test is only trying to do
> >      asm volatile("smsw %0\n" : "=m" (val));
> > and expect to get SIGSEGV in this SMSW operation, but it exits with 0
> > unexpectedly.
>
> In addition to what Thomas said, perhaps you are using a host that does
> *not* have UMIP, and configuring KVM to emulate it(*).  In that case, it
> is not possible to intercept SMSW, and therefore it will incorrectly
> succeed.
>

Right, I checked the host system, and confirmed that CPU doesn't support
UMIP.

>
> Paolo
>
> (*) before the x86 people jump at me, this won't happen unless you
> explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
> incorrect emulation of SMSW when CR4.UMIP=1 is why.
>
Good to know this, is there any document for that declaration? It seems
neither LTP issue nor kernel bug here. But anyway we'd better do something
to avoid the error in the test.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20190701/bda8153f/attachment-0001.htm>
