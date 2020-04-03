From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 3 Apr 2020 11:30:19 +0200
Subject: [LTP] Query: Supporting time64 syscalls
In-Reply-To: <20200403071223.4d2vcfwiuxnuxij6@vireshk-i7>
References: <CAKohpokaPiyGFkAXgG2oy_f5UGMCtsVUUAf4vA3Npa2ixAbNig@mail.gmail.com>
 <20200403071223.4d2vcfwiuxnuxij6@vireshk-i7>
Message-ID: <20200403093019.GA26355@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > I was looking to start working on the time64 syscalls
> > (like clock_gettime64, timerfd_settime64, etc) and
> > was looking for your suggestions on how to proceed on
> > the same.
> > 
> > AFAIU, the only difference is that the argument is 64 bit now
> > instead of 32 bit and so I don't think I should be adding new
> > tests but reusing the existing ones for both 32 bit and 64 bit
> > variants.
> 
> @Cyril/Petr,
> 
> Any suggestions on how should I go about these tests ?

I guess that we can take the existing timer tests and add tests variants
so that we cover all possible cases, I guess that would mean 32bit
kernel syscall, 64bit kernel syscall, glibc wrapper and in some cases
also VDSO.

You can have a look at clock_getres01.c and take it as an example.

-- 
Cyril Hrubis
chrubis@suse.cz
