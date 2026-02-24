Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F4DEFB801
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 08:21:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771921264; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=pFKGb3XjR89SAdu1+gqjtZe1BGDWLbKtPy2wxZnyRCE=;
 b=SNjcehgaDd1FA7gUgh2qQI85T9TDkHEFdWxFXtLk0B63TNbQq9U1L8u9BGZC1NCVeMfFS
 mdHeOVk9PjIKNOBQOpQMvNno7ebfDXNLuMKyMLp8dUrwj66g59F3wou0SGrw2jrNA3dT7iW
 Hu/3qi66+cckfdejUGJCTvnPwrIQbb0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 328963D0F75
	for <ltp@archiver.kernel.org>; Tue, 24 Feb 2026 09:21:04 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B3D7E3CB958
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:20:39 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 28ED21A00800
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 09:20:34 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-48371bb515eso64879635e9.1
 for <ltp@lists.linux.it>; Tue, 24 Feb 2026 00:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771921233; x=1772526033; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ULYcA6AKrfVpU75JsZ+gol9sMKqBusBLViTobGdD3kM=;
 b=DX7N9vDmtDUk70G7hJMTK2NoqnkoFr7wdrSd3b3MwLh/tUBU6QdefVfhNFyz1tWt/t
 /uPv7TgAfiCWcjTLewnE5cM5Icbgd1HdyTq+DBaPxJCZUHoZD8r45oLUquzfgR+CAvXZ
 rhjMvXQARDC2VE1tT5SLYVAQ0CyoHfPMfIr+12zmmh2xmgK+nqJlxL53XprvqupUDD/U
 a4ZcitmK4+htSet+2RwKlDPT6DUvEfVBB7PtE2Bt62ZEDpGEs5qrdMXlLV/RqOjO1LIS
 rfRjJYoTKiWIVd0kSnUhdESy+fpDq7rv78MO91kHA4Svky2pahqUDadIbiAJKcceWpI6
 RKmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771921233; x=1772526033;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ULYcA6AKrfVpU75JsZ+gol9sMKqBusBLViTobGdD3kM=;
 b=ZsCpKJFv5eiIExMOeS/qFZTp4wtf4Nu4ti6JO1tmnjRDTESU/8twN1WPCG1ZNSvHbe
 3zOWKhNNMiEPlMrk8lFM6U1ZG8AUdRFGxPCj7XhsgfQvX40jRjnpKAe74zujN8yYmp4k
 6NAqJGpIjAzzElIk+dwcMp9GXPbekLk0hckzfPFSC83iearMtDYtEIWEkuLewOTkLvoz
 BWwce8kmFPwTLF8H97hE2xowvj/qwabDj6uvwtftefn6KrKnDH1WniJx4fvgFfDy/QPa
 qCMe2vFprg1h8qGGMok2Oxobi0zIa1Q0K35V8B2unXtwDa8MeHh5lvoHUazeJjkVP1Sr
 NvHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm9xAoH3I/DVKyWHF1KrrChM2CLZePTvEkHyOmT1CFVZ/2rW9ZjP3I742LfjkJYlZNkEs=@lists.linux.it
X-Gm-Message-State: AOJu0Yyoaoy2U+Qbz6/pAPizdL7FtxkgRTvtGTABnZpiAWiOn4Nm7RjR
 CMGWmcZQRtzHJGMnZlZarUDmN7LLZVuXI9yCQwzxBQC4Ry9sWLjNKroAusPUKOH3i2H/asPI/h8
 9roRZUMk=
X-Gm-Gg: AZuq6aIey5X2SEXI4Eoaw4uG0YtFF4mWKw2Qkm1aL4Mz/vEAv2IBQACdSk/nmdOxosJ
 EG4rY92MwcZU52/SvHdflhj244H3LKM++YUGQrs4V5B4fcuQcyAH2XlRBhc8hwIkGP/Meh9lxJb
 WKTeLsyYFSdmjjU/+gYbiq7KW8/3KRRHS4lZIf35nJsgXZHJ1fBANh4DRjrT2Fl9xe3TqwfgxTK
 /uxu+mXw2nRB8ohD8xKCZ2CiyXOJKeyhuW/q03msV7juAOAkg6ei7NChxgPFLLSZV//Wv7OZmyk
 xuSIpMIVk3Iuau7lj+piguaYU72uCLMRwOxKw0n6WeMkibgUTnHTAMUutaixQsI/Cn4LYXXL8ur
 kIt6DOUuJ/o4ZhsJDBBYPqbfpYYF1wdXDo2FHJeueXRrR61isiKNUWT7yeTbt/yXCPYFpi8eCMn
 MLxg3EfBsgERcVPIVM2rA9jRX7myA1gMRqkaeOc//wC8qkYJ+BRt0ymSethQkiH3ezJGuQP6gZG
 6olZ7YXv83RY5Hg0ew7CtmRG1zOtQ==
X-Received: by 2002:a05:600c:5020:b0:483:71f7:2767 with SMTP id
 5b1f17b1804b1-483a95fc0a9mr204296455e9.11.1771921233469; 
 Tue, 24 Feb 2026 00:20:33 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483b8195f50sm21096865e9.0.2026.02.24.00.20.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 00:20:33 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 24 Feb 2026 09:20:32 +0100
Message-Id: <DGN1NKQI9KLJ.1C2ZYIGL9OQ61@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>, "Linux Test Project"
 <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260224-remove_runltp-v1-1-7baa79b65acd@suse.com>
In-Reply-To: <20260224-remove_runltp-v1-1-7baa79b65acd@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Remove runltp leftovers
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Forgot to keep `runltp`. Sent v2.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
