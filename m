Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF9C5E7718A
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 02:56:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61DE23ED7D2
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 03:56:04 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 15F973ED7D2
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 03:55:48 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2D6AF63D149
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 03:55:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734576945;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gQZHM9+JO5SndSKli8NCOt6nf4ESH18mKlbP0ZUUX3c=;
 b=h1DeG0m+W7erxZhsUPY8toxrzDsMfLflytlkTZcjI3s5NiDB+0BeN1mEnl1ryr/LyDnWjs
 w+Xg2+HYtBoV2bk+VVjSzeSeRVZhRFsIaoe6EEqz5YWa/5Ie7kTIkfSrS2cYVDchrw0u/4
 NQFnfnf4p1Tq9Wz+RT4+hOm7MwUzey0=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-Ln_7nZCAOviKO7kYWXAJQA-1; Wed, 18 Dec 2024 21:55:43 -0500
X-MC-Unique: Ln_7nZCAOviKO7kYWXAJQA-1
X-Mimecast-MFC-AGG-ID: Ln_7nZCAOviKO7kYWXAJQA
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ef91d5c863so322012a91.2
 for <ltp@lists.linux.it>; Wed, 18 Dec 2024 18:55:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734576941; x=1735181741;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gQZHM9+JO5SndSKli8NCOt6nf4ESH18mKlbP0ZUUX3c=;
 b=Ffvwk48iw8X1Vm5+Ca2PF52ltzTGty/VvpSnEiUUrpSGrXZFD5VBZ84HX0Bd7ts9nf
 p7mONaNZfzBq/vn61XkNp6sRX7QRQFXCWjUK3bbAbRfLjzwfDW7uwsAzoSmDW/RBpewp
 qPTi+k0ZPGjg6e3WfJK5pxKk7oO2LBk4Nqb6D8QoEtw9ceUzzhVIGP1dsXm2TRT2hbbG
 t3XGXECd+NyJxEDhBRt2EwXbRMncpZNC0EQPSjn0TM5xzJegW7lVuABb6bGCqcrCgMTA
 sjzF4CjW8xmKLAInFB+EvkLPDUWmRiubVy3De88ASo321pTsD7mI8YMNtTkCBnEmL7DY
 ZxnA==
X-Gm-Message-State: AOJu0Ywf7T302yqhtUlzTx8lKBsC5173bSwzG/BS//aaawU0UbhXnis0
 B7Tldtr3E0U9m9y75fIJCAcCMHogqL/6HqvnD+RbDc80Xz+nuyAbrxz9DSGbv/9FBex/avmMmLx
 OvNpEtjSJ8XxikJhL2NQGTDs+uDjdjBXgXbzzLtXapgTMRg2h4KrrQ+udasvWNrftB+01zPg+R5
 AvIZ+N4xZUW45eZGnrnJXidn6rfmm/FJcTN7py
X-Gm-Gg: ASbGncvkkIc/fBvQjZlqXRFERcl31SC9wWj/JzRMon5NwnaPThzYvyWUXpXr1EXynjR
 ic+yxlZBgBCdg0MiOroEDgG+gQozQdQx+tw+xBsA=
X-Received: by 2002:a17:90b:2d0e:b0:2ee:94d1:7a9d with SMTP id
 98e67ed59e1d1-2f443d6f919mr2150857a91.32.1734576940917; 
 Wed, 18 Dec 2024 18:55:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEeV52TljPV2CAsg1PZFnFHqM4r97LSdbg+H0n5zDSHyoK1DUjTJcdtXLcsaPLOLQsXnPOH2o7f/dStVcpzT14=
X-Received: by 2002:a17:90b:2d0e:b0:2ee:94d1:7a9d with SMTP id
 98e67ed59e1d1-2f443d6f919mr2150837a91.32.1734576940648; Wed, 18 Dec 2024
 18:55:40 -0800 (PST)
MIME-Version: 1.0
References: <20241218184518.16190-1-chrubis@suse.cz>
 <20241218184518.16190-10-chrubis@suse.cz>
 <CAEemH2d=r9XMqzwr=Jd=0KEvT6YE6uTtBqoOKWOu=3xfYUbnRQ@mail.gmail.com>
In-Reply-To: <CAEemH2d=r9XMqzwr=Jd=0KEvT6YE6uTtBqoOKWOu=3xfYUbnRQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 19 Dec 2024 10:55:29 +0800
Message-ID: <CAEemH2fW3+Py82z6LDmHQvTYbUR5T0jbqkoy+T4TEDtDfCe6RQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Gco0mWwTVbXaY20GUD7l7N2aLroP6WI0HIJ-Z49gEBo_1734576943
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 09/13] testcases/kernel/mem: Move KSM bits to ksm
 tests
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

Li Wang <liwang@redhat.com> wrote:


>  testcases/kernel/mem/ksm/ksm_test.h   | 299 ++++++++++++++++++++++++++
>>
>
> We do have another tst_helper.h under testcases/kernel/include/,
> maybe we can combine it with ksm_test.h together?
>
Sorry for the typo: tst_helper.h ---> ksm_helper.h


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
