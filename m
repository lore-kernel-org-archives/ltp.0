From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Oct 2018 14:33:21 +0200
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
In-Reply-To: <915e66da-a4d8-4092-98c0-02d4daaed86f@linaro.org>
References: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
 <20181008133059.GB30978@rei>
 <3dbee853-6bce-d057-f42a-655a8f2991c3@linaro.org>
 <20181009092821.GA16630@rei>
 <6903290a-523f-7130-b64f-d1a73b601c38@linaro.org>
 <20181010104101.GA1990@rei>
 <29fce88c-c771-0ca4-19b9-c9eb25484999@linaro.org>
 <20181010120550.GA1093@rei>
 <915e66da-a4d8-4092-98c0-02d4daaed86f@linaro.org>
Message-ID: <20181010123321.GA7875@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Ok, I guess that I understand why this is so slow, we emulate PC memory
> > mapped serial port and we go back and forth for each byte we write. And
> > I guess that we cannot do much about this.
> > 
> > Also I suppose that it could be "fixed" by switching to virtio serial
> > driver that should be able to read the whole buffer in one go.
> 
> Just as curiosity... Unfortunately, ARM QEMU does not seem to have a 
> virtio serial device (yet ?) and x86 can't have boot loaders on a virtio 
> serial device, only systemd output and console, afaik. =(.

Huh, I'm pretty sure we run aarch64 VMs with virtio serial devices.

Also AFAIC you can enable both PC serial port emulation and virtio
serial and configure the system to start console on the virtio serial
device.

-- 
Cyril Hrubis
chrubis@suse.cz
