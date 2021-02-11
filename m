From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 11 Feb 2021 16:30:29 +0100
Subject: [LTP] [PATCH 4/5] API: Add tst_clone
In-Reply-To: <874kii63to.fsf@suse.de>
References: <20210211110317.31942-1-rpalethorpe@suse.com>
 <20210211110317.31942-5-rpalethorpe@suse.com>
 <YCUoWPHssRVkQ+vf@yuki.lan> <877dne65s5.fsf@suse.de>
 <YCVAwoQDKJWMi6hX@rei.lan> <874kii63to.fsf@suse.de>
Message-ID: <YCVNlU3JRCddZ4Z9@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I don't know where you are getting EINVAL from?
> 
> Try the following
> 
> #include <errno.h>
> #include <unistd.h>
> #include <sys/syscall.h>
> 
> int main(int argc, const char* argv[])
> {
> 	syscall(~0ULL);
> 
> 	return errno;
> }
> 
> It returns ENOSYS and strace shows this is not due to any sanity
> checking by glibc.
> 
> I guess it would actually be a bug if it returned EINVAL although I am
> not sure this is specified anywhere.

And I guess that I got confused again. You get EINVAL when you pass
unsupported flags to a syscall, not unsupported syscall number.

-- 
Cyril Hrubis
chrubis@suse.cz
