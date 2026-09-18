Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B55DC88E75
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 07:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789717981; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=WZEySSMLCwJq8sHma/GLDKc+jSsNRG89ybSKtg0TOCM=;
 b=dPTAFsMoh7gIrD0xEc1e85jwYPpAPmuxaoL6qH6iII1XW47fXhflQdGMeO2gakCUlyZwf
 w+c7YQGdpKIzoHcntd6tIjsU6eKDonTfzbv/5i2hx3djQTk5HxnvfiFPEm5de0HhSuqzsp1
 ywNDYRb+ZQtIwIKvWUQiv0/93VwV4Bo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0906D3E72A8
	for <ltp@archiver.kernel.org>; Fri, 18 Sep 2026 09:53:01 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EA1CA3E7283
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:40 +0200 (CEST)
Received: from mail-wr2-x14.google.com (mail-wr2-x14.google.com
 [IPv6:2a00:1450:4864:30::14])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 49376600B2C
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 09:52:40 +0200 (CEST)
Received: by mail-wr2-x14.google.com with SMTP id
 ffacd0b85a97d-482f633ece3so287171f8f.3
 for <ltp@lists.linux.it>; Fri, 18 Sep 2026 00:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789717960; x=1790322760; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ntqYVvWAhKAi5rYKbtW5xk87knHprlL02CdQG6G7/V0=;
 b=I0iOTrAK+FUSoVWEfT8c4HwxttwP1PTjAgD4mJn2TXU4IwkGahlKqzIQf7Jb+bes8p
 8ce/gM3iFd7vQCRNPGf5xCRSryhNmVkgdPgCHJi7F/Hhxp3zfiIToNQzHlD7YGgBOw56
 ly+rvOMggWpGMnDBz1PcnvnA3XisBN4Z+QXw5rU1jEa6gH/zWCNoVoZihwC5/r8atUIB
 tn5C4kSxm3YmE6N7FniqqSZzeMPCfx1/zM5m1A7Exy6kBwgTOo21SMtUQmOwga2q1W8z
 I27nwID67UR2zZ00YNR13ALY18464P9Wq1LJcasnxiUxaMnJ4tZ77MStFwXjq6V6E23S
 qiAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789717960; x=1790322760;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ntqYVvWAhKAi5rYKbtW5xk87knHprlL02CdQG6G7/V0=;
 b=y68FQLLwE4gEnSDp7hJDZvSJ61IQ+dNyqOOJlV9kb0ybopkUhZUxW4AMdEkx96zr1e
 4RQc/zgNQNpZxmdpRkLzfQpRP6YPyKZoAzD9D/9l8OMuJXgztuQmRY2xCM13/ZAMM9nD
 FMSmOx7wMcmg/jXc4sCb1OWRGll9KKfTT8R2sTyxkNrylucw2XRlISNlrDjfNU8bd/Jx
 VTyJVtxovod0ke3Rwk3kCfmEyKoOgzc5iY4n4usEFNcMZUMKd9nTEldnGF0wwD1H/SDk
 182xeIbp6OcHyC0NTq9ul798oBj58PSsx7+rrzMB5M/E1NetGKJWsD9ShrxqW+X67WHA
 Vfsg==
X-Gm-Message-State: AFuF++noh44FsFUzlxhP4R3+AWm8ZsazidFlBMyUfjCNJORXBZHemZ89
 7eqkIeqXNLRdyuEsJVZqy8Vm5pcfn9vW65hsTN01CGx3aUAVhLOKBkPdhHj2pX+BEYN93nYFt1r
 ZnQs=
X-Gm-Gg: AYBFou3Beuq3asAd239/swucJfTCjYKJSSeVDEtYf1fg4G6SyaUH8KczOgkENjxeYON
 13dEIHuQ5eHrVADLWMtk8Mg6z+owtJrWwn8UzSnGtCptDQGKr6TvOBFzlOUm4ZMrcImFNrOd4c6
 +aBoKKWlSO/FdkgxnzdG/VWL7tjsnNN6AIL1q+n8KUtDwGtzhMDonmcY9sa4MHETiYx1GUuZWzy
 c9gh8hF3KZT2daow9tntYAYtOKpkX+HA83izLOMgIcrAFTBpysnT6ZY0UUD4TWlwzqGjZ8oiuUY
 QeK1KYOdq02OC54/WiG5zugDSH3JMR1Pv40mLFNp76eJ3/JD4COEZskiXn87ibA6kp/0R/8NjFP
 0dSsBRXjhQVIQnXppds6DpZjiBAzU4Es+27pBmf211dwwbIGGBdBY91t73PK6vk2yZvJHWQyFPR
 /ZUdXPPzRcvjsRaYqfdqLoACfBo5NxzTsf4USnIqcYmfK0Gu/ZtA2/QE7+UnNBiSRr59Y5loZc1
 nrdPcEZE3fZYI2Kj/bvPuEVMZ+doJi3ba5CfFY0g/8VjibepxWgXeE=
X-Received: by 2002:a05:6000:5c7:b0:486:e707:42eb with SMTP id
 ffacd0b85a97d-4871e266a28mr1884037f8f.33.1789717959627; 
 Fri, 18 Sep 2026 00:52:39 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-4872008f34dsm2089823f8f.36.2026.09.18.00.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 00:52:39 -0700 (PDT)
To: ltp@lists.linux.it
Date: Fri, 18 Sep 2026 07:52:20 +0000
Message-ID: <20260918075228.21423-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v14 0/3] open16: allow restricted O_CREAT of FIFOs and
 regular files
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

v13->v14:
   * Swapped informal "Level 1/2" descriptions for actual sysctl values 1 and 2.
   * Moved local sysctl macros to the global include/tst_path_defs.h header.
   * Use designated initializers.
   * Flat-nested the child process path by using SAFE_FORK() with an early parent return.
   * Replaced conditional branch logic with the unified TST_EXP_FD_OR_FAIL() macro.
   * Add 8 missing CVE tags associated with the kernel commit.

Wei Gao (3):
  lib/tst_uid: Remove spurious TERRNO from tst_get_free_gid success path
  lib: New library function tst_get_free_uid
  open16: allow restricted O_CREAT of FIFOs and regular files

 include/tst_path_defs.h                   |   2 +
 include/tst_uid.h                         |  14 +++
 lib/tst_uid.c                             |  30 ++++-
 runtest/syscalls                          |   1 +
 testcases/kernel/syscalls/open/.gitignore |   1 +
 testcases/kernel/syscalls/open/open16.c   | 143 ++++++++++++++++++++++
 6 files changed, 190 insertions(+), 1 deletion(-)
 create mode 100644 testcases/kernel/syscalls/open/open16.c

-- 
2.55.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
