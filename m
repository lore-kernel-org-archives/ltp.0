From: Li Wang <liwang@redhat.com>
Date: Wed, 24 Jul 2019 17:56:56 +0800
Subject: [LTP] Question about kernel/syscall/signal/signal06.c
In-Reply-To: <e7d0e66d-f348-9d57-0ea9-dc1fa289942d@windriver.com>
References: <56f854e2-9cc6-4725-3182-ff83e106ee23@windriver.com>
 <20190717094614.GA9539@rei>
 <7d2c4936-2e89-6285-c856-a156d3a76284@windriver.com>
 <CAEemH2edg4R-JFM=u_ceLoRcNAMmV=c+hVV6kxoK4g6DOBnGeg@mail.gmail.com>
 <e7d0e66d-f348-9d57-0ea9-dc1fa289942d@windriver.com>
Message-ID: <CAEemH2e+_b66or6MZCMXh5AbXk_WAzwVMjx==XFYKYEHRCy7cA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Hongzhi,

On Mon, Jul 22, 2019 at 9:59 AM Hongzhi, Song
<hongzhi.song@windriver.com> wrote:
>
>
> On 7/19/19 4:44 PM, Li Wang wrote:
> > On Fri, Jul 19, 2019 at 4:14 PM Hongzhi, Song
> > <hongzhi.song@windriver.com> wrote:
> >> This case fails when boot qemux86-64 with 1/2 cores.
> >>
> >> I find [kernel 5.2-rc1: 0d714dba162] causes the failure by git bisect.
>
> Hi Li,Wang
>
>
> Sorry for my a bit mistake, the exact tag is [5.1-rc3 : 0d714dba162]
>
> commit 0d714dba162620fd8b9f5b3104a487e041353c4d
> Author: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Date:   Wed Apr 3 18:41:48 2019 +0200
>
>      x86/fpu: Update xstate's PKRU value on write_pkru()
>
>      During the context switch the xstate is loaded which also includes the
>      PKRU value.
>
>      If xstate is restored on return to userland it is required
>      that the PKRU value in xstate is the same as the one in the CPU.
>
>      Save the PKRU in xstate during modification.
>
>
> >>
> >> If git checkout a commit before 0d714dba162, the case will pass on the
> >> same qemu configuration.
> > It sounds like a new regression on fpu. I will have a try on this test then.
> >
> > @Hongzhi, could you provide more info of your test machine? (e.g.
> > lscpu, uname -r)
> > and test result with 1vcpu, 2vcpus?
>
>
> I tested "-smp 1/2/4" and "-cpu Skylake-Client-IBRS/core2duo", all of
> them failed.
>
>
> 1. This is my qemu boot cmdline:
>
> qemu-system-x86_64 -device
> virtio-net-pci,netdev=net0,mac=52:54:00:12:35:02 -netdev
> user,id=net0,hostfwd=tcp::2222-:22,hostfwd=tcp::2323-:23,tftp=images/qemux86-64
> -drive file=image.rootfs.ext4,if=virtio,format=raw -vga vmware
> -show-cursor -usb -device usb-tablet -object
> rng-random,filename=/dev/urandom,id=rng0 -device
> virtio-rng-pci,rng=rng0  -nographic  -m 256  -cpu Skylake-Client-IBRS
> -serial mon:stdio -serial null -kernel linux/arch/x86/boot/bzImage
> -append 'root=/dev/vda rw highres=off console=ttyS0 mem=256M ip=dhcp
> vga=0 uvesafb.mode_option=640x480-32 oprofile.timer=1
> uvesafb.task_timeout=-1 '
>
> 2. lscpu
>
> root@qemux86-64:~# lscpu
> Architecture:                    x86_64
> CPU op-mode(s):              32-bit, 64-bit
> Byte Order:                      Little Endian
> Address sizes:                 40 bits physical, 48 bits virtual
> CPU(s):                            4
> On-line CPU(s) list:           0
> Thread(s) per core:          1
> Core(s) per socket:          1
> Socket(s):                        1
> Vendor ID:                       GenuineIntel
> CPU family:                      6
> Model:                             94
> Model name:                   Intel Core Processor (Skylake, IBRS)

Thanks for the information.

I tried the mainline kernel-v5.2 on the kvm system(with 1/2 Skylake
vCPUs) but didn't reproduce your failure, I'm not sure if I missed
anything there, maybe the virtualization way is related, I will have a
try on your command when I available.

--
Regards,
Li Wang
