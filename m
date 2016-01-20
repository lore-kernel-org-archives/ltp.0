From: Stanislav Kholmanskikh <stanislav.kholmanskikh@oracle.com>
Date: Wed, 20 Jan 2016 15:20:44 +0300
Subject: [LTP] [PATCH] device-drivers/uaccess: use linux/uaccess.h
In-Reply-To: <20160119172141.GA17351@rei.lan>
References: <1453218464-13605-1-git-send-email-stanislav.kholmanskikh@oracle.com>
 <20160119172141.GA17351@rei.lan>
Message-ID: <569F7B9C.3000005@oracle.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



On 01/19/2016 08:21 PM, Cyril Hrubis wrote:
> Hi!
>>   #include <linux/module.h>
>>   #include <linux/device.h>
>> -#include <asm-generic/uaccess.h>
>> +#include <linux/uaccess.h>
>
> Looks good, acked.

Thank you. Committed.

>
> Btw, grepping "uaccess.h" in linux/drivers/ shows either linux/uaccess.h
> or asm/uaccess.h but no asm-generic/uaccess.h.
>
