Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40FE7C4332F
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 06:51:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2B6253CE562
	for <ltp@archiver.kernel.org>; Mon, 13 Nov 2023 07:51:47 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F18E73C89B6
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 07:51:36 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C7214100046D
 for <ltp@lists.linux.it>; Mon, 13 Nov 2023 07:51:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1699858293;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aorwsRiiJTD37OHXNEv0hfmtC0q1KnhffyEJ/5imCQE=;
 b=KzNgtb9TcmyKIbdzk3yX+CRceNpGb9GUp6LI8PaNvcpDjVjXOSQvzH+ki5Znu9f2QPmZQZ
 dLyhCd31/AylFxRDSZ9WpP7aJuxXYlv7S+zsdA0vzznsFIXV3nl/7Af3588eGGn04vJYH+
 Ickz7N8GxdNR2HBzBgskx5+vE92hnk8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-W_qRUHBNOKqO21Re82p55g-1; Mon, 13 Nov 2023 01:51:27 -0500
X-MC-Unique: W_qRUHBNOKqO21Re82p55g-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079c865541so3833956e87.3
 for <ltp@lists.linux.it>; Sun, 12 Nov 2023 22:51:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1699858286; x=1700463086;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aorwsRiiJTD37OHXNEv0hfmtC0q1KnhffyEJ/5imCQE=;
 b=bxQRVVSilOGjk36S+PRe1rGfpczXWc4P94W95VEPW2rxSBR65LvoWctBOgYBMRuzrd
 u3X0nu5RYFXp+zwlTP81zdk9t6NpzHrE+EabuBxkupd5l/Ng+9eN9OauqMV1Vti6uewS
 bgGYApdMHYbG0BsWa4caLHo5C9szOmyLfEJZQ2XTo8BvHBWT3Bya2XZOYCLVNSmqzFMQ
 gQOE/pbxE7eZe/gIzbLib+ifFoGSXQyttICjMSsGfA5aedQfK0YZq7BXvWoWYVFJwr4J
 rEJ3CeFpMfNia5LJswbBOfCOXiNrondQ0+zZ/EPYLC4ifB2knq/Fxbr1SrtzYyU51SEZ
 Ed1w==
X-Gm-Message-State: AOJu0YwjLZptR1Q4dmjgUxVh9YIBZiKB9nw0Jee2zH0SH9Du78TGjgCi
 emOU4/7feC9bT78+NFEI038mCHJW00r+34QH/KaLDKHYMLTdXoctArUICoQ3ySFxNwxcGNV47ZB
 5CEQCTmwciD4X1CnPRIZUW5rZUCE=
X-Received: by 2002:ac2:4e0a:0:b0:502:d743:9fc4 with SMTP id
 e10-20020ac24e0a000000b00502d7439fc4mr4620972lfr.37.1699858286517; 
 Sun, 12 Nov 2023 22:51:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IElGNVKtJNj5rqs3oKFbE2cyYXXyBAUrWsac0cqBaaHbbycZS4rQkzIVBPlsNSBjiNRZD4l59AumQzRuFyAbMM=
X-Received: by 2002:ac2:4e0a:0:b0:502:d743:9fc4 with SMTP id
 e10-20020ac24e0a000000b00502d7439fc4mr4620961lfr.37.1699858286133; Sun, 12
 Nov 2023 22:51:26 -0800 (PST)
MIME-Version: 1.0
References: <20231109025456.71696-1-18810879172@163.com>
In-Reply-To: <20231109025456.71696-1-18810879172@163.com>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Nov 2023 14:51:14 +0800
Message-ID: <CAEemH2df1sXnfvt03cZ3dJx-ZinSP10Cg1QpCgqd5idAD6exiQ@mail.gmail.com>
To: 18810879172@163.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] hugemmap24: loongarch:Add __longarch__ for
 compatibility with Loongarch
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
Cc: wangxuewen <wangxuewen@kylinos.cn>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Thanks for the fix, pushed.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
