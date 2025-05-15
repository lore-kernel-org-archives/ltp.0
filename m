Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C6AC3ABDA
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 02:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747276239; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=G0gWHyymXQPO2slwMI9CWnQMcNjEM17Ewm7jLM6vdU4=;
 b=RNEYr1c7kg/fh5EOX/MeIA6Z6WYPZX53CXdQICGqJJGtDICEVfZPX4rSIGdIsqwPseBgm
 bmuRhxn8zkW2mB61AVVMt8//7zU+PsyTfxZonRBzlf1YFFvgqR+fS+RKbyMzKov+AHLBcEN
 7V7TFOWu1th4al1My0yIQD2GxXiLa6s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D02A13CC3F3
	for <ltp@archiver.kernel.org>; Thu, 15 May 2025 04:30:39 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 772103CA312
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:30:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B254E600810
 for <ltp@lists.linux.it>; Thu, 15 May 2025 04:30:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747276215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AgSMaymebdry5XamiF1cgxIlGZMhEdh/8sn5qCZhy0M=;
 b=FgBlZsN3QFutFnrdRcsQrhArBJhrOrF0fS1dEo9uHNqBPAwRETaeu7S0C/mpR42LNpP3BL
 WDYg53cLasJFK5YUfsHvGH8NcI0ScNeBu0ZEMg0kFxdupjSSJ+0U5l3/CSDfFOcd3ZtLPw
 fE3Ju1WX7nMgnxcJEs4e/e6sksLwIA8=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-S-wh6ET5Pciw41qP9jDdkA-1; Wed, 14 May 2025 22:30:14 -0400
X-MC-Unique: S-wh6ET5Pciw41qP9jDdkA-1
X-Mimecast-MFC-AGG-ID: S-wh6ET5Pciw41qP9jDdkA_1747276213
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-22e7f041997so7514525ad.3
 for <ltp@lists.linux.it>; Wed, 14 May 2025 19:30:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747276213; x=1747881013;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AgSMaymebdry5XamiF1cgxIlGZMhEdh/8sn5qCZhy0M=;
 b=CQpRGaQlqOjP0VV5ja6deppNrJz9tyCytTl+7Gc2wLA9fH0Fr3CSW32qRqvgir4j+c
 HK675OnXU4pCAym7pjAeXKuUKyxWpVMNGuhpfcNE29o9RQ4nzXqYvk9qmKwULomMGZMw
 1J6UWc1xWUrig8iWObOlLc1/oCvSyIiUTh9pPS9o1H++Rv/OwrYkJe1ruLTahoEqgOd9
 ei5fOacOjdloOD5Wg26uCFnV3I5HWculmiOV3zN9dDpPbPmiQ3fDu6cjDPMz9NBLF7DC
 TeaCTFMnsxJ6YWBwM5BQkHCJpgSOr/HU9jp6eqtuj4b1+XiGWXlRQEOeQixMxOqPx6Pk
 JyuQ==
X-Gm-Message-State: AOJu0Yy4mDW1ls2mLKWy9Hy2nBSME7UQ8JonJcka+WJFdyKKHt5OACSk
 zKAns+Cv8oIeJvwE4JD4UGI7zdPpd7lURYLzb2+i+jYZqMdVE9GPzbLNEtpcgtaGjX0/hmORg30
 idzW3vvorc61sv3+1yoaF5W875AaX8q3qHUPUv1Cmz3tUWphYx+of4GDWQjTDeO5xljI0k56eOH
 VNvItpd9FTMSX9qQW8LXJiTzH08OM1el0ONA==
X-Gm-Gg: ASbGncvB6L7sijNw/+ZIoHOhRKsrZ56/2bldGWfNQIC+sMlIq4eeO9C5NLjO4kymYqT
 tivXfIHMqYi4q+5LCsab5spuMkTo6XfU07z9AcIcRW6kxjU6FyWbZ36BV1NGJsLoxnnBQUw==
X-Received: by 2002:a17:903:1aef:b0:220:c164:6ee1 with SMTP id
 d9443c01a7336-23198129cd1mr96787715ad.32.1747276212810; 
 Wed, 14 May 2025 19:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEEobhrvLV5K2BDJmPHqfJ8VJHQRwxYWq3oo/Ut8JvZT6qr7ogH8y6UO/rGa5ph0c90dVdixsyCTG6xgUMfw68=
X-Received: by 2002:a17:903:1aef:b0:220:c164:6ee1 with SMTP id
 d9443c01a7336-23198129cd1mr96787445ad.32.1747276212480; Wed, 14 May 2025
 19:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250514-conversions-kill-v1-0-cd633e941e8b@suse.com>
 <20250514-conversions-kill-v1-6-cd633e941e8b@suse.com>
In-Reply-To: <20250514-conversions-kill-v1-6-cd633e941e8b@suse.com>
Date: Thu, 15 May 2025 10:30:00 +0800
X-Gm-Features: AX0GCFvpRssNEU1UkUVP5q1u0PvodJE_d_NBZ0euK7olGIrbbO2maCdkOs1_D00
Message-ID: <CAEemH2cuC1g6SkQ_BNNyNsMNconVeNWBZxSU3kPAv2d38uj=xw@mail.gmail.com>
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: wm-5moKAg5Kdx0rPqD2gNbgJNWm2jHDtkRLe3Qjf6d4_1747276213
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 6/6] syscalls: Remove kill09
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

@Ricard, Maybe combine into 5/6, then looks good.
Reviewed-by: Li Wang <liwang@redhat.com>

@Cryil, @petr, this patchset is clean and mostly touches code comments,
I think it's safe to have them in the May release.

--
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
