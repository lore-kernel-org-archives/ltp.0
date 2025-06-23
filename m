Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F177C7115B
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 14:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750687510; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=zcNXlr1w7hYell4UDCNJ2UNV7czOUSoSdcZ9bdS47DI=;
 b=ouBFPKwKMfvM0M39nO/5WxER9nntEmFLMZP+31QLn74GDejFpePcqQqyHncGoKKYGOwG/
 SveZREXut5A8ZJK29mLba4mcyACidPZDfUy8FvbX2RDFLXBuh4Vdzd62ZakKl3xzhEn/r4F
 si35poS8uJ8anYhiF1i70JnU5I/stbw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E5E433CCA5E
	for <ltp@archiver.kernel.org>; Mon, 23 Jun 2025 16:05:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 73F113CBFF4
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:04:49 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id AFD5B1000980
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 16:04:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750687487;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tnK5uor9VRtEeSoTJwLYX7HXdlRp5fzJX+lLAX1kWL4=;
 b=aQaNvhkr6b9ubpCUGJTMkVpb/LWJpSW8MNm14aNc/LUFiC/SE4SgYPu3A2lgBm0rEEUxfR
 Ib1xW3nPgAnaxtrTk1jvPSyRKqUQ/7ETfaV6f4ziWy9fvQUHuJQeJmLIZOM61Z/AgbWCAZ
 wQTgPK75Bg/3BBuT054QP4hsVfh3tlY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-tOVgSWR9PBGo6mqzLMkjaQ-1; Mon, 23 Jun 2025 10:04:45 -0400
X-MC-Unique: tOVgSWR9PBGo6mqzLMkjaQ-1
X-Mimecast-MFC-AGG-ID: tOVgSWR9PBGo6mqzLMkjaQ_1750687483
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-311ef4fb5fdso3718780a91.1
 for <ltp@lists.linux.it>; Mon, 23 Jun 2025 07:04:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750687482; x=1751292282;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tnK5uor9VRtEeSoTJwLYX7HXdlRp5fzJX+lLAX1kWL4=;
 b=nZJJqHHVkeTFe7cOGB9l+IEkSZMLb87TsfY8JPor9SXEATz7hItP7tpGxdB9PUAQcE
 ED7pXaXU7SiA4x2SRnhaYrR5AEBWKUkupL7PWfWjWGBJpnIOm5QZGQwjfREPp3/dbSct
 vx16w7rRQHUthsPeRMDeaAaU3GgU9/9gjWRqwsGwcQixO2XJt8l9mvk995SGQEUqNRR3
 2BLbRT40C2vY2r5DrIaVJK6i/mDUEn4nkS5PO2UlUA6OKlwoQWf0gZc9xRV3Ej/ziI9X
 qbELfuc5zeQZPcWhkYRBHgreUViJ6E9wy0bMUMwhrycT4ZbzuowBRy2DC6xF+gDqz+a7
 +whQ==
X-Gm-Message-State: AOJu0Yxr6dbNVvGEkIb0H6P/DBuIWbNLU7YNj7Kk8dXqBo3krn94p4xX
 8Jt9ocGkVMs52zkbZUeEL3jgutgQjCeXwhOxto2/q6Aeau/mIGuR4IRv19NtWA0WA59IrqVqXYJ
 H0R0NWx05PszALr9uDMDYB8MO8Lg0YxO/bvM4n71GILSL+NMl4YBVF3mn9dXLrTYBqkJRgWR5pU
 UE4k4lxTCBmx5d/+BHPJtDLU+ayzRWm4if+Tr1Lw==
X-Gm-Gg: ASbGnctEd5R07zaZMvfEsUlVE8d6GIa0GEBxOYe4Tq/ACWM0lkk9JLw6j6v4kQ2bZdh
 DbGDuPIrBmOkeLW85OpBMiNQNDHB4hpNkHJTaFBXO5ZzCyskBNhqjGvG9fNZJ1bhrZ1IikdAj68
 2dTS3/
X-Received: by 2002:a17:90b:2c8d:b0:311:ba2e:bdca with SMTP id
 98e67ed59e1d1-3159d8d9c25mr18375671a91.28.1750687481947; 
 Mon, 23 Jun 2025 07:04:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPeTm2to/IeAMnmgDFl7rOUN8VuWDi7KQe1/g7cjr9QOKzp39qKR5xyP3nmSRuiRiN0ChPwuhfuTtLJkuqeCA=
X-Received: by 2002:a17:90b:2c8d:b0:311:ba2e:bdca with SMTP id
 98e67ed59e1d1-3159d8d9c25mr18375626a91.28.1750687481547; Mon, 23 Jun 2025
 07:04:41 -0700 (PDT)
MIME-Version: 1.0
References: <20250620073000.514444-1-liwang@redhat.com>
In-Reply-To: <20250620073000.514444-1-liwang@redhat.com>
Date: Mon, 23 Jun 2025 22:04:29 +0800
X-Gm-Features: Ac12FXzSfMIj3tUqfNeCa_RiAKV-Ms7aQsZs3IPAt4iVVLHcu45o1l9JVRfgkws
Message-ID: <CAEemH2fEjvSBq_n7+8TWUxFkKqwCp1rguu8O+sM7UVhgDpBcdg@mail.gmail.com>
To: LTP List <ltp@lists.linux.it>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: oNqIJY6mwKxBCQ4TXlMgO44jeeEkDe3NXRa8F2IaLiw_1750687483
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: ensure multiply_runtime() returns at least 1
 second
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Please ignore this patch, refactored into another one:
https://lists.linux.it/pipermail/ltp/2025-June/043983.html

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
