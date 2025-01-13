Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96EF5E7719E
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 10:21:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6AA853C776D
	for <ltp@archiver.kernel.org>; Mon, 13 Jan 2025 11:21:26 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9B7C23C2ECE
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 11:21:10 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 9783862FB53
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 11:21:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736763667;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=WLxzu6Xxc/qu7sGRuKDIWEh4KeGYLOw+OMysaTeFlWI=;
 b=hAZjMt9jR17gP2TbK2QqseWSjkLGDNtYXMelIJLsN2Af1jp8r/O2qBul5V66LuD6DZ5qj9
 HTbbWvdM378hZOn2dZOsxQkgldRzHB5Q2i+Qt0KGdtu0jONzM1mrxNWnur//vuLL1ibQpM
 XMIy6NXwatqfAopdR4U/a6ydoUBd9QY=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-455-Tzs3nUI-NEudOS68Rt8rkw-1; Mon, 13 Jan 2025 05:21:05 -0500
X-MC-Unique: Tzs3nUI-NEudOS68Rt8rkw-1
X-Mimecast-MFC-AGG-ID: Tzs3nUI-NEudOS68Rt8rkw
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef728e36d5so7400576a91.3
 for <ltp@lists.linux.it>; Mon, 13 Jan 2025 02:21:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736763664; x=1737368464;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WLxzu6Xxc/qu7sGRuKDIWEh4KeGYLOw+OMysaTeFlWI=;
 b=IRxcTAiEblWPo1uWquanGZCW7v54hQpl9EMwd8pCPtP6N3DiwVEjddHbQHoZKe0kG4
 SuxWOl7mrvHMKMksdE1HeE0JrWmK3vM9xtAOwKCMxBT5ZTbU7ywFKrlwii5H/hagwcCO
 gLli8FrRL+adpjY5tfKX0jNyxdIBYuA7TqiGI/7pv1aKE2T6N+ukTdF6+D1CDmY/HxX7
 GIh+fQBmtqosmCkzI23pWIros7hy/Tv1yx3eLXkg6m22zV9YB0CObZwkmBkXM78QOYur
 M4MWNI7IJWb2nZbj6xFAmN19rqlBYR6nkEHUblwCIiPILd7+XoXpTwK4t3eIWe3gxx8Y
 YhkA==
X-Gm-Message-State: AOJu0YxMOUhJkxh5GtDxLWEsJ6ZU6CpvBg5L1T7F/hkeAPklSYNDsRFY
 LVhgvtAAktNYLtkE07f6FtYt2+rncZTb5eIOEs8L4lAatlpoUxOgUAYCMypihm5IGMAOOdUAqwN
 2ADDkw+TLS2nq+Enhcenwaak/FgscRssuSnrBYtsXQfUEBoCSKr8Cj6ZINY7i86jt5CJLfcxZwI
 LjALUqSUp2DliQzIsFKubImEA=
X-Gm-Gg: ASbGncvfvJ6NumrYg3T8iPQaJoxRbnMFwzteqeiv23hY5gxaOEyTD4b8rjOu+fUpoc6
 DhGd4+StjGTmRXCbbk8Uri2Y5rDRDoGdCSLBt7R8=
X-Received: by 2002:a17:90b:1f8b:b0:2ee:c1d2:bc67 with SMTP id
 98e67ed59e1d1-2f548eb3415mr32491556a91.16.1736763664704; 
 Mon, 13 Jan 2025 02:21:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGHakgMYmcsfZwdyOgSs8fq3+PGUaE7K433c3GGm2PS1rvoz07hQ0a0lZFZ78DfvXrf18HUz1TfquSN7pQ1Sxw=
X-Received: by 2002:a17:90b:1f8b:b0:2ee:c1d2:bc67 with SMTP id
 98e67ed59e1d1-2f548eb3415mr32491531a91.16.1736763664304; Mon, 13 Jan 2025
 02:21:04 -0800 (PST)
MIME-Version: 1.0
References: <20250109130032.50480-1-liwang@redhat.com>
 <CAEemH2e2D2xW5zJZsqUo8+f8Ta1GYUKCE4jNeaHECBbVmbY0TA@mail.gmail.com>
 <20250110171304.GB413134@pevik>
In-Reply-To: <20250110171304.GB413134@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 13 Jan 2025 18:20:51 +0800
X-Gm-Features: AbW1kvZyEltIVbmLqzBvCAtxtgLHGEPf-XG95-vOrbRho4xPT0dF9SMSZZdxsVQ
Message-ID: <CAEemH2cCr70K+-hU6VTZSYZzyu8e1dtHLt7gAvv-hpJdGiD4Ug@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 01KLLjQBSQdBck6TSX4WLJtVDq7tuFMMTj38kMLs73c_1736763665
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel <pvorel@suse.cz> wrote:


> > > * Drop the changes on shell test test_timeout.sh
>
> I wonder what to do with shell timeout in the future. Not needed to be
> changed?
>

We'd better redesign the shell timeout tests according to the new timeout
logic.
Later I will look into them.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
