Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33D4CD6CFB1
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 02:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769135875; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=kUS/mhqNrSqr7geMJUhV1Jzx5KnJdbL+ghjVYxH34wo=;
 b=SN663GJNqEINpEE48LTHRoHmacOj87Tt302MTU7ouIktk0YEteCv//4Hu6HLap4Jrrh6I
 92Q1bpf9FlnHuuW4K4nbzTXn4XwNE5ZpXYWxcgiew3Ph95R3Ra03Eab9376EZWYdtxz2Ord
 5KVQNMg5Xq7NmWrm78YvKqKLy2zYIEM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9E44A3CB43E
	for <ltp@archiver.kernel.org>; Fri, 23 Jan 2026 03:37:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 59DAE3CB3C9
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 03:36:44 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id ED1051000D8F
 for <ltp@lists.linux.it>; Fri, 23 Jan 2026 03:36:43 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-480142406b3so11839465e9.1
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 18:36:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769135803; x=1769740603; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J/iiZCsiYjn5/KvU8l9NZg3oTN1Q0vOiAebnzNpY+8A=;
 b=Q24dnEm8yUxexPVVtPlSaADQpNzPOsDxXH1Vh/w6SP+P8LdPxrGzJUSi/SsqPbTL0O
 lfF7NzCyISSRMBV2jMy7EKUfrhOlNvQf3kCBsqVYBFwTGjUp+/z3ZLL1GWSpDxSovpWA
 tR5vp9e7OnvB0VSpo/Dm49IA8a0UQZZcVpwOU3VcZo2YiAyY6y71/jFsJIpVkiHSnVQ5
 h0WBaBN2cR7Xl++VedPe7Hgx6S4pwDIFxvs0XGgVGCqd2RZt7XFvBjprfnp0MqSE0eWW
 0+XqSxhPDMFX/KW6QLG+0g428YbT3kMggj9ThrCDZpIEJUCUVRg9hiX+c4JfJMeXutfS
 ujeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769135803; x=1769740603;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=J/iiZCsiYjn5/KvU8l9NZg3oTN1Q0vOiAebnzNpY+8A=;
 b=cAL67fIWE+O4YN56S3FpGo1lxbTw2im9/QUd7W8rj3gc1b33rxW8CrXL+kjAyw/uGj
 t/8e4wxK+n9hkXm+IaA7qY9EzDfyF4+GjhjgF6ZNH+0yUwyRkk/Pi9KVPh6xzJavOKiM
 skjZzO+HSoXIWTPLOirgbEnrgtRrVkAUnsbKUjXhwJCt0b9jNI4LO++mcwdlFePoT3Zr
 Bg3UKVeV96LAHSwyzuMce5iA1ESV7xA4HSx2h0JkzjP5jWXvxoOpZ1qtlvnLGwd+dq8y
 cpuUCo4NlnNlY8IGZHb9uptUQOKyEzDgOKFA04hAnrNZXWSs/M1htpUoq7wXcfOc6NE+
 APBA==
X-Gm-Message-State: AOJu0YwNUr+n4M+OkswdxR/nN4uAFyAOHYcPfMe+w5zsXabDbPY0CYKR
 jeHwWM0AxSWjlqKv2zgF+hDeunF5/zDzo0tH/XWiN8L3RiTiJO3AwbM2wtr5ivVIYkQTm3aLZ8s
 5MKw=
X-Gm-Gg: AZuq6aLsTWBfLkLRZP4tOu0Hxdcd2+pOsPZyn6rPnuNHssTcL81AIHZn/yqbroKgN96
 0LQzhVoUf/TJsw+Tf2GUkmaNTWej0p32IZ0HwX2uq9NZApVbSontnL+GbAhHipl5pxB80cu6+w7
 kByshrFNPjvWo+iI7MILwv0xeMO/gsCQ7lz+2LtdjqUleGAx3Y/b9jhrs0Jgkx/cMwe/B4AtCyd
 NJaH+ECp+UIBliXUmLXE4KPyAT6tcWoja+H87oR+IlcaRYORSEOvCbTl9yvCoqdNjqZEjqpvQfQ
 El+uqZDsaNrtH8t9SpGEqquwKU9DPgSWSVj9Z4rd5bbl9vrX9bjBrIU0jghC/pZ69vt0BfpJRAC
 UUCOT+rrjyoACc5uYhnLn2KMdv7ahcL0Iuo1cnaskfBq4KsyRrMFQ+fL83ZfbUDJUeSURL+aPqc
 0=
X-Received: by 2002:a05:600c:c113:b0:480:3ad0:64fb with SMTP id
 5b1f17b1804b1-48050679699mr3533925e9.12.1769135803151; 
 Thu, 22 Jan 2026 18:36:43 -0800 (PST)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4804dbbcbddsm7632015e9.15.2026.01.22.18.36.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 18:36:42 -0800 (PST)
To: ltp@lists.linux.it
Date: Fri, 23 Jan 2026 02:36:27 +0000
Message-ID: <20260123023635.29692-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260123023635.29692-1-wegao@suse.com>
References: <20251113015242.799-1-wegao@suse.com>
 <20260123023635.29692-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v5 2/3] ci: Add mount operation for busybox
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Busybox df implementation require mounting (unlike coreutils
implementation). Following error can be found during alpine ci:

runtest TINFO: * shell/tst_format_device.sh
tst_format_device 1 TINFO: Running: tst_format_device.sh
tst_format_device 1 TINFO: Tested kernel: Linux 0ba9f024d6b7 6.11.0-1018-azure #18~24.04.1-Ubuntu SMP Sat Jun 28 04:46:03 UTC 2025 x86_64 Linux
tst_format_device 1 TINFO: Using /tmp/LTP_tst_format_device.XXXXOajpgN as tmpdir (UNKNOWN filesystem)
tst_device.c:98: TINFO: Found free device 0 '/dev/loop0'
tst_format_device 1 TINFO: Formatting ext2 with opts='-b 1024 /dev/loop0 5m'
tst_format_device 1 TINFO: timeout per run is 0h 5m 0s
tst_format_device 1 TPASS: device formatted
df: /dev/loop0: can't find mount point
tst_format_device 2 TFAIL: df /dev/loop0 | grep -q /dev failed unexpectedly
tst_format_device 3 TINFO: AppArmor enabled, this may affect test results
tst_format_device 3 TINFO: it can be disabled with TST_DISABLE_APPARMOR=1 (requires super/root)
tst_format_device 3 TINFO: loaded AppArmor profiles: none

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
Reviewed-by: Li Wang <liwang@redhat.com>
---
 lib/newlib_tests/shell/tst_format_device.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
index dbe4ea9e7..b7366517e 100755
--- a/lib/newlib_tests/shell/tst_format_device.sh
+++ b/lib/newlib_tests/shell/tst_format_device.sh
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0-or-later
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
-TST_FORMAT_DEVICE=1
+TST_MOUNT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_TESTFUNC=test
 TST_CNT=2
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
