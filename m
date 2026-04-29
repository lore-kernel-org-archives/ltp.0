Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDFCFF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 06:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777444842; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=7HFNguQ22Sp+erEk2sBTgAd0VWVQo8o2N3jaP/ds47U=;
 b=bL51V1O+jXeb5nkOiCz7aOfCfap7bDCVM/3pMpwHNdRkEfqtN1A5GClN2KPhL6st2WOOF
 UvvgLMIM0Ss4jxYFdFfJ9uMvbYO/hJaVI4XhA7r8SmCYvrx/FoLrskIvC/zzJmzWPiZb3Ae
 QyZMGRYYoKF/+F5U68/Aab2GTKes+gU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 524C53E2572
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 08:40:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4C2063CFB7E
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:40:19 +0200 (CEST)
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com
 [IPv6:2607:f8b0:4864:20::44a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 739F31400C5E
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 08:40:19 +0200 (CEST)
Received: by mail-pf1-x44a.google.com with SMTP id
 d2e1a72fcca58-8230d6d54a5so343742b3a.1
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 23:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777444818; x=1778049618; darn=lists.linux.it;
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CtMOpEZHJnfO8XEgUPd4HjCnhQ9LXVJvyOVUvR0wIMU=;
 b=dBjerSOvG4r/Zk7y3JzxaRqF3xL1hAc2T/3TPVm4CZZrYVL+0xLyrRZZ87cwsYGt+Q
 iCvmaCueLzFdx6obWVaiFpcgakkBDa2x+Trqa3tGnwb2EBplA+JDaFXiE2xj/0IAgnGg
 SNG2YWJo8AlyZxySQPyKuTdF2jLfg5tdgYr7bxiPCZc++U5Z31nwRGGkpocXC7gQaAtA
 f/8BWbhN54rW8bt5Q2PDjNw6i3yOSrdtufYc21J8lDezOAjBt/phpnIjv2hA8AXqZrn1
 +6fzh193IEaDtE1GKrncfyPXbZnqzzMJXpWjsQ+xzd0W6jJxgD26cYgvxsvp27vCydbE
 7jmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777444818; x=1778049618;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CtMOpEZHJnfO8XEgUPd4HjCnhQ9LXVJvyOVUvR0wIMU=;
 b=PlHlG7rbDuxo3qePO13XJluiDg+XgJ+A6RI4q+Ye8U3BWYtdgCcYlZWWwxZS0Gd9PN
 EnA4BTgdJ1qnj/6hjGblUrD9sdzFl24yCARk05Bxzd3OcXwoyHdWZsf/CrQ0iZiJH4MW
 kti60sOGnh/VsQCWC2WgYkxwWq1KF7wcCC+Hz+Kw4itq9H1JKOx8vNL/Vh6bGXKxTV5u
 vhF21SS0+PdEJDYqmuM4U1u85d2UwVsWI5VD9A8POMHqAHi95ZAjoB1UuIRsqeneejxl
 4MyJJJOfbtNNFajp5pCGuggQoGmnQRdIZHcqWgCcxSE+ELhjztDRYLClqCuTqN0b9aeA
 g7/g==
X-Gm-Message-State: AOJu0YxUy7Sz/g5FO9EUs/SNmcP+0iPDsa7LZBYZpPKD49S4jkbJA4AM
 Ugxbxb3qEx+tI2HyVT87Ta6nJKTAEJV6gU/qYbq1HPgUeIhuzGvQUyVHI+7EOae/n5Qc7YnRAgm
 igMZhLhs6cG2/lVL2K9I4eb9Ta+VRMon7e9iQYSk0QsGBrlWFESBYnWAEN5xT/qweZwWoVA9Vlp
 k6qhu0oqqcjT+K3h4V8y5Q/QV+yw==
X-Received: from pffy15.prod.google.com ([2002:aa7:93cf:0:b0:82f:2cac:686a])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:b47:b0:82f:39df:dd54
 with SMTP id d2e1a72fcca58-834eb434f21mr1897871b3a.8.1777444817341; Tue, 28
 Apr 2026 23:40:17 -0700 (PDT)
Date: Wed, 29 Apr 2026 14:40:10 +0800
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260429064011.3200745-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] lapi/userfaultfd: Handle ENOSYS in SAFE_USERFAULTFD
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
Cc: Wake Liu <wakel@google.com>, camann@suse.com, rbranco@suse.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When CONFIG_USERFAULTFD is not enabled in the kernel, the userfaultfd
syscall returns ENOSYS. Currently, SAFE_USERFAULTFD calls tst_brk(TBROK)
for any error other than EPERM, causing tests to fail when they should
be skipped.

Add a check for ENOSYS to return TCONF, so that tests using
SAFE_USERFAULTFD are skipped appropriately on kernels without
userfaultfd support.

Signed-off-by: Wake Liu <wakel@google.com>
---
 include/lapi/userfaultfd.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/lapi/userfaultfd.h b/include/lapi/userfaultfd.h
index 0c9e34c84..09126d856 100644
--- a/include/lapi/userfaultfd.h
+++ b/include/lapi/userfaultfd.h
@@ -244,6 +244,10 @@ static inline int safe_userfaultfd(const char *file, const int lineno, int
 retry:
 	ret = tst_syscall(__NR_userfaultfd, flags);
 	if (ret == -1) {
+		if (errno == ENOSYS) {
+			tst_brk_(file, lineno, TCONF | TERRNO,
+				"userfaultfd() is not supported by this kernel");
+		}
 		if (errno == EPERM) {
 			if (retry && !(flags & UFFD_USER_MODE_ONLY)) {
 				flags |= UFFD_USER_MODE_ONLY;
-- 
2.54.0.545.g6539524ca2-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
