Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0AA3CF9C68
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 02:35:56 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE5403C30FC
	for <ltp@archiver.kernel.org>; Sat, 21 Sep 2024 04:35:54 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 34BE33C307C
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 04:35:37 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C750B1036E42
 for <ltp@lists.linux.it>; Sat, 21 Sep 2024 04:35:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726886134;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEc5Wur1KPqUew+hOQiJ8LC2z5iFP18UNBYptv66wno=;
 b=eRyrfmYBxpcfKZmfM0yCcwbat3OG3RyFHhHiLuSOO8yjISc7uT87leFrl7GNUnlQeY9qGp
 CTx3NcCNTiyELMb17uY35dcGDvQLfhW4PcLBfbkLU60r+cEYCB5J+OmWVyAUCd1LlLFsk7
 tVFZf8Xq9raEJpPi342hMNr5PzggDyk=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-661-7OogEFQsMFeXOG-tU3FXLQ-1; Fri, 20 Sep 2024 22:35:32 -0400
X-MC-Unique: 7OogEFQsMFeXOG-tU3FXLQ-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-718e2da2e33so3711387b3a.1
 for <ltp@lists.linux.it>; Fri, 20 Sep 2024 19:35:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726886131; x=1727490931;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZEc5Wur1KPqUew+hOQiJ8LC2z5iFP18UNBYptv66wno=;
 b=Lp4jEW9t/2PBU/SArzbI5NETVTPW1Nk9vY3OPY4Eo7tdbj4A5bIDN8APwDzMYUe+7C
 LlZvGKty9dNQEqgxliUrS8aQoOJ6mqsvYpx616U6dILv4dH6y5Ww/y1SOm5bVy74UIZw
 hGLZLNK9E3+gt9GHqAxXFjxWsV3xNOc6TH8OIG7ZmN3Kr+VAKfpwW5XPWvn75mU32JoB
 rWITZzGcJMuHNSwSMNZ0DVQMiiiHlj9iwOTag5oDakYYoIVlWvUAWLb/DPyvXnbc75oi
 1R2T1M9IWBLKpDhrK3y+4vkpmCr7DRrzK8jhF8UAuxH7wZ339Pi4xn32fPTLG19EWKmE
 qWug==
X-Gm-Message-State: AOJu0YyrbUsZgstVGFZobEc+7lSz3SHkwPqRuHHoqE4zMCf/2TVT/g+v
 eWjJlu18ARcKXzEyXnY40WP0ScAEolzZya+KuvXoROTk6ZiMK3Wk3gg+4BqzDFqxJ6DNo7Tp4yb
 q7so5CF90ey0kiRZRolkyagnWyCsrNueg+0nRCyoR7GR22t2qhOqntpRnLjfp6L9DFU1jU4hjX4
 4/2Sas7/N3piero2bM7j0tC/U=
X-Received: by 2002:a05:6a00:b4f:b0:718:ddd7:dc3b with SMTP id
 d2e1a72fcca58-7199ca7be44mr7046377b3a.21.1726886131415; 
 Fri, 20 Sep 2024 19:35:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE024DAtaCGZqYUYmfo1ZWFt7lMiKsNd3L3O8tkgRdp4/ZZZAht8MmB4yxQwbNNgsSrqb2NgPVFio2P0wxY8Sc=
X-Received: by 2002:a05:6a00:b4f:b0:718:ddd7:dc3b with SMTP id
 d2e1a72fcca58-7199ca7be44mr7046344b3a.21.1726886130908; Fri, 20 Sep 2024
 19:35:30 -0700 (PDT)
MIME-Version: 1.0
References: <20240918073257.13930-1-liwang@redhat.com>
 <Zu2GK3-vbJVaivNM@yuki.lan>
In-Reply-To: <Zu2GK3-vbJVaivNM@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Sat, 21 Sep 2024 10:35:18 +0800
Message-ID: <CAEemH2eg2B6v2AC3vWJ=fRqeBRVm-_6wdEvXOz7EM=0vY6kvxg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: handle ENOENT errors when processes exit
 during PID scanning
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
Cc: Charles Mirabile <cmirabil@redhat.com>, Paul Bunyan <pbunyan@redhat.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Cyril Hrubis <chrubis@suse.cz> wrote:

Hi!
> I've spend some time looking at the code that uses the
> FILE_LINES_SCANF() and it looks like this change shouldn't break
> anything.
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>
>

Patch merged, thank you.

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
