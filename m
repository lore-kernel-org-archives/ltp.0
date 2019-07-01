From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2019 14:02:35 +0200
Subject: [LTP] [Kernel BUG?] SMSW operation get success on UMIP KVM guest
In-Reply-To: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
Message-ID: <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/07/19 09:50, Li Wang wrote:
> Hello there,
> 
> LTP/umip_basic_test get failed on KVM UMIP
> system(kernel-v5.2-rc4.x86_64). The test is only trying to do
> ? ? ?asm volatile("smsw %0\n" : "=m" (val));
> and expect to get SIGSEGV in this SMSW operation, but it exits with 0
> unexpectedly.

In addition to what Thomas said, perhaps you are using a host that does
*not* have UMIP, and configuring KVM to emulate it(*).  In that case, it
is not possible to intercept SMSW, and therefore it will incorrectly
succeed.

Paolo

(*) before the x86 people jump at me, this won't happen unless you
explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
incorrect emulation of SMSW when CR4.UMIP=1 is why.
