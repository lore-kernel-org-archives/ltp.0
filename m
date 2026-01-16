Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74487D4A609
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 09:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768554310; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+LntvkjARTg1DolTBEN+phxoMdxcUcJrKxCplNVpgXo=;
 b=C4LrHrXqz6Pscii/vuXMt/i8qkbIDkKjsooMPmq53lMCmux320wVNPryGxjE3FnJVYAfL
 ivvG8GykiySlgAj+c5GmFhVHD3P+zxwPUpA5fz8/Lmua4+lZo15VFVESv9tlsOFvAER1uaB
 O+rWrmm80njVXBrB73z5cPlE7xDQWB8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C26D93CA524
	for <ltp@archiver.kernel.org>; Fri, 16 Jan 2026 10:05:10 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D30773C5F64
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 10:04:47 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4E0376005E9
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 10:04:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768554285;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nsB7/hUwSEUgw4K14tRIFvgw5bFwvMK/lNirs2pSOb0=;
 b=QlUoBBZL7r6zn9MnBZRwIPRFNMBNDmLhl2d3IVzBEho8o6eSBcTBrTHaareS9E5zbzevvh
 csgrvoJEuFnawwFAUg0kveCDePQAbJU2z0xO1Fm3w1pb7JyF8kgpL12xYKXdEcnLC8SehA
 gbBbFLjO7E2Dv7VVB9PocQyMapoLFUU=
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-aRW6TQ-HOYyEuXuFkJYz_Q-1; Fri, 16 Jan 2026 04:04:44 -0500
X-MC-Unique: aRW6TQ-HOYyEuXuFkJYz_Q-1
X-Mimecast-MFC-AGG-ID: aRW6TQ-HOYyEuXuFkJYz_Q_1768554283
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ac363a9465so2138756eec.0
 for <ltp@lists.linux.it>; Fri, 16 Jan 2026 01:04:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768554282; x=1769159082;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nsB7/hUwSEUgw4K14tRIFvgw5bFwvMK/lNirs2pSOb0=;
 b=Pcq7ZHrpyDHfYUlGw9iua6hD/27xd3OkP99oBkuxc/C+RBubCI6J1qF0OeNmpWl35X
 rhqBkwfTpt1NeLKURuXBd3/wuD94oGffZ0aFe1BDFceZgBYlp7cIzz2Xv5OOcSWVod6B
 O8v4xqtCWXQWPWMoT4Hu3Nb5MJlfQoZMADXBH2stSP3URUPHl/52ek5f4be7eHggtd5d
 mmSBnt1X5U2OfRgE047GNcejCRHrkfBSPyLav+taOzIITiRjcBE0cQzfz6dKX/l94+ww
 0TOGlMXV28Er8W652IOPnA4BOIJuSGD7wXhCSFk3XfhMqm5DoPm9GfcLy3miVBqwHjwC
 QiMg==
X-Gm-Message-State: AOJu0YxsKRL03vh24h6TL+OpAff0UxgcNPmPZfTXJ886D1gukYZ+g1hR
 +95gSjYplflYOlr+ylqGhF7yUmaFG7JorCYsX76iCZ1kj60jA65/qryp6AJFT5SC5C5hucbc0cR
 R47vZCioI4/ElTL2VeYY8dy1MoWC5W2yKUp1jyf71qKWKIbBoNekIzj+vwvEmB83KzV8mbVYrN7
 eJluUfIx68lxat2NRLMsvCQ7fDmQQCDYWxHusrUQ==
X-Gm-Gg: AY/fxX71QvHS+MqPFPjaOGX1A66hHfnmcKEl+ovDp8VVhDSpkZU/9bJdN/NWdXqDFXj
 S/x2YIMDZgGapwgLK4aJG/E8UTLA9+lamBuioJSXjKpFacKWtVvM3iQax4wIQZG3kvjk040zSFb
 Km7/lGz9eqQ3fvFHhAEB1LlPIFDHuK2CbNNGgyc3rNoodaXFYjzEklf2aX8jqXdtksCbs=
X-Received: by 2002:a05:7300:cb05:b0:2b0:6a03:e66f with SMTP id
 5a478bee46e88-2b6b3f29e91mr1528429eec.10.1768554282388; 
 Fri, 16 Jan 2026 01:04:42 -0800 (PST)
X-Received: by 2002:a05:7300:cb05:b0:2b0:6a03:e66f with SMTP id
 5a478bee46e88-2b6b3f29e91mr1528418eec.10.1768554281797; Fri, 16 Jan 2026
 01:04:41 -0800 (PST)
MIME-Version: 1.0
References: <20260116022507.204549-1-liwang@redhat.com>
 <20260116022507.204549-2-liwang@redhat.com>
In-Reply-To: <20260116022507.204549-2-liwang@redhat.com>
Date: Fri, 16 Jan 2026 17:04:30 +0800
X-Gm-Features: AZwV_QgENbYKQYlyvGepJHqsHH-xLI7OLsASq0ctzrFcKT6IizD2Jr8PtqOcT6E
Message-ID: <CAEemH2eunvO+Y+eaDBteycU_WUd0_shy0tL8QCwmUwESscTwXQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fPHoOzB_ZXga4TDTOb5Eus8PEWMI5IvFa72XywksD5o_1768554283
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] include/old: rename legacy headers to
 tso_* namespace
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Note:

Patch 2/2 has a tiny conflict in git-am:
   error: patch failed: testcases/kernel/device-drivers/pci/tpci_user/tpci.c:27

I have resolved it in my local branch, if anyone wants to build&test,
please fetch from this:
  https://github.com/wangli5665/ltp/tree/ext-lib

-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
