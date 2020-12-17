From: Viresh Kumar <viresh.kumar@linaro.org>
Date: Thu, 17 Dec 2020 15:54:54 +0530
Subject: [LTP] [PATCH V2 3/3] syscalls: finit_module: Add tests
In-Reply-To: <X9suVu55wgMPiOxC@yuki.lan>
References: <b48115a8d6dc3036f08e0166332035fab078b34a.1608189944.git.viresh.kumar@linaro.org>
 <0279beda4660ab1b401164e369c79475633bd067.1608189944.git.viresh.kumar@linaro.org>
 <X9suVu55wgMPiOxC@yuki.lan>
Message-ID: <20201217102454.4trtcre2cyrcxzdr@vireshk-i7>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 17-12-20, 11:09, Cyril Hrubis wrote:
> Hi!
> This finit_module02 fails for me:
> 
> tst_test.c:1261: TINFO: Timeout per run is 0h 05m 00s
> finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EINVAL (22)
> finit_module02.c:66: TFAIL: finit_module(*tc->fd, tc->param, tc->flags) expected ENOEXEC: EBADF (9)
> finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EFAULT (14)
> finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EINVAL (22)
> finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EINVAL (22)
> tst_capability.c:29: TINFO: Dropping CAP_SYS_MODULE(16)
> finit_module02.c:66: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EPERM (1)
> tst_capability.c:41: TINFO: Permitting CAP_SYS_MODULE(16)
> finit_module02.c:59: TPASS: finit_module(*tc->fd, tc->param, tc->flags) passed
> finit_module02.c:63: TPASS: finit_module(*tc->fd, tc->param, tc->flags): EEXIST (17)
> finit_module02.c:66: TFAIL: finit_module(*tc->fd, tc->param, tc->flags) expected EBADF: ETXTBSY (26)
> 
> Linux 5.9.12
> 
> Also it looks to me like EBADF is more reasonable error for fd set to -1
> also ETXTBSY sounds more reasonable for a file opened for writing.
> 
> I guess that someone cleaned up the kernel implementation but forget to
> update the manual pages?

Merged in v4.6 and I am on 4.4 :(

commit a1db74209483a24c861c848b4bb79a4d945ef6fa
Author: Mimi Zohar <zohar@linux.vnet.ibm.com>
Date:   Wed Dec 30 07:35:30 2015 -0500

    module: replace copy_module_from_fd with kernel version
    
    Replace copy_module_from_fd() with kernel_read_file_from_fd().
    
    Although none of the upstreamed LSMs define a kernel_module_from_file
    hook, IMA is called, based on policy, to prevent unsigned kernel modules
    from being loaded by the original kernel module syscall and to
    measure/appraise signed kernel modules.
    
    The security function security_kernel_module_from_file() was called prior
    to reading a kernel module.  Preventing unsigned kernel modules from being
    loaded by the original kernel module syscall remains on the pre-read
    kernel_read_file() security hook.  Instead of reading the kernel module
    twice, once for measuring/appraising and again for loading the kernel
    module, the signature validation is moved to the kernel_post_read_file()
    security hook.
    
    This patch removes the security_kernel_module_from_file() hook and security
    call.
    
    Signed-off-by: Mimi Zohar <zohar@linux.vnet.ibm.com>
    Acked-by: Kees Cook <keescook@chromium.org>
    Acked-by: Luis R. Rodriguez <mcgrof@kernel.org>
    Cc: Rusty Russell <rusty@rustcorp.com.au>

-- 
viresh
