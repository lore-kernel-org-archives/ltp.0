Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40722D116F3
	for <ltp@archiver.kernel.org>; Wed,  3 Dec 2025 08:13:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764749598; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=amv8Dh/OMjiXQNOEOTbFvDQFPT/WGPjy63hJdCeSSN8=;
 b=SEZZqtUNBLQX+UleI7YuR3vMPDPq2bbkVqklOMDN2ruyQcdNypD+3OuRiwMZVUqvJQ88T
 eW8vLC1dCqIxnKaC5ScgVlX5u1uinMaZYUYavoluxWzCAdVMA7tZL56Q4N6AXVzywREx/Lb
 bsMRgzWy69Bm52BfwNxqzb1zW80r9O8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F24FF3CEB95
	for <ltp@archiver.kernel.org>; Wed,  3 Dec 2025 09:13:17 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8707B3C00CF
 for <ltp@lists.linux.it>; Wed,  3 Dec 2025 09:12:57 +0100 (CET)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 018E21400E0C
 for <ltp@lists.linux.it>; Wed,  3 Dec 2025 09:12:56 +0100 (CET)
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id CFA873F857
 for <ltp@lists.linux.it>; Wed,  3 Dec 2025 08:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1764749574;
 bh=LEO3Kwl9EOqsIYhtMdkGwnfeH6DMVojvueM2ZcxPgoQ=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=Q7HNaU1UozYVmvGzEoNI3k77Vxsrs1O7jBwp4oO0T3L0vYl/v8iJ8zPSEddBif17K
 3UiSoa/3x4VN6i1ZeaIb4VTLRPFwMacp//vVergcrx83a+CvxAoa7GyP1HlQdVsIV0
 jWsWwGWlWq9RRBZvswEEMwCk4IxipavjwSgjY/k/rEZwiVBfU7RvlsMh/Ot1OcQ0Fc
 KL/OoVKaTCBE7ofVv/Ybmp7ec5uTPOdy59nZNwukBlmqdyoobXb5rWFgngt6YbL5oq
 wdIVnChszsEzZSFW9CElhydKFWVF8QpJg7YRsqlRe/hzkXZZjOjEReonjzgHtiUo+v
 q+cR73a1U+njeIAyBw0Qce5eWnQuf7Vfvx1vwwR7Qg1PedUpuZImWiag1U/ABEEkQB
 wMuS8ykXr46n5AUZis8SBlq4HPGnFZT0CGw4qZrFZVmZVO9CUPZwWQetIKqG4vS9dQ
 1ZFgU0mF9pu3RDvf7sUkdB5hetX1cFDSgQStfLFVbQi97FyueHL3JTePpz9uEfh0qO
 bSlKetJIJ0oiJ6bn3rwCi6qOP8HEauG87sY68FQBL82Qu2BmIGTVy0coPwnidy8+Uo
 U7ImdxCnu+BFuw44svekNrkH6qaIrOH7bd/QwDc2QGrdxnuLgaR/bkIjRURqdRNRB1
 VUPOud250ByapCNzYZJX2HW8=
Received: by mail-pl1-f198.google.com with SMTP id
 d9443c01a7336-29806c42760so199935995ad.2
 for <ltp@lists.linux.it>; Wed, 03 Dec 2025 00:12:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764749573; x=1765354373;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LEO3Kwl9EOqsIYhtMdkGwnfeH6DMVojvueM2ZcxPgoQ=;
 b=tKx0c3RPf0SIKzbnowvJL0sZCMrw/YOFZ1JHcxi4E//PuEn1jRXK1Xa/YmSnqUtJso
 4mplw1KjquOTn9bHYwi0FF4wbBjowJYFo+HTiJS8wy20N991vLaw2KuzBPsS2DECiYVy
 WE9N5tulCGtGlIxKnKkirzfjOHGjn9m/bLfel0x5MW6ahhJOkjhPa0+ZrAr1XzD6vq8o
 uUDbeVW5EaD94zVjVzvrE/AQ7+mmdq19dGvXXKs5VnzJtxQf1Djns1fPyBKtng32QehN
 Ll9OMojyruQgUmoaiWZR7wjWwcLAQLkcpe9dFomQZBU6zLYnjWSiOx9Np7hwDV2IQBFO
 r6tA==
X-Gm-Message-State: AOJu0YxXJJGME4WD812gTBDEAM8bKA8NbtzeabT1iiJoScxKc5u6JBxW
 5UNxDTcroRiMqui1IxeOqWj0ISc0KRvyhRrnMe6uTpVZC1+LFGdvgH1wzw45Fj6mr13CFpkmy2K
 HTYCWgNO462T4IAAg/ctlA/prdPUEaYosKmpPsR9Th8fk2rWwo3fJn7KbCuf5yIT+R07nSTaaPd
 4a
X-Gm-Gg: ASbGnct4lOmBsnVzDA4G7VK0/x8MytnS5RcFFPJv+Q2NbJ8uWZlaLJSPKN0Am5kdWo3
 ByKDjs0iASDzaN+S6K+o4gmc790Jyy5FR1VZ//E4TXDQ04nfk3AfSGMJlYvIU9tPlqkZZIkcN+7
 Zbs/HN63dceazs8P7NSK1V21WfUfg/0R+bBSNLeCi3nYaZloAncgcF4WeGzeoxcF9UjC0k/IUzd
 10B7+Gy9OSi2NguJnOfVRiMiW1MLTabnJUEIOLLzoYW2ygd/rHCClp4xc5G/plxe+0oUHqtl466
 zv3y8lV/83RICiLXkb/8V+iuqTDJq2xCQW+DrFsz1KvuwqubOTuG00mb9uOhFS0T7Ng0Pswjg5Q
 I96c=
X-Received: by 2002:a17:903:1ace:b0:298:8ec:9991 with SMTP id
 d9443c01a7336-29d684010d3mr18809715ad.37.1764749572859; 
 Wed, 03 Dec 2025 00:12:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFI0zdMm0ek7r7BCOLNOH1JGeMKn4uhy4Wuv4WTLAmQNg6Ac2/hTTbLTyF3NNpoDO1723+O+g==
X-Received: by 2002:a17:903:1ace:b0:298:8ec:9991 with SMTP id
 d9443c01a7336-29d684010d3mr18809375ad.37.1764749572234; 
 Wed, 03 Dec 2025 00:12:52 -0800 (PST)
Received: from zoe.. ([2001:f74:8f00:c00:6aff::1002])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-29bce40ab76sm175977585ad.6.2025.12.03.00.12.51
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Dec 2025 00:12:51 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed,  3 Dec 2025 17:12:26 +0900
Message-ID: <20251203081226.1148236-1-masahiro.yamada@canonical.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] listmount04: require kernel version 6.11
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
From: Masahiro Yamada via ltp <ltp@lists.linux.it>
Reply-To: Masahiro Yamada <masahiro.yamada@canonical.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Linux kernel 6.8, the listmount04 test fails as follows:

  Running tests.......
  tst_buffers.c:57: TINFO: Test is using guarded buffers
  tst_test.c:2025: TINFO: LTP version: 20250930
  tst_test.c:2028: TINFO: Tested kernel: 6.8.0 #71 SMP PREEMPT_DYNAMIC Wed Dec  3 16:00:27 JST 2025 x86_64
  tst_kconfig.c:88: TINFO: Parsing kernel config '/proc/config.gz'
  tst_kconfig.c:676: TINFO: CONFIG_TRACE_IRQFLAGS kernel option detected which might slow the execution
  tst_test.c:1846: TINFO: Overall timeout per run is 0h 02m 00s
  listmount04.c:128: TPASS: request points to unaccessible memory : EFAULT (14)
  listmount04.c:128: TPASS: mnt_ids points to unaccessible memory : EFAULT (14)
  listmount04.c:128: TPASS: invalid flags : EINVAL (22)
  listmount04.c:128: TPASS: insufficient mnt_id_req.size : EINVAL (22)
  listmount04.c:128: TPASS: invalid mnt_id_req.spare : EINVAL (22)
  listmount04.c:128: TFAIL: invalid mnt_id_req.param invalid retval 20: SUCCESS (0)
  listmount04.c:128: TFAIL: invalid mnt_id_req.mnt_id expected EINVAL: ENOENT (2)
  listmount04.c:128: TPASS: non-existant mnt_id : ENOENT (2)

  Summary:
  passed   6
  failed   2
  broken   0
  skipped  0
  warnings 0
  INFO: ltp-pan reported some tests FAIL
  LTP Version: 20250930
  INFO: Test end time: Wed Dec  3 07:01:33 UTC 2025

This test passes only after kernel commit 4bed843b1000 ("fs: reject
invalid last mount id early"), i.e. kernel version 6.11.

Signed-off-by: Masahiro Yamada <masahiro.yamada@canonical.com>
---
 testcases/kernel/syscalls/listmount/listmount04.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/listmount/listmount04.c b/testcases/kernel/syscalls/listmount/listmount04.c
index a52bad064c0e..a6921a24975d 100644
--- a/testcases/kernel/syscalls/listmount/listmount04.c
+++ b/testcases/kernel/syscalls/listmount/listmount04.c
@@ -133,7 +133,7 @@ static void run(unsigned int n)
 static struct tst_test test = {
 	.test = run,
 	.tcnt = ARRAY_SIZE(tcases),
-	.min_kver = "6.8",
+	.min_kver = "6.11",
 	.bufs = (struct tst_buffers []) {
 		{ &request, .size = MNT_ID_REQ_SIZE_VER0 },
 		{},
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
