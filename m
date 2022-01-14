Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93908C433EF
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 16:16:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E196F3C9556
	for <ltp@archiver.kernel.org>; Fri, 14 Jan 2022 17:16:47 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0C04A3C8DAA
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 17:16:37 +0100 (CET)
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com
 [IPv6:2607:f8b0:4864:20::52d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B9642005C3
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 17:16:36 +0100 (CET)
Received: by mail-pg1-x52d.google.com with SMTP id i8so3127559pgt.13
 for <ltp@lists.linux.it>; Fri, 14 Jan 2022 08:16:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZfO4qdWQQk+YYyXM0b3mY2R1iB9IQFNWj8XYH1iQjec=;
 b=C7EE5EYCy/AfcCuUYd+gDn4ofUBld0bds/Uwf+BKaE62vk4WB0Jtb/lg2Eyqsb5Dlr
 4SEHciBrhLoDDaCYXXsX9l4tn14Z/Lr89LLPSZAizRWfAoDIHNdwC+cQ850XcbhHGVlS
 3NLGah7ZxoLZf2Bty4hNk+ThjFxJ2wz3US+unnkn/X08j8YvIWEQuLCSJAmZNJiACgq8
 2qSpC6ZbEyuGSpcy5Vvs3+xvJHBZrZVBFMAdZnnsGjYyWxeoJviB8BmpaZvoBf2/ieLd
 UgTWgWibxUzuAfEWESZCNJNSOjxP9ReskRubd36fC1pkeAJXpnQZhSrZ3XJ5XW2mI2H8
 1VDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=ZfO4qdWQQk+YYyXM0b3mY2R1iB9IQFNWj8XYH1iQjec=;
 b=qYj4aZf/a9iYyRnO176XV2EeT+jIa16nwqqxqOs9oSw+xQuseBqYr4K5OFYRDUP8tK
 fJCqoAse23mQK6Cg1SAZjtswsQcFdgz7SdzyLSDOse6hAWxTbRr33KBK5udCX7U+sWCE
 5z2t3bNvM+MGC5Ijyy3JcYya77JCRGKHgWfVuZtPhrKjx8mwJ/GC5vzNoYDH6gxfRMyy
 YlWKTlpjr0o8kIgo+EkvuDXxR/DR8hcJqBn8TB7HcfTs07tOn0WXLaLzLo4WU1P3R+ay
 bzD1NbbfWvhdbEQHvygDDcDyiA1x8bC4vIDtzSUZnnFVam9/ALUnGkiWslexRPj60c6p
 L+Rg==
X-Gm-Message-State: AOAM531yAgR8GVpddWNxT0qVH5VBoUuf1fNqkL4+dIJ3ZDhkm6S+GbXI
 k2mfCskdedF3d36iCIU/NAeVLHbDtZ4=
X-Google-Smtp-Source: ABdhPJz3svQyJzMjb8VnEh+YBaW+LL8I5kSDNd54E6Nf9v9uQJ0jr0yRLCoRqLCpUQqY3HLf/fqykA==
X-Received: by 2002:a63:4d17:: with SMTP id a23mr8678895pgb.179.1642176994500; 
 Fri, 14 Jan 2022 08:16:34 -0800 (PST)
Received: from localhost.localdomain ([2405:201:e030:893d:50bf:7ae4:ea69:95d9])
 by smtp.gmail.com with ESMTPSA id k2sm6457908pfc.53.2022.01.14.08.16.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Jan 2022 08:16:34 -0800 (PST)
From: Kushal Chand <kushalkataria5@gmail.com>
To: ltp@lists.linux.it
Date: Fri, 14 Jan 2022 21:46:12 +0530
Message-Id: <20220114161612.206475-1-kushalkataria5@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] Fixes: #776,
 tst_taint prints human readable error messages instead of numerical
 codes
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
Cc: Kushal Chand <kushalkataria5@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This patch prints human readable messages when kernel is tainted instead
of numerical codes.

Git Hub Issue link  - https://github.com/linux-test-project/ltp/issues/776

Signed-off-by: Kushal Chand <kushalkataria5@gmail.com>

---
 lib/tst_taint.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/lib/tst_taint.c b/lib/tst_taint.c
index 49146aacb..049769873 100644
--- a/lib/tst_taint.c
+++ b/lib/tst_taint.c
@@ -8,6 +8,48 @@
 
 static unsigned int taint_mask = -1;
 
+struct pair {
+	const char *name;
+	int val;
+};
+
+#define PAIR(def)[def] = {.name = #def, .val = def},
+
+#define STRPAIR(key, value)[key] = {.name = value, .val = key},
+
+#define PAIR_LOOKUP(pair_arr, idx) do {			      \
+	if (idx < 0 || (size_t)idx >= ARRAY_SIZE(pair_arr) || \
+	    pair_arr[idx].name == NULL)			      \
+		return "???";				      \
+	return pair_arr[idx].name;			      \
+} while (0)
+
+const char *tst_strtaint(int err)
+{
+	static const struct pair taint_pairs[] = {
+		STRPAIR(TST_TAINT_A, "TAINT_A(ACPI table overridden)")
+		STRPAIR(TST_TAINT_B, "TAINT_B(Bad page reference)")
+		STRPAIR(TST_TAINT_C, "TAINT_C(Staging driver loaded)")
+		STRPAIR(TST_TAINT_D, "TAINT_D(OOPS/BUG)")
+		STRPAIR(TST_TAINT_E, "TAINT_E(Unsigned module loaded)")
+		STRPAIR(TST_TAINT_F, "TAINT_F(Module force loaded)")
+		STRPAIR(TST_TAINT_G, "TAINT_G(Propriety module loaded)")
+		STRPAIR(TST_TAINT_I, "TAINT_I(Workaround BIOS/FW bug)")
+		STRPAIR(TST_TAINT_K, "TAINT_K(Live patched)")
+		STRPAIR(TST_TAINT_L, "TAINT_L(Soft lock up occured)")
+		STRPAIR(TST_TAINT_M, "TAINT_M(Machine check exception)")
+		STRPAIR(TST_TAINT_O, "TAINT_O(Out of tree module loaded)")
+		STRPAIR(TST_TAINT_R, "TAINT_R(Module force unloaded)")
+		STRPAIR(TST_TAINT_S, "TAINT_S(Running on out of spec system)")
+		STRPAIR(TST_TAINT_T, "TAINT_T(Built with struct randomization)")
+		STRPAIR(TST_TAINT_U, "TAINT_U(User request)")
+		STRPAIR(TST_TAINT_W, "TAINT_W(Warning)")
+		STRPAIR(TST_TAINT_X, "TAINT_X(Auxilary)")
+	};
+
+	PAIR_LOOKUP(taint_pairs, err);
+}
+
 static unsigned int tst_taint_read(void)
 {
 	unsigned int val;
@@ -90,7 +132,8 @@ void tst_taint_init(unsigned int mask)
 	}
 
 	if ((taint & taint_mask) != 0)
-		tst_brk(TBROK, "Kernel is already tainted: %u", taint);
+		tst_brk(TBROK, "Kernel is already tainted: %s",
+			tst_strtaint(taint));
 }
 
 
-- 
2.25.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
