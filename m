Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E732AD29FFF
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 12:37:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768394268; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=FFkBB21FLzvNW+uwhjqj1h5gyZOx/pl2FuaUwZq3wYg=;
 b=gF/iLXIa8snnbsLcYJi1RgXJhYJU5gMihO5Tk2eamGGVi+YWnci/0zdL8mVUKhiAEbChT
 XCazZEFg3m1C+RM8igMZ+9k9XG4jO7NTYk28AlFarbI8+HdibV7GXNq8wYKMWio1RIgmYnR
 6pAVnxEMo1NSKh4yX9u6qmVyMbzuEN8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5EDB83C9A81
	for <ltp@archiver.kernel.org>; Wed, 14 Jan 2026 13:37:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 973383C1BDB
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:37:24 +0100 (CET)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 35E711000989
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 13:37:22 +0100 (CET)
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b872f1c31f1so374307166b.0
 for <ltp@lists.linux.it>; Wed, 14 Jan 2026 04:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768394241; x=1768999041; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MmgycmhbealqDJtUyf9ABkyEgUxZWMHrOrDBv11mnf8=;
 b=TzhDSsxLKDRgNBr6ZHyqpjqmfXiFdtg3DsxnAnAZcXCGNziwAFQjwi6tYVEvCO5a2V
 Yddgx3PnPe8cbJNscFEgmXuhBduN1ED1Uv7xb49g9NcbqDrPyspwbXPdU79ves5xK1c5
 hDgR49pikHLytDx6d3lLbmzgIzYzRWGIFSvcz7y03+cKy3lozjxQoXUKaekJXFuDNWbK
 vFEYaS2+Sy1onUmrSEoETzw29M6vY2qUQymdH5zjkAnLN092lwuowftPDxZSO6byWnXf
 EEJrYd3Jr0EipyzMiJM9rqFDTwzmwZVPChsaAj6JOiGBpxFkHl1nLQETaZSlUPE/Ubjx
 NBKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768394241; x=1768999041;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MmgycmhbealqDJtUyf9ABkyEgUxZWMHrOrDBv11mnf8=;
 b=MR+P6igB5mq9wuAyt8RfRYvTJBNQcg3EsU5VU5QJ0Ma3fBVHbcIuwgNti9f2Rr4hM5
 Y4HpFRkvf8qdaI0rz3Uhl2y/hOlRPcVYUMkQ0ZZNNx/uz7phNa9gbxj7t19gIj4Iky7X
 LjILnH6Y2GnZqUSfYNd7UoLyBwd+JuwkVv9VE1RqeS0XJtZsVWXNsG4kG411oVhWscY0
 HiKVOLOpG1l50nKyoeNXmUQUFm8bWFYT1rRXJR6+vQQdZahz4oYucanhXyNMMTnEdLFe
 xVm/op4XDJC313Nhp/zTmkGdB7TcgUq3TRwGCAlZiuBideRRoetBihD6Gn4ZzNtH/+Ub
 L7Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm270Nj5CMapGUKwZe4ycg4h9i98wuM4VCJqHi1Vx23lGxb9IZLZRMnSaPsvM5OG01wbg=@lists.linux.it
X-Gm-Message-State: AOJu0YyzsJW+3XNeTYsDZgmIX4iMamFnRCB/6kW1ghzVwsHHiKnnOtnt
 j/xn0VfXwEvsPPY5p6KwQTNSUWOg6i6/3QFDmA5wXhTKFxV/Cc5e3xF8iEVKpE4SztWNVBI6O5L
 j7pF+eT3fqQ==
X-Gm-Gg: AY/fxX6psPibKSTJI8Q6uUZaIJskaD5qvUKxJk40CYwOHfcL+upywCdPGMxNT3nnJPm
 7g42xqk14lEtSivOVYRizSxvxVxqCeZtrr2yZsdG6yycJpm+5vjip9hNN5D4pTQZ4rjZtsAL8X7
 6+U9dbGPmMNQaSuwc+mgM2Fl424b5wVjXd4cwTpSs3TZG+iD0DpKLTppD2XJZsQCM1jW5ij8gIx
 qlaFS1yMCCP/B7gN9HC/TKifvjBUhkqsZ6EyEtywuERgecgjg6bkz3GFcgqNA0jMzBu7dR0+UXS
 B8Zr6ZBRfjqxVFwzFtu7O4AXxsCBZF8hbB73JQuf17RBgPYDULTe2zFuho/iwjZYDOlQTD7klgQ
 zMWVMZvWjD1IziAhRwLClXANcA88P26rTdD/OY6AC9oAtOl8eDoO1VGMYo2wdgb6kSHjUYB9cXR
 sK4PmXSobamIqPLwEFMCfh2NFRDI0auex8dcrXjaOQJO6sMKEhamSxf8C3sPkTmOpKR+B5xeR6a
 sYP
X-Received: by 2002:a17:906:4fd0:b0:b87:1e3c:2a5 with SMTP id
 a640c23a62f3a-b8761110d37mr212630066b.35.1768394241498; 
 Wed, 14 Jan 2026 04:37:21 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b872152ee10sm792417766b.34.2026.01.14.04.37.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Jan 2026 04:37:21 -0800 (PST)
Mime-Version: 1.0
Date: Wed, 14 Jan 2026 13:37:20 +0100
Message-Id: <DFOBFUZVWV2N.3PNMXB89R5OQV@suse.com>
To: "Martin Doucha" <mdoucha@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260113150202.68070-1-mdoucha@suse.cz>
In-Reply-To: <20260113150202.68070-1-mdoucha@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] aio_cancel_5-1: Rewrite test
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

Hi!

That "we hope to have enough time to cancel at least one" sentence in
the previous test version should have raised more than one question..

Thanks for fixing it, I don't see any critical error.

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
