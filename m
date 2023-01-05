Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54C4DC3DA7A
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 09:06:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 309143CB621
	for <ltp@archiver.kernel.org>; Fri,  6 Jan 2023 10:06:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 557C63C81C8
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 15:26:10 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CF3911A00990
 for <ltp@lists.linux.it>; Thu,  5 Jan 2023 15:26:09 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id s9so4281297wru.13
 for <ltp@lists.linux.it>; Thu, 05 Jan 2023 06:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=SPKIOaOccfRsWgHi2TMA9uQmKIjRDvnlOd9qMcuRzFA=;
 b=gF8cObA+0dukyH7u48Cm4FSF45ypvufN2IZkNsysEuXLc+ur0XBQvRK52mR2CoPJ+U
 aGsELH0NA+nS/GfbsnOsHmwH94P1UFB3Wt9Zgx7iI6Z+o/443574HoHLxYUd2hA8RgJz
 DMgNE3D1NgLL3Zc+zCcYHZXxNSW0aJ6CnCi+kr5rPk++4RISQUzibuIep+9FKo40tOHk
 rAB2Wv9L9XQJO0LQRECu79H7Xvm4SSkFW5BpzJbgMfbyK26iptWqYY7mewwZCEP7Ctv+
 lkV+1TaTuoZ7+7iA/D0Qo50ZFdXW7pQbqOz37H1Ol2Frab/2DsKfxEYSagXuOb9XknSC
 ICOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SPKIOaOccfRsWgHi2TMA9uQmKIjRDvnlOd9qMcuRzFA=;
 b=568kvZByyT+7UHMwzUFywQ/wiBA1TvWvWQuk6aP41wriFlDayiydDew4rcMBdBMTzv
 78ceD3le9+5VO5t/uwY/lk4IXJ9gAmhq3FXkpTUStjalCl1ZGSd0WmrANT3Y10o14HJ+
 aNaYf95PwTpRLMbLeExN8gVd8t8BPLNy5dwXgeL9ohvq/IW5fPO08B+wpWCsYWCQaKoa
 4j+7L4T0ieFi+9b7rcCjeoVhQ75Q/z/ejmPihMxgND/fCY9iphI7VXTXl8P8pFCzN2Wg
 4MWSEy65QSKLdKtu3DpYODQjFxCTrimd/hxgxe9kFaeLapPF04/5KOgZ5AC43nQZKmqZ
 K0TQ==
X-Gm-Message-State: AFqh2kpeEPhz0NxF7LJVdpRiQ9PWzdODCMIsRvNM5aNV6CsLLbyLiAT3
 sjQ2UXVDEi9XGKzD/wPaej1Qvyc2xJnr6A==
X-Google-Smtp-Source: AMrXdXtlz4D+nTR2mxX4ZPOGIKN/LMnIaM1gzlSBBs/MsbjNeZxREJd54V7MzE/dN2ewCukPy+JPrw==
X-Received: by 2002:a5d:6449:0:b0:285:5249:1178 with SMTP id
 d9-20020a5d6449000000b0028552491178mr19987741wrw.66.1672928769403; 
 Thu, 05 Jan 2023 06:26:09 -0800 (PST)
Received: from aa.suse.de ([223.72.84.126]) by smtp.gmail.com with ESMTPSA id
 i1-20020adfb641000000b002425787c5easm37003829wre.96.2023.01.05.06.26.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Jan 2023 06:26:08 -0800 (PST)
From: coolgw <coolgw1126@gmail.com>
X-Google-Original-From: coolgw <wegao@suse.com>
To: ltp@lists.linux.it
Date: Thu,  5 Jan 2023 09:25:59 -0500
Message-Id: <20230105142559.20174-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 06 Jan 2023 10:06:02 +0100
Subject: [LTP] [PATCH v2] Add containers/share to PATH when call
 init_ltp_netspace
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

When run single test case use command such as:
LTP_SHELL_API_TESTS=shell/net/tst_rhost_run.sh make test-shell
Error msg such as "ns_create: command not found" will popup, so
need update PATH before call ns_create etc..

Signed-off-by: WEI GAO <wegao@suse.com>
---
 testcases/lib/tst_net.sh | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/testcases/lib/tst_net.sh b/testcases/lib/tst_net.sh
index ceb45c98d..cd370e26f 100644
--- a/testcases/lib/tst_net.sh
+++ b/testcases/lib/tst_net.sh
@@ -128,10 +128,13 @@ tst_net_require_ipv6()
 
 init_ltp_netspace()
 {
+	PATH="$PWD/../../testcases/kernel/containers/share/:$PATH"
+	tst_res TINFO "PATH='$PATH'"
+
 	local pid
 
 	if [ ! -f /var/run/netns/ltp_ns -a -z "$LTP_NETNS" ]; then
-		tst_require_cmds ip
+		tst_require_cmds ip ns_create ns_exec ns_ifmov
 		tst_require_root
 
 		tst_require_drivers veth
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
