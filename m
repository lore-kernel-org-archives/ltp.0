Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E6AFC30658
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 02:42:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 096163D1217
	for <ltp@archiver.kernel.org>; Thu, 27 Jun 2024 04:42:01 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 240BB3D03C1
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 04:41:45 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 4E53F1000938
 for <ltp@lists.linux.it>; Thu, 27 Jun 2024 04:41:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1719456103;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlP4kpf+Yy+SRWKOe5LUDYSD5ipmDwqOfnyWq7dmPN0=;
 b=EEFvzDcUV5MZ3gsUpSRkbQxypxa94RQMoJBdLotwM5cDFEecZr0r7dbo77hLaA41uHRakh
 63A13Z4OrHqoR+bEO8jxECr+iUrtS+BAN2NF8v+jZG/ZCSlEbjCyvnr6XuKHKsjxE3NKOx
 OQFvvUC55VagphaIeYhWr/jDjVzh35c=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-ZcW2FRG2McaMx6d1kY2V9A-1; Wed, 26 Jun 2024 22:41:41 -0400
X-MC-Unique: ZcW2FRG2McaMx6d1kY2V9A-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7a8949243so8787185a91.0
 for <ltp@lists.linux.it>; Wed, 26 Jun 2024 19:41:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719456099; x=1720060899;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlP4kpf+Yy+SRWKOe5LUDYSD5ipmDwqOfnyWq7dmPN0=;
 b=rSY5z7Wrn57OQ33Y4Pdmgo+H5STJ7SNvuW5BN1KVxGwAgMRmaoMFuGWja1z7Zj4Exn
 KSGj9LHeL0Ezn5rVlVCw0KNp3Q6kUWOxS2rFSNHbXRZUOSSFERVm/pHxZ/y2KSV+XxSE
 P+kCzF2fmhtjc5BhDyVQXcQrfWHrZbaWGgdtimlAjVsUWqLzrHri6BEPJnXV7FYbYnGo
 jqWvwEE0sNwe6TJuoIcj4G3q6221Ot++sHq+4LUG0ck3M1ft8wySKTP1tTq/T7SXxYzp
 y9LsK0Pt+eo8seK9cIMFw6xzlI/Q6sjXlWxJqaleIkNfxq+gcMIfPQYNzwU9x/m+bc0R
 0/mQ==
X-Gm-Message-State: AOJu0YzS2yl2K7sEBRZOaxpmAceVDhPAYzmuTRA48ejEIlujvtH//Cmn
 vuXZz+/f2AQfns5mKQfmDsz18WfYQf3DQZ+dvD1oAWLRUEGnOEJsXkygwHAuA2ACF4GMAnT1d3f
 oeqRJddlA6od7M8OejJdUpDTGdB6h5Ennpy05jiPilbJ1pZtQRAORuY9WXQpJzkhiyTFjUOQ5b2
 FxANTKIEZ/XPAAyXXuyjgUL9LyuoK0M6ACFA==
X-Received: by 2002:a17:90a:9417:b0:2c8:e654:66a3 with SMTP id
 98e67ed59e1d1-2c8e65467dfmr2250110a91.9.1719456099446; 
 Wed, 26 Jun 2024 19:41:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHPAEyib4Bov09wx6C2e3lYoqR7maYImWShIUrsjIkRHlEi8Y7jdZAyn0LVMQ+zNeMU8IEylnP2Yiq0fb2OAd4=
X-Received: by 2002:a17:90a:9417:b0:2c8:e654:66a3 with SMTP id
 98e67ed59e1d1-2c8e65467dfmr2250099a91.9.1719456098938; Wed, 26 Jun 2024
 19:41:38 -0700 (PDT)
MIME-Version: 1.0
References: <20240625100130.735643-1-liwang@redhat.com> <ZnwaBib74LSPh-uk@yuki>
In-Reply-To: <ZnwaBib74LSPh-uk@yuki>
From: Li Wang <liwang@redhat.com>
Date: Thu, 27 Jun 2024 10:41:27 +0800
Message-ID: <CAEemH2fsBssjDyyozHnFt4T5y7LCWFEDqfN3nE7t3kyd19FjLg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] msgstress01: remove TWARN type from runtime
 remaining
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

Cyril Hrubis <chrubis@suse.cz> wrote:


> > --- a/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> > +++ b/testcases/kernel/syscalls/ipc/msgstress/msgstress01.c
> > @@ -214,7 +214,7 @@ static void run(void)
> >                       break;
> >
> >               if (!tst_remaining_runtime()) {
> > -                     tst_res(TWARN, "Out of runtime during forking...");
> > +                     tst_res(TINFO, "Warning: Out of runtime during
> forking...");
>
> Maybe this should be a TCONF instead, since we were not able to run the
> test because the kernel is too slow...
>

Yeah, good point, once the '*stop' set to 1 the rest process doesn't
get perform as well, so TCONF should be better.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
