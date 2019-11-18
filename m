From: Xu, Yang <xuyang2018.jy@cn.fujitsu.com>
Date: Mon, 18 Nov 2019 06:42:21 +0000
Subject: [LTP] [PATCH v3 1/5] syscalls/quotactl01.c: Add Q_GETNEXQUOTA
 test
In-Reply-To: <20191115155123.GA658@x230>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572612959-20577-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191115155123.GA658@x230>
Message-ID: <989b7cbfa4cf4d7bb65c9b7df45b8c37@G08CNEXMBPEKD04.g08.fujitsu.local>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


>> Q_GETNEXTQUOTA was introduced since linux 4.6, this operation is the 
>>same as Q_GETQUOTA, but it returns quota information for the next ID 
>> greater than or equal to id that has a quota set.
>
>> Signed-off-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
>Reviewed-by: Petr Vorel <pvorel@suse.cz> LGTM, minor note below.
Thanks for your review.

>> +#ifdef HAVE_STRUCT_IF_NEXTDQBLK
>> +# include <linux/quota.h>
>You test <linux/quota.h> in LTP_CHECK_SYSCALL_QUOTACTL (indirectly via AC_CHECK_TYPES, but that should be ok)
...
>>  	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
>>+	if (TST_ERR == EINVAL) {
>> +		tst_res(TCONF, "Current system doesn't support this cmd");
>nit: cmd? Maybe something like "quotactl() syscall does not support this command"
>or "quotactl() syscall does not support to %s", tc->des to follow other messages. I'd actually prefer to have some macro, which prints QCMD flags, but that's a detail which we can >ignore.
I think we can add some info before each run (such as prctl02.c and copy_file_range02.c, make error cases more clear ), as below:
	tst_res(TINFO, "Test #%d: %s", n, tc->tname);  // this tname is a QCMD_string
>Kind regards,
>Petr




