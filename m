Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7563EC27C53
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 12:31:53 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 627D83D0BBD
	for <ltp@archiver.kernel.org>; Wed, 12 Jun 2024 14:31:51 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B336B3D00C7
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:31:33 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5924F200D02
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 14:31:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718195490;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GT+E3G2c0V0FzGfFMO7Fw9xwfcsNC6+V/aUou0vOhrQ=;
 b=JAdtwiL5fH8FT8dWhAf2BRsPe18NeNjpwS+2ILawr/KvZEtUCimAJMzoTyx9qCyUub7PZu
 qmf8I9oQbnvjuagxZ2RcdiTpJjR55zmeelwyV74EwtH8bmO2wbZ9REmkhRKJvwfrPyJE4h
 AhGVawxkVN2KcpiH4AWzmGK/UHGRK7k=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-154-PQPxNqavMK2OyOo5FhqpJA-1; Wed, 12 Jun 2024 08:31:28 -0400
X-MC-Unique: PQPxNqavMK2OyOo5FhqpJA-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-649731dd35bso5308319a12.0
 for <ltp@lists.linux.it>; Wed, 12 Jun 2024 05:31:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718195488; x=1718800288;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GT+E3G2c0V0FzGfFMO7Fw9xwfcsNC6+V/aUou0vOhrQ=;
 b=QXC6hHq9Y4MlQ2+gG1Vu4ZHWVDNnlk5ErztNQZyPiTRfMzeyM/zOnD/itzkov7gxnP
 MDwjGfyXhqtyJGi/RroA2RBJW8QMSGyLsUqZMDBLII9rgEffYBeKRN3bEvwVA3yUNhU3
 kpPEUqahugE7ZPwJ7ReFGSDVUDksYpYwQ5V2pHQp78sraOxog1iJ/TfrDV3+iJsSqcrG
 sREgUR9XnSDMkEPF8YNKGw2ek5fdtTWfc0bTnFNVKpFJyJRWRaVU+dWH5mqIL4C0NV1F
 6S+5ocHu7mJR3VcwvpM26foHCu7uzXUd4FVcSddFDquzs9gwtd0TtASXO1g/sJDDmgtY
 DmBg==
X-Gm-Message-State: AOJu0YxK0KjoE6gWJUIILiadShua8T22uuEG9Q77n/miDhpixAO1yzkc
 ixN7nndG9rWko5u5bTxfHU6GvfxF1hTiVCLeNRa/NxBuWZA3ThWxWkQqc1qdxn3IwA0yrkmj0O6
 E33cUtKxKqATzIaS14GwURuoXuQt2S6LjRHMzYAMYmh5PDWp3PuorW59/HUun4dn0LH4CvD7Aae
 zSHPcMsMtUnylbuRxptJZ+2uk=
X-Received: by 2002:a05:6a20:2588:b0:1b8:3fc6:ab84 with SMTP id
 adf61e73a8af0-1b8a9c88664mr2068588637.58.1718195487755; 
 Wed, 12 Jun 2024 05:31:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHSWfK8jrMQ0sdaeqoqVE+IwxQS6lKX+OPBk32pB1Qtb9t8horWSUPbftbjLKwxVeepMD9k37Fl/gU6sHCZiAY=
X-Received: by 2002:a05:6a20:2588:b0:1b8:3fc6:ab84 with SMTP id
 adf61e73a8af0-1b8a9c88664mr2068556637.58.1718195487331; Wed, 12 Jun 2024
 05:31:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240605104512.18296-1-chrubis@suse.cz>
In-Reply-To: <20240605104512.18296-1-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Wed, 12 Jun 2024 20:31:14 +0800
Message-ID: <CAEemH2fAjnF=TFqJ=yvYi86phvcMVAE_rFzLpgbZA1aCO1DNQw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] testcases: realtime: Get rid of autotools
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
Cc: John Stultz <jstultz@google.com>,
 Darren Hart <darren@os.amperecomputing.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

V2 looks good, thanks!

Reviewed-by: Li Wang <liwang@redhat.com>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
