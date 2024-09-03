Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E53CCCD13CF
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 08:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1725351584; h=to : date :
 message-id : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=LPaqGpUpTWLM2StjVvl7IpF47NwLj1Bni4UiEF4Rlxc=;
 b=TOfedL3qOD+KY1AKkS05N2fcDvb6SCHjdjW6OGGBq0L5E09j5n6ekM0grSi8GiHoajqnC
 bPdX8nxj0l8UGms/fwkrSkarstzMPmwiPZ9RaPksT6W3qbBbXIlNProb4xkfwSV0BYa6TgV
 cv4VfOKKV8y61hksWaPHoFxS1CFUe1M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5BCCD3C0303
	for <ltp@archiver.kernel.org>; Tue,  3 Sep 2024 10:19:44 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 844143C0303
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 10:19:24 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 272BE1A00E63
 for <ltp@lists.linux.it>; Tue,  3 Sep 2024 10:19:24 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a86abbd68ffso824197766b.0
 for <ltp@lists.linux.it>; Tue, 03 Sep 2024 01:19:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1725351563; x=1725956363; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7Q0B+jV4yiTtBFJmzIxsbNQIbtceLwnI+pi3Td9pDXc=;
 b=R1lReTNdS1NNVL5kPkjDrvl5Kn64lxI2xTzlhTtC9mSB/MWWwZH5opLNNX/znSNLaj
 0UEZXrA03eMIq1pg1F8w08OO/KePoUk1sGQMpxpuejO1J9xy/p2e7zSWHRBVnMmNFxuS
 okBV3YBxaDaqU8Ao3QuicJQrOdYNqUg5t/AMKgLOhx8rIg/TgLKKhcsl1GkKB0nICTIG
 HT4J+NhEjJnVNMLDI7wGqvFWI2gQIpXq4Kq4MuAYFsEANl8v+8xoBuduU6F0Y2qWkOGf
 qi5NUZ/xKAkEyE5BeG0zWX/W1bHBj8LIDB9DuA30irHcgTn2qQg1YHa2uu9Dl7I9gIlt
 VREA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725351563; x=1725956363;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=7Q0B+jV4yiTtBFJmzIxsbNQIbtceLwnI+pi3Td9pDXc=;
 b=QURiIaalQzFt7DMyaZZGxMNTeQ7PBSASflt6Xgw87BdhxqISO/gUdEsCy/VPgKaIsz
 PcAK5BSroTn1fYD43MjhEPpjkusuWMAhIiJ82BMvLt8eOTcGYmKiPFIkG8quv7s+I3wv
 pEkFBf6aki60lswpyjHVqgnZH0tTPTfuByN4uaEVonUWv/nA/oKQzO1C6q+7o8cFdpRf
 97vfQ41J34Pwn/fKx4a5MZxcY4FGY0a2doaTZpIANIuf48w+oaOizXQQnKitOYoKOkNA
 waz93sdyAt/9seF5cUnWWlrZbR4x4lTecMyPmE1AE9zP8K2J4VBVvOIW/xcpVnYnKx2w
 fz8w==
X-Gm-Message-State: AOJu0YyOmbbfQVsWLVjihDisuF/5QkjpOoH9l21Zr8NaCa+U/b547/nr
 WJlrNs1JoS8yyepUeVarNwrAQaqRnAoSx0giXzTCA4bKMduQgxU6RPEslvEnzvhby3FDSLhRjWY
 =
X-Google-Smtp-Source: AGHT+IGvGFMweikFElNQcZ6IoSIFORzWBszD5LIa5pHJoXA+3af7SCzf9L/yVzIJT36F/CUyvUuZEA==
X-Received: by 2002:a17:907:d867:b0:a7a:a4cf:4f93 with SMTP id
 a640c23a62f3a-a89a29f6270mr1293878666b.32.1725351562865; 
 Tue, 03 Sep 2024 01:19:22 -0700 (PDT)
Received: from localhost ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989035f80sm648846466b.78.2024.09.03.01.19.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Sep 2024 01:19:22 -0700 (PDT)
To: ltp@lists.linux.it
Date: Tue,  3 Sep 2024 04:19:16 -0400
Message-Id: <20240903081916.27033-1-wegao@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240902024017.6404-1-wegao@suse.com>
References: <20240902024017.6404-1-wegao@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v3] mpls01.sh: Add --allow-unsupported for modprobe
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

In sle-micro we encounter following error when do modprobe:
root# modprobe mpls_router
modprobe: ERROR: module 'mpls_router' is unsupported
modprobe: ERROR: Use --allow-unsupported or set allow_unsupported_modules 1 in
modprobe: ERROR: /etc/modprobe.d/10-unsupported-modules.conf
modprobe: ERROR: could not insert 'mpls_router': Operation not permitted

Signed-off-by: Wei Gao <wegao@suse.com>
Reviewed-by: Petr Vorel <pvorel@suse.cz>
---
 testcases/network/mpls/mpls01.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/testcases/network/mpls/mpls01.sh b/testcases/network/mpls/mpls01.sh
index 196b5b2f9..892b5bd85 100755
--- a/testcases/network/mpls/mpls01.sh
+++ b/testcases/network/mpls/mpls01.sh
@@ -21,7 +21,11 @@ cleanup()
 
 setup()
 {
-	ROD modprobe mpls_router
+	if grep -q 'sl-micro' /etc/os-release; then
+		ROD modprobe --allow-unsupported mpls_router
+	else
+		ROD modprobe mpls_router
+	fi
 }
 
 test1()
-- 
2.35.3


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
