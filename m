From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 9 Mar 2020 17:27:27 +0800
Subject: [LTP] [PATCH v1 1/2] syscalls/settimeofday01: convert to new
 library
In-Reply-To: <20200309080134.GB299736@x230>
References: <1583311467-2379-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20200309080134.GB299736@x230>
Message-ID: <3752c0de-404b-4436-6807-21688d1cfd94@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi  Petr

> Hi Xu,
>> Also, since glibc 2.31[1], when tz and tv are both null, it will get
>> SIGSEGV sig. So, remove this EFAULT error test to adopt glibc 2.31.
> +1, thanks for testing on new glibc.
> 
>> Moreover, musl 1.2.0 is now available and changes time_t for 32-bit
>> archs to a 64-bit type. It is updated to slove y2038 problem and get
> => typo solve.
>> time function no longer used for 32bit arch but not affecting set time
>> function and 64 bit arch, more info see[2]. So for gettimeofday(), we
>> use tst_syscall instead of calling libc to avoid this problem.
> Hm, it'd be nice to test both raw syscall and libc implementations (via
> tst_variant),
 From glibc 2.31 announce,
"settimeofday itself is obsolescent according to POSIX.  Programs
   that set the system time should use clock_settime and/or the adjtime
   family of functions instead".

This is why I am not using tst_variant for this case.
Also, glibc actually call clock_settime/gettime for this pair.

>but IMHO there is no way to detect musl change. Or am I missing
> something?
> 
I remembered we have a commit for this "
syscalls: Check for time64 unsafe syscalls before using them"
Looking musl glibc code[1], can we use 
__NR_gettimeofday_time32/__NR_settimeofday_time32 in syscalls.h to 
detect this change?

[1]http://git.musl-libc.org/cgit/musl/commit/?id=5a105f19b5aae79dd302899e634b6b18b3dcd0d6
> + one would prefer this change to be in a separate commit, but we can live with that :).
> 
> I guess there is no need to setup SAFE_{G,S}ETTIMEOFDAY(), because only these 2
> tests and stime_var.h are using it (or at least no now).
Agree. The more important reason is that get/settimeofday is obsolete, 
we should use other syscall to set/get time.

Best Regards
Yang Xu
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Kind regards,
> Petr
> 
> 


