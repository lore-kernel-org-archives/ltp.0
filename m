From: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Date: Mon, 1 Jul 2019 07:53:08 -0700
Subject: [LTP] [Kernel BUG?] SMSW operation get success on UMIP KVM guest
In-Reply-To: <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
 <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
Message-ID: <20190701145308.GA19368@ranerica-svr.sc.intel.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On Mon, Jul 01, 2019 at 02:02:35PM +0200, Paolo Bonzini wrote:
> On 01/07/19 09:50, Li Wang wrote:
> > Hello there,
> > 
> > LTP/umip_basic_test get failed on KVM UMIP
> > system(kernel-v5.2-rc4.x86_64). The test is only trying to do
> > ? ? ?asm volatile("smsw %0\n" : "=m" (val));
> > and expect to get SIGSEGV in this SMSW operation, but it exits with 0
> > unexpectedly.
> 
> In addition to what Thomas said, perhaps you are using a host that does
> *not* have UMIP, and configuring KVM to emulate it(*).  In that case, it
> is not possible to intercept SMSW, and therefore it will incorrectly
> succeed.

Also, emulation for SMSW, SIDT, and SGDT is done only for 32-bit
processes. As Thomas said, the purpose is not on break Wine. In 64-bit
processes, we sould always see a #GP exception.
> 
> Paolo
> 
> (*) before the x86 people jump at me, this won't happen unless you
> explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
> incorrect emulation of SMSW when CR4.UMIP=1 is why.

Paolo, what do you mean by the incorrect emulation of SMSW?

Thanks and BR,
Ricardo
