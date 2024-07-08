Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A24C3271E
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 05:31:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBE753D39ED
	for <ltp@archiver.kernel.org>; Mon,  8 Jul 2024 07:31:55 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F21A73D39E8
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 07:31:36 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=54.243.244.52;
 helo=smtpbguseast3.qq.com; envelope-from=lufei@uniontech.com;
 receiver=lists.linux.it)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B6AF61402F86
 for <ltp@lists.linux.it>; Mon,  8 Jul 2024 07:31:33 +0200 (CEST)
X-QQ-GoodBg: 2
X-QQ-SSF: 00400000000000F0
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-FEAT: rZJGTgY0+YOb5AoQSY7Xv7SDmVWPM44kNuJXjuySlyRK163S54ScUWnN+03st
 iIhgJcFT7eEgE/fg/tYy29MUiC0JwOHtm/a7PUJ8SDrr7NHzIa4uOzqknYt0Xi0GVjcXIhm
 EJxdYD+82SVWXlEc4gkQlC502V6u8NRqFMdHWzOWzeMwi7WzeSVmoVNjjlrqfXZecWqu94n
 esUmGfbWBdSM+jQBxyXShS/t6ImtYyiQe/szt/2FIJLVE1eRpshKLIkssyUiqIe22W9fbjN
 kZknc6zRbmfzKsBxOjzK+R6PBTcp99Mgfvgmulkr9Kb7SV1MPqkuHi489z/dAAH+HOY5Mz/
 THkfbB57KQkgyU7oSv+qtt7UhxpRNToToHeWiIYr3CizHir05Pq4s/hMjbwzjfK1iDqr1ts
 XFZqEtA0sYcLmFNLsAxGKA==
X-QQ-BUSINESS-ORIGIN: 2
X-QQ-Originating-IP: V7bSI4a8iWP+k+MVVjtDuyrYwh1N11baaBOmTYTkskI=
X-Originating-IP: 125.76.39.228
X-QQ-STYLE: 
X-QQ-mid: t5gz6a-3t1720416687t9041336
From: "=?utf-8?B?6Lev5paQ?=" <lufei@uniontech.com>
To: "=?utf-8?B?UGV0ciBWb3JlbA==?=" <pvorel@suse.cz>,
 "=?utf-8?B?Q3lyaWwgSHJ1Ymlz?=" <chrubis@suse.cz>,
 "=?utf-8?B?bHRw?=" <ltp@lists.linux.it>
Mime-Version: 1.0
Date: Mon, 8 Jul 2024 05:31:27 +0000
X-Priority: 3
Message-ID: <tencent_3E63AE5B3A162AF97E6505AD@qq.com>
X-QQ-MIME: TCMime 1.0 by Tencent
X-Mailer: QQMail 2.x
X-QQ-Mailer: QQMail 2.x
References: <20240606065506.1686-1-lufei@uniontech.com>
 <20240624015245.54968-1-lufei@uniontech.com>
 <20240624015245.54968-2-lufei@uniontech.com>
 <20240708042318.GA119348@pevik>
In-Reply-To: <20240708042318.GA119348@pevik>
X-QQ-ReplyHash: 2631809715
X-BIZMAIL-ID: 11339285976284122351
X-QQ-SENDSIZE: 520
Received: from qq.com (unknown [127.0.0.1]) by smtp.qq.com (ESMTP) with SMTP
 id ; Mon, 08 Jul 2024 13:31:29 +0800 (CST)
Feedback-ID: t:uniontech.com:qybglogicsvrsz:qybglogicsvrsz4a-1
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] acct01: add EFAULT errno check.
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr, Cyril.
Really thanks for the advises. Each of them makes me learned.


Sorry for the patches not so good I've sent, I'm trying to make it better in the future.
I will make warnings clearnup patches after this one merged.


Best reguards.
Lu Fei
&nbsp;
------------------&nbsp;Original&nbsp;------------------
From: &nbsp;"Petr&nbsp;Vorel"<pvorel@suse.cz&gt;;
Date: &nbsp;Mon, Jul 8, 2024 04:23 AM
To: &nbsp;"ltp"<ltp@lists.linux.it&gt;; "lufei"<lufei@uniontech.com&gt;; 
Cc: &nbsp;"Cyril Hrubis"<chrubis@suse.cz&gt;; 
Subject: &nbsp;Re: [LTP] [PATCH] acct01: add EFAULT errno check.

&nbsp;

Hi 
&gt; Add EFAULT errno check in acct01 testcase.

&gt; Signed-off-by: lufei <lufei@uniontech.com&gt;

I guess you don't mind if I change this to following before merge:
Signed-off-by: Lu Fei <lufei@uniontech.com&gt;

&gt; ---
&gt;&nbsp; testcases/kernel/syscalls/acct/acct01.c | 13 +++++++++++++
&gt;&nbsp; 1 file changed, 13 insertions(+)

&gt; diff --git a/testcases/kernel/syscalls/acct/acct01.c b/testcases/kernel/syscalls/acct/acct01.c
&gt; index 1b53a32f2..ed1817bc5 100644
&gt; --- a/testcases/kernel/syscalls/acct/acct01.c
&gt; +++ b/testcases/kernel/syscalls/acct/acct01.c
&gt; @@ -33,6 +33,7 @@
&gt;&nbsp; #define FILE_TMPFILE		"./tmpfile"
&gt;&nbsp; #define FILE_ELOOP		"test_file_eloop1"
&gt;&nbsp; #define FILE_EROFS		"ro_mntpoint/file"
&gt; +#define FILE_EFAULT		"/tmp/invalid/file/name"

And here I just amend to:
#define FILE_EFAULT&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; "invalid/file/name"

(although it's very unlikely, the full patch *could* be existing, but not the
relative one, because LTP is creating unique temporary directory for each run,
e.g. /tmp/LTP_accTJpYqc.

&gt;&nbsp; static struct passwd *ltpuser;

&gt; @@ -45,6 +46,7 @@ static char *file_eloop;
&gt;&nbsp; static char *file_enametoolong;
&gt;&nbsp; static char *file_erofs;
&gt;&nbsp; static char *file_null;
&gt; +static char *file_efault;

&gt;&nbsp; static void setup_euid(void)
&gt;&nbsp; {
&gt; @@ -56,6 +58,16 @@ static void cleanup_euid(void)
&gt;&nbsp; 	SAFE_SETEUID(0);
&gt;&nbsp; }

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
&gt; @@ -72,6 +84,7 @@ static struct test_case {
&gt;&nbsp; 	{&amp;file_eloop,&nbsp;&nbsp; FILE_ELOOP,&nbsp;&nbsp; ELOOP,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL},
&gt;&nbsp; 	{&amp;file_enametoolong, "aaaa...", ENAMETOOLONG, NULL, NULL},
&gt;&nbsp; 	{&amp;file_erofs,&nbsp;&nbsp; FILE_EROFS,&nbsp;&nbsp; EROFS,&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; NULL, NULL},
&gt; +	{&amp;file_efault,	FILE_EFAULT,&nbsp; EFAULT,&nbsp; setup_emem, cleanup_emem},
&nbsp;&nbsp;&nbsp; {&amp;file_efault,&nbsp; "Invalid address",&nbsp; EFAULT,&nbsp; setup_emem, cleanup_emem},
(as Cyril suggested)

Actually this second version does only single thing (unlike the previous version
[1]), thus I suggest to merge it:
Reviewed-by: Petr Vorel <pvorel@suse.cz&gt;

Therefore I reopen it in patchwork [2].

And you can send warning cleanup after merging this?

Could you, please, next time put version to your patchset (e.g. -v2 for second
version), this help to avoid confusions?

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/20240606065506.1686-1-lufei@uniontech.com/
[2] https://patchwork.ozlabs.org/project/ltp/patch/20240624015245.54968-2-lufei@uniontech.com/

&gt;&nbsp; };

&gt;&nbsp; static void setup(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
