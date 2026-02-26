Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4FFD8FCA
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 15:33:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F21F13CBE68
	for <ltp@archiver.kernel.org>; Thu, 26 Feb 2026 16:33:15 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A463F3CB7A6
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 16:32:57 +0100 (CET)
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 52C092001D9
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 16:32:57 +0100 (CET)
Received: by mail-pf1-x441.google.com with SMTP id
 d2e1a72fcca58-824af5e5c81so1145346b3a.0
 for <ltp@lists.linux.it>; Thu, 26 Feb 2026 07:32:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772119976; x=1772724776; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4L1OZP4VEALz5DEOOBd4FlZa2xvAKpa1MFBn+bpTHlk=;
 b=LdhqPAZtKlmzzpbpYByp4Z1vPzZHmuruWswMRVMEzaCxikELiaO9w2oDxFauLhRb6s
 CPOpLUOcPl2F8YxUz7ZqsD9awMX8J9xCZJiuO/DnaKv9aeOhNrtiJ6o/xZB6KjxbeOW5
 6YrcGLl9/AQh1sv2phKnL1BesRwXH3EnMYAkBDDyzNhVjNQ+f1rTUmjx4nVa4oHI+J5e
 jQ/rYMFC6tAKGrifo019skUt23WiGaZv7X019Xy7j9SwjVjpM4LSS9V8ci0OVrWFznkT
 K9RWXIxWBByQQx9/FeScyqZoef775D/zGoRX8FWlphfm12Z55ieZNBAVoyFifqjy1y4o
 zK1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772119976; x=1772724776;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=4L1OZP4VEALz5DEOOBd4FlZa2xvAKpa1MFBn+bpTHlk=;
 b=axoxkgO148ndjXM+//XSWhFXWWzrDfwEv46dnp6AeW227nrs9c8APy7y9PJBnsbdcz
 tZ2wENVGzKBDJRB7/bsdcYNTlqX1hjZI4ZHtMejwAz2MDGg/JkjPhqRH/2KZh1PvjhVr
 mR1UXWZsseeaTi+s1PR8fBowj87F6xdpl4vfBerCYmyeswZ+WdcOkh5FuYjL2Bhwq+Wt
 vsP0wbK7w6mcKSAZEdSsZ+XAjx+85Xnr9DSfEKyVTwLpUbrCzMTSjx1VmnMdFrhf03Ke
 x5GsKUy2ZxI6yjxKmBfkCrH7X7+fQil9emsylfoECOmF4advaaBc0wBcIHbKjgHjzcYO
 +95Q==
X-Gm-Message-State: AOJu0YzKRwGlRVuSCr4mk3kwW9GKfe9pz2GyHgLx6x1oBlKDRSx61718
 mz96m2VooTMsnOy4WUb4BGgZU8/QK4QlHiPtA7+yNPfWimH7sgNIjmA=
X-Gm-Gg: ATEYQzwz1SfhTjiXxQ+MbgmlZr70JTy1NXpl1RcblbbopXceimQRVWut6/BGoWQcJG6
 dENFyzjTIm2qMOwKeBS6E9LmHp4F82G4Zx4nE+fHJFxe2k4hMKG2QeAd8K8xCWz/5PiRMxxQIPI
 a4iBAml8BLFX/Y0uo06ZwCBwygoI5u9QarRMRKqrE2eBqHhDEc+9VgcxGMoWsv4N8SUSfowl7kZ
 G58y8mb8iyZeBpoIprmRkxnAmEoecfJ5cO13REqmNencY8hGG81jZyFRqSDtyMFlheUfn7s7vpk
 LuxXSgp3pLkUSuW4DXwly95Z2aHhKIY2blJ4Froexy2y78x8JMqIFcptKgKwrmnJ8HK/Sz3/syE
 gKvaQbS5d6iK5C2m/n8BEkSnAp/q2YJhp8jYNyoXY0MDxTcm9q+wIXxuL+r05BRJWIENbZBooRk
 H3iTcZEOjUG7F26N3bbQROs04fs4lnMZZzdyK2p04pqg==
X-Received: by 2002:a05:6a21:b8f:b0:38d:f226:49d2 with SMTP id
 adf61e73a8af0-39545f8d79emr18872364637.35.1772119975603; 
 Thu, 26 Feb 2026 07:32:55 -0800 (PST)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35912fe1040sm2246209a91.4.2026.02.26.07.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Feb 2026 07:32:55 -0800 (PST)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Fri, 27 Feb 2026 00:32:30 +0900
Message-ID: <20260226153231.1513-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <DGO4558ZMLNH.3U00SNOHLUVXJ@suse.com>
References: <DGO4558ZMLNH.3U00SNOHLUVXJ@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3 2/2] fstat: add test for multiple file types using
 fstat
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Thank you for the review.

If we switch to using lstat() only, this test would no longer exercise
fstat() at all, which changes the original intent of the test.

In that case, should we consider renaming the test from fstat to lstat?

Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
