Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECD75C43458
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 01:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783301896; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=8sinEocOoowGZjM7wGrtvO/w+rPmYYH29aVH4OO1Lkw=;
 b=RkXC8NnjnX4FZJEEd3CEPTLyaHRXiBDX8fOJMpY9Le/e4WWBLWFFEXwCOxbGvT4FoA8Vl
 v8ZBK0R8aEZoe1F4mGN7k6skw+ktameGo+zxjpmdeDpzjhksf3HTGhRxBOY6nzFHiQydZhR
 Hyg9rD4HxaMRBo3ZrWb4kP4BPLI0PMQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 08AFB3E4A3E
	for <ltp@archiver.kernel.org>; Mon,  6 Jul 2026 03:38:16 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0BC913CEDDE
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 03:37:56 +0200 (CEST)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 4C9CB6000E6
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 03:37:56 +0200 (CEST)
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 89CF93F0B5
 for <ltp@lists.linux.it>; Mon,  6 Jul 2026 01:37:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1783301875;
 bh=pP2p6dcgfUkQi16fkI0AAAONPn47MApZ9+hdrBr9UU8=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=hmTXEJaaaszvZw/Tbi4tdtOq13nxHVF12HMiJK/7UORylWJe0XF60PZjN8CPWBNhP
 7oi8n3FrmnVEzB9mrWlscowhSF4tHURPjfVFQx4a1z12CqQKiu4IY1B8aQwoMPPxay
 SVXJf8kUe70GKurU8tHXqVRjSJQ4LUgCszGE0tAoh3S4kvCVkr/nyCJi7iSs0NIEN7
 uppJohYaoRxfRjagY+DPFveL90SfSLrt2vAfTFRaFnmka2Y5tY82HJBuulAwN1ZEek
 efoWXY5jahMC6c9sefoizv2ha453LrT/9PQgdNh2nj04qCd2SMid2PuSFaZtHWUeFO
 Me6D6lnHR3CT5A1WSpyIi8c3ltDaM+jOna17cVO38vuhCW6mhefg/AZLJupV2H6Z+3
 rREDFbVuFxTWyd0cIBhcBNK4Vpy2CJej1Y9iA0S4Qjlin4+788CcGPWHaZVQ9GpJs5
 v9OCnq5HzZgVZuHu063xzkhl64siFY/hKt0c723qBneIjVUL0FhqZXFOTIF5Y9HGkZ
 u2dSCyjBIy1IlbqKSxlLtNw+d4YCHgYgWNQMsZlm9UWrfNhy78d+YZ7GqpgXkEJQD9
 PmM07dxuU1XQLFhKj9JI/2264g+yah3YmmCkurcqk2ZB4xMCUKgZpOm8Z92zDs4egC
 L8AgQJcszdSssdmI7b+hnMo8=
Received: by mail-pf1-f199.google.com with SMTP id
 d2e1a72fcca58-8479cc04d8fso4150626b3a.2
 for <ltp@lists.linux.it>; Sun, 05 Jul 2026 18:37:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783301874; x=1783906674;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=pP2p6dcgfUkQi16fkI0AAAONPn47MApZ9+hdrBr9UU8=;
 b=H23j+ITiCAqyCyFCEtMI9+aHbKnrRaZUbtLo/VgWdUmvNG2PvV7sSuKeIJt8qqjGD0
 4GLWnq+sm3SUDJ/x4WsvPjz7f61RaSXDljypyQ5tC43bnzCM3rAOcuGTa9Sv9OW6XYWy
 AV884JriSuF1+TTO8WHM2bo5WzISo17iL7np3BvVbuogqWc/bOBXERXZdG8+7Oyxm8jl
 XNkiKFi5kzQjji6aBabYkKFOGB03p6zB0iv6oTYrClg3QZm46x9yuM096RCv/wvWhTVs
 Y+mVBospcFVF6H2GAvngpte9FxXBg1rqkzh9RbUGGYPZQil1DyvexJH17Z7W6Ds0oSod
 Isaw==
X-Gm-Message-State: AOJu0Yw4SyFjOOquqeCyc9dBoUPWEHFwJD64Pfm7wAyIWg9zlPjpqgQB
 dywnG+DezZw4ZBnrC+0B981EgDrN90SNIzPrPtmkCKn7y8pXF4+EUcWfiMTzTBoVoOZI964FCtX
 1MbZY3Hi74F/VZvgVmRqMv+9DeBPjO6ZnAfabaMPz+PQE1mxm/tYbFqnfpLg0gEedtzpRTmTA/6
 l4
X-Gm-Gg: AfdE7cmUB9L5+bcr+JYsMpufBEMs25Kq13iw5RVQ2dLFh4rVsPqcnPKuHrNLhdOEabg
 HRtHPoEcavFr3uTFWk4Qyd8Khq9u+V7GhwLn1kbJ+7Nyr+AUjJKSDFww9ev4mw/rW72TZW0qXae
 H+sM1CLmJn11DVhGO08b6/SDpXM+HLsFblMpc7oHfn559s2KsyORBwQiD3g75rHvCxkJjxjRY5y
 jaMy8PhNpfzXH0ptMmunyUhNSYm636/vwzGdC6GnhRDx9kBCDU9Xc8CvoMBgo9lifC8s7SD92z8
 bmC1skybxXgk7ti1gXbbx9GIIhuVGiiGIqvl6EufC5v8HMQkDQq5dXD3KIMD+ltQH0y8+nYgU1q
 kuSfh0LHSbUKBkkASZUh/cc9p48RmOSg8AZ3fkrb+TXiZF6k4Bqg+
X-Received: by 2002:a05:6a00:2e1d:b0:842:57e8:1bdb with SMTP id
 d2e1a72fcca58-847f6dd4b06mr7307853b3a.20.1783301873074; 
 Sun, 05 Jul 2026 18:37:53 -0700 (PDT)
X-Received: by 2002:a05:6a00:2e1d:b0:842:57e8:1bdb with SMTP id
 d2e1a72fcca58-847f6dd4b06mr7307277b3a.20.1783301842153; 
 Sun, 05 Jul 2026 18:37:22 -0700 (PDT)
Received: from canonical.com (118-163-61-247.hinet-ip.hinet.net.
 [118.163.61.247]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b96c04sm2815597b3a.22.2026.07.05.18.37.21
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 18:37:21 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon,  6 Jul 2026 09:37:19 +0800
Message-ID: <20260706013720.450291-1-ivan.hu@canonical.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] landlock04: Skip variants unsupported by the running
 Landlock ABI
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
From: Ivan Hu via ltp <ltp@lists.linux.it>
Reply-To: Ivan Hu <ivan.hu@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The LANDLOCK_ACCESS_FS_TRUNCATE access right is only available from
Landlock ABI v3 (kernel v6.2, commit b9f5ce27c8f8 "landlock: Support
file truncation"). On older kernels (e.g. those exposing ABI v1) setup()
passed the variant's access right, including LANDLOCK_ACCESS_FS_TRUNCATE,
directly to landlock_add_rule(), which failed with EINVAL and broke the
test:

  landlock04.c: TBROK: landlock_add_rule(8, 1, ..., 0): EINVAL (22)

tester_get_all_fs_rules() already masks the rule set according to the
running kernel's Landlock ABI. Use it in setup() to detect when a variant
requires an unsupported access right and skip it with TCONF instead of
breaking.

Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
---
 testcases/kernel/syscalls/landlock/landlock04.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/landlock/landlock04.c b/testcases/kernel/syscalls/landlock/landlock04.c
index 737fdbf24..86dc19994 100644
--- a/testcases/kernel/syscalls/landlock/landlock04.c
+++ b/testcases/kernel/syscalls/landlock/landlock04.c
@@ -143,12 +143,26 @@ static void enable_exec_libs(const int ruleset_fd)
 static void setup(void)
 {
 	struct tvariant variant = tvariants[tst_variant];
+	int supported_rules;
 
 	verify_landlock_is_enabled();
 
 	tst_res(TINFO, "Testing %s", variant.desc);
 
-	ruleset_attr->handled_access_fs = tester_get_all_fs_rules();
+	supported_rules = tester_get_all_fs_rules();
+
+	/* Some access rights are only available from a given Landlock ABI
+	 * version (e.g. LANDLOCK_ACCESS_FS_TRUNCATE needs ABI >= 3). Skip the
+	 * variant when the running kernel doesn't support the tested right,
+	 * otherwise landlock_add_rule() fails with EINVAL.
+	 */
+	if (variant.access & ~supported_rules) {
+		tst_brk(TCONF,
+			"%s is not supported by the current Landlock ABI",
+			variant.desc);
+	}
+
+	ruleset_attr->handled_access_fs = supported_rules;
 
 	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(
 		ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1), 0);
-- 
2.53.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
