Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10E24CCF9F8
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 01:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1761960273; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=tS4+3CkixOBM1Pta+hQt99ynQJAykJCIZbiqjzGrNlM=;
 b=NGAWeyhdPYgjoIw7Mt1Fky78pttfgu9fqcpNPvthhIgXVLrm4mDiq4/MuUzPsgtUlxNvk
 QLFlRgRkuLDAisUHSUCcRUiOXjDXRiJtFbzQwNSwQ4cd+DR/bVVwVv/XfEF9qaFCuxej8zs
 fu8qXyjdxaDc5GZ1sjOA1Jj+saxLaIQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 842393CCF2B
	for <ltp@archiver.kernel.org>; Sat,  1 Nov 2025 02:24:33 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B6613CAD2A
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 02:23:29 +0100 (CET)
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com
 [IPv6:2a00:1450:4864:20::634])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9F4FB200089
 for <ltp@lists.linux.it>; Sat,  1 Nov 2025 02:23:28 +0100 (CET)
Received: by mail-ej1-x634.google.com with SMTP id
 a640c23a62f3a-b3b27b50090so494776466b.0
 for <ltp@lists.linux.it>; Fri, 31 Oct 2025 18:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1761960208; x=1762565008; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fz6JBwHjj8Ueme8oTmo0zRY6IVNHAAHyBsdPKb9R9sk=;
 b=Zrkq4egvqVszi4L14OktjuoH2LZczXdbubAFaTLgu5FBABnvWKBLL5WG3AxYlJekm/
 NCHd2dZP1fiYwQplYrJxwJruH+NWMpWY4obr54WE8r73ZYtWQdXyO7+hI8VJSPpdM6r6
 mDNyxGbxqkr6dauuE1EPFcbsUOwjDEFflDqEb3QBNMgd2l0Mav4lPIKAqGlNd6+F8ICD
 7CCjqRQbziLMYmmrYONYKdFD5CJEncIVuVtIVh+wACPxMGbKJshkQpeVJ6nxZH3XPLJi
 oLc3wSlyslfq0bEHpVWvtXa/BcSiZ5G8Siytgbuf34AAfc9FNGoxPtgYSzZk5VUKmx1c
 qPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761960208; x=1762565008;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fz6JBwHjj8Ueme8oTmo0zRY6IVNHAAHyBsdPKb9R9sk=;
 b=oz17hxpZH+afWNMgz1Cg7OGoYRKbgv/zV4hR3HkNDhZxc9uvlh/0BsNJpYBeo+wLXW
 dJP0Ymzi9zZCjaRdvT2VvyWWg7xIbPxEtC11uHK61CgJ5iFn3BO9bReaL/N7DEFyN5tY
 lb4uznTACvr9uzed8KlIN6nH3TGYcskD1TaAtTkWwkf3KqYqQu+jxYVIdQ8Dlco90PEs
 XcSK/X0URn/TQhd9R/+k2tzzeq+W61H7Z492/3xAeB3fTVGDB3UR9q1ND8cOWCsICkou
 kAmkb2HdO/t442qvDqIQfxbZRW9ZP7+bSJhNy46bNz2BCDkXGve6z6EyYapP3luG7JNs
 jJ3w==
X-Gm-Message-State: AOJu0Yz09dNWmGdwK3ar3lcTzctsK3aOa5C/sqPpNACWD/bvQDYMhrOS
 gYsPlyx9K/fXO7YCR8381IYOUTvtdAgMP1UYBpHF73DMtUVM2tImDEFalOt09nQMRfuAQ4jd2mo
 bqIk=
X-Gm-Gg: ASbGnctec6GRR0wEgUw+HYec0aHfd4uFzBzn/c3IOKC3lzYfXMUgOEgLfqKxhWJ3UPE
 hM37AGvbTBjrdeDwcmIwY+XH6dpnEOuIBca0GI6se2LM51Kuhvq5V4CoEDAING0obxbDT6STfsh
 LG0TrXyyGEfYb8l0XUmYql5HDUgpk8WlGntz3Ep3FApE/JxA08l9Um18tLiYtonPlJLfD7wEM+q
 kV/wN4pDhv2yNBJyz6yeW3vjN3xJGg8iJFBJxCRugSUB8ilAL6Ine0jM2FZ10VWEW2l9/umTfda
 QWspuXrSVbTaXksJFkPn/cneoBmQl+BXY3NhV6d7hIOi+pGwc1bzS9eLs6vZ6ECgz5ETYsm0WU9
 u+VYxl47f0ssUXDSi0j4xVIrg2XyfhqdxjvNi1BVPlGuuye7+EbTOVGh1sHvUjIFJTgt5AkkbS9
 I=
X-Google-Smtp-Source: AGHT+IG6yQ8H5UbkMkHkLl3V1BA2V6WpNkkdp++LU3VHJrCg9xfZE+f4/JNescrwiqv0BBdwBOqpvg==
X-Received: by 2002:a17:907:1c17:b0:b6d:7d46:52b2 with SMTP id
 a640c23a62f3a-b707013c9bamr552595866b.15.1761960207850; 
 Fri, 31 Oct 2025 18:23:27 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 a640c23a62f3a-b7077d18d59sm316451366b.75.2025.10.31.18.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Oct 2025 18:23:27 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sat,  1 Nov 2025 01:20:22 +0000
Message-ID: <20251101012320.24972-3-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251101012320.24972-1-wegao@suse.com>
References: <20250924084223.20597-1-wegao@suse.com>
 <20251101012320.24972-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] tst_format_device.sh: Add e2fsprogs package
 for CI test
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

For alpine platform we should mount /dev/loop device before df check.
Otherwise following error will be triggered

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
---
 ci/alpine.sh                                | 1 +
 ci/debian.sh                                | 1 +
 ci/fedora.sh                                | 1 +
 ci/tumbleweed.sh                            | 1 +
 lib/newlib_tests/shell/tst_format_device.sh | 1 +
 5 files changed, 5 insertions(+)

diff --git a/ci/alpine.sh b/ci/alpine.sh
index 254f4aaec..f3a1bf528 100755
--- a/ci/alpine.sh
+++ b/ci/alpine.sh
@@ -25,6 +25,7 @@ apk add \
 	musl-dev \
 	numactl-dev \
 	openssl-dev \
+	e2fsprogs-extra \
 	pkgconfig
 
 cat /etc/os-release
diff --git a/ci/debian.sh b/ci/debian.sh
index 0445c92ec..767c9b985 100755
--- a/ci/debian.sh
+++ b/ci/debian.sh
@@ -33,6 +33,7 @@ pkg_minimal="
 	linux-libc-dev
 	lsb-release
 	pkg-config
+	e2fsprogs
 "
 
 pkg_nonessential="
diff --git a/ci/fedora.sh b/ci/fedora.sh
index f57806ebf..f4482a1da 100755
--- a/ci/fedora.sh
+++ b/ci/fedora.sh
@@ -26,6 +26,7 @@ $yum \
 	libtirpc \
 	libtirpc-devel \
 	pkg-config \
+	e2fsprogs \
 	redhat-lsb-core
 
 # CentOS 8 fixes
diff --git a/ci/tumbleweed.sh b/ci/tumbleweed.sh
index 8a30b02c2..8f23229df 100755
--- a/ci/tumbleweed.sh
+++ b/ci/tumbleweed.sh
@@ -30,6 +30,7 @@ while [ $i != 0 ]; do
 		libtirpc-devel \
 		linux-glibc-devel \
 		lsb-release \
+		e2fsprogs \
 		pkg-config
 
 	ret=$?
diff --git a/lib/newlib_tests/shell/tst_format_device.sh b/lib/newlib_tests/shell/tst_format_device.sh
index dbe4ea9e7..bd4aa2ed9 100755
--- a/lib/newlib_tests/shell/tst_format_device.sh
+++ b/lib/newlib_tests/shell/tst_format_device.sh
@@ -3,6 +3,7 @@
 # Copyright (c) 2022 Petr Vorel <pvorel@suse.cz>
 
 TST_FORMAT_DEVICE=1
+TST_MOUNT_DEVICE=1
 TST_NEEDS_ROOT=1
 TST_TESTFUNC=test
 TST_CNT=2
-- 
2.51.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
