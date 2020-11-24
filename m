From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Tue, 24 Nov 2020 18:24:42 +0800
Subject: [LTP] [PATCH 2/2] syscalls: shift to time() if __NR_time not
 support
In-Reply-To: <CAEemH2eiTQMBA6g1BOeDNx+H81Yk6FvZt_0AonRY7zdpc0K14w@mail.gmail.com>
References: <20201123083137.11575-1-liwang@redhat.com>
 <20201123083137.11575-2-liwang@redhat.com> <5FBC765A.3020102@cn.fujitsu.com>
 <CAEemH2eiTQMBA6g1BOeDNx+H81Yk6FvZt_0AonRY7zdpc0K14w@mail.gmail.com>
Message-ID: <5FBCDF6A.8050704@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li
> Hi Xu,
>
> Yang Xu <xuyang2018.jy@cn.fujitsu.com
> <mailto:xuyang2018.jy@cn.fujitsu.com>> wrote:
>
>     I have seen this patchset, Can we use a function to check whether
>     kernel
>
>
> Yes, we can, I was even thinking to define a global MACRO can check
> any syscall not only __NR_time.
> (maybe we can achieve it for other tests)
> But for this kind of case, I'd not suggest using that MACRO/function
> to check __NR_time, because the test will perform twice at the moment
> for the __NR_time syscall if it supporting(first time for support checking,
> second time for real invoking).
>
> Considering this is a time comparing test, that makes our seconds
> more inaccurate to compare.
>
>     supports time syscall (like time_supported_by_kernel()) in setup
>     and then we use time() - !return value in verify funtion?
>
>
> Though we check the syscall in setup(), shouldn't we also export a variable
> to record the result we checked? That does not make things be simple too.
Yes. On some platform(aarch64), it is simple because it doesn't need to 
call tst_syscall two times and  time() two times and report non-support 
info many times especailly when using -i parameters.

IMO, it is a taste perference(I usually detect kernel whether support in 
setup). Your patchset is also ok. So

Acked-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>

>
> --
> Regards,
> Li Wang



