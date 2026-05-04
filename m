Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B79CD342C
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 10:22:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777890151; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6APpTMucsTR+c/NKhU1+lj2MbZjiECAB7+EMGftWcg0=;
 b=YkzShihLapuCit413N8dQARVe3TZC/cBeZgmnvVWzyngEFo4dXk5oDjCB/xOOcRTXF+WN
 jX2WgKkgRFUCQNl8q/1iqRKljfQLndv7mQjhF/nmEDZ9XIzY3VGIRxXcADtRxPD+QPjqwAa
 OwC5VuQKpKAkCaxvJU/VtavpKgO4gkQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 711EC3E4AC0
	for <ltp@archiver.kernel.org>; Mon,  4 May 2026 12:22:31 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7201D3D227E
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:22:08 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3BD6A1A004E6
 for <ltp@lists.linux.it>; Mon,  4 May 2026 12:22:07 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-44ce78ab5feso1210667f8f.0
 for <ltp@lists.linux.it>; Mon, 04 May 2026 03:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777890126; x=1778494926; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=zBlpesfxJ+BBOpqfPLO4nXZhQMtM2hRmCpCSWqVVxXA=;
 b=OoRTxkhDE8aZ9ccycDqZxMpw6JnQ1qyqrq/JxVJH1sex/gBhF9DQ4YhxOUo0DnI6sO
 Zi4ieBOjnHlIJyR9dmUfyHLWiP6qYbPueiP5jreVvmbIu3lokKTJq0TVN33/GbNPEEu4
 w/oeBdiPWzzwOsydSSQCYRLgA/1cOkUaSCZgAxwYhWFyT9Qv3meRp0XP0YLWL5+d3Lru
 YiiTOYmmKvkh0xplYPjfCL+8KQpESIWxY3g38IXL/+D3G5yJ5hOzZDccDu4cQa4VcFKT
 hfGdz6PFfcWTBTAMBOTLjB5yGJMsczbpbAlxruI2s3mJF923qKUqub9u8AqLJDQdFvwb
 lG4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777890126; x=1778494926;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zBlpesfxJ+BBOpqfPLO4nXZhQMtM2hRmCpCSWqVVxXA=;
 b=Vymn4bHT8pS2RnxABUgVmVYyJhmK8D2DELoRDtj0kBiw/oM4Y4gRxwT14H6YBUtZbU
 El8whzRPe8NpiFjLeGQPxmMRBXwmA/S9p2fBe40lvtX1uWr+yOuLzyXPWYX3uxQRj7xs
 1O0YXAJFUgz2qaMG3yJ/zZ2PTgy37O7al1v7ZwHx7S+WMMxxBS4Y3RAPTORBU3caIyQq
 oAC1xTCUmtsx4XvX0tUXhQ4/GQlqV3mpZxmBRwYVE6clJ/T7vkIGq/TZA0FWEdoqZCUF
 O9/tO6weF1ntDN2Dt1KsIiexkSdlM3GnQy79g57btKu6O02nxTtWWclwPLMr7un3M9mZ
 gBkw==
X-Forwarded-Encrypted: i=1;
 AFNElJ82ayrW3vMIyfEeAJ51t8g87P3zUUXPOogw1roY2Is5tZqVv7tMoJpufh8R9X/RY7aGO5s=@lists.linux.it
X-Gm-Message-State: AOJu0YzD6wH7WlmjyP5pPiABTpFoJhsqW42TwPubY3Cs7vkHkimgGQY5
 cogpGQ2ar7cmsYNs+KSTuWMcpFtpaZeXF0Z1S0w0Ll9hbuj/RzE+jPHhdMFxVXdfioI=
X-Gm-Gg: AeBDieumjpcbZC7exQKDEu+L7vwKtBX1ItNRFyKaaY5EXjRB82x3SIPGRXlaobb+rK8
 8ptWOunlcSkPVK3MZH/z/r9MSySxvCwvHwCEONYCGHdIdp5DbJhXXI1IW65rqb/6GrxMZpUcGvY
 j5wMM6HJZ9ETPmZmRFU9VLL5EaiJVQyfTDijkOvc1jt9AVjtD8Hx90WuXqyTA//YNIojfUrF0e7
 mzGAtpW75o68wTBTXs2egKh/LUtqIQafNoWX4VIVBlnqzrJXaPrgmAva3187o4xtjp4eYT8HEmm
 FZsGQqo30KvRv5GLylfj/9BFRvhkcqkmSFBdcTnEj9AP0e0Q6+2BRZUrV0QzkUO3wtR5xEluqEp
 A0TjHlBMcY9+G5BJMBzqVzQdZNJtcBxbvLgPMTaQZmNXje9i+A37em3zeT0htWhokPmacDhMDjh
 CjMyM9xO2DKj/qRLbkUU7hLbX/Zbfutf+uhDYLD2E3KVG3DNQVZ+vnH+bEla/flVM=
X-Received: by 2002:a05:6000:1787:b0:43d:1df7:ed24 with SMTP id
 ffacd0b85a97d-44bb62fbb4emr16143499f8f.21.1777890126481; 
 Mon, 04 May 2026 03:22:06 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ea7cf5dsm25221006f8f.1.2026.05.04.03.22.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 May 2026 03:22:06 -0700 (PDT)
Message-ID: <69f8734e.5d0a0220.263edd.8881@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <afhs4WvcNbp1msPY@yuki.lan>
Date: Mon, 04 May 2026 10:22:05 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] clock_settime: use POSIX runtime detection for
 CLOCK_MONOTONIC
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> This one should have stayed _POSIX_MONOTONIC_CLOCK since we are doing a
> presence checks and the -1 is correctly handled here (we get to return 0
> case in this case).
If it's ok, i can merge with this change

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
