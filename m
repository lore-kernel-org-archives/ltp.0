Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 399CEE77197
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 13:13:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AB90E3C22CB
	for <ltp@archiver.kernel.org>; Thu,  9 Jan 2025 14:13:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A89FF3C217E
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:13:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E339B1434453
 for <ltp@lists.linux.it>; Thu,  9 Jan 2025 14:13:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736428409;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=R1vIy5J+hB6ozkZ5je9ExLxsay1w5nvQaIyUuBvhaio=;
 b=YFyAqLwcNXdZLOiprW/eyZhhlMnNpgZrSpZXyC6d26qJxKPvFgqR2LgPIDjEi04uunxenQ
 t6aPva/MvcHa/HcntK83tE0ctiPSUu9Q5UF8ONlBCkT/QS70gpxUbuvhcB3caDim9gLqtP
 u3ZPmJECoX2wYgNlZ+AtAI2ELuNIzng=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-hVYtprMUMPC4UD5_UNVLjQ-1; Thu, 09 Jan 2025 08:13:28 -0500
X-MC-Unique: hVYtprMUMPC4UD5_UNVLjQ-1
X-Mimecast-MFC-AGG-ID: hVYtprMUMPC4UD5_UNVLjQ
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ef80d30df1so1628206a91.1
 for <ltp@lists.linux.it>; Thu, 09 Jan 2025 05:13:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736428405; x=1737033205;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=R1vIy5J+hB6ozkZ5je9ExLxsay1w5nvQaIyUuBvhaio=;
 b=OaED1/yPJzc1SoHVR3y2hgI0aohMfKBG5r0zSQQyvoNzvbd7c899xETXAuFRpfsacE
 x5a0p/yl42kyRjJ4wa6v0kmd1WhV/eWIHj65cTNZ3v5qTzyBYNZH1yUrX5MMHf7pNxya
 xhT+nRhGJ9T1BWRLPOy0jSaCb15NCWSaVJZsTxIzOSS28TbQa9yF6sqMSo3WSt6uyY1j
 t9tVjTuNbaW1SfZFj1CMowPli1Sx6HyjhixIPybBaFOiQ1rcEBNWgEoHQpaiit2VkE3C
 5CLZry5NK4A6w/2oCeljneB0XSbkkdK7xwxDL5X+gctVoc20ATlQdwXMvh/ciRXaE6Nb
 k7mw==
X-Gm-Message-State: AOJu0Yw+z6Ib4Yu8dWsRsGN6k0L9nHCUuAW1VOyXo+fHjfiSY+8STyNP
 k8QN2CpRZVt1IZ/wp/xO3xZgwTC/NdVPHEpGhLGgSjrxIjMD0pxD1zeC+knIdyuSRpGC7ppOb0Q
 6mPfuvaZDql2ratber8/oTiZ28dNu0ob1O3iLV0l1pCiQkSnTtZH7KykWrFd4vrHo9sCfV4Dkeb
 jzHrHfAHFRTNRzl5WhdV6+r1sOOsMYj7PL9Q==
X-Gm-Gg: ASbGncuenGLdM2FiqDT14socGM25iEqPXrHYkHeX5pdEw4PyRxCzjF+6H2u9mv/Ls+L
 YpOULdcOZ9X4/H/HOr2Te4PlXqfM5DUcvw7ao7Ac=
X-Received: by 2002:a17:90a:da8f:b0:2ee:dcf6:1c77 with SMTP id
 98e67ed59e1d1-2f548ebf531mr10914897a91.16.1736428405015; 
 Thu, 09 Jan 2025 05:13:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8+5J+G68AfGmYn1vmowCLJo2dodWbxehaU9Ay0R8NT17je2KPogLZgSwo1BtkMA5deburigBL4bYsdqq1AM0=
X-Received: by 2002:a17:90a:da8f:b0:2ee:dcf6:1c77 with SMTP id
 98e67ed59e1d1-2f548ebf531mr10914866a91.16.1736428404743; Thu, 09 Jan 2025
 05:13:24 -0800 (PST)
MIME-Version: 1.0
References: <20250109130032.50480-1-liwang@redhat.com>
In-Reply-To: <20250109130032.50480-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 9 Jan 2025 21:13:12 +0800
X-Gm-Features: AbW1kva2Kc16ayNRI41quHIBSTZdMXfAH4xgfsDrfcyHznh3CE5mqPkR1IQmuFE
Message-ID: <CAEemH2e2D2xW5zJZsqUo8+f8Ta1GYUKCE4jNeaHECBbVmbY0TA@mail.gmail.com>
To: ltp@lists.linux.it
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: BYJ_ABL_laz-TKiUS6QTPYF7Q5twve0i9h6b_OEJAqg_1736428407
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH V3] lib: redefine the overall timeout logic of test
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
Cc: Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

To patch reviewer:

Looks like this patch fell behind the last one commit f162bff0af19ce7d7f3,
please drop that one manually if you want to apply it without conflicts
locally.

I will do code rebase once getting enough Reviewed-by tags.

Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
