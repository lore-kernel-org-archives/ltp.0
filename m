From: Xu, Yang <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 18 Nov 2019 07:59:33 +0000
Subject: [LTP] [PATCH v3 2/5] syscalls/quotactl02.c: Add Q_XGETQSTATV
 test
In-Reply-To: <20191115174110.GB22234@x230>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572612959-20577-3-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191115174110.GB22234@x230>
Message-ID: <791f40c927114eb8b9ce5320d8c33447@G08CNEXMBPEKD04.g08.fujitsu.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>Hi Xu,
> >Q_XGETQSTATV returns XFS filesystem-specific quota information in the 
> >fs_quota_statv pointed to by addr. The qs_version field of the 
> >structure should be filled with the version of the structure supported 
> >by the caller (for now, only FS_QSTAT_VERSION1 is supported).
>nit: one would think you add 1 test case. But you added 8 test cases, all of them are XFS related, but only 4 related to Q_XGETQSTATV.
For user quota, I add 2 test cases to use Q_XGETQSTATV to get status for Q_XQUOTAOFF and Q_XQUOTAOFF . 
Also, I add group quota for this case as quotactl01.c.  so I add 8 (2+6) test cases.  I will update group coverage in commit info. 

Ps: I want to use Q_XGETQSTAT to test  Q_XQUOTAOFF, Q_XGETQSTATV to test Q_XQUOTAON. So it can be only 8 test cases. But Q_XGETQSTATV
is introduced since v3.12-rc1 commit[1]. We should use a pair (on,off )to test Q_XGETQSTATV.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d5e3d57605e77708685e8d20a40fe86891db299

>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>Reviewed-by: Petr Vorel <pvorel@suse.cz> Nice work, thanks!
Thanks for your review.

>>Nit: I'd just extract quotactl02.h later in the commit, where the code needs to be reused (i.e. in 0cc1dc512 ("syscalls/quotactl05: add project quota test for xfs filesystem")) or at least mention why you do it now.
I will mention it in commit info.
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl02.c
>...
>> +#if defined(HAVE_STRUCT_FS_QUOTA_STATV)
>> +	{QCMD(Q_XQUOTAOFF, GRPQUOTA), &qflagg, check_qoffv,
>> +	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
> >+	"turn off xfs quota and get xfs quota off statv for group"},
>
>> -	tst_res(TPASS, "quoactl() succeeded to set and use %s to get xfs disk quota limits",
> >-			desp);
> >-}
> >+	{QCMD(Q_XQUOTAON, GRPQUOTA), &qflagg, check_qonv,
> >+	QCMD(Q_XGETQSTATV, GRPQUOTA), 1,
> >+	"turn on xfs quota and get xfs quota on statv for group"}, #endif };
>Hm, we don't report some TCONF: Q_XGETQSTATV not supported.
>But that's probably not important
This cmd was introduced since 2013,  I think we should check it. Also,  if we 
Use a new kernel but boot with a older kernel header, HAVE_STRUCT_FS_QUOTA_STATV may be undefined.
But in kernel, it is implemented. So I think we may define a fs_quota_statv struct in ltp, so we can detect whether Q_XGETQSTAT is implemented. 
What do you think about it?

>...
>Kind regards,
>Petr




