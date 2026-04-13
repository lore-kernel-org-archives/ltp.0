Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B769F34C62
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 15:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1776094558; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=yvwnLrLiuspgQYCQPvB1yVOGta7eBH3j8+LmmtPNbiA=;
 b=Diy7rEnK0/S3JpQ2CC3+2NSvEgHMuf8rX7TyzvEge1kta5+knPrN+QoLD9d/zL/y57KG3
 kEE06Hwqf0gwQc3ZdwqQx85TkCZA/KaZgRaSt2Gpt6GOZpojaWSi9yPxLcUKCUiiLQigKpE
 VSP7En+2XuQ20tvTynyZnRtjp6shMh4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B70613E4B33
	for <ltp@archiver.kernel.org>; Mon, 13 Apr 2026 17:35:58 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 917DC3E1DD5
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:35:33 +0200 (CEST)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 11659140097D
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 17:35:32 +0200 (CEST)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43d75312379so917507f8f.1
 for <ltp@lists.linux.it>; Mon, 13 Apr 2026 08:35:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1776094532; x=1776699332; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=xFR9tQxP2RYupFBjEQiv5fFz78IdS+i5mfOrHx7CPxs=;
 b=bMZdD9GD3YdFdGGujvfBW7UlEUq6AxpCP4Ouw5Y71fwFRAgHqENPjB+3GV4AUTiSDx
 MDAWJjQCFFapirxxSUIWtJ4smJhQqZc+A+8A/h0RhGf52gkiA+AB3FwrzogNURh4mWlT
 WmFWwiR+O1Iyw1z3vX5kN9tt3G72VYIO+KakuJA67PVYqSkXxJ0YwFapPZ0cLm3sewgi
 MOxoaqJjK2sRDRu6SlnfIFtYKtkoAfu22KhEbv8C4g7bLcnTsFWqXFuUgoHC6lNwJyHQ
 ViPASwFIPKlC3aHQk6M2CBKAHR9K82oSz1CqsulsRxP/6xEqMRWbRrgemz7/7QVSTfg1
 wIkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776094532; x=1776699332;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xFR9tQxP2RYupFBjEQiv5fFz78IdS+i5mfOrHx7CPxs=;
 b=B8I4fgv8nSaWnuTA0/uLP6eYQ/RL065m2rtlFm/5GDHxNj47Ifw/evyJkTVvajhPiN
 CWkLX3fgDDz8knKPIri25XCVMD/AbHWKFlhj0Ar9zNTkWTb5poFufd5X7CbsUJ/EZKcC
 ivuSsS2yzbTlC5efTgLVlUTBT+rq6yls957aXIZQmjWMDLerQM7ukFaffyByxRTxFia2
 krsclhdUyKhNq9S3GIx9TWNkvqMkdAhtVPWxKd5jspw2Lqnht1XqBYcWMe7FWc+gocMl
 076p+u+XenL5Ozog4Uq37x8jH2bR1py1YuKMLGBUG7jquJ60JMlE/F3SjVBsgd4E2qF6
 z/dg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8wlfoPCFENWEAUwha+7ipIfwijhG40/HuTlEmRE5l5xuT5wiRvWMSQ820aFma8EzVuqnI=@lists.linux.it
X-Gm-Message-State: AOJu0YwlMioMb3/SNHTKizrdQ7RyLGlhw6XRlicy1zD0hhX1CujDQQ6k
 F6PfOOXWzHeRGbw7rf/Ri51dO1EcxDY7kVkk6F9aKdx/FgXCBE45KzrDFzFVXKRCGer1fWNWadL
 hC+f5DnuHlg==
X-Gm-Gg: AeBDievG0GODB3kffiRtwNMUBBOt2lM9riA22Xnw9kdkhYZLmDGj64lSpY6w8RCRjo1
 /MNzSLwWoU1S6CyzFv6Bqhg7k3Ej9jPcpStnjG4y9/RlAKlpcnI/EweTauXWQ8lKzspFgfju10/
 DOm//5IpLkiIGB7uvKfDptsTtPyodly4zMGUsx48a1mufisHBQNuTGRkO/Jq5T9ZCtnh69bIeRk
 799s8x1kgLA+3cP9C2pIM5IZNgVP3L5o3QNnWfr4pIEnr19CKffl3Nocta8Q0/+3FewoUz+Hq39
 RxEyMrt0ew7jEdNa1eEYyCq+b1JPI81nIdWwCFFGSNIbhzhn0kEy2TIcEvaGHjEdMh6TjDtO7vH
 jNgFI3e8FI8EXFzbqu0xn6N87V8iey2cLVSbpP7VQPSFjojA62oFRdogsWgwsaosbMy90nC2pbQ
 aXlUgNIikcHlVV6X8/ncAuYg55oKojXS3rdnNEHkIx
X-Received: by 2002:a5d:5f94:0:b0:439:bee4:8a93 with SMTP id
 ffacd0b85a97d-43d6497409emr20107081f8f.12.1776094531902; 
 Mon, 13 Apr 2026 08:35:31 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.18])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d6ffd3880sm18305235f8f.7.2026.04.13.08.35.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Apr 2026 08:35:31 -0700 (PDT)
Message-ID: <69dd0d43.5d0a0220.8975a.1b36@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ad0LDXRdv-yXar8B@yuki.lan>
Date: Mon, 13 Apr 2026 15:35:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] clock_settime: Detect external clock
 adjustments via CLOCK_MONOTONIC
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
Cc: Claude <noreply@anthropic.com>, Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, thanks for the review

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
