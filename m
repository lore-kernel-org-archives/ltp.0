From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2019 10:29:35 +0800
Subject: [LTP] [PATCH v4 1/5] syscalls/quotactl01: Add Q_GETNEXTQUOTA
 test
In-Reply-To: <20191120151244.GA28197@dell5510>
References: <1574241216-15168-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1574241216-15168-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191120151244.GA28197@dell5510>
Message-ID: <d1d72a63-fd3b-e670-4559-c0216176546c@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/20 23:12, Petr Vorel wrote:

> Hi Jan, Cyril, Xu,
>
>> Q_GETNEXTQUOTA was introduced since linux 4.6, this operation is the
>> same as Q_GETQUOTA, but it returns quota information for the next ID
>> greater than or equal to id that has a quota set.
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
>
> LGTM, with 2 questions.
>
>>   #ifndef LAPI_QUOTACTL_H__
>>   # define LAPI_QUOTACTL_H__
>> +#include <sys/quota.h>
>> +
>> +#ifdef HAVE_STRUCT_IF_NEXTDQBLK
>> +# include <linux/quota.h>
>> +#else
>> +# ifdef HAVE_LINUX_TYPES_H
>> +# include <linux/types.h>
> @Jan, @Cyril: Do we want to generally avoid loading <linux/types.h> if not really needed?
> __u64 can be uint64_t etc (as it's also visible in struct dqblk in <sys/quota.h>
> in various libc headers).
> We used this approach for /usr/include/linux/bpf.h and for fanotify fixes for
> musl (testcases/kernel/syscalls/fanotify/fanotify.h).
>
> So unless you're against this approach here I'll change it before merge
> (and add this info to next version of library API writing guidelines patch
> https://patchwork.ozlabs.org/patch/1166786/).

I have no objection about using uint64_t becuase Q_GETNEXTQUOTA man-pages also uses it.
I used  struct if_nextdqblk as same as <linux/quota.h> defined. But I don't know why we can't use
<linux/type.h> in lapi/quotactl.h and I also use it in lapi/seccomp.h. IMHO, they affected nothing.
Or, they have some redefined errors or not having this headers files in special linux distribution.

>> +struct if_nextdqblk {
>> +	__u64 dqb_bhardlimit;
>> +	__u64 dqb_bsoftlimit;
>> +	__u64 dqb_curspace;
>> +	__u64 dqb_ihardlimit;
>> +	__u64 dqb_isoftlimit;
>> +	__u64 dqb_curinodes;
>> +	__u64 dqb_btime;
>> +	__u64 dqb_itime;
>> +	__u32 dqb_valid;
>> +	__u32 dqb_id;
>> +};
> ...
>> +++ b/testcases/kernel/syscalls/quotactl/quotactl01.c
>> @@ -1,7 +1,7 @@
>>   // SPDX-License-Identifier: GPL-2.0-or-later
>>   /*
>>   * Copyright (c) Crackerjack Project., 2007
>> -* Copyright (c) 2016 Fujitsu Ltd.
>> +* Copyright (c) 2016-2019 FUJITSU LIMITED. All rights reserved
> BTW correct formatting is
> /*
>   *
>   */
> Not
> /*
> *
> */
> I'll change it during merge (nit, the code is what matters, not formatting, of course).
>
> ...
>> +static int getnextquota_nsup;
> ...
>>   static void setup(void)
>>   {
>>   	const char *const cmd[] = {"quotacheck", "-ugF", "vfsv0", MNTPOINT, NULL};
>>   	int ret;
>> +	getnextquota_nsup = 0;
> This is not needed (getnextquota_nsup is static and it's called just once, I'll
> remove it before merge).

Yes.

>
>>   	ret = tst_run_cmd(cmd, NULL, NULL, 1);
>>   	switch (ret) {
>> @@ -146,6 +183,11 @@ static void setup(void)
>>   	if (access(GRPPATH, F_OK) == -1)
>>   		tst_brk(TFAIL | TERRNO, "group quotafile didn't exist");
>> +
>> +	TEST(quotactl(QCMD(Q_GETNEXTQUOTA, USRQUOTA), tst_device->dev,
>> +		test_id, (void *) &res_ndq));
>> +	if (TST_ERR == EINVAL || TST_ERR == ENOSYS)
> Does EINVAL really mans not supported? Shouldn't be just for ENOSYS.

EINVAL can mean non-supported? by using correct argument.

>> +		getnextquota_nsup = 1;
>>   }
> Looking at kernel sources - this does not look as not supported, but rather a
> failure (we might want to add some test for EINVAL):
> 	if (!qid_has_mapping(sb->s_user_ns, qid))
> 		return -EINVAL;
>
> kernel fs/quota/quota.c
> /*
>   * Return quota for next active quota >= this id, if any exists,
>   * otherwise return -ENOENT via ->get_nextdqblk
>   */
> static int quota_getnextquota(struct super_block *sb, int type, qid_t id,
> 			  void __user *addr)
> {
> 	struct kqid qid;
> 	struct qc_dqblk fdq;
> 	struct if_nextdqblk idq;
> 	int ret;
>
> 	if (!sb->s_qcop->get_nextdqblk)
> 		return -ENOSYS;
> 	qid = make_kqid(current_user_ns(), type, id);
> 	if (!qid_has_mapping(sb->s_user_ns, qid))
> 		return -EINVAL;
> 	ret = sb->s_qcop->get_nextdqblk(sb, &qid, &fdq);
> 	if (ret)
> 		return ret;
> 	/* struct if_nextdqblk is a superset of struct if_dqblk */
> 	copy_to_if_dqblk((struct if_dqblk *)&idq, &fdq);
> 	idq.dqb_id = from_kqid(current_user_ns(), qid);
> 	if (copy_to_user(addr, &idq, sizeof(idq)))
> 		return -EFAULT;
> 	return 0;
> }

Hi Petr

look do_quotactl function in fs/quota/quota.c.

static int do_quotactl(struct super_block *sb, int type, int cmd, qid_t id,
 ?????????????????????? void __user *addr, const struct path *path)
{

 ??? switch (cmd) {
 ??????? case Q_QUOTAON:
 ??????????????? return quota_quotaon(sb, type, id, path);
 ??????? case Q_QUOTAOFF:
 ??????????????? return quota_quotaoff(sb, type);
 ??????? case Q_GETFMT:
 ??????????????? return quota_getfmt(sb, type, addr);
 ??????? case Q_GETINFO:
 ??? ??? ......

 ??? ???? default:
 ??????????????? return -EINVAL;
 ??????? }
}

So if it doesn't have Q_GETNEXTQUOTA cmd, it should report EINVAL(we use correct argument and correct environment, so there is no failure).

> Kind regards,
> Petr
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191121/a085db33/attachment-0001.htm>
