From: xieziyao <xieziyao@huawei.com>
Date: Thu, 18 Mar 2021 06:44:28 +0000
Subject: [LTP] =?gb2312?b?tPC4tDogIFtQQVRDSF0ga2VybmVsL3N5c2NhbGxzOiBV?=
 =?gb2312?b?c2UgU0FGRV9PUEVOKCkgaW5zdGVhZCBvZiBjYWxsaW5nIHN5c3RlbSBBUEkg?=
 =?gb2312?b?ZnVuY3Rpb25z?=
In-Reply-To: <TYCPR01MB654415A23C745F8AB49DEC15FD699@TYCPR01MB6544.jpnprd01.prod.outlook.com>
References: <TYCPR01MB654415A23C745F8AB49DEC15FD699@TYCPR01MB6544.jpnprd01.prod.outlook.com>
Message-ID: <11d89e3b750a4544aad4d75f0acd5f51@huawei.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

I'll send a new patch to fix it. Thanks!

-----????-----
???: xuyang2018.jy@fujitsu.com [mailto:xuyang2018.jy@fujitsu.com] 
????: 2021?3?18? 14:35
???: xieziyao <xieziyao@huawei.com>
??: ltp@lists.linux.it
??: RE: [LTP] [PATCH] kernel/syscalls: Use SAFE_OPEN() instead of calling system API functions

Hi Xie
>--- a/testcases/kernel/syscalls/fsconfig/fsconfig02.c
>+++ b/testcases/kernel/syscalls/fsconfig/fsconfig02.c
>@@ -55,9 +55,7 @@ static void setup(void)
> 	if (fd == -1)
> 		tst_brk(TBROK | TTERRNO, "fsopen() failed");
>
>-	temp_fd = open("testfile", O_RDWR | O_CREAT, 01444);
>-	if (temp_fd == -1)
>-		tst_brk(TBROK, "Can't obtain temp_fd, open() failed");
>+	fd = SAFE_OPEN("testfile", O_RDWR | O_CREAT, 01444);
> }

Here has a typo. We should use temp_fd instead of fd.
Other than this, it looks good to me.

Reviewed-by: Yang Xu <xuyang2018.jy@cn.fujitsu.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp


