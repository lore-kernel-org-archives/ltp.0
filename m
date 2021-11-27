Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64EDC433EF
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 00:04:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53FDF3C8DD7
	for <ltp@archiver.kernel.org>; Sat, 27 Nov 2021 01:04:41 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D0923C6B60
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:31 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id F1A961400747
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 01:04:30 +0100 (CET)
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 71A1C40019
 for <ltp@lists.linux.it>; Sat, 27 Nov 2021 00:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1637971470;
 bh=G8WGQsTaSLW66PLXfpnrhz5YeS0Bli2ura2ggYV6H5U=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=KZ/Y031sgxjMGbt4nC6iVZ5sBNF+pgeK7pnfcuiP0M+/vcR6Bd7PhEdh4Wy8ZRH/p
 iaf5uTxo0YnCkfDBInxT+gnH0hguL+8Nq7JtcsP+rdXS0P/czBeg/IwceqNt4TFWPX
 BSFy0N0p8ym9ChfvfGQ5A02cQba926ixNi1UTBXCSGHaBcg7+BQ2ctU1ErouIzTdg8
 j9l5iQMtwtYwG49ZjD8qzpGLaZ+53E8Z0QK6w9Uy0vm5ryYj21QizuCHyHLiGsSAU+
 WLsTIJ47pY+O1mo/2TA7OY+Bc032dTjWA/HojfQWV+cYZjTCkS1Yymfhp01BHULuaZ
 DOw8zAvZn2MrA==
Received: by mail-pg1-f197.google.com with SMTP id
 r35-20020a635163000000b0032513121db6so1245921pgl.10
 for <ltp@lists.linux.it>; Fri, 26 Nov 2021 16:04:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=G8WGQsTaSLW66PLXfpnrhz5YeS0Bli2ura2ggYV6H5U=;
 b=XrQijRqolc+x0Sqnf4H/QQWgT3xRjo1oHuidMZ7D1XCJFKmTszWMiVOc7Nbe5LYFtz
 Qx90INudTz/AHiG2HlCDhytqSvDNIvzy7BtusOBEEOcRQSlILFsuT0K5QO/pFLgU2YNS
 y9wkRlUGW8gGkY0nqsuPNri4zdxCkZ1gZdMr7NtWLvhMn9skav2adWO3Xq7ORQRDRVHl
 W/erLJs09kJEZyOKS+RocbxuLwB+4Y4Gr6sqLhYivUJNDDE9x9+B+79Qeue+cVMWU7rl
 kNvg+e+Lk9cUFb1BESMm/Q3B213npLIo1zPdZUw0+qnkxgOX1OqlKYZQzC25JBF4Pybf
 3vsg==
X-Gm-Message-State: AOAM532aHjzd/Ywk9ZZDFV0BNz9obuTLbXcC6NdyoXixiWYotWzyFAdT
 2H7zowbS+r9tJmAaotYX8SiUrOff0Qszo19rxBceX+LePRLq0Q3hBlRCgbSl0Zfc3h4PYAshJe3
 yZt5SPG+u5QD8Kt/nhsPd82Byt0pr
X-Received: by 2002:a17:903:1c5:b0:141:fbe2:56c1 with SMTP id
 e5-20020a17090301c500b00141fbe256c1mr40701339plh.52.1637971468799; 
 Fri, 26 Nov 2021 16:04:28 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyIvUIuXmqyIZrmkFQSk1bEBMsbCJfdSthzV+OL/8MskdXP6B2SQeJdE6Ar+ym6hpBx76+0yQ==
X-Received: by 2002:a17:903:1c5:b0:141:fbe2:56c1 with SMTP id
 e5-20020a17090301c500b00141fbe256c1mr40701304plh.52.1637971468450; 
 Fri, 26 Nov 2021 16:04:28 -0800 (PST)
Received: from luke-ubuntu.. (cpe-66-27-118-101.san.res.rr.com.
 [66.27.118.101])
 by smtp.gmail.com with ESMTPSA id d3sm8598125pfv.57.2021.11.26.16.04.27
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Nov 2021 16:04:28 -0800 (PST)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it
Date: Fri, 26 Nov 2021 16:04:23 -0800
Message-Id: <519f3399ef3071fff4abe3f36b725cb4869fa955.1637970912.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1637970912.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/4] controllers/memcg: Skip functional tests when
 mounted under cgroup2 hierarchy
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

Skip all of the tests when the memory controller is mounted under the
cgroup2 hierarchy due to the tests mainly testing features related to
the cgroup1 memory controller interface.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
 .../kernel/controllers/memcg/functional/memcg_lib.sh      | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
index 1b76b6597..38e494ea6 100755
--- a/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
+++ b/testcases/kernel/controllers/memcg/functional/memcg_lib.sh
@@ -104,6 +104,14 @@ memcg_setup()
 		tst_brk TCONF "Either kernel does not support Memory Resource Controller or feature not enabled"
 	fi
 
+	# Most of the tests here are testing specific parts of the cgroup v1 memory interface that is
+	# not present for cgroup2, so if it is already mounted on a cgroup2 hierarchy we should skip
+	# the test.
+	cgroup_mount_point=$(grep -w cgroup2 /proc/mounts | cut -f 2 | cut -d " " -f2)
+	if grep -q memory "$cgroup_mount_point"/cgroup.controllers; then
+		tst_brk TCONF "memory controller mounted on cgroup v2 hierarchy, skipping test."
+	fi
+
 	ROD mkdir /dev/memcg
 	ROD mount -t cgroup -omemory memcg /dev/memcg
 
-- 
2.32.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
