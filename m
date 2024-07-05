Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 557AFC30653
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 02:02:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7BA2F3D3D16
	for <ltp@archiver.kernel.org>; Fri,  5 Jul 2024 04:02:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EDD503D1198
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 04:02:37 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.206.34.216; helo=smtpbgau2.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 92DE2600D84
 for <ltp@lists.linux.it>; Fri,  5 Jul 2024 04:02:33 +0200 (CEST)
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-FEAT: CR3LFp2JE4m05+x2gyxE+7xRD2kFMYkEtPZEMG9vR2ARVxQu3P8Imfd3Rqs+s
 KLffmJ9OT34HWXNqm4V0Tn5/qszUhxvcydL13lLgbcdYoFg2ry1Zc6uZT+Wbmr/Aj5hXDaX
 0v9ljzD3v9AvX13Msi/0HuO78OUx1cohSolTOrNs+dFjqkZDf6OU4Kn8p6RT7gj98p9c/Xm
 awmONKD7vpbUXcF6HejiD39uxBb5dIwgfOkEkzLoMAeV02kbZH9CUd63vVa9+WJgdGiPQ2j
 zp/xaCnnDu0C6cXRXmdaUIZa2IumxJzdL0lWTcuymLXm8AyevgAPuP/41AroPRfrzvdj2xr
 J109tG/1cLNfT1lFkqqDSAVaXJ9J0OPur/Qfu9l98P8XPz/r5llmgKiqcPrxuN0eRAtbqA8
 X2zAD2DdJSk=
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: OIf3L2sEU42M1RK0HOEF4FD94hjyYiwqVQioweE8N7g=
X-Originating-IP: 125.76.39.228
X-QQ-STYLE: 
X-QQ-mid: t5gz6a-3t1720144945t9210764
From: "=?utf-8?B?6Lev5paQ?=" <lufei@uniontech.com>
To: "=?utf-8?B?Q3lyaWwgSHJ1Ymlz?=" <chrubis@suse.cz>
Mime-Version: 1.0
Date: Fri, 5 Jul 2024 02:02:25 +0000
X-Priority: 3
Message-ID: <tencent_29288C9E297DDACC1D8B73FC@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240606065506.1686-1-lufei@uniontech.com> <Zoajv8Y1HEbjvhmh@yuki>
In-Reply-To: <Zoajv8Y1HEbjvhmh@yuki>
X-QQ-ReplyHash: 1529053711
X-BIZMAIL-ID: 17103312918980180909
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Fri, 05 Jul 2024 10:02:27 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] acct01: add EFAULT errno check
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Unsubscribe: <https://lists.linux.it/options/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=unsubscribe>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: =?utf-8?B?bHRw?= <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril
Thanks for reply.
In the beginning, replace ENOSYS with .needs_kconfigs is for fixing one of the `make check` warnings. Should I still split .needs_kconfigs and make check fixes to seperate patches?&nbsp;

Best reguards.
Lufei

&nbsp;
&nbsp;
------------------&nbsp;Original&nbsp;------------------
From: &nbsp;"Cyril&nbsp;Hrubis"<chrubis@suse.cz&gt;;
Date: &nbsp;Thu, Jul 4, 2024 01:29 PM
To: &nbsp;"lufei"<lufei@uniontech.com&gt;; 
Cc: &nbsp;"ltp"<ltp@lists.linux.it&gt;; 
Subject: &nbsp;Re: [LTP] [PATCH] acct01: add EFAULT errno check

&nbsp;

Hi!
&gt; 1. add EFAULT errno check.
&gt; 2. fix make check errors and warnings.

Can you please split the functional changes and make chek fixes into
separate tests?

Ideally each type of change should be put into a separate patch.

&gt; Signed-off-by: lufei <lufei@uniontech.com&gt;
&gt; ---
&gt;&nbsp; testcases/kernel/syscalls/acct/acct01.c | 31 +++++++++++++++++--------
&gt;&nbsp; testcases/kernel/syscalls/acct/acct02.c |&nbsp; 2 +-
&gt;&nbsp; 2 files changed, 22 insertions(+), 11 deletions(-)
&gt; 
&gt; diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
&gt; index a05ed2ea9..ed1817bc5 100644
&gt; --- a/testcases/kernel/syscalls/acct/acct01.c
&gt; +++ b/testcases/kernel/syscalls/acct/acct01.c
&gt; @@ -25,8 +25,7 @@
&gt;&nbsp; 
&gt;&nbsp; #include "tst_test.h"
&gt;&nbsp; 
&gt; -#define DIR_MODE	(S_IRUSR|S_IWUSR|S_IXUSR|S_IRGRP| \
&gt; -			 S_IXGRP|S_IROTH|S_IXOTH)
&gt; +#define DIR_MODE	0755
&gt;&nbsp; #define FILE_EISDIR		"."
&gt;&nbsp; #define FILE_EACCESS		"/dev/null"
&gt;&nbsp; #define FILE_ENOENT		"/tmp/does/not/exist"
&gt; @@ -34,6 +33,7 @@
&gt;&nbsp; #define FILE_TMPFILE		"./tmpfile"
&gt;&nbsp; #define FILE_ELOOP		"test_file_eloop1"
&gt;&nbsp; #define FILE_EROFS		"ro_mntpoint/file"
&gt; +#define FILE_EFAULT		"/tmp/invalid/file/name"
&gt;&nbsp; 
&gt;&nbsp; static struct passwd *ltpuser;
&gt;&nbsp; 
&gt; @@ -46,6 +46,7 @@ static char *file_eloop;
&gt;&nbsp; static char *file_enametoolong;
&gt;&nbsp; static char *file_erofs;
&gt;&nbsp; static char *file_null;
&gt; +static char *file_efault;
&gt;&nbsp; 
&gt;&nbsp; static void setup_euid(void)
&gt;&nbsp; {
&gt; @@ -57,12 +58,22 @@ static void cleanup_euid(void)
&gt;&nbsp; 	SAFE_SETEUID(0);
&gt;&nbsp; }
&gt;&nbsp; 
&gt; +static void setup_emem(void)
&gt; +{
&gt; +	file_efault = SAFE_MMAP(NULL, 1, PROT_NONE,
&gt; +			MAP_ANONYMOUS | MAP_PRIVATE, 0, 0);
&gt; +}
&gt; +static void cleanup_emem(void)
&gt; +{
&gt; +	SAFE_MUNMAP(file_efault, 1);
&gt; +}
&gt; +
&gt;&nbsp; static struct test_case {
&gt;&nbsp; 	char **filename;
&gt;&nbsp; 	char *desc;
&gt;&nbsp; 	int exp_errno;
&gt; -	void (*setupfunc) ();
&gt; -	void (*cleanfunc) ();
&gt; +	void (*setupfunc)();
&gt; +	void (*cleanfunc)();
&gt;&nbsp; } tcases[] = {
&gt;&nbsp; 	{&amp;file_eisdir,&nbsp; FILE_EISDIR,&nbsp; EISDIR,&nbsp; NULL,&nbsp;&nbsp; NULL},
&gt;&nbsp; 	{&amp;file_eaccess, FILE_EACCESS, EACCES,&nbsp; NULL,&nbsp;&nbsp; NULL},
&gt; @@ -73,16 +84,13 @@ static struct test_case {
&gt;&nbsp; 	{&amp;file_eloop,&nbsp;&nbsp; FILE_ELOOP,&nbsp;&nbsp; ELOOP,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL},
&gt;&nbsp; 	{&amp;file_enametoolong, "aaaa...", ENAMETOOLONG, NULL, NULL},
&gt;&nbsp; 	{&amp;file_erofs,&nbsp;&nbsp; FILE_EROFS,&nbsp;&nbsp; EROFS,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL},
&gt; +	{&amp;file_efault,	FILE_EFAULT,&nbsp; EFAULT,&nbsp; setup_emem, cleanup_emem},
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; ^
			 This should actually describe the testcase so
			 it should be something as "Invalid address"

&gt;&nbsp; };
&gt;&nbsp; 
&gt;&nbsp; static void setup(void)
&gt;&nbsp; {
&gt;&nbsp; 	int fd;
&gt;&nbsp; 
&gt; -	TEST(acct(NULL));
&gt; -	if (TST_RET == -1 &amp;&amp; TST_ERR == ENOSYS)
&gt; -		tst_brk(TCONF, "acct() system call isn't configured in kernel");
&gt; -
&gt;&nbsp; 	ltpuser = SAFE_GETPWNAM("nobody");
&gt;&nbsp; 
&gt;&nbsp; 	fd = SAFE_CREAT(FILE_TMPFILE, 0777);
&gt; @@ -113,7 +121,7 @@ static void verify_acct(unsigned int nr)
&gt;&nbsp; 		tcase-&gt;setupfunc();
&gt;&nbsp; 
&gt;&nbsp; 	TST_EXP_FAIL(acct(*tcase-&gt;filename), tcase-&gt;exp_errno,
&gt; -	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "acct(%s)", tcase-&gt;desc);
&gt; +			"acct(%s)", tcase-&gt;desc);
&gt;&nbsp; 
&gt;&nbsp; 	if (tcase-&gt;cleanfunc)
&gt;&nbsp; 		tcase-&gt;cleanfunc();
&gt; @@ -136,5 +144,8 @@ static struct tst_test test = {
&gt;&nbsp; 		{&amp;file_enametoolong, .size = PATH_MAX+2},
&gt;&nbsp; 		{&amp;file_erofs, .str = FILE_EROFS},
&gt;&nbsp; 		{}
&gt; -	}
&gt; +	},
&gt; +	.needs_kconfigs = (const char *[]) {
&gt; +		"CONFIG_BSD_PROCESS_ACCT=y",
&gt; +	},
&gt;&nbsp; };

And this is a different change that is not described in the patch
description. So this patch should be actually split into three patches,
one that adds errno check, one that adds needs_kconfigs and one that
fixes make check errors.

&gt; diff --git a/testcases/kernel/syscalls/acct/acct02.c b/testcases/kernel/syscalls/acct/acct02.c
&gt; index d3f3d9d04..74019f430 100644
&gt; --- a/testcases/kernel/syscalls/acct/acct02.c
&gt; +++ b/testcases/kernel/syscalls/acct/acct02.c
&gt; @@ -186,7 +186,7 @@ static void run(void)
&gt;&nbsp; 
&gt;&nbsp; 		if (read_bytes != acct_size) {
&gt;&nbsp; 			tst_res(TFAIL, "incomplete read %i bytes, expected %i",
&gt; -			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read_bytes, acct_size);
&gt; +					read_bytes, acct_size);
&gt;&nbsp; 			goto exit;
&gt;&nbsp; 		}
&gt;&nbsp; 
&gt; -- 
&gt; 2.39.3
&gt; 
&gt; 
&gt; -- 
&gt; Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
