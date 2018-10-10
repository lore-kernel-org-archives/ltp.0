From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 10 Oct 2018 09:48:26 -0300
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
In-Reply-To: <20181010123321.GA7875@rei>
References: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
 <20181008133059.GB30978@rei>
 <3dbee853-6bce-d057-f42a-655a8f2991c3@linaro.org>
 <20181009092821.GA16630@rei>
 <6903290a-523f-7130-b64f-d1a73b601c38@linaro.org> <20181010104101.GA1990@rei>
 <29fce88c-c771-0ca4-19b9-c9eb25484999@linaro.org> <20181010120550.GA1093@rei>
 <915e66da-a4d8-4092-98c0-02d4daaed86f@linaro.org> <20181010123321.GA7875@rei>
Message-ID: <3e79f76b-0996-1bb6-8bad-5b4bed12a971@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/10/18 9:33 AM, Cyril Hrubis wrote:
> Hi!
>>> Ok, I guess that I understand why this is so slow, we emulate PC memory
>>> mapped serial port and we go back and forth for each byte we write. And
>>> I guess that we cannot do much about this.
>>>
>>> Also I suppose that it could be "fixed" by switching to virtio serial
>>> driver that should be able to read the whole buffer in one go.
>>
>> Just as curiosity... Unfortunately, ARM QEMU does not seem to have a
>> virtio serial device (yet ?) and x86 can't have boot loaders on a virtio
>> serial device, only systemd output and console, afaik. =(.
> 
> Huh, I'm pretty sure we run aarch64 VMs with virtio serial devices.

Yes, you are right. This is what I have in my dev machine:

libvirt xml:

     <serial type='pty'>
       <source path='/dev/pts/1'/>
       <target type='system-serial' port='0'>
         <model name='pl011'/>
       </target>
       <alias name='serial0'/>
     </serial>
     <console type='pty' tty='/dev/pts/1'>
       <source path='/dev/pts/1'/>
       <target type='serial' port='0'/>
       <alias name='serial0'/>
     </console>
     <console type='pty'>
       <source path='/dev/pts/2'/>
       <target type='virtio' port='1'/>
       <alias name='console1'/>
     </console>

And the cmdline:

-device 
pcie-root-port,port=0xb,chassis=4,id=pci.4,bus=pcie.0,addr=0x1.0x3 
-device virtio-serial-pci,id=virtio-serial0,bus=pci.2,addr=0x0

-chardev pty,id=charserial0 -serial chardev:charserial0 -chardev 
pty,id=charconsole1 -device virtconsole,chardev=charconsole1,id=console1

> Also AFAIC you can enable both PC serial port emulation and virtio
> serial and configure the system to start console on the virtio serial
> device.

True.

Best,
Rafael
