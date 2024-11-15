Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD073D6DDCB
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 03:39:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D4183D726B
	for <ltp@archiver.kernel.org>; Fri, 15 Nov 2024 04:39:38 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D8AD3D71FA
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 04:39:22 +0100 (CET)
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com
 [IPv6:2a00:1450:4864:20::129])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E4CF01BDE4DB
 for <ltp@lists.linux.it>; Fri, 15 Nov 2024 04:39:21 +0100 (CET)
Received: by mail-lf1-x129.google.com with SMTP id
 2adb3069b0e04-539f6e1f756so1292292e87.0
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 19:39:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731641961; x=1732246761; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o93KbUvBHQnUFxJhmiqzOqRdqi4nALRQYnXwxfhhyNI=;
 b=BCrpWll3fsRDHmHLzrZEsnYArgk1Cn97N0zz/0x+X1boAmIG21BrqEDfopATjpGso7
 rBCFMotnAbaMnZjczJtpnR1FMaZxaypwADRiXLz6va541uKC8JUUxN4bCN4Dr0D9ILkt
 SkvAhoEl+xKAhU6CcPMAFb5rxFm+3FrN9OoNkrZE6/HOctSO/mgMgCRwFM23JZf24NSg
 vydoq0dlijP2pr3R2W+SVwDmOQWgx7G+jQCfHdgsjF0JVQBfW6YFD1EGhNl/L+zBtOUv
 V1N8Fr6QqTsUkiicnl7E9qkrIxkurk6k0NCc0EWeUi+/gFvZzokMXGS/O4Q4lGOQriKr
 OIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731641961; x=1732246761;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o93KbUvBHQnUFxJhmiqzOqRdqi4nALRQYnXwxfhhyNI=;
 b=PRH8AykUNAaB6QyXKVdjj/d3prBKM7swymEckhIqBKm+ha6ZKsAHmcGWLgMtttzk3z
 CqdGq7Y3qZW3c9bzgS3InHnnaXMs8y9tMGbsja2d1dIqSKeOBah5dm0Evqg9c50Md6hG
 VSkqDF0qa5RUeOIJ554BH+zjgHRA1ok4DJAx/S+Ml68Pek7qXHqc2mWXrwmwyPeklXHw
 iAyHf+CL/RbiYrE5WcxA1vbKWLGXtup59uw9Ydc/4QeelxptckSy4fzBZxGerUEmyp8Q
 EeKDPNxf2XvTZT8vOAQW8I9eIFQz//g7Uzd8sb8hWJHis+nFFvhr/zVs7mFbfF+zCYvL
 MrPw==
X-Gm-Message-State: AOJu0Yx985srqEVTIOo2oK3PyM8zl97EcrCG1aBNZxnzQYJ0GnfwTjbg
 qWrGEk91t7L1jR67TIAh6ktFOSOE0BHcQQ4ACBjB4eAMxzDJ+YxhIr+tzQ==
X-Google-Smtp-Source: AGHT+IEQxdp0zv5TLu0mvhyF43uPuk+VDeA6vPxsWDG7vsKJjXwtXQEFv1vTL+AODRMyZGNu7uFW+w==
X-Received: by 2002:a05:6512:3b23:b0:530:c212:4a5a with SMTP id
 2adb3069b0e04-53dab29eb11mr343121e87.22.1731641960739; 
 Thu, 14 Nov 2024 19:39:20 -0800 (PST)
Received: from x230.suse.cz (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-432da29ffe9sm43609375e9.44.2024.11.14.19.39.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 14 Nov 2024 19:39:20 -0800 (PST)
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 15 Nov 2024 04:39:15 +0100
Message-ID: <20241115033916.1707627-1-petr.vorel@gmail.com>
X-Mailer: git-send-email 2.45.2
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/2] doc: Update blacklist and whitelist
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

From: Petr Vorel <pvorel@suse.cz>

getmsg, getpmsg, putmsg, putpmsg in man UNIMPLEMENTED(2),
move them from whitelist to blacklist.

seccomp is now detected, therefore remove from whitelist.

Fixes: 7248e5c5f7 ("doc: update syscalls statistics")
Signed-off-by: Petr Vorel <pvorel@suse.cz>
---
 doc/conf.py | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/doc/conf.py b/doc/conf.py
index aed0cd50fd..e14c1387d0 100644
--- a/doc/conf.py
+++ b/doc/conf.py
@@ -67,8 +67,6 @@ def generate_syscalls_stats(_):
         'fanotify_init',
         'fanotify_mark',
         'getdents64',
-        'getmsg',
-        'getpmsg',
         'inotify_add_watch',
         'inotify_rm_watch',
         'io_uring_enter',
@@ -79,8 +77,6 @@ def generate_syscalls_stats(_):
         'landlock_restrict_self',
         'lsetxattr',
         'newfstatat',
-        'putmsg',
-        'putpmsg',
         'pkey_alloc',
         'pkey_free',
         'pkey_mprotect',
@@ -90,7 +86,6 @@ def generate_syscalls_stats(_):
         'pwrite64',
         'quotactl_fd',
         'rt_sigpending',
-        'seccomp',
         'semtimedop',
         'sethostname',
     ]
-- 
2.45.2


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
