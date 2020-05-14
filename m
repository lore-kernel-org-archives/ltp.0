From: Xiao Yang <yangx.jy@cn.fujitsu.com>
Date: Thu, 14 May 2020 17:43:53 +0800
Subject: [LTP] [PATCH v2 1/2] syscalls/pidfd_open01.c: Add check for
 close-on-exec flag
In-Reply-To: <20200514073701.GA9562@dell5510>
References: <20200513012626.1571-1-yangx.jy@cn.fujitsu.com>
 <5EBB5B3D.4020302@cn.fujitsu.com> <20200513092028.GA4598@dell5510>
 <5EBBCA12.5020901@cn.fujitsu.com> <20200513103032.GA18763@dell5510>
 <20200514073701.GA9562@dell5510>
Message-ID: <5EBD12D9.70708@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 2020/5/14 15:37, Petr Vorel wrote:
> Hi Yang,
>
> one more note:
>
>>> As my pervious mail said, It is just a possible situation? for example:
>>> Upstream kernel introduces btrfs filesystem long long ago but the
>>> kernel of RHEL8 drops btrfs filesystem because of some reasons.
>> I guess filesystem changes are the most frequent. But as I said, I wouldn't mind
>> this implementation:
>> void fsopen_supported_by_kernel(void)
>> {
>> 	TEST(tst_syscall(__NR_fsopen, NULL, 0));
>> 	if (TST_RET != -1)
>> 		SAFE_CLOSE(TST_RET);
>> }
> BTW the same approach is used in include/lapi/openat2.h
>
> void openat2_supported_by_kernel(void)
> {
> 	if ((tst_kvercmp(5, 6, 0))<  0) {
> 		/* Check if the syscall is backported on an older kernel */
> 		TEST(syscall(__NR_openat2, -1, NULL, NULL, 0));
> 		if (TST_RET == -1&&  TST_ERR == ENOSYS)
> 			tst_brk(TCONF, "Test not supported on kernel version<  v5.6");
> 	}
> }
>
> and clone3_supported_by_kernel(). Both merged by Cyril.
>
> To be honest I like this approach, because 1) it defines when new syscall was
> backported
Hi Petr?

Hmm, the reason seems a little weak, it can be done by adding a 
comment(e.g. "the syscall is introduced since v5.6.0").

2) if there is really problem that some functionality was removed, we
> can always handle it. But IMHO that's going to be rare (btrfs removed in RHEL 8
> is IMHO because RHEL does not want to support it, but that would not happen for
> syscalls).

Without the rare situation, I also think tst_syscall() is enough to 
check the support of syscall.

>
> I'd also like to be consistent how we handle these new syscalls.
Agreed.

I also think if we can implement common func(e.g. 
syscall_supported_by_kernel()).

Best Regards,
Xiao Yang
>
> Kind regards,
> Petr
>
>
> .
>



