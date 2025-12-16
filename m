Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8A3CD5CCA5
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 09:56:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765878982; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3Qth+aKF1bqqkXF3c92HhJI+V16edEHkeXk/Pp+iqLg=;
 b=QgJsI+07tWTWa8B2DFg7MwySdTA6i45wnikPs4oTXspw6hpFDXodstxkLfoSJDFxNamJ+
 55+zrVXmSA6Ll+otB5ZDBgQAYt+X0jToVJe5CZGAShzW7f8YJ6Xn94yVpn/m3NnlNy6MNwB
 sb421IXWBvPxgRUuSi9NukIuad2d998=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F37093D0328
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 10:56:21 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A5E03D0323
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 10:56:00 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id C8F4D200910
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 10:55:55 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-47795f6f5c0so28184055e9.1
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 01:55:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1765878955; x=1766483755; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
 b=IeaDS6XWFqYGuCQsLHMGW4dIw1YItmLtcp30dODHaH8G/JIJy1U8vzN4/MYSOOFz9I
 fVwd3Qof8Jwz/26P48AKfqa66vAZmx4iCZtbop/H8MUWb18FT4OiuQ2FxClp0iHnpL8G
 M4qL1IqGg98qkn4jKJTMGY+9Rxq3fQuOcqQuhuR1xj0mUWncyvPXVtXaJ+UJBIpiBYMw
 DTbcYgCAp28wV6mWKpUqIL99yj8dfxGDna1J63wSTZt/VqenQwmimrH0BGA7EMbOFY2u
 4wccRF2b7UGKHT6y640UJLctzyN/lvDoHiD2PtaQNqezZfqDWarn15PxUZ9WtiSGS10E
 U5nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765878955; x=1766483755;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v6qSPbazIbEay7EXZFe9DGCkiumHopuzf+llzVeMCzA=;
 b=laQB0dq7mjJ63W+04vgUARkucpXqxWWTnp359iMzYV6QiFIVZCwQB0HvB0FaDUuTfl
 2+8I6L+sE8BeTY+BpPoD3P8LCGZEaeI0khBSTr0I8StdT4QACG0/fPmE2wyCDoP+WC3T
 9XV/evJe2UdmI1vF8m229gI7LZPVJkb+BYfhqra8CUYwy4U0VDf4ToCza9TdUg8EkVh0
 yHBfDJfZGQb8lP7UOCjSoCCRhZNOmkKY4K3Sa6ssjkL2ct5azlJGMMR+WLBM7fEgQBhS
 FwsnPnpF+ERDoo+iSsTj3xPQ/s0ZkqgEnfIVBw11v7RyVUY20nwbUNdy4I9cII12aD3b
 liMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKTvcgI42oLxJ7wg+jKEpFKf4BZ8eXmhQ//m7DExs18x2JHPastkv0gAeV12eh/k49pRY=@lists.linux.it
X-Gm-Message-State: AOJu0YzFhmKq7qvGEoXXyBC2lGmD7F0y8jYYVPJKORepoPM9B8A9SOEz
 i3zNXVOEcwMMhUzoa+D2PjIxLzkl4lBZocgJyTi0TJDQ+fE/mmDSrJa29pRFx+CrIXc=
X-Gm-Gg: AY/fxX6Z/iAtrfU4Q+DOlPbuuCdjFAfAKnsAQOIyG2b6hJtRbKQrN7jRi78cjnlZLqP
 9nLM3sdwYYDTTxWmRibFdetV41Q460krZbJ+5P1+WdsIhZz1UzbNWFF9AS3MaDillXD34y2fQWH
 XoZli90CUm9maes3GtJZSH4e1ztzrAe+WfL61YmbSfMfmLJaMKo8xF6+3dwFJeLoNo1Yk6xvVlB
 NgPqxVIAVR8yu44RBd593b+P5O21CusPs9Nc95vFYy3Aj3JJSxBPMiwHDCtJUZqfKNJB2FIkSk6
 HF76msLGppSfFN0t0OH4n5h4/2v4oErM/yGz9RfKsIi1eB4d6UHtEcsbOENQfiX3QHh69YNVbFI
 y9ZswpVb+sQF2D4loPzeeeZ7DgOLQsveXsGCLI6C4cmRXJ84xD/+/4J2Z9yyno5TJGOzRbsLMLA
 Ns8fOQ7QgqGCW5Uprg8ZQ=
X-Google-Smtp-Source: AGHT+IHVG/5tLgeX9lKKllhXy4OLKTMjwaMgOmEL5Z/47SH1UmyNaMk7+S+ymlyPRDD4ez9W+Qs8ww==
X-Received: by 2002:a05:600c:1d2a:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-47a8f7039c3mr146487405e9.0.1765878955168; 
 Tue, 16 Dec 2025 01:55:55 -0800 (PST)
Received: from localhost ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-430fb078e56sm13668810f8f.21.2025.12.16.01.55.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Dec 2025 01:55:54 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 16 Dec 2025 10:55:54 +0100
Message-Id: <DEZJUGBX3UJT.3NRHNSS55B7I2@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251208141321.696537-1-pvorel@suse.cz>
In-Reply-To: <20251208141321.696537-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ima_selinux: Fix requirements
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
Cc: selinux@vger.kernel.org, linux-integrity@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Acked-by: Andrea Cervesato <andrea.cervesato@suse.com>

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
