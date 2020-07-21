From: Erico Nunes <ernunes@redhat.com>
Date: Tue, 21 Jul 2020 10:57:25 +0200
Subject: [LTP] [PATCH 1/3] lib: add function to check for kernel lockdown
In-Reply-To: <CAEemH2c1Sz+pkcLnCoWWCaMCte7QsmUTOoUxU6fzCF32nrrG+w@mail.gmail.com>
References: <20200720194920.22784-1-ernunes@redhat.com>
 <CAEemH2c1Sz+pkcLnCoWWCaMCte7QsmUTOoUxU6fzCF32nrrG+w@mail.gmail.com>
Message-ID: <98eaa723-1349-272d-3021-d2fef6e1abdd@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Thanks for the review. I'll address other comments soon, just an initial
note below:

On 7/21/20 9:46 AM, Li Wang wrote:
> Maybe renaming the function to tst_lockdown_enabled() is better? Then we
> can return?1 if confirm kernel under lockdown mode otherwise 0.
> 
>     +{
>     +? ? ? ?char line[BUFSIZ];
>     +? ? ? ?FILE *file;
>     +
>     +? ? ? ?if (access("/sys/kernel/security/lockdown", F_OK) != 0)
> 
> 
> After thinking over, I guess it's not enough to only check
> /sys/../lockdown file. Seems we need to consider the situation that
> system without supporting this file??
> 
> i.e.?
> ? Test on RHEL8 (no /sys/../lockdown file) with kernel parameter
> "lockdown" and got the restriction error too.
> 
> # cat /proc/cmdline?
> BOOT_IMAGE=(hd0,msdos1)/vmlinuz-4.18.0-226.el8.x86_64
> root=/dev/mapper/rhel_bootp--73--3--209-root ro console=ttyS0,115200
> ...?lockdown
> ? ??
> # ll /sys/kernel/security/lockdown
> ls: cannot access '/sys/kernel/security/lockdown': No such file or directory

To my understanding, the parameter to enable lockdown through kenrel
parameters is "lockdown={integrity|confidentiality}", not just
"lockdown", at least on upstream kernels:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=aefcf2f4b58155d27340ba5f9ddbe9513da8286d

If /sys/kernel/security/lockdown doesn't exist, I'm not sure there is
much we can do easily, or that is worth doing now. I think it is ok to
fall back and fail like it has been happening since the feature was
merged upstream.
I can't see a tweak that would enable the feature but not the sysfs file
in the kernel source. Maybe that kernel only had partial support?

Erico

