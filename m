From: $rik@nth  <srikanth007m@gmail.com>
Date: Mon, 12 Oct 2015 17:38:58 +0530
Subject: [LTP] proc01 causing kernel panic
In-Reply-To: <20151012092037.GA24891@rei.suse.cz>
References: <CANKSX+HCdoZ2+fk7eTkiiysAHhOds-Vdy87ONhC5ecrHD0C8iw@mail.gmail.com>
 <20151012092037.GA24891@rei.suse.cz>
Message-ID: <CANKSX+HYkq-uEe-kDLnucGQBzh96HK1kNF7nvj3dn0x83uUNTQ@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

the same driver is been ported from 3.10 to 3.18 kernel. But from your
analysis the issue is with rndis driver.

As mentioned initially proc01 is passing on 3.10 and on 3.18 panic is seen.



On Mon, Oct 12, 2015 at 2:50 PM, Cyril Hrubis <chrubis@suse.cz> wrote:
> Hi!
>> Can anyone help in debugging the proc01 test causing the kernel panic.
>>   6821.197961:   <6> Process proc01 (pid: 9052, stack limit = 0xffffffc01e1e0058)
>>   6821.204642:   <6> Call trace:
>>   6821.207083:   <2> [<ffffffc000669b40>] rndis_proc_show+0xa4/0xf8
>>   6821.212549:   <2> [<ffffffc0001bb4d0>] seq_read+0x180/0x3ac
>>   6821.217582:   <2> [<ffffffc0001ec5a8>] proc_reg_read+0x64/0x84
>>   6821.222878:   <2> [<ffffffc00019c1c0>] vfs_read+0x90/0x148
>>   6821.227824:   <2> [<ffffffc00019c928>] SyS_read+0x44/0x84
>>   6821.232688:   <6> Code: f9401c28 53001d2a f90007e8 f9401428 (b9421908)
>>   6821.239083:   <6> ---[ end trace 64a7e95832f9f646 ]---
>>   6821.243380:   <6> Kernel panic - not syncing: Fatal exception
>
> Looks like a bug in rndis kernel driver (because reading the proc files
> the driver export causes kernel panic).
>
> --
> Cyril Hrubis
> chrubis@suse.cz



-- 
Thanks & Regards,
M.Srikanth Kumar.
