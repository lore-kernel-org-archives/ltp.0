From: zhaogongyi <zhaogongyi@huawei.com>
Date: Sat, 8 May 2021 06:48:29 +0000
Subject: [LTP] [PATCH] syscalls/setfsgid02: Bugfix for running as root
Message-ID: <4aa96ba2e4da40cca03556cb7f0e331f@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

Thanks for your review!

I have resubmitted the patch and rewrite setfsgid02.c,

please see: https://patchwork.ozlabs.org/project/ltp/patch/20210508064351.10737-1-zhaogongyi@huawei.com/


Thanks so much!

Best Regards,
Gongyi

> 
> Hi!
> > When we run the test as root id, and with the option "-i 2", test will
> > fail.
> 
> Looking at the test there is much more to fix.
> 
> - the description does not match what the test is doing
> - the pass/fail condition and TFAIL message does not make any sense
> 
> And its the same for the rest of the setfsgid tests.
> 
> Looking at the manual pages for this oddball syscall we should check if:
> 
> - unpriviledged process cannot change the value i.e. value that is
>   different from return from ret=setfsgid(-1) is passed as
>   setfsgid(ret+1) followed by setfsgid(-1) and all of these returns the
>   same value and the value also matches process effective group ID
> 
> - priviledged process can change the value i.e. the same as
>   unpriviledged but we expect the last setfsgid(-1) return
>   the new value. We either have to reset the setfsgid() at the end of
>   the test or run it in a fork()-ed process so that we start with a
>   clean plate for each iteration
> 
> --
> Cyril Hrubis
> chrubis@suse.cz
