From: Steve Muckle <smuckle@google.com>
Date: Fri, 22 Feb 2019 11:43:48 -0800
Subject: [LTP] [PATCH] syscalls/ustat: Move the syscall to lapi
In-Reply-To: <20190222150006.GA23713@rei>
References: <20190221112201.18324-1-chrubis@suse.cz>
 <87r2c12udf.fsf@rpws.prws.suse.cz> <20190221143021.GC17813@rei.lan>
 <87pnrk2rw6.fsf@rpws.prws.suse.cz> <20190222150006.GA23713@rei>
Message-ID: <93f34d76-f1ba-c6a9-fa02-a4ffc0ec8426@google.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 02/22/2019 07:00 AM, Cyril Hrubis wrote:
> Hi!
>>>>> diff --git a/include/lapi/ustat.h b/include/lapi/ustat.h
>>>>> index 12c073582..6365b2e92 100644
>>>>> --- a/include/lapi/ustat.h
>>>>> +++ b/include/lapi/ustat.h
>>>>> @@ -10,12 +10,19 @@
>>>>>   #ifdef HAVE_SYS_USTAT_H
>>>>>   # include <sys/ustat.h>
>>>>
>>>> Just a thought, but this is potentially a problem if lib C implementes
>>>> ustat in user land, but the system call still exists. Which I think is
>>>> more likely with an obsolete system call.
>>>
>>> Good point. So it all depends on what we want to focus on, if we are
>>> after kernel, we should call the syscall directly, if we look at system
>>> functionality we should go after the libc one by default.
>>>
>>> I guess that ideally we should test both, not sure how to achiveve that
>>> reasonably easily...

This seems to me a great feature to have as well - it would address the 
concern that was just recently raised about having to choose between 
focusing on testing at the libc level or the kernel syscall level.
>> Possibly we could create a config option which forcibly sets (almost)
>> all the HAVE_* macros to zero. This will probably result in a lot of
>> tests being skipped as well, but it might be good enough.
> 
> I don't think that this will actully get past linking, I suppose we
> would end up with two confilicting syscall wrappers in most of the
> cases.

Perhaps something like how the compat_16 syscalls are handled? Test libc 
wrappers by default if the host has them, and for syscalls that can 
easily be called directly, add an extra bit in the test's Makefile that 
causes a "<testname>_direct" version of the test to be built using a 
direct syscall?
