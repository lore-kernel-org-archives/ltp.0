From: sujiaxun <sujiaxun@uniontech.com>
Date: Wed, 11 Aug 2021 10:45:58 +0800
Subject: [LTP] [PATCH] [v2,
 1/6] syscalls/sysfs: Convert sysfs01 to the new API
In-Reply-To: <YRKFBxpUwJExuMzi@yuki>
References: <20210806062456.11678-1-sujiaxun@uniontech.com>
 <YRJM9PffB27VBngU@yuki> <69afbc39-4c9d-dbab-beb2-4ff43d733818@uniontech.com>
 <YRKFBxpUwJExuMzi@yuki>
Message-ID: <a5a54da0-4283-9e97-261d-835e4e15de13@uniontech.com>+399C52ED10E9AFD7
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it



? 2021/8/10 ??9:54, Cyril Hrubis ??:
> Hi!
>> I checked with "checkpatch.pl -f" and there were no errors or warnings.
>> I use "git am" to apply the patch normally without any warning. How did
>> you check that there are spaces.
> 
> Have you used recent enough version?
> 
> Latest kernel git:
> 
> $ ~/linux/scripts/checkpatch.pl -f sysfs01.c
> 
> ERROR: code indent should use tabs where possible
> #20: FILE: sysfs01.c:20:
> +        /* option 1, buf holds fs name */$
> 
> ERROR: code indent should use tabs where possible
> #21: FILE: sysfs01.c:21:
> +        TST_EXP_POSITIVE(tst_syscall(__NR_sysfs, 1, "proc"),$
> 
> WARNING: please, no spaces at the start of a line
> #21: FILE: sysfs01.c:21:
> +        TST_EXP_POSITIVE(tst_syscall(__NR_sysfs, 1, "proc"),$
> 
> ERROR: code indent should use tabs where possible
> #22: FILE: sysfs01.c:22:
> +                        "sysfs(1,'proc')");$
> 
> WARNING: please, no spaces at the start of a line
> #22: FILE: sysfs01.c:22:
> 
> ...
> 
> 
> $ cd ~/linux/; git describe
> 
> v5.14-rc5-2-g9a73fa375d58
> 
Thank you, the kernel version I use is v4.19.90. But it may have nothing 
to do with the version. I only use "checkpatch.pl -f X.patch" instead of 
"checkpatch.pl -f sysfs01.c". I have revised the check again and will 
resubmit.
-- 
Kind regards,

sujiaxun


