From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 29 Jun 2021 08:15:28 +0100
Subject: [LTP] [PATCH 3/3] API: Cause GCC/Clang to blow up when TEST is
 used in the library
In-Reply-To: <YNniPHlHTVyiz74B@pevik>
References: <20210621113804.26179-1-rpalethorpe@suse.com>
 <20210621113804.26179-3-rpalethorpe@suse.com> <YNniPHlHTVyiz74B@pevik>
Message-ID: <87wnqd2lbj.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Petr Vorel <pvorel@suse.cz> writes:

> Hi Richie,
>
>> +#if LTPLIB
>> +#define TEST(SCALL) _Pragma("GCC error \"Do not use TEST macro in library\"")
>> +#define TEST_VOID(SCALL) _Pragma("GCC error \"Do not use TEST_VOID macro in library\"")
>
> It'd be nice to document "Do not use TEST() macro in library" in LTP Library API
> Writing Guidelines [1].

Yes, I will submit this in the Sparse patch set today.

>
> Kind regards,
> Petr
>
> [1] https://github.com/linux-test-project/ltp/wiki/LTP-Library-API-Writing-Guidelines


-- 
Thank you,
Richard.
