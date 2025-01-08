Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48FBAE77188
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 11:38:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A52113C0794
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 12:38:21 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 647093C0794
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 12:38:04 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 829687A9242
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 12:38:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736336281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jy9DPvUIVku6Hac4vWVmBjh21Kq9rDJA/xO7NHK0LFg=;
 b=VNBuKsXyZkFSdiZghcYY8wLhnXdKIa7th2IMDQBQqH6MuzO3ta2CzVVMocs2KsLydgG+HM
 eauGiC6fygJ/H8oFMOcBd0ZWByUiYvGcefrfP+4AV6U/fBa08uhbWNQothHAZZbD8fXISn
 vVcx3DvO1vRO4kKtFMfxEpAyTKY3JCU=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-357-Y51ar1FiPgWpVCFpVta1Kw-1; Wed, 08 Jan 2025 06:38:00 -0500
X-MC-Unique: Y51ar1FiPgWpVCFpVta1Kw-1
X-Mimecast-MFC-AGG-ID: Y51ar1FiPgWpVCFpVta1Kw
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ee46799961so37633236a91.2
 for <ltp@lists.linux.it>; Wed, 08 Jan 2025 03:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736336279; x=1736941079;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jy9DPvUIVku6Hac4vWVmBjh21Kq9rDJA/xO7NHK0LFg=;
 b=lMNpJqORePwCv1xmzbIOa1W26EQfdz8LTJipSnFxMmklRMjukVlLoIXyCgA1/KH7mq
 ut4TCsvHSzdccqZsgNvgCl9ePu6m5caPGuWEjhFfIwzxXJ3d7LRct+6UeCJeU47XXmJz
 M1tv5AKwiC4T5veZJ5Y+4XxJVphxSoTsM48Yb96XnfK0XmBhli24uYxFZE239OfXQt63
 M2oN2q94srbCYgDj+sOrXyjg8+S51QJe5P15eQRPSa11vjtwR79W5CvbljTndF1TNMzd
 e3vj8mMVKpmduI+kwKxrEP5PqQm7bHgmufbW2krjjzGrsnt5acPgZeh+eqkOQR9ZCvEk
 fbdQ==
X-Gm-Message-State: AOJu0YzSSjKutTAq6dxUfyLKOt9FsDtg/R5+N3PRdqQP+1EWiWjft+py
 TJ/G6AZq0ohs+k0vBv/IspRJyFOltK752M7kiRU5WWGxycmwD6uiphkA7E2m4b5WjrDJEjdB8F9
 dOHbcuwjhWzdFD377iugQBbsufrFD57nJhlvFqjQJnZse+xxLQxnV8vHc4uijjIzl+2pCB//t8Z
 YKE5XUjZsmtz+jOYCdVMgOqBA=
X-Gm-Gg: ASbGnctLIir1mDLRx1YH6tNkNhpu+5ag+hMUfj/XUwrKTmJQAz+a1DrSoYMnIWcF2gP
 66016qNhf+5vUBv4UpfD295EKF/BJoaKPqraerWYI13l2EA==
X-Received: by 2002:a17:90b:4ed0:b0:2ee:6736:8512 with SMTP id
 98e67ed59e1d1-2f548eb3229mr4553698a91.12.1736336279391; 
 Wed, 08 Jan 2025 03:37:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGd1vX3k6rRRWKK2D0lN3DHfouKvgl89chUC5EOMiE0ZM4Tls/cP857hMaLp46ORXiCbUWh4phik5/2m8QA5kc=
X-Received: by 2002:a17:90b:4ed0:b0:2ee:6736:8512 with SMTP id
 98e67ed59e1d1-2f548eb3229mr4553672a91.12.1736336279176; Wed, 08 Jan 2025
 03:37:59 -0800 (PST)
MIME-Version: 1.0
References: <20250108071201.26984-1-liwang@redhat.com>
 <Z35C00m6FwH8P8BI@yuki.lan>
 <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
In-Reply-To: <CAEemH2dYrPTT3iw69bWwpyS6uVf8wkZQESuUudp274A7hsmRUA@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2025 19:37:44 +0800
X-Gm-Features: AbW1kvZUfqXnIV4n7f2ILCp9XC23PMlJbLJV5zlFu8QhTuxzF2Lea85dU9Yht6M
Message-ID: <CAEemH2eAoto=mLFeiXG9WtwPgiwzF=NKbXDbE1eWTuo_QBW8Zw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 5vEuULg_h5iv0vDWYPpEN-rbq7GhRaeRzNXO2YNAiNQ_1736336279
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCh] lib: redefine the overall timeout logic of
 test
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
Cc: ltp@lists.linux.it, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Li Wang <liwang@redhat.com> wrote:


>
>> The changes mostly looks okay, but some of the tests below that had
>> .max_runtime should replace that with .timeout instead. And we also
>>
>
> Btw, we have some tests that implicitly invoke tst_remaining_runtime,
> for example, using the fuzzy_sync library, which also needs .runtime
> but not .timeout.
>

Also, tests that use 'test.runtime' directly (e.g. readahead02.c,
set_mempolicy01.c)
must continue to be marked as using .runtime.

>

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
