Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DED3DCD8CB9
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 07:48:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781164135; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=Mf7bDR6zrvXiNBnn4bCIBYpTZauA1pctWXlOxE4C/+OrVKyHOUqfDTc9HHxRq/PJr9wOI
 0Tq1SMEjjNywfd8jTch4jE4uraR7h6SypMSJvd/u3MjA35X8IpnohmI52DKavDQ+E7dJ4Ug
 KzqaIuo6lTnyRwKntcASjuu8BTgYJ30=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 06C243E2AAB
	for <ltp@archiver.kernel.org>; Thu, 11 Jun 2026 09:48:55 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677533CB67D
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:48:35 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E07CE100023E
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 09:48:34 +0200 (CEST)
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-45ef5146b56so394807f8f.0
 for <ltp@lists.linux.it>; Thu, 11 Jun 2026 00:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781164114; x=1781768914; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Z6X+KehVFdIFdMfHURpv7CLstvJOz/kBQe0zfkCyRnt7gQHwL1Ssym8Zum5qB3fKr6
 yl81yoO7K8wln/+50QpuM7hvD2s1/dCw6NqeP0GxBxyqMqqgBxzb/5KEk5Jyq1V5Muna
 7NwMeuSXv4P/CRe7PRXlV5utROtlghE9jrOxk7tYU0W2LqVRnwC6B2Mi9bJru2BqgK3Q
 dUXh5zCUbimmTlQ05c/U8U5gmDOzpK/oMoprN7CbuYYCHzixb3Emk736WCp/1f1MAmZp
 29doXXXYZq974RJRN7iov/ZNSh+e1N0qXYUDOFwtTELEElaDyZJ/78o+juja4wx2eWQE
 FVIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781164114; x=1781768914;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=mJuUyk7dZsy51JCsGFqooKuPa1qIhLvbj5PyyJNiG8xuF+Pfv5yrl2BnHXLkJEBWtg
 snbl4A4pb6et0Szihgoc/j9N2b4Mf+44zmCmwt7WnRbRuzujfPsqEYs591sfPzlrdN9p
 8xlTL3s7jEILgef1oR7i9xqIiqcKrQYkAJLRgD2tb2e0UzgmSzzQor2j/8XI2KnKC8r5
 33A/7feghBDGP8jyhBqLNVJbA+t51TaQthq62n9CN4Dz5QBjfe+o3MWhp40FuVat3hJk
 eI5gCHUWVsSh09+xgLwjIsNG0LVBhx9doAvJEsINAxDKlo/ydcrYwx+A+xWdmDxapY4O
 aZuQ==
X-Gm-Message-State: AOJu0YzsrB3rgZ2C8aMGaR1cs1o2l6ssCUqDKi2Fy6mfw8SEXGBvTZnt
 2fy03FTX/no2OTFHvIXqfucaU8sK23T7IhFRuSSmCJXsqjZBlxdMZ1Mar+HQfZO4AHDowxf1rQE
 Bs/kURfM=
X-Gm-Gg: Acq92OExQj8dmEVFZjPgQxk79R2XTdSls87tQ7oo0jFtzESTi3F1L0z8OsmeVOvi4jN
 bZWwMRmfePwdu//4mH3SQJo+AEIZiBZSkvdAjKgvFseOGItgNxyi4vr/PyQf4vqpMgyUcDW7Kme
 fXCPHfq5R2P/hqNrQRQoea+apuYQPxgzzoLDSyr8RZAAZNGJoR5SevNedd6Vd2DFVkmrTBTiMmJ
 2fDhxkLaF+X7Sz0FgrHA9DKUvGI6OYdK5KKZ5YnYISZ50XZf45bQcH/M9UV+redaFTzI0RJ/cgR
 PTmUwOCjmp3jbSEAH3OO+ddZJRCq9umxTWoT7n0ytfsh0k8SZg/vH7D0BDD3FxErUyG4hobKhSB
 InXqo/v9wgQLf96z9by6Ywibv6ZBZ2zpklLnsr/HxsTUoK+28S+mHuXvXWJm68KdtV1CnAPRhWX
 Pgl0NzyQKOW2nX64RpJo8qradFeNNFYBkqWzEQ7ljDM1FRxvf1bFTe4WnzkPe3BoR3td2cxBGbt
 gpMdsR+b5g78rudvez/oEu3dVh6FhlVnO5el8N0lou8cQ==
X-Received: by 2002:a05:6000:4615:b0:45e:dd32:92fa with SMTP id
 ffacd0b85a97d-46067be6a45mr1755204f8f.12.1781164114244; 
 Thu, 11 Jun 2026 00:48:34 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f368e9fsm74517404f8f.37.2026.06.11.00.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 00:48:34 -0700 (PDT)
Message-ID: <6a2a6852.b3e625ec.294455.628f@mx.google.com>
To: "Ricardo Branco" <rbranco@suse.de>
In-Reply-To: <20260507181045.19489-1-rbranco@suse.de>
Date: Thu, 11 Jun 2026 07:48:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 1/2] memfd_create: move sys_memfd_create() to
 lapi/memfd.h
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
