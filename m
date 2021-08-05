From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Thu, 05 Aug 2021 07:37:47 +0100
Subject: [LTP] [PATCH v3 1/3] API: TST_EXP_FAIL: Allow passing when
 errno is not checked
In-Reply-To: <YQlhQa/q55F98Gui@yuki>
References: <87czquna4l.fsf@suse.de>
 <20210803125252.16214-1-rpalethorpe@suse.com> <YQlhQa/q55F98Gui@yuki>
Message-ID: <87a6lwmm6c.fsf@suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis <chrubis@suse.cz> writes:

> Hi!
>> Judging by the existing usage of TST_EXP_FAIL(..., 0, ...) in
>> finit_module02. We want to pass if errno == 0 otherwise the test will
>> not return a result.
>
> This is actually not true, we do not pass 0 to TST_EXP_FAIL() in
> finit_module() at all. The places that are not initialized in the
> structure are initialized at runtime based on the kernel version. I do
> not think that we even pass 0 to TST_EXP_FAIL*() as an errno anywhere,
> but I haven't really checked all the callers.
>
>> This is also less surprising than giving errno == 0 a dual
>> meaning.
>
> But I do agree that the current if (ERRNO) branch is confusing. I would
> be for dropping the if (ERRNO) and checking the TST_ERR against ERRNO
> unconditionally.
>
> Also note that the TEST() macro clears errno, so if a syscall fails but
> does not report any error TST_ERR will end up 0 either way so there is
> no need for having special handling for 0.

There is if the errno is set, but is undefined. Like if the resulting
errno is platform or config dependent.

In the present case though we can just check for EINVAL. That is what
the setsockopt man page indicates. Initially I wasn't sure if EFAULT
were equally valid, but it seems not.

I suppose we can fall back to using TEST() if the other case arises.

-- 
Thank you,
Richard.
