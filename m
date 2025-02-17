Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACD0C021A0
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 08:52:19 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E7FE63C9BC8
	for <ltp@archiver.kernel.org>; Mon, 17 Feb 2025 09:52:17 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FB7B3C92EA
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 09:52:02 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A974B1A0037D
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 09:52:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739782320;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mw+MCW5ymZSFZmnR6jaF4tlEZApAJbc/UPWFLmapvxs=;
 b=evy0lPbq4vprAVUYPJ0159JtqQ1zuVZN+9hKc3UUMGanoHpac1AjZWyLfV4j1lyIJ7sexD
 8pQChVZBK95xvpFE44jG4qv+LD0Z0AWN4zPb0+oQIjiftnl/xxKnf30x0nhO1PV4HjS3vC
 h2owK2RAiWUWEDRXShin542qediMOjM=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-dazeD-tYPG6bX7183MxGUQ-1; Mon, 17 Feb 2025 03:51:57 -0500
X-MC-Unique: dazeD-tYPG6bX7183MxGUQ-1
X-Mimecast-MFC-AGG-ID: dazeD-tYPG6bX7183MxGUQ_1739782316
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2fc318bd470so5626247a91.0
 for <ltp@lists.linux.it>; Mon, 17 Feb 2025 00:51:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739782314; x=1740387114;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mw+MCW5ymZSFZmnR6jaF4tlEZApAJbc/UPWFLmapvxs=;
 b=Dvu4Wap7Ucazw2dciIVt4eGwu9PO5dhh9OfIF4aswtO4gLK3fmlX26lo0SrQb5eZO5
 N91+YZeH4Gt8cxxmVB8MFIKzWkyQIzZhW3aVw3k5iP+WKjVPbLlULAu+mXQSOCnnZgJO
 CcMl/mco/elCXHY+PC4gAIjaCgZm2Wat7+0c/Pv/lX1iqDg/GC2Z7qvdzHAGcgmwRMoK
 LXANLf9t9ilnmBW6aQEfuVm4+g6iEalkUM1zGJ/UKekJZ1igKK8DmJEjuxyZJLizNooz
 6ZXC4LkxRXtRHhVvdUgsgICHynIh7QNVVe+67azpkTvZy5acIPJkkO4Ip1wuh344lHXn
 cVCA==
X-Gm-Message-State: AOJu0YwkyJlp7XEx/Txu9JMHxIzZoIpUsn/+et05tRnbXDgug6IDsfIQ
 B/Rty/nM0rnIsXcW0apXaKXHWHiCSqfZFqp+Uq+dTXQqdTgMBRfoRJ3MC6fekHNzMGSlMj5doaJ
 tqOmKJy+Jn7aWsUKgwbHEdJA4Fi1y4BC5m3uJlHO6onueDHeZ810swaCAvhWEdHskuu3ij1/ixV
 vTiExTb6eZiBwHQFWVjKtf3UinN4g1IxKG0uv/
X-Gm-Gg: ASbGncstDoKDyIryQA7by1Bf415AeyweCvFqIOQzHqnSrrr2ocwxDcxQhkdLMsIUBtP
 n5LzMCkdxreAotBbAP5mWpzwAlEwR++79kvx1AGq2Om+YSeWWQvMbB42GBOGvZfg=
X-Received: by 2002:a17:90b:3e8e:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2fc41045052mr12975585a91.25.1739782314664; 
 Mon, 17 Feb 2025 00:51:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGvftEjC50HnTJ9Q6sVk9WDTbD5JKUk3l2/5YewFpnO8KjzI1dp0GayqdSymrxxXeTyeG2efkd7pethbaVDAEY=
X-Received: by 2002:a17:90b:3e8e:b0:2ea:3f34:f190 with SMTP id
 98e67ed59e1d1-2fc41045052mr12975571a91.25.1739782314396; Mon, 17 Feb 2025
 00:51:54 -0800 (PST)
MIME-Version: 1.0
References: <20250217084833.2365977-1-pvorel@suse.cz>
In-Reply-To: <20250217084833.2365977-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 17 Feb 2025 16:51:41 +0800
X-Gm-Features: AWEUYZmhk8jEYnopZKoS2LzNGyaGao6vcnGD2sqVulKhpJ35Lh9Fo3qE2fuuzjg
Message-ID: <CAEemH2dbp=-3xR3YWfrtfPVhXueQz3ZtJPuf9_49=pEe9=R2Zg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MAZlitQ2eiuJTyAvRbPtEYDGxSvnUq7CbYL1cdHVOmY_1739782316
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] doc: Remove [Description] title from shell API
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

Reviewed-by: Li Wang <liwang@redhat.com>


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
