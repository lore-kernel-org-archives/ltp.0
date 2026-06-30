Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C708CC43458
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 07:17:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782803826; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=gg4NMFsVZjaqmHja8Ji1kBafOTs6Dqs8cBLDSjVZjWo=;
 b=nbjaUmqkn39Hw3mXwK/CJqmhEC8KN43YcMhcSaQZ0BQe7R/st1o1LucygiSUIMpgHZw5r
 If7l20HCEidm68spI3FpgJHBL6wCryWq/YKZEvm+8w9QXrrJCNwKYGT8IKRrcje7K50hIBQ
 sUSi/ORi7A/YvQIvEABN17hNBM/V0/E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 353A63E4AF1
	for <ltp@archiver.kernel.org>; Tue, 30 Jun 2026 09:17:06 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 301C83C8412
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 09:16:44 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id EE5DE1000DC7
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 09:16:43 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-845c6ab4975so2851279b3a.2
 for <ltp@lists.linux.it>; Tue, 30 Jun 2026 00:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1782803802; x=1783408602; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=t2hVE1BjgAocto56RxolWKgNdQh9SOWtUNLm904E0bk=;
 b=qUjHz6IX/vkEOsGH3NKT4gxgDH/lxxi92kNpi1XQHcEZ3PlG/1f+1JDdlXEjnf05Ve
 ggvF07NV6mlobsZrJ7k4vPe2oEaidJdMgmZDvd2lLaMtkMsCR6qhPEF/Opo1lpcTpfk8
 slkILQvnRcNRv5i+Wh0++G1BSrxdkYFHEEPG3mMedt8dFmKwmwyFrVmVcr7BjL1DHcvv
 1QUGlsjF7LN+On/oEOSIct6Ijc+ZYEd9lVkxW4aGqquOuIv+xuSPB5TNIzj+e0WQ2e4G
 OfGQ4B60gh0TpOz3h8ikJyqBSKhnzxkOhtSKs8rtum+PCTv7Di5DZCz9MEfezgNViutW
 zKcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782803802; x=1783408602;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t2hVE1BjgAocto56RxolWKgNdQh9SOWtUNLm904E0bk=;
 b=mThJQfHNwLACUVwWbVqNkcA+KJrHVDVPWrFuJEm+eujsNGXofWivyQymots/vK5jZS
 dCY8WgBZvDDoC+Rlhr11XtuucPDyn71N6Dsv0yqOD3E2a0vn9lFWnSRhvnSCFsdPH71c
 M6SUSJN8qndjs9rr5QxJMVsLmDItkIbodA+0JRUhdmhOP1fITjxnvwKHxxrS2Oyr9uHq
 3XrwVOYwWIZyVcdpDvebht3u47lKKz9eAzHkUhG9JSrHkpz7RcB+wHFHje+f3RaARBNs
 KyUT8wFhV1sRpfGSE+nKdkoYTFA6TTn+r7NAwJTn4EzC0jk62ZV2hdoTh9liKOSUKNb4
 qwrQ==
X-Gm-Message-State: AOJu0Yy3VZ9O44nhBnGIbKdLd7BCONTkpS69sNJcnMancC+ecn/u/5HZ
 pSKXIftHnPxJAW+mwOn4bscEFgpzC/kQQXrEp2pAZUzK80PDTvaaL/2p2P/wW/97YrZ13j6qeR7
 Ix/0KPOiJ9MEt53FQOHGbkjjlPjMUVllBG3oI6zgayLQTmQFdkXWHL3tmYrtV+p/LnmN0u4aH+I
 5G/n0f8LJbDPufxwocK0CU5unfeg==
X-Received: from pfbgs14.prod.google.com
 ([2002:a05:6a00:4d8e:b0:845:b941:bc97])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2e15:b0:847:8650:69c7
 with SMTP id d2e1a72fcca58-8479f19f2b9mr2180660b3a.21.1782803801798; Tue, 30
 Jun 2026 00:16:41 -0700 (PDT)
Date: Tue, 30 Jun 2026 07:16:39 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
Message-ID: <20260630071639.2248082-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] tst_test.sh: Replace GNU word boundary \b with \< in
 grep
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
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: ttritton@google.com, Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Terence Tritton <ttritton@google.com>

The regex word boundary extension '\b' is a GNU extension and is not
supported by Toybox and lightweight POSIX regex implementations
(such as Bionic libc), causing grep to fail with:

    grep: bad regex '^[^#]*\bTST_': trailing backslash (\)

Replace '\b' with '\<' to ensure shell tests run correctly on
lightweight environments such as Android (Toybox).

Signed-off-by: Terence Tritton <ttritton@google.com>
Co-developed-by: Wake Liu <wakel@google.com>
Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/lib/tst_test.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/lib/tst_test.sh b/testcases/lib/tst_test.sh
index 1234567..89abcdef 100644
--- a/testcases/lib/tst_test.sh
+++ b/testcases/lib/tst_test.sh
@@ -679,7 +679,7 @@ tst_run()
 	local ret

 	if [ -n "$TST_TEST_PATH" ]; then
-		for _tst_i in $(grep '^[^#]*\bTST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
+		for _tst_i in $(grep '^[^#]*\<TST_' "$TST_TEST_PATH" | sed "s/.*TST_//; s/$_tst_pattern//"); do
 			case "$_tst_i" in
 			ALL_FILESYSTEMS|DISABLE_APPARMOR|DISABLE_SELINUX);;
 			SETUP|CLEANUP|TESTFUNC|ID|CNT|MIN_KVER);;
@@ -701,7 +701,7 @@ tst_run()
 			esac
 		done

-		for _tst_i in $(grep '^[^#]*\b_tst_' "$TST_TEST_PATH" | sed "s/.*_tst_//; s/$_tst_pattern//"); do
+		for _tst_i in $(grep '^[^#]*\<_tst_' "$TST_TEST_PATH" | sed "s/.*_tst_//; s/$_tst_pattern//"); do
 			tst_res TWARN "Private variable or function _tst_$_tst_i used!"
 		done
 	fi
-- 
2.45.2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
