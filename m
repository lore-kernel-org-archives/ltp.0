Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57C0C61DCB
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 12:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787918588; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=eHNJlxqSsNYb9yO/XSVhmNwfwUdJu8eXVlBJVLbSh9o=;
 b=g2+ilpad9wQGQ2h9PgCKgw9t4J6kHsE5uazY2wbpFMuJUkHtbB/bvebOBsN2OePdAdwlo
 jBVIR9nZzo+76dusVQ/FaXYFTEVF6GuSH8fu4oEMDJQ2GeFkY+l1AtCnxL6TlDJlTgtTQyy
 70kdiTolJGVWb/zOc16nydrRXv1Lmec=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 157363E4D0F
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 14:03:08 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AEF863CD6A6
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:02:46 +0200 (CEST)
Received: from mail-yw1-x1145.google.com (mail-yw1-x1145.google.com
 [IPv6:2607:f8b0:4864:20::1145])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EE5C81400E1B
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 14:02:45 +0200 (CEST)
Received: by mail-yw1-x1145.google.com with SMTP id
 00721157ae682-7fe835353acso14344887b3.2
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 05:02:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787918564; x=1788523364; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=pd3H4XGWbDBUseAlggSffdqXcSxWbj1mXU6zKfxihyI=;
 b=wXVYdk/uUIV/4KcHHdntegpfC670swpV6aUxEx3Xme19YkAWLIhZDsE1JYIyfI68+Z
 ecxMkQxBYXEvyShcqEoqjElbbIrUWzco7nhoiTRhzNqLYqPSWrRoBM4NR0LPinyv3zur
 EUNEIzK5L6+LbYmii5HmfwA1/vTs4hTe2ius7cNuOYMb7xNMJQjR8qEIbEXYXpqlVojm
 1elgkkokXc7wgmbED/bc70K65vCE/1qvduIShEO3P4iMPA6sgd7rq+96sbgKryzR8GQH
 k03peoe5XNOPJ5QtdZAZxcmanVEpIYISsNJ7teCIMH0ZvRJs8Y6gbwGwht2cYRl2ykNW
 VRsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787918564; x=1788523364;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=pd3H4XGWbDBUseAlggSffdqXcSxWbj1mXU6zKfxihyI=;
 b=MeQtcTLvHQk5Rr41ZgAWARSJrHCyZGmPyrtP4anx2Wl+VnPfF4gR1yrZh5bBUFkthH
 0vFtDWC5uqO23AHy19yijUp/kttMUZihqY7/ilpN4tYLjU6A4kFAyiZlDOs4hgfmSYds
 aOyG5bhZNrnkVWbvDTLBeErofkj0S2rh9PDNQ6vpBxbmpgio0yetcontkso0inzWs61b
 VfDu6/69RkPzhMoWAD9lV3Dz3Uza9HncfnRkh1psWwne4BOToct2vyVp59zRThcGM2oH
 mK4kKAnygAdp0ga17T5Wy0jBSXqCtCPN4O7Wo64oMQwpd500pHhIQjkpcQak2JlmF4m8
 YrOw==
X-Gm-Message-State: AFuF++mGCgEl4nHLnXI5F3SkpSOBnqipVx3pRMh19Is8fqUXFsyqfSPk
 gwx3/AjA9bEOL4NJP32Hvi15auIaSmL4u0UPL5BHuxba7LiQOVjBpPoBjLb73NNLOSDzBX3pizB
 JowaPSzjGcloi+k1S/e6jL1x2ElqHcbHnrzwvSiO/QiaDaHurCotHiBFLPJaqcVx++/lGOV0L7A
 D4i0IUn6H8oeYoipq83GegqF10ZA==
X-Received: from pgtq23.prod.google.com ([2002:a65:6857:0:b0:c88:90c8:13c5])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:e142:10b0:812:c9fa:9910
 with SMTP id 00721157ae682-85d6b84ac95mr21582527b3.29.1787918564026; Fri, 28
 Aug 2026 05:02:44 -0700 (PDT)
Date: Fri, 28 Aug 2026 12:02:42 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260828120242.2367797-1-wakel@google.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] cgroup_fj: Check start_path before removing
 directories in cleanup
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
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

When setup() fails early (for example, when a cgroup controller is not
available and cgroup_require triggers TCONF), start_path has not yet
been assigned.

In this case, cleanup() in cgroup_fj_function.sh unconditionally runs
rmdir "$start_path/ltp_1", which evaluates to rmdir /ltp_1 and fails.
Similarly, common_cleanup() prints a message about removing all ltp
subgroups even when none were created.

Add checks to verify that start_path is non-empty and the directory
exists before attempting removal.

Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh | 7 ++++---
 .../kernel/controllers/cgroup_fj/cgroup_fj_function.sh     | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
index 8b5e73466..03e416f55 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_common.sh
@@ -79,9 +79,10 @@ common_cleanup()
 {
     killall -9 cgroup_fj_proc >/dev/null 2>&1

-    tst_res TINFO "Removing all ltp subgroups..."
-
-    [ -d "$start_path" ] && find "$start_path" -depth -type d -exec rmdir '{}' \;
+    if [ -n "$start_path" ] && [ -d "$start_path" ]; then
+        tst_res TINFO "Removing all ltp subgroups..."
+        find "$start_path" -depth -type d -exec rmdir '{}' \;
+    fi

     cgroup_cleanup

diff --git a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
index b0c9410ca..61b7a0415 100755
--- a/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
+++ b/testcases/kernel/controllers/cgroup_fj/cgroup_fj_function.sh
@@ -231,7 +231,7 @@ cleanup()
         wait $pid >/dev/null 2>&1
     fi

-    rmdir "$start_path/ltp_1" >/dev/null 2>&1
+    [ -n "$start_path" ] && [ -d "$start_path/ltp_1" ] && rmdir "$start_path/ltp_1" >/dev/null 2>&1
     common_cleanup
 }

--
2.55.0.897.gb25b4bd76c-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
