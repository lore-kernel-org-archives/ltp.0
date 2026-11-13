Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E334A606A331
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 22:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Fdeo1feY;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=IWz9Fp1H
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794610477; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=hpdpRECg73lLmnBsokAigvVzd94to/cu9MEknxzKVDU=;
 b=Fdeo1feYpV9JjLVM0slpDix7uFsAlLDXrBWDamCyhKaw7ebKeRb+IL+HomGr+tFnbWmG5
 Msi7MmkH266oQQi7a/9goZzZuCuLfiU2hh20TuNDngwRkwE0i6X46tRb6ATgepVeVKBXdPq
 xPh1iaroxRpTf2xVH3BJGvfv1oD5FsI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B8A03E951B
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 23:54:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9BCF33CBC58
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 23:54:16 +0100 (CET)
Received: from mail-pf1-x446.google.com (mail-pf1-x446.google.com
 [IPv6:2607:f8b0:4864:20::446])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C4DF41A010D3
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 23:54:15 +0100 (CET)
Received: by mail-pf1-x446.google.com with SMTP id
 d2e1a72fcca58-8b5d8de9619so1813191b3a.0
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 14:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794610454; x=1795215254; darn=lists.linux.it;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=/BQRRRz4ilP2gNQJZNdaKMCWKxQSduHEpdvCePCBgV8=;
 b=IWz9Fp1HXFawAVulOgO84EH2TSJfbyzH/tkIVTxwjV4ICz57Tio4a8H27HBcoNn2JL
 0Fj1EhB98vlzQ1/9f/b8/Tj1dvjPP4sN5V4umtR9Sz1S7JkwtrgZ64VTo5KXy6DH9dfh
 Im95XoRclDAfWSFBZs2QQ2hgk+rb2lSwGiavNu+ArNgeymy0+N7kgQBvnll9sqk/NrIl
 QjUiop2wcXNfVrO4/P086Az7wdmcm0AiGMJ5dauXbXxmskJW4upAcKHcSIfj+CHspVAG
 hS3qM6qX4PyuGxnFWq31BmDHL9tLMSfHOwsXNOX062O4n7Nzi5Egxe46ATRQvvdM6Msz
 GMqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794610454; x=1795215254;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/BQRRRz4ilP2gNQJZNdaKMCWKxQSduHEpdvCePCBgV8=;
 b=A2tEcbim1OJa90HADkWMoDigQzzAMXFeYDXdthOxEOJF7SlDEFMvQqlI5sJgMbw7zP
 jNyYtEsRk5ojdzDSJCqF7Vn/0L8EGx20BVOfr6OpPqTsaK8GzqiBq87mDkcFUv0K+w2I
 d0mTYpC3skFKOhBExS29uBcQkY3SSGOp8HvhyWTW1Ny152Fk0lU4LdeS+m/h8bmX+6f1
 DN6E7kD9e3bA4ETpR9LbU1ieRiHyCu/OVIy1T80nn/rv9Emb5ucfPYFYRwTpW2Uqw43i
 pxmty/IbSKfyj0AJCI6ipPbocW2cD2DrzapbiXfBu9P37oWwgwbrGYUphMPtyEQUKwi9
 KbYw==
X-Gm-Message-State: APuU4Z/++jZnrzb6Pv3jNsT/TSZWs6goklG/iU0g9DGMI7RRj5tRU3RZ
 5p3Wih2SMsbTnVzh1YjKxNkw0h6dPkVgZJOpbORhPwa/s9rhb/tfwu9nrEH0Ga92rOdxWLUFvf3
 TQf1RJC+YY6+R3GdmDyW6sA2gX2dZZOQyLtwUQ+QAbYy+9PgYd1ZtXTtAtkOCF+KpmxWGIGhFuP
 X250IyJDGsEl41vujJTIeaZFbmPA==
X-Received: from pfks19.prod.google.com ([2002:a05:6a00:1953:b0:8a2:1bc3:8884])
 (user=wakel job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2350:b0:89e:779b:d0f
 with SMTP id d2e1a72fcca58-8beb6b703d9mr3769210b3a.37.1794610453424; Fri, 13
 Nov 2026 14:54:13 -0800 (PST)
Date: Fri, 13 Nov 2026 22:54:11 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261113225411.3757447-1-wakel@google.com>
To: ltp@lists.linux.it
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] sys_leds01: Fix max_brightness range check on 32-bit
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wake Liu via ltp <ltp@lists.linux.it>
Reply-To: Wake Liu <wakel@google.com>
Cc: Wake Liu <wakel@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The kernel stores max_brightness in struct led_classdev as unsigned int
and led-class.c exports it with "%u", so any value up to UINT_MAX is
valid.

The test checks it against LONG_MAX, which is only 2147483647 on 32-bit
userspace. An LED that reports a larger max_brightness, e.g. 4294967295,
makes the test fail on 32-bit while the same value passes on 64-bit.

Use TST_SYSFS_ASSERT_RANGEUU() with UINT_MAX as the upper bound. This
matches the kernel type on all architectures and follows the
tst_sysfs_assert.h guidance to use the unsigned variant for attributes
the kernel exports as an unsigned type.

Fixes: e996b5a6c2d9 ("testcases: sysfs: sys_leds01")
Signed-off-by: Wake Liu <wakel@google.com>
---
 testcases/kernel/sysfs/class/leds/sys_leds01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/sysfs/class/leds/sys_leds01.c b/testcases/kernel/sysfs/class/leds/sys_leds01.c
index 68e7f2094..50376d219 100644
--- a/testcases/kernel/sysfs/class/leds/sys_leds01.c
+++ b/testcases/kernel/sysfs/class/leds/sys_leds01.c
@@ -30,7 +30,7 @@ static void check_led(const char *name)
 
 	tst_res(TINFO, "Checking led '%s'", name);
 
-	TST_SYSFS_ASSERT_RANGELL(1, LONG_MAX, PATH_CLASS_LEDS "/%s/max_brightness", name);
+	TST_SYSFS_ASSERT_RANGEUU(1, UINT_MAX, PATH_CLASS_LEDS "/%s/max_brightness", name);
 
 	TST_SYSFS_ASSERT_RANGELF(0, "brightness", "max_brightness",
 				  PATH_CLASS_LEDS "/%s/", name);
-- 
2.56.0.611.g1030f0b940-goog


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
