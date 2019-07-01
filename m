From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 1 Jul 2019 19:30:50 +0200
Subject: [LTP] [Kernel BUG?] SMSW operation get success on UMIP KVM guest
In-Reply-To: <20190701145308.GA19368@ranerica-svr.sc.intel.com>
References: <CAEemH2cg01cdz=amrCWU00Xof9+cxmfR_DqCBaQe36QoGsakmA@mail.gmail.com>
 <5622c0ac-236f-4e3e-a132-c8d3bd8fadc4@redhat.com>
 <20190701145308.GA19368@ranerica-svr.sc.intel.com>
Message-ID: <cde7f924-10c9-7ffc-d323-b786240244b3@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 01/07/19 16:53, Ricardo Neri wrote:
>>
>> (*) before the x86 people jump at me, this won't happen unless you
>> explicitly pass an option to QEMU, such as "-cpu host,+umip". :)  The
>> incorrect emulation of SMSW when CR4.UMIP=1 is why.
> Paolo, what do you mean by the incorrect emulation of SMSW?

When KVM tries to emulate UMIP on a system that doesn't have it, SMSW
won't cause a #GP.  The processor is simply not able to trap to the
hypervisor on SMSW (unlike SGDT/SIDT/SLDT/STR), so it's impossible to do
better.

Paolo
