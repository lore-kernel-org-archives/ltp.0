From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 7 Aug 2020 10:45:44 +0200
Subject: [LTP] [PATCH V8 1/2] syscalls/utimensat: Migrate to new test
 framework
In-Reply-To: <20200807044234.basdp5ic4xzleqsx@vireshk-mac-ubuntu>
References: <ebc888947b095fd6a359ad749e50217d0b38954e.1596637728.git.viresh.kumar@linaro.org>
 <20200806125603.GC3315@yuki.lan>
 <20200807044234.basdp5ic4xzleqsx@vireshk-mac-ubuntu>
Message-ID: <20200807084544.GB4931@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also we do pass libc timespec to a syscall that is supposed to take the
> > old kernel type, right?
> > 
> > I guess that the options are:
> > 
> > * Use the glibc function here instead
> > 
> > * Change the type in the follow up patch
> 
> This is already properly fixed in 2/2.

Maybe I'm blind but I do not see anything that would touch the
reset_time() function in 2/2.

-- 
Cyril Hrubis
chrubis@suse.cz
