Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCC4C4725D
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 00:49:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D28FC3CE361
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 01:49:28 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3AD723CBF60
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 01:49:13 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A59EF1400C74
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 01:49:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705538949;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q5CKHDRlaoL2GA5fFSM9Drz6Qgspkt8sfM1mhS0b3tc=;
 b=fsro/7XtgG0r4mGlx0ULqMskQewhdQ7UI+CD/EljZVCksf/LjPSsLHwG6FR3YQIVWVj51k
 jqfXTeYiGJI16gQfgk78Op28T8KExk1jYoeg5VJbeTAQ/BHVyoScdYXhgSrIqJGqf32YDe
 AT72BBHgWDkOlRtrbHAf31SPp784oOo=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-297-a9s93hWPPvqady0rtWLP8A-1; Wed, 17 Jan 2024 19:49:08 -0500
X-MC-Unique: a9s93hWPPvqady0rtWLP8A-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-20486eac97fso19345942fac.0
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 16:49:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705538946; x=1706143746;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=q5CKHDRlaoL2GA5fFSM9Drz6Qgspkt8sfM1mhS0b3tc=;
 b=BS9memGSjR5My3SafHJnVI5Ujyq2IA16zI5steHT4Qf2vi+C6fcVWO1kf5yny/POcL
 38JyiU5kjaG9do7FjCwR6uGc6+KSLvdd46LjE9AsVfBQ0/uG1aalRAXOsFVeWVfvv2TN
 1MIa+x4F8czWhNSDNuksCWxhVNTl3ToUwzxPUfFi8vU9ZPRLLApIVxiZv4fIuelv4K1/
 j50PcwHleYvYWzFN4EwAtWs9YUP3urjTZQDjyIaAN7zYX7t/IzVrQJRsrFrQ32TnHVWY
 vAe7nRmb7uf8G8rv5yx3sNUZulH2ht1K+TiWh87egyls9qcp9jBhbJP9Vw2BjXhK3dN3
 2xSg==
X-Gm-Message-State: AOJu0YwKvPEhCb9VheYVV/b/1d6+dtA2/6VANnEq0ss9B9MFqJoIs1OK
 G2W48UlGJbCBA/JDMebhsYv8iSTJCVlu/rAzcP4YkPx+nX4bPezj2PAZUxmNYdfuEwVLqJZZppc
 WoP3ZOE+UY6VCrYMSJc/KRAm6bgAkurFY/ywVoDS/HNQCaJdz5ZVqaY1xJLRYJeWwOg/GcVgRZw
 QvhjQ9qgVRBCrXbYb3STZdmeW3Card1ApK8ByQ
X-Received: by 2002:a05:6359:308e:b0:175:d89b:7941 with SMTP id
 rg14-20020a056359308e00b00175d89b7941mr80076rwb.29.1705538946609; 
 Wed, 17 Jan 2024 16:49:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHeuuJ7QEHDUNDaKNUeelgkCpOsn1jgw47Xnsteq659f11+EY70qTCbXO/veMuvxLV04aubR/XmlE8psjWCsGY=
X-Received: by 2002:a05:6359:308e:b0:175:d89b:7941 with SMTP id
 rg14-20020a056359308e00b00175d89b7941mr80073rwb.29.1705538946334; Wed, 17 Jan
 2024 16:49:06 -0800 (PST)
MIME-Version: 1.0
References: <20240116031728.2500892-1-liwang@redhat.com>
 <CAM0EoMns7T+JkJquM21_9S0FUoPdPQxw1Ebg4jBPLer5cOF+uQ@mail.gmail.com>
In-Reply-To: <CAM0EoMns7T+JkJquM21_9S0FUoPdPQxw1Ebg4jBPLer5cOF+uQ@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Jan 2024 08:48:53 +0800
Message-ID: <CAEemH2cZ9KLCb=yaVvLzC6uo0m8+vmw7ic4KNTFe7K5TauV3dA@mail.gmail.com>
To: Jamal Hadi Salim <jhs@mojatatu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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

Hi Jamal,

Jamal Hadi Salim <jhs@mojatatu.com> wrote:

Pardon my ignorance - what is this tree? I dont recall seeing this
> anywhere. If you pull uapi headers from the kernel on your tree you
> can catch these deletions sooner..
>

This is an LTP (Linux Test Project <https://linux-test-project.github.io/>)
that targets testing the Linux kernel.

The commit 82b2545ed9a you made in kernel recently caused the LTP
compile break on the latest mainline kernel. So that's why I CCed you
in this patch.

BTW, It would be helpful to run some LTP test cases against our kernel-patch
before sent to LKML next time.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
