Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7990EC54E71
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 19:28:02 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A1DC3D00B0
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 20:28:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AAE7A3CE6A4
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 20:27:45 +0100 (CET)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com
 [IPv6:2a00:1450:4864:20::630])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C6FFE600FC1
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 20:27:44 +0100 (CET)
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a450bedffdfso732163066b.3
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 12:27:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710876463; x=1711481263; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sb1NBRGhVDYbhyHHTkNvgHCTRd9PVNO885af4GEmriU=;
 b=eV8IiULP5ZlPopZH+GuGNsy4jeId6vOk/j0XMDB82udVgMQPSW4kcMt3b2le3kegp+
 ryTMSU9WqjpJcCJTvO9mf1Li0auRwqitmzumP3ByplkpFmH4yjIhfRIJKS5YXUr3pWiz
 borzNTqKIrd6kh0VKtj/Q+MOgD+6qyIEmMFNBCbB7c40Nk63v4lXc0liLJWbwERoJm6d
 VAq1vZPaTEFjWJ6eF0Yn4SYJYKesLWhYJQrAkZ7CIqvqjBP4E6NQ39XpiZfyhc1vOnJp
 XMBoYKl6ghISRFapyodFxT2GZGKh/j6bmibycwtJpoOnYhqNugmKlqDI2LDSURBImiUD
 8y2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710876463; x=1711481263;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sb1NBRGhVDYbhyHHTkNvgHCTRd9PVNO885af4GEmriU=;
 b=grK5fvWWDtLHygvGfztBAiyfWSsnL0uW2wLEkOwrU5GjBJq5n2lBzoXyv0RIlZHhgO
 R5jc8EE+T6dCvgRS6zE9bFK5pLl3moDuvo6pMup/HCk9mDgqpRz1Lxmw1TWbyM9TNUb1
 VdFU+jKdtqj+Gbw1079WEFiei5zFyzbhLQWhEtp6rImedx+W9NVhNZm7T3fUzc57HVRy
 W8jptmr6wK+Hwz1IeAa6MOEMvkhHSuKxsgSvwNvtk2rUSAcRJFEcicQG3kWmjKJg+7so
 7x7Uug8xL0ib9s1OGfz/YWYS5GyRgIP2m83LUw/3IJrhVLlaul8qLFqCDAtGzajw0KoC
 Q01g==
X-Gm-Message-State: AOJu0YzxMSkXRdDU15V/ANjmcPq5j8uuC5MjGguxWJI0TcazCUKofHGD
 9usEGbizTpySCLYWTxAzjlycjm/Aui77X6aq5GeB4e5unXZ9gCB4/fss6792
X-Google-Smtp-Source: AGHT+IGmFo/MoTIWdDADm5z+c3omQARCtM6HjEJ16LvHrnvMLCm7trT4d0g1bjaraaM9m7lT6ixqgQ==
X-Received: by 2002:a17:906:ef0c:b0:a46:c01b:7e2c with SMTP id
 f12-20020a170906ef0c00b00a46c01b7e2cmr5808667ejs.75.1710876463151; 
 Tue, 19 Mar 2024 12:27:43 -0700 (PDT)
Received: from localhost.suse.cz ([37.109.164.85])
 by smtp.gmail.com with ESMTPSA id
 bk10-20020a170907360a00b00a46e2f89a9csm917592ejc.32.2024.03.19.12.27.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Mar 2024 12:27:42 -0700 (PDT)
From: Sebastian Chlad <sebastianchlad@gmail.com>
To: ltp@lists.linux.it
Date: Tue, 19 Mar 2024 20:27:27 +0100
Message-Id: <20240319192727.17538-1-sebastianchlad@gmail.com>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] docparse: Correct spelling mistake
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

---
 docparse/README.md | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/docparse/README.md b/docparse/README.md
index 9ccfa44af..c71062759 100644
--- a/docparse/README.md
+++ b/docparse/README.md
@@ -234,7 +234,7 @@ with a header describing the testsuite:
 Open Points
 ===========
 
-There are stil some loose ends. Mostly it's not well defined where to put
+There are still some loose ends. Mostly it's not well defined where to put
 things and how to format them.
 
 * Some of the hardware requirements are already listed in the tst\_test. Should
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
