From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 6 Mar 2019 15:54:09 +0100
Subject: [LTP] [PATCH] select: tests offer choice of syscall path:
In-Reply-To: <20190305162410.127713-1-salyzyn@android.com>
References: <20190305162410.127713-1-salyzyn@android.com>
Message-ID: <20190306145409.GA12479@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Switch between libc library, __newselect syscall, select syscall or
> pselect6 syscall for selection of select() tests.  This provides
> filled in coverage of all the possible select alternatives.
> 
> CC flags can be one of:
> 
> -DSYSCALL_SELECT_LIBC        // use select() libc library function
> -DSYSCALL_SELECT__NEWSELECT  // use __NR__newselect system call
> -DSYSCALL_SELECT_SELECT      // use __NR_select system call
> -DSYSCALL_SELECT_PSELECT6    // use __NR_pselect6 system call worker
> <default>                    // chose a _defined_ system call

I was meanwhile thinking of how we should handle the libc/syscall
multiplexing and I would be probably in favor of doing it on runtime
since I do not see any reason why we should generate test binary for
each syscall variant.

Rather than that I'm looking into having a multiplexer callback from the
new test library that would allow running the test function in a loop
for each possible syscall variant.

I will send a RFC patch ideally today and add you into CC.

-- 
Cyril Hrubis
chrubis@suse.cz
