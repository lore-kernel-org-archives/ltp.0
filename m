Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17063D38FEB
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 16:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768409118; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=QKtjXzVOr31f89rgqN8pURyTNTX7+GHvbNaNe7J0guM=;
 b=dGGKu1uxY20TlR9zRsyfJQeiDxBzx7QI/URonwXT+8UXI1FtESu4+9y3kd/G5VXJOVtr2
 qLESdHtIqfy/3h4y6cvkAg5SIDfGEEWKl/VtYP0e1gswLuD9SzDqu83kULTQVELr2I7F6ZW
 KxrEEMdokN3LyZnwnhLyE6/XA5Rb71A=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B168F3C9FB7
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 17:45:18 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 13CA73C3103
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 11:18:43 +0100 (CET)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com
 [IPv6:2607:f8b0:4864:20::62f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8D9181A00145
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 11:18:42 +0100 (CET)
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a0d6f647e2so84255495ad.1
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 02:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1768385920; x=1768990720; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ub2eha8WULHLEg2XheB/4u69pl3NeqD7MuulH6bhRis=;
 b=E14sg+MBdJV6+Qxd3TVD0YNN+qF54gbZZoCrPYoYC0EVO6rMc+jn2LTTuj9EIjHCp1
 XqMVMfArtYVe2R8S1G6h1WvlrQVIfMRZhImVnN1XuszVyGfI3sDcmWxLYj3ZLY4uMr9b
 joptqWpBC6xiVIHfiKpKa99kbt/oq4RyUN9uX/mQzpmoWhr4mNmPq+lkEMIrDlsvYS2O
 agw7OuCjr/xY67o+tlg4AxRpBVFJaUypzGy5NCl2gebkbutVmx9g4uz9TCYG8nfWt1x7
 NDY0OVgFEoGfDCsP0zP/URDxONsZiv4vLWE/CXkl+ka7MvcEpUPDUMQN4RTc38QLofVI
 D87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768385920; x=1768990720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ub2eha8WULHLEg2XheB/4u69pl3NeqD7MuulH6bhRis=;
 b=lQLb4pOsApOHNTo0eqwHj90ndLjGYofCT91QywGdWCLdgXXZJ/YfSjKGpSezT+Q9V+
 6y4ABLwWc8W9i6CirsTJUOWzvFyjbqpNj+2pcJ7sx4tBxYRbPZdktignHdbCVmCNpynT
 IXlDSBBtJrBsBQa+ereTRoBHbbf3TkAGrzPuDT15sVhmJfH+yYfLJb45lYllNfw/kfs9
 woqwYXrQnX9tZe1NX5OqtNHoHLdw0X3GTOeSY1vMhxcx7oq6FJZoQzUeyW6XdMl5zLyA
 iVnbzdx1FXE6eEV3VzQ0ESllwZHcJhf8WOC4JZdZET2BMo3Vakr40HQs/nPexJ3CXMkp
 bRCQ==
X-Gm-Message-State: AOJu0YyC7wowMppFPViQgGHgiHkIemRVUbI8d7RfTQVRbeNPX3bFsIAN
 UelTdCQjN5waphsqPRbngeuSG5wF4Nzkmjj54bO1zIUgt8l0gy3UZiSvUIofNPj5yv9jp1LNvOa
 h4yaztpd2Z6uVAeGLYjFCTX8qiiOII01t9hnKfWzMzsuKPgN5OxG6b+6dpKODNccFRv2KL6A29v
 SvgWoqcbKJ8dbL4UxYh1r4TUuD2PPxRXJeh2HrT9D/
X-Gm-Gg: AY/fxX7/7rLj3DlxtOR6OOLr2DDsnB0RfSHe+QUQoN5Hvh5LEM21glJNf3rleIAdpvj
 druvdJ2bAKMgZ8X9kE1dAnyDpexcU7PFnefjxft3MNkt5bi4VrWHlgBAV2uhHtJ5nStdK24qQNC
 zQx18Ac4VkoG4/Mj+d7lKssqnF7uuw8CpWbLMVdsZHNG+pqvMo/JxZrtbmGEaSzzqZKdRI8LtQi
 eF7g/5o58q5VJT+eGtx76q4rvGaFeeaRcdtXZxNWWzazHte1dsnKsylrMecnUeA0HnywkzfG8pc
 1PhQXTod9EaHkkkP6OFneDQjiNafFWL+XPLLnhh7XagbE0AqrLhVxsE625mC1BrWwQAcBIJcudi
 w9AFJ81WazpbKqX3T8sy/RjskghkLGmA2SMbKe7sAjj4WKxc7tx4b5khcekmgdNUnxGa6/z8HiP
 txOZUj8TRwnpLAz/6ykQx7dAVtWezKyBLPavd9ZU4o4KKqwvOcSGfKcyuhkZEPSd9bzg==
X-Received: by 2002:a17:902:ec90:b0:298:2637:800b with SMTP id
 d9443c01a7336-2a599e34891mr20397025ad.31.1768385920227; 
 Wed, 14 Jan 2026 02:18:40 -0800 (PST)
Received: from Vincent-X1Extreme-TW.internal.sifive.com ([136.226.240.177])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cd495dsm226859885ad.96.2026.01.14.02.18.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 02:18:39 -0800 (PST)
To: ltp@lists.linux.it
Date: Wed, 14 Jan 2026 18:18:34 +0800
Message-Id: <20260114101834.3397158-1-vincent.chen@sifive.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 14 Jan 2026 17:44:54 +0100
Subject: [LTP] [PATCH] locking/lock_torture: accept optional "[debug]" in
 result string
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
From: Vincent Chen via ltp <ltp@lists.linux.it>
Reply-To: Vincent Chen <vincent.chen@sifive.com>
Cc: vincent.chen@sifive.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

lock_torture.sh parses the lock_torture result from dmesg by
matching the "End of test: <RESULT>:" line.

When the kernel is built with lock debugging enabled (e.g.
CONFIG_DEBUG_MUTEXES, CONFIG_DEBUG_RT_MUTEXES, CONFIG_DEBUG_SPINLOCK),
lock_torture may print "End of test: SUCCESS [debug]: ...".
The current regexp expects "SUCCESS:" and fails to match, causing the
test to be reported as failure.

Allow an optional " [debug]" token between the result string and the
colon so the test can correctly detect SUCCESS on debug kernels.

Signed-off-by: Vincent Chen <vincent.chen@sifive.com>
---
 testcases/kernel/device-drivers/locking/lock_torture.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/device-drivers/locking/lock_torture.sh b/testcases/kernel/device-drivers/locking/lock_torture.sh
index dfa57373f..d9bd95da2 100755
--- a/testcases/kernel/device-drivers/locking/lock_torture.sh
+++ b/testcases/kernel/device-drivers/locking/lock_torture.sh
@@ -83,7 +83,7 @@ for type in $lock_type; do
 		tst_brkm TBROK "failed to unload module"
 
 	# check module status in dmesg
-	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+):.*/\1/p'`
+	result_str=`dmesg | sed -nE '$s/.*End of test: ([A-Z]+)([[:space:]]+\[debug\])?:.*/\1/p'`
 	if [ "$result_str" = "SUCCESS" ]; then
 		tst_resm TPASS "$type: completed"
 	else
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
