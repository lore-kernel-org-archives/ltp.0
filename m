Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBE87C43334
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 20:54:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 300FD3C9F90
	for <ltp@archiver.kernel.org>; Thu, 21 Jul 2022 22:54:48 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED7483C9FEC
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:18 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 911DF1400DA9
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 22:53:18 +0200 (CEST)
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 0C32C3F12A
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 20:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1658436798;
 bh=1o2So7Wti/H8GVmcz3M8tuSB/NuigsOdIkkLL1v0rQk=;
 h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
 MIME-Version;
 b=uXG25AnH6MSWsfKU61xZ3pouAUXqKOhLbqKuBFZ2teCSrGrawpx3on6wCWJKtixuO
 uvsY2vu27qDk3QV1nEMFCwLMC97aJ+sCiysP3KD433jxZT1iECpXhM53LVaKcxv8j/
 6sU+XYpS0/M3aZaYRFZNdIokybCID7siQU1jB65mlA5d3C1PHFD1rTteX6aVNFLbRZ
 /EpfuuvLcJVjW/SWTg854QZDfDCqjO6nNfbveH4k8LA0fwYvsS2LJo2Gncba7sZvam
 5pv6rcZvlAN3gHN4PxRl1ZDVuyAaxiJ0CxmwK3gsikAB4bHi5lHtg7Qn0fOGBU7ksH
 MhCIc5TlqFChQ==
Received: by mail-pl1-f200.google.com with SMTP id
 e11-20020a17090301cb00b0016c3375abd3so1655738plh.3
 for <ltp@lists.linux.it>; Thu, 21 Jul 2022 13:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=1o2So7Wti/H8GVmcz3M8tuSB/NuigsOdIkkLL1v0rQk=;
 b=peXd+a2ssQq+2l0WZi3ZKipvQ4v+Axz5UH6QlyF/lz+ebSmTaS4TZ7/Is4R3nq0/cI
 zDWGFvldQ5DfKD6pAD9mNXeWJNcK47P7zyxd/HgKtfu2Utu06F5gDUr7x1JpVRpEio8B
 5lusFdVYHtgVZuFfW9TxVnXsogZnswTBAjMJmcxvdna0dscijVM3yhyMvOvKinOi+YvR
 wh35N3yHxO/Cvg97rPellmBDWSQC34RvBkn1Hzlg+7XA/cI2oDej9oJnVG3L5JgPGs8y
 JlWLkUusv4oaCglMB/ZQp/m9sbfqQsIUVQu3wG023RvvSbL1ndgJRrtK+WiWjWnGVBQc
 gbOA==
X-Gm-Message-State: AJIora+bYezgCguVe7VHNUXkBWPXA+/0iecKYuDTTowFg5wanI3py2fX
 zdOCrBAEuaPNX+gw2MDH2JbT807uvCPYzoz4wo8/yyz866Vf/YgFh7i7rBiF7ODQWJYbPPapJTP
 CBVnta+MeiH398A/WyY1Kpo8BxxUh
X-Received: by 2002:a17:902:d2d1:b0:16c:43fb:a363 with SMTP id
 n17-20020a170902d2d100b0016c43fba363mr154646plc.8.1658436797361; 
 Thu, 21 Jul 2022 13:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1venpu5nqymIZyC9uST/QiLEZa39V7w2/AAOGW+LdScQ7nI3jbByAT0uINrCDswgO3sYnlmeg==
X-Received: by 2002:a17:902:d2d1:b0:16c:43fb:a363 with SMTP id
 n17-20020a170902d2d100b0016c43fba363mr154627plc.8.1658436796955; 
 Thu, 21 Jul 2022 13:53:16 -0700 (PDT)
Received: from luke-ubuntu.buildd (cpe-75-80-146-43.san.res.rr.com.
 [75.80.146.43]) by smtp.gmail.com with ESMTPSA id
 c6-20020a656746000000b0041a4d5e7e5fsm1916364pgu.47.2022.07.21.13.53.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Jul 2022 13:53:16 -0700 (PDT)
From: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
To: ltp@lists.linux.it, rpalethorpe@suse.de, liwang@redhat.com, pvorel@suse.cz,
 chrubis@suse.cz
Date: Thu, 21 Jul 2022 13:52:18 -0700
Message-Id: <c828808c8970db1ffac3dc2c94266eee04872b65.1658433280.git.luke.nowakowskikrijger@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
References: <cover.1658433280.git.luke.nowakowskikrijger@canonical.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 08/18] API/cgroup: refuse to mount blkio when io
 controller is mounted
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

Mounting the v1 blkio controller while v2 io controller is mounted
unmounts the io controller, triggering a tst_brk that the number of
controller has gone down.

Because these controllers don't seem to be compatible, tst_res with
TCONF and report that we refused to mount the blkio controller while the
io controller is mounted.

Signed-off-by: Luke Nowakowski-Krijger <luke.nowakowskikrijger@canonical.com>
---
v2: Change from tst_brk to tst_res TCONF and return

 lib/tst_cgroup.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
index 16cb233a8..d29279838 100644
--- a/lib/tst_cgroup.c
+++ b/lib/tst_cgroup.c
@@ -716,6 +716,12 @@ static void cgroup_mount_v1(struct cgroup_ctrl *const ctrl)
 	char mnt_path[PATH_MAX];
 	int made_dir = 0;
 
+	if (ctrl->ctrl_indx == CTRL_BLKIO && controllers[CTRL_IO].ctrl_root) {
+		tst_res(TCONF,
+			"IO controller found on V2 root, skipping blkio mount that would unmount IO controller");
+		return;
+	}
+
 	sprintf(mnt_path, "%s%s", cgroup_mount_ltp_prefix, ctrl->ctrl_name);
 
 	if (!mkdir(mnt_path, 0777)) {
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
