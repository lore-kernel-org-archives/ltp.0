Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2937C54E90
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 14:50:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747925398; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=w94gYd0IiUacnfWbGZEE5BK+mITZ/p+jfdmaxSgnR/U=;
 b=DyKSJN4dwRhtzvX9sFa/wrLoVpQQa2u8ts84hnfiLrh7L6HKBiAJB5+nu7kLXyCxmVgoK
 wz1WHYnGRJUmcpSFH7MY2TTLLJmoY6YxcvfB1ElUk/TOV4n6kNmaJ3acvP1gzVyUYBtxgLd
 4OXUifjm/bagIOSnhGPDMLPbxvF0mtw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA62C3CC872
	for <ltp@archiver.kernel.org>; Thu, 22 May 2025 16:49:58 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F29403CC85D
 for <ltp@lists.linux.it>; Thu, 22 May 2025 16:49:37 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 56AC36002AE
 for <ltp@lists.linux.it>; Thu, 22 May 2025 16:49:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747925375;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TRG9PwnO3pyaPP3XFBkB/qV0N+o3ns/lWyQrG7120cw=;
 b=Bpfrf8CBGFH4EaMPZnNJSyzLFiZQBNPfVM8gU5lo7Q387TkM2Goin2gLuWKawTHZVZPtzV
 szxKe/LT1MLq/PHor0ZR+TSMAX9PrvTRbeVF/GnCqwGLWJt2SZo4opiraSYMOuzrQ8Qe1H
 lwyLLOngpJDmXpaJ7ZstP8Iy17YctsA=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-yMcA_VoPNyygUzvRxUZizw-1; Thu, 22 May 2025 10:49:32 -0400
X-MC-Unique: yMcA_VoPNyygUzvRxUZizw-1
X-Mimecast-MFC-AGG-ID: yMcA_VoPNyygUzvRxUZizw_1747925371
Received: by mail-pl1-f199.google.com with SMTP id
 d9443c01a7336-2326a6d667eso33223915ad.1
 for <ltp@lists.linux.it>; Thu, 22 May 2025 07:49:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747925371; x=1748530171;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TRG9PwnO3pyaPP3XFBkB/qV0N+o3ns/lWyQrG7120cw=;
 b=wIIAVc2zKitWsNNlJfiybUKUkKZmLphdAzV7/FYx76jUBMdGYFYkkh1kd6jgSJ5stj
 R5cI3RZIeDtng8XHfGKR6UiQeRXkgy+KPELdd76z7PA7GFHivoiiH3Gf8ug68KyS2ebT
 EZBfS8DJhta1PwyWSXKtZmQA3e+24Of0rXt11NTRYxXR6ZbeHk78XaMawoC/K5m9ssN1
 RXIftEkamzGUmV7DazH1XEmw5Kle9rXg45YfvGZiGpgP5f7f87HWW2v/O964cRbzNXZG
 27z440V5lGI4wIE3XP6pL5jOpa/zQ2RW8Uf0aP3Xq2qWWYJBor+Di2IEDX5e+aBGubUy
 Jiiw==
X-Gm-Message-State: AOJu0YxZwjSZFP7vP4UpD+iDH8WoCXYwmmy5lOytVgWKDRfsPyWPOeyL
 L8T8mn4gw+SN3hrOEEWDU5VK7rIRq+99uxO8ohHhuUzLwU14NwVsE2RdeDDO3p/7Z11zwleUg9i
 mtcKriaw91hPPd5YHTlvbd7SwlSGpr887dk6unjCZ7gbXOLv2UlBrYfy5s+4VqpgM/etMfR5EbE
 dSaJ7jh/eE9T3zN1x7TSD88sNnME8=
X-Gm-Gg: ASbGncvT2o4//JYjRGtgJkObB+1Zu46ix6WRfcKXUqfRzl06RiU1+b9EO49xhr65CzF
 m4zlF5odhvEuN23tW6Wp14yRGTnkUdWhMoz+RIiWYJEjS93e/11ZN/bW6Lv3sp3FwJgGGzQ==
X-Received: by 2002:a17:903:183:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-231d459a702mr330244575ad.42.1747925371121; 
 Thu, 22 May 2025 07:49:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGb0YkzD4rgXgCm0oexfqQ907JOBgQhByoRBpbyWMXKdZI0XrPHhwYXwVjuiErnVhvXP7+EGkxtCbAhf/se0AE=
X-Received: by 2002:a17:903:183:b0:21f:4c8b:c4de with SMTP id
 d9443c01a7336-231d459a702mr330244365ad.42.1747925370775; Thu, 22 May 2025
 07:49:30 -0700 (PDT)
MIME-Version: 1.0
References: <20250520202429.577890-1-luizcap@redhat.com>
 <CAEemH2cdN6mcYJk06ksp7nyzz5qOmmRM=sR_SAqLtquD=8ya3g@mail.gmail.com>
 <ae7ee313-21f4-4f82-b522-4028947c8a1c@redhat.com>
 <CAEemH2dccNNvuEE_GNLxd3eR1_uiVX+UhmFBaNXTPU7sRYg29w@mail.gmail.com>
 <CAEemH2f33e0287pfngF+dczQ_AS0Yvt6YxNQOnrpSGHuqODRbQ@mail.gmail.com>
 <72dcba43-6d27-40e9-a110-3db7990e58d1@redhat.com>
In-Reply-To: <72dcba43-6d27-40e9-a110-3db7990e58d1@redhat.com>
Date: Thu, 22 May 2025 22:49:18 +0800
X-Gm-Features: AX0GCFtq3wg-E8RmfnrT_IN1LyFm-nCQgE4PlK9VPQ0TTzGmFmESZq2RaxCWy1I
Message-ID: <CAEemH2ewJYavkogUsfMXqEbt6=V+fndxF5U00Rw7JZ1RbkebsQ@mail.gmail.com>
To: Luiz Capitulino <luizcap@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bGVOExfb6mqmhfjQGrqYDGQFzwDCEZ87vGeUyCc6nE8_1747925371
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] ksm: fix segfault on s390
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Luiz Capitulino <luizcap@redhat.com> wrote:

> Just to make sure I understand: you measured total test run-time, correct?
> How many times did you run it?

Yes, I measure the ksm01 test total time, more than 10 times, each time
checking in per-block is faster than per-byte method 1 second.

If we test with 10 cycles, we still get similar results. So, I would keep this
as a open question to see if others care about the 1 second (like me).

Per-block:
# time ./ksm01 -i 10
...
real 0m58.723s
user 0m10.530s
sys 0m13.973s

Per-byte:
# time ./ksm01 -i 10
...
real 1m7.958s
user 0m24.990s
sys 0m14.016s


-- 
Regards,
Li Wang


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
