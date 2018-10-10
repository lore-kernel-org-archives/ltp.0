From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Date: Wed, 10 Oct 2018 09:15:25 -0300
Subject: [LTP] LTP: futex_wake04 hangs forever on i386
In-Reply-To: <20181010120550.GA1093@rei>
References: <CA+G9fYs13QZtsREe3dvic+G6VPQ1dJroKH0sguBiNdtizRTeNQ@mail.gmail.com>
 <20181008133059.GB30978@rei>
 <3dbee853-6bce-d057-f42a-655a8f2991c3@linaro.org>
 <20181009092821.GA16630@rei>
 <6903290a-523f-7130-b64f-d1a73b601c38@linaro.org> <20181010104101.GA1990@rei>
 <29fce88c-c771-0ca4-19b9-c9eb25484999@linaro.org> <20181010120550.GA1093@rei>
Message-ID: <915e66da-a4d8-4092-98c0-02d4daaed86f@linaro.org>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 10/10/18 9:05 AM, Cyril Hrubis wrote:
>> That is what happened, no ? Stack trace shows that possibly same process
>> that had its execution interrupted by the time handler in a recent past
>> (with a leftover frame pointer indicated by ? apic_timer_interrupt) also
>> ran the handler for serial8250_interrupt() and that execution caused
>> some dmesg warnings like:
>>
>> serial8250: too much work for irq
>>
>> which I had. I guess having the terminal with a smaller buffer would
>> help here as well, since the calls to the interrupt handler would be
>> more often and less time consuming (because of baud rate).
>>
>> Continuing, there was a software interrupt to flush serial 8250 contents
>> and it took too long to flush to the device, causing the task, waiting
>> on the line, to wait.
>>
>> HOWEVER, for this case, for example, every single byte written to a
>> terminal memory mapped I/O register causes a VM_EXIT (in the host:
>> cpu->kvm_run->exit_reason == 2), giving execution back to the QEMU vCPU
>> (that had entered VM mode), that will schedule a function inside the
>> emulation thread to deal with that I/O (for the virtualized serial HW
>> being emulated) and calling the VM_ENTER again at some further point.
>> This could make the interrupt handler even slower.
> Ok, I guess that I understand why this is so slow, we emulate PC memory
> mapped serial port and we go back and forth for each byte we write. And
> I guess that we cannot do much about this.
> 
> Also I suppose that it could be "fixed" by switching to virtio serial
> driver that should be able to read the whole buffer in one go.

Just as curiosity... Unfortunately, ARM QEMU does not seem to have a 
virtio serial device (yet ?) and x86 can't have boot loaders on a virtio 
serial device, only systemd output and console, afaik. =(.
