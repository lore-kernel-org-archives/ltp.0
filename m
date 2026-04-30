Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AC95FF8873
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 15:10:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BDC693E688C
	for <ltp@archiver.kernel.org>; Thu, 30 Apr 2026 17:10:47 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1D1F43CB935
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 17:10:30 +0200 (CEST)
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com
 [IPv6:2607:f8b0:4864:20::643])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AD0D21001165
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 17:10:29 +0200 (CEST)
Received: by mail-pl1-x643.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso7340025ad.0
 for <ltp@lists.linux.it>; Thu, 30 Apr 2026 08:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777561828; x=1778166628; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Oohxsa5xCCVH301WUfhsHiZb5QtgcAvEb2+AgvTF5AM=;
 b=QAm//Lbl64/sTNz4hJi6zaUHo6wEMFhcTNPm0v6eY3nez6E7WPi0UrXt/HvQbBZILi
 MAoLJTucTlR0exLSnT0gLT5bjER5bbtt4NZiwvm8IUA3yQzk5GupIZ/JYzaf6yRKhj+s
 1R0dWaqVg5+S3XXtIENJ1GcNYRoP5gor3zIznTpI9chRh5Co+hXATm5JwItwXPyc8w9y
 9nBER6J0ZDwNhCIvEOsUqqpi28eQklDJ8Y3wx6IQCDWCaxCKBXB3ulw2yU1lHwCM2U4x
 Hnf2sYBmJpGiynaOw0a+etESlRY+ww2ZU0/WyHbsH32/TTt6ZzQSXOROeVW4jsN7SXa+
 +CtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777561828; x=1778166628;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Oohxsa5xCCVH301WUfhsHiZb5QtgcAvEb2+AgvTF5AM=;
 b=ZQqGHp2B9cCPH6ofn/0GH+ZVrQbmsLGZXM9LfwRIrk2VlvHSdBYfpGgcRmXOCz2DLW
 jsiCGcHLNmqeTds9VWs53igdX3ZOpFjaPhzFRMnBnkUY7f3PfqY42E2xC1DR2a7XrI9Q
 wBH9qYjThzHdW4qmaCUmmToTWiVcEsMNaYuQr3+dR4LkvVW6qzJ9XV5x/AJeynL6p2BD
 EGpWPRbi+SyDfEeTRI2OL7QcXGBlHRIWk8fSnMdo+K5bwA51KQGhtAtklESLczdn8jvV
 4ta6h/Zt00VKQTMC0/7KgmGWJWIS/Cd8wWZuRrwHk9QtZlbdbBE3JO9B+rfKg9PGF79b
 5S8g==
X-Gm-Message-State: AOJu0YwFCSeqXBFf252u9Q1BBJ0JvLd7WPOlW55mLi6N2EZLf+jmv+v5
 K6zjgw+/c8he3e3YwF0Z2Ei679f3IbUr9nC0fyyJg9GmEc1BiajhxgwDxYizjHlix893
X-Gm-Gg: AeBDieuTGgCsYVtOKhO0JvjDHZaUwOqI60To/dOkMiP7/SW83twrk+30uF+RDNsMxBT
 pgz18Vtm3IxUW7WL6zgE1qcJiqeW4Z93DxV62LVWZ+cVG2RMy07r9N1YKvjSGGynNKl9zXNzlEA
 1EjdVZNqBUTyRsmSYSOFi6aJ662KLKrmCU/mj+rzg+xqfWEnZqR89G7XAm09AoJnEs6xt0zwj4V
 pAi9Mi+f4NikXabxwbq1RJj2NT1VvntoG8id8yntdfclKc/47P+dor5G4FEhiUqGyv+735wIdIy
 D0/udVegLfZcS85mqROAayKdgLxbc9jzS5YISFejHX9+wDrvNkwtx++DiDQov2q2jDtKSea8Syj
 MFECbFIlDl0VUiRFruxH6xTdKy4FvXpFWGuilREGuNSxia76+BVtXypGHdFQFsGQn4dIWYGgVI2
 b0lnPCrRVHYidM5nYduQIOhUDJ0z/5gz1AiBm3DAFssfZ1xr3JfLM0XkvH8X9vmTc=
X-Received: by 2002:a17:903:44c4:b0:2b2:5099:2f40 with SMTP id
 d9443c01a7336-2b9a44e0957mr18044325ad.22.1777561827635; 
 Thu, 30 Apr 2026 08:10:27 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b98897112bsm60675655ad.67.2026.04.30.08.10.26
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 08:10:26 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: ltp@lists.linux.it
Date: Fri,  1 May 2026 00:09:09 +0900
Message-ID: <20260430150942.4859-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] testcases: unify naming for syscall tests ending in
 digits
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

Hi All,

I noticed both styles are used for tests of syscalls ending in digits:

For example:
  dup2/dup201.c
  dup3/dup3_01.c

Would it be better to unify them as dup2_01.c / dup3_01.c for consistency?

Thanks.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
