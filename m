Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D65D70E02
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 02:11:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0BEC33DBEBE
	for <ltp@archiver.kernel.org>; Fri, 29 Nov 2024 03:11:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 19D7D3DBE47
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 03:10:49 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 2CFC81BCC633
 for <ltp@lists.linux.it>; Fri, 29 Nov 2024 03:10:48 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732846246;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=nJ29USmOJY/TT/B+f2y3xKiiMkYhxxOpdUm7IWIbews=;
 b=iuIF3dHKlUyEupL9iccy+4orclHF3iP/L+JY5jAVHOiVu63J1kHbNaiPlozxMrq/3D5889
 fc585MYtw92+PYq6Sv1r/aHxz4v1SE/1O5ZZ+AVGawFqQGw5fdi5gMY39Yxqay1buThOdM
 vnylHr4x+HWE8ubs6XtkUb/WUz0nfTI=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-hwqV9DqDMa-iJnNsxKzTqQ-1; Thu, 28 Nov 2024 21:10:44 -0500
X-MC-Unique: hwqV9DqDMa-iJnNsxKzTqQ-1
X-Mimecast-MFC-AGG-ID: hwqV9DqDMa-iJnNsxKzTqQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ee46799961so742602a91.2
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 18:10:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732846242; x=1733451042;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nJ29USmOJY/TT/B+f2y3xKiiMkYhxxOpdUm7IWIbews=;
 b=mVLYL5gnIz2guNOXfk/8l3Nosi3+kz/Su9fRDdJim5ws4uI5FXs3NsFTONrKYZfFb8
 ZdSgCmnGERiqRIcrDbHLoh+Z3W5g5HqXZB3InCUEaKiHoOiJnBaDmZcYnYeAgdEATQmH
 i1S92gcMRGVSG7lvQStnWNw3qdExy0t2oNRCTOof62HgDKyjnau7zoNF0S7nvP2Te1j4
 HA1eeBYTj2Hpvm1ezlpdQlDxHN5StWD+0DBkg7YOmKox4+lUuwxub2ChVdbmKsFYciIF
 6o757kx7IbzaeBvJD/JXkrq8hKqP50celt3sRb5kaTr81KAujspaI8Rrzi9Pd4oGeDAI
 Zxgg==
X-Gm-Message-State: AOJu0YzKFzobH9Q7ZxHNos5f4SKpFi0YWENqdJTaYrUL5A5/2ClJdTsi
 IkVNr5oq5WemTQ1e9dG9KQS3ZifR1XSq81QMNkJ+mAn5vE0K96fXgCHF8hXmw3uWQMMgHFxAPw+
 3eCOqXKYe5Z1Zbqt3iuEHzzkUUJJN9CfcVFRW+KUYXPvsCXKjzoll5cIzOL38bdCJ9HRD/z7mOe
 FvVRrboA3m110Bl7d4LEizhGaHa922SEaiH7GI
X-Gm-Gg: ASbGncv2BvjNa76pXrpKVMnwg74YvBDVIKBpcS7EWJEfDSo9j/w9mFdgF6LYW5nswIV
 kVR3XEdZRDMm/wU6+eb2YsEOw6ehkCqZp
X-Received: by 2002:a17:90b:17ca:b0:2ea:97b6:c466 with SMTP id
 98e67ed59e1d1-2ee08eb3148mr14815357a91.12.1732846241349; 
 Thu, 28 Nov 2024 18:10:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHYwaA1LkbwG6gAYyJ46rWx5JIFrVzgoRvJLa/Ru8fskXvbWVzTYgxd8u6leTDQRL+jBQVKH6e8/oNc0Ib2b4o=
X-Received: by 2002:a17:90b:17ca:b0:2ea:97b6:c466 with SMTP id
 98e67ed59e1d1-2ee08eb3148mr14815340a91.12.1732846241146; Thu, 28 Nov 2024
 18:10:41 -0800 (PST)
MIME-Version: 1.0
References: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
 <20241125-input_refactoring-v1-5-b622b3aa698d@suse.com>
In-Reply-To: <20241125-input_refactoring-v1-5-b622b3aa698d@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 29 Nov 2024 10:10:29 +0800
Message-ID: <CAEemH2eF-MTi3cgspBufG6N84NcGNfJ+VT_+_wRUKrCK-ktDJw@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jmk-9QbBL_hwLn6vzdWrAwR_BrXuKm1aaOQ7baDUmrQ_1732846243
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 5/7] Refactor input05 test
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
