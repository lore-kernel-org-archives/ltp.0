From: Yang Xu <xuyang2018.jy@cn.fujitsu.com>
Date: Thu, 21 Nov 2019 11:59:44 +0800
Subject: [LTP] [PATCH v3 1/5] syscalls/quotactl01.c: Add Q_GETNEXQUOTA
 test
In-Reply-To: <20191120170948.GA7010@dell5510>
References: <20191031152646.GA7078@dell5510>
 <1572612959-20577-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <1572612959-20577-2-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <20191115155123.GA658@x230>
 <989b7cbfa4cf4d7bb65c9b7df45b8c37@G08CNEXMBPEKD04.g08.fujitsu.local>
 <20191120170948.GA7010@dell5510>
Message-ID: <29a09da1-0869-0809-ab26-995b6b078453@cn.fujitsu.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it


on 2019/11/21 1:09, Petr Vorel wrote:

> Hi Xu,
>
>>>>   	TEST(quotactl(tc->cmd, tst_device->dev, *tc->id, tc->addr));
>>>> +	if (TST_ERR == EINVAL) {
>>>> +		tst_res(TCONF, "Current system doesn't support this cmd");
>>> nit: cmd? Maybe something like "quotactl() syscall does not support this command"
>>> or "quotactl() syscall does not support to %s", tc->des to follow other messages. I'd actually prefer to have some macro, which prints QCMD flags, but that's a detail which we can >ignore.
>> I think we can add some info before each run (such as prctl02.c and copy_file_range02.c, make error cases more clear ), as below:
>> 	tst_res(TINFO, "Test #%d: %s", n, tc->tname);  // this tname is a QCMD_string
> +1.  It could use similar approach as it's in testcases/kernel/syscalls/mbind/mbind01.c
>
> #define POLICY_DESC(x) .policy = x, .desc = #x
> #define POLICY_DESC_TEXT(x, y) .policy = x, .desc = #x" ("y")"
>
> static struct test_case tcase[] = {
> 	{
> 		POLICY_DESC(MPOL_DEFAULT),
> 		...
> 	},
> 	{
> 		POLICY_DESC_TEXT(MPOL_DEFAULT, "target exists"),
>
> But I'd prefer to have it as a separate patch after v4 of this patchset is merged.
> I'd prefer to finish v4 (I've already fixed small formatting things, I can fix
> the rest of needed things myself).

Hi Petr

 ?Using a macro is a better way.

Thanks
Yang Xu

>
> Kind regards,
> Petr
>
>


-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20191121/19ca1160/attachment.htm>
