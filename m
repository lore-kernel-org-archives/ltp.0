Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB7E4FF8864
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 00:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777251453; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=aX3AmstvRbjUirDde4FsLhR5upcUe0sT3WyyAv1p4oo=;
 b=Oi7XEfKp8oOqbGs/C5WOMqasB7mpY6+UMWIdqFqrByUPxasSAPvQSHIylFf3fOwD2+dqy
 o0o1XHlbfvNSTtAnseUwv613Pe4myckS4sJ6IjqujwMg51z9tqQRb5Nz9kjwcH/pWlhSDRg
 zQYCQIVX4ihjeGMhoMfRbD5GDCd5Maw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 032303CE0F0
	for <ltp@archiver.kernel.org>; Mon, 27 Apr 2026 02:57:33 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 454733C9F71
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 02:57:08 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DF7CF1400200
 for <ltp@lists.linux.it>; Mon, 27 Apr 2026 02:57:06 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488af96f6b2so126272205e9.0
 for <ltp@lists.linux.it>; Sun, 26 Apr 2026 17:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777251426; x=1777856226; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/MJ0/I9/sF5BeY9qbgVDIviE/NyDz75JkVPiktuXR78=;
 b=WdpzMqUE5XWC9k0u5mjoVs1R4Uegv6YCbXzOXShyOPq4w1DMyj8v5SioajRIqCf8nl
 hVFHIt1upsYSscelb15nj1dCtXJ869MUHoBtExwOGk/Iihre+thHRZF4zTEupqSqCrrB
 24EbN8XC61ouPEVkQA7PxKLHeFtZxMcV4sV/gCiXHIw4iMzyQktzhRC5d8cSLeXBvywQ
 zThNpH5H6UExJ82IiuYW60Zio4q2+Fw/94J3f/n9NeG1X1NOCRwznCE3bRARs6H/Zoar
 A7Cn1I9egCdbA29f8+7zjbJl9ay6rqTC6k+u7vFfNmye9E4LSZ46W774IhRYQxxJ5N38
 rV5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777251426; x=1777856226;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/MJ0/I9/sF5BeY9qbgVDIviE/NyDz75JkVPiktuXR78=;
 b=XEmbj/M2sw7QuPziVhwmAa4Jb6MvFalaDag9gXSGLQzs0DDy17ENScU2Xq8Yxnzk9E
 Q7qfCYYk33tCSEieu6Xa6rBFWGdD2O3IBeo/+njQDO+6YinwwsNDx/rwyhgOJYChr4MJ
 tWRyGI8YghSxTt9QWMgecMMm3x34LATk+ShpsiMnM7zaYRoyTFqasdeZ55p6qqmR7uoh
 SNXy86Mg03iWMuSueer0nsrc+UQfNFlHluEvd3FlOCpcSpiJe63VBRRvEeSfvvjsP1+1
 evHwaBeIoDK9QHf+fDGqIIt4pblKfcWqrUfvwEtvIZ8EpKgF0WHLS5GOFsFP9W0Hv37b
 I0eQ==
X-Gm-Message-State: AOJu0YxBKU0WBCoBsZ9Kmt3EDcOO/7jjz+D2XRYOVv26ZgPkqPFwKDx0
 kzt7XSFWnLIOQabsS2g6P7RXYn/nRtmYKaQ1yXtyw3Dz2JMUGHJBYrb6nv7LOymniSC0aeXNxgI
 72e8=
X-Gm-Gg: AeBDieuZK27RQg4xqyaPv2x3Zy1OVirs5z2aD2N3/kMfjZQ/ANC4RedWnMd82IJ2F6d
 nPDL0KiGrbe7nbhToASF/M2u4fI33RWCh0Vxvt/1mn+kVoCA7ZgJFezlqdNLrKHfZYzB01YqhMS
 l+4zjoMyqhw/cjTNMrzFa/zhfIcmDRX4eBdtvpD3FT21z1odYVElZnkIApOOI9vDcMVsGqhU3f0
 5b7FrWGYddnaOlhFNGtTcQNXKUBiqcDKh0xPXlozHo9JnCrJRSUI4i0exDdup6leP5kpAmVbAia
 3dYL/+fdLDtynvdZVN8JpSYfIup7OYZQLsMO0Wah+Tpl913i+yPmo9JVn6GUHWM/34ot2RDDrwj
 VmtX88g1j+ydpS9e6LeOGywVHBacEqT1SfUoYRpLc/pvW5IPHey8Cytmqi1aGNbfJ8t3efdpW/1
 QiHU+g9AJS1aOttfCQJbks/g==
X-Received: by 2002:a05:600c:c4a8:b0:48a:52ee:5776 with SMTP id
 5b1f17b1804b1-48a52ee579dmr414634945e9.11.1777251425954; 
 Sun, 26 Apr 2026 17:57:05 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-4891cdfcd50sm207714755e9.9.2026.04.26.17.57.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 26 Apr 2026 17:57:05 -0700 (PDT)
To: ltp@lists.linux.it
Date: Mon, 27 Apr 2026 00:56:56 +0000
Message-ID: <20260427005658.31295-1-wegao@suse.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v1] ld01.sh: Relax grep pattern for linker error
 message
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

The test was failing on systems (like openSUSE-Tumbleweed) where the
linker identifies itself as '/usr/bin/ld.bfd:' instead of the expected
'ld:'.

ld01 5 TPASS: ld -Bdynamic -shared main.o f1.o rf1.o -o test.so -L/usr/lib/ passed as expected
ld01 5 TPASS: ld -Bstatic -r main.o f1.o rf1.o test.so -L/usr/lib/ 2> ld.out failed as expected
/usr/bin/ld.bfd: attempted static link of dynamic object `test.so'
ld01 5 TFAIL: Unexpected error message

Relax the grep pattern to search for the core error message
'attempted static link of dynamic object' without requiring the
binary name prefix.

Signed-off-by: Wei Gao <wegao@suse.com>
---
 testcases/commands/ld/ld01.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/commands/ld/ld01.sh b/testcases/commands/ld/ld01.sh
index c8ba4fc1c..a0fbf9631 100755
--- a/testcases/commands/ld/ld01.sh
+++ b/testcases/commands/ld/ld01.sh
@@ -69,7 +69,7 @@ test5()
 	EXPECT_FAIL $LD -Bstatic -r main.o f1.o rf1.o test.so -L/usr/lib/ 2\> ld.out
 	cat ld.out
 
-	if grep -q "$LD: attempted static link of dynamic object" ld.out; then
+	if grep -q "attempted static link of dynamic object" ld.out; then
 		tst_res TPASS "Got expected error message"
 	else
 		tst_res TFAIL "Unexpected error message"
-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
