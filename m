Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6565CC3DA49
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 03:19:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A44D3D15B8
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 05:19:10 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 432E13C05D2
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 05:18:54 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 442FC600BB5
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 05:18:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720754332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gE7LA+X8Bnzua77IRN3A4E5IU1HeaJ5AMiXyncVXpuQ=;
 b=WEDv4vyWM4K+wWSs7ETy1GpKZ83vafiVsCCh1kDXwoE/a6FgRsPlC1eOd0wxBPs8hTP1Zc
 d56cPyvlR4RY9KqjySbLgQYyqLAdvBhPSp3+HOGk27m1dCFVjEsIKp1X4upNaRE7/xPr/8
 RnT4Az98vV4hkR2M9pKX8Qqzz84n7Bw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-vTLjpdSmPl6HLt91YzS-hA-1; Thu, 11 Jul 2024 23:18:46 -0400
X-MC-Unique: vTLjpdSmPl6HLt91YzS-hA-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2c9015b0910so1968458a91.1
 for <ltp@lists.linux.it>; Thu, 11 Jul 2024 20:18:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720754324; x=1721359124;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gE7LA+X8Bnzua77IRN3A4E5IU1HeaJ5AMiXyncVXpuQ=;
 b=dlg8nwK5FmHlLXepbNSkJRfmhwVoA3KR+tbvj/LzPjZKcWAt7qkUgopoOSVZeSJe4F
 4ztnYM5Il7tyiaX+6OkQFLmB35ruBhHF5Pp0kNtqRDd79KyVIFanOXRx8SZXxgpnruwC
 3iQ0tYa4NwX2b3OERTAk6NAQUtKm6I/ZSFr+cK+VSkHmxwLnrQpN/Gg90EjB0E8yyRR7
 pkBnEKn9UGzsVwhGbkaEzGiza5c+f07mKWBKRjmHRusDXw27Ymu5D+BNFBng7E/ysXP/
 4EPRJGnAK4KoLjyPgiaZkawUPdsLRXiqJFIICzyt+0O82b6QV7ZgeI86h4mpTAJEJkWV
 KJgg==
X-Gm-Message-State: AOJu0Yy0qQQOvA0lLXBCwng+iZM0XvQSWMpH3XvSDjIWe/FHgePXzgtl
 z8L61oAAhtO0q+YnCqBxYFA/0+Bs2f+z9Rl/kRGhRSq8xvrCpqmexCfa9FyDSLM40svpInXjS1P
 S0pXyAWC4Z/rVIS3Z17QwSlCFvG/bupDAujx/ZYtyH/lS+aQyMrF5vODNm1q473RcZeUNA9ATyx
 Ka+zh2SXCIcmiLYI3oUdoK76ti+ScFggWE8g==
X-Received: by 2002:a17:90a:d3c2:b0:2c7:49b4:7e3a with SMTP id
 98e67ed59e1d1-2cac4ce5600mr2265512a91.7.1720754323995; 
 Thu, 11 Jul 2024 20:18:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE4hPEJqjgAsCyYTzeGa9in6Ls48t2QZDPjXYwYPt90Um8DQhrGqErX3q2FAodaSNljDqSfyujbfAxlJovqgdI=
X-Received: by 2002:a17:90a:d3c2:b0:2c7:49b4:7e3a with SMTP id
 98e67ed59e1d1-2cac4ce5600mr2265492a91.7.1720754323657; Thu, 11 Jul 2024
 20:18:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240712025149.11527-1-maxj.fnst@fujitsu.com>
In-Reply-To: <20240712025149.11527-1-maxj.fnst@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jul 2024 11:18:31 +0800
Message-ID: <CAEemH2dcDuquydAZdpM0U1MnkK9XbOPriQqiEEXRgCDcXbtpJA@mail.gmail.com>
To: Ma Xinjian <maxj.fnst@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] utimensat: Convert docs to docparse
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

Patch merged, thanks!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
