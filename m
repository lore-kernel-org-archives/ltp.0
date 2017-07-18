From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 18 Jul 2017 11:09:37 +0200
Subject: [LTP] [PATCH 4/4] Test for CVE-2016-10044 mark AIO pseudo-fs
	noexec
In-Reply-To: <1513116395.54444036.1500364708984.JavaMail.zimbra@redhat.com>
References: <20170718073319.23543-1-rpalethorpe@suse.com>
 <20170718073319.23543-5-rpalethorpe@suse.com>
 <1513116395.54444036.1500364708984.JavaMail.zimbra@redhat.com>
Message-ID: <8760eqqffy.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello Jan,

Jan Stancek writes:

> ----- Original Message -----
> ...
>> +
>> +#include "tst_test.h"
>> +
>> +#ifdef HAVE_LINUX_AIO_ABI_H
>> +
>> +#include <stdio.h>
>> +#include <string.h>
>> +#include <linux_syscall_numbers.h>
>> +#include <linux/aio_abi.h>
>
> Hi,
>
> from LTP docs:
> "Don't use +linux/+ headers if at all possible. Usually they are replaced with
> +sys/+ headers as things work their way into glibc.  Furthermore, +linux/+
> headers get shuffled around a lot more than their +sys/+ counterparts it
> seems."

Ah, thanks for pointing that out.

>
> If we really have to use linux header then I'd suggest a configure check
> that also checks it's compilable.
>
> Regards,
> Jan

As far as I am aware the alternatives are to use libaio, which seems
like overkill for this test. Or to include the AIO ABI definitions
inside the test. I don't think there is a comparable sys/ header.

I don't really mind using libaio if that is preferred?

--
Thank you,
Richard.
