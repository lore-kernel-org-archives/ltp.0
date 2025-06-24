Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833BCC77B7C
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 12:37:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1750768646; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=A5T6SNryomfoZ+TifNOzRjA2J/UZHUPt5DtBUgvg7bc=;
 b=Gk58Nfy6U5l3kRl4MG+AnLg2qZQ23I5j+VRxZ2yClI1knMi+t8MSaSpCNqcbdhbGYkbbf
 Nvu/AMvnMesFUGvndoezJOqsoSe3/1mpbSgdnxuKy2E17EN/eQEjMIC2Cvp3Ry9UasGF1Uj
 gYte3eAqE3pAtTYNwJ5kXGOVdG16am0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A54C13CB294
	for <ltp@archiver.kernel.org>; Tue, 24 Jun 2025 14:37:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D17D53CB294
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 14:37:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 168E314002B3
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 14:37:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750768622;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yiVe/Gg7+RxLBnrKSHIxLv1tu6bKbYbMSLbFqjudbKQ=;
 b=e3Iu3U6zYcYglkYEOqQ4SsrlszTSDtd6WKrNLbZbkF4NzbAFOENHAOp1dMtYrigFdvKgJW
 9sZCHXweCDfOlmBXSH+S7jgcZp2KK65ngSPWRhTzwOKr73xFvujjFz6ELB56BTQL5MfBMw
 La9MSBzjKvzZwfBLWwUKMtz4gn0clQQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-lg2LI0WmNQC-vO8bVx4-jQ-1; Tue, 24 Jun 2025 08:37:00 -0400
X-MC-Unique: lg2LI0WmNQC-vO8bVx4-jQ-1
X-Mimecast-MFC-AGG-ID: lg2LI0WmNQC-vO8bVx4-jQ_1750768619
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-313fb0ec33bso408002a91.2
 for <ltp@lists.linux.it>; Tue, 24 Jun 2025 05:37:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750768619; x=1751373419;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yiVe/Gg7+RxLBnrKSHIxLv1tu6bKbYbMSLbFqjudbKQ=;
 b=aE1AhQe6OPDJ/3KU1ot50700kGWOtcbhl3Bn8q4XeOc7LVeA1idtfr7HQ76pNxTBMv
 c3WJdudDzNJ19jnRFveOpbuOU+hVF0Dx0mxUaLR2kcOnt9GrOA347cIk18nRXZpxmL+F
 FB2OAX32HXqQ780ogFpUD9YlrlQjsaaNvOyeZCUgb1g4C3+LgWzWqKdQOTIbQcqagCAB
 hJ0RryrQqN/pMeZZNzuh3W1XYJ5i/FPq/eQTXyEKioazcO1b531QQ6CubHv+1EVHTSFd
 I2/tdBet9mOekCb5mr7eU9/IA0L11UqdlIi3B43v4gP2YrHMJ/kuFd51c8hsB1bs40zk
 Wubg==
X-Gm-Message-State: AOJu0YzXDGZRmgsePUo2uJydSsnABn8g4X2wxJ+fVQWlMuyTX4XM+ysV
 RkK4ebOZo/6pFjGEfvDtUjsF0uaxecLtEGg5tIdLnTN7NQzXtr2yam1iXUqpJAM2i/OIzXioV5N
 OKL+/2GsRVzlFfRTE0u/fysL3An0NpbHifsNhp/rWcwWodPQNBlMn1UIhHzw4rd5EM60AE2tjgd
 miyJQnw61idnjatNSmfxX6yGqEQJY=
X-Gm-Gg: ASbGncv5otHlqJKHrMG8EPoeGysBNPraK3b7qkxnCLlc0E4/6zjToH1oahJKb/72lrX
 pFumNos8hOYltZUz7DRAYcoFWuqRwektzUGnmqjKZc1JC3YUGJgLegwQvTMttP78ilXk0BJOJpD
 vuG5b2
X-Received: by 2002:a17:90b:1cc3:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-3159d635d0bmr25869973a91.4.1750768619051; 
 Tue, 24 Jun 2025 05:36:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsBs0bcoubngwMW1mVlJ17cKplKNy4NgRUMMa3TqBGxCNHSTwkjrsT7fMOlbtsC4vPi8cDXCkAIj8NykadAiU=
X-Received: by 2002:a17:90b:1cc3:b0:313:2206:adf1 with SMTP id
 98e67ed59e1d1-3159d635d0bmr25869943a91.4.1750768618613; Tue, 24 Jun 2025
 05:36:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250623140210.32347-1-liwang@redhat.com>
 <aFrxBElBT0jg6IOy@MiWiFi-CR6608-srv>
 <CAEemH2ctXX_-xs3UPu4wCikok-b7qq747wgTBoer8q6+vELzXw@mail.gmail.com>
In-Reply-To: <CAEemH2ctXX_-xs3UPu4wCikok-b7qq747wgTBoer8q6+vELzXw@mail.gmail.com>
Date: Tue, 24 Jun 2025 20:36:46 +0800
X-Gm-Features: Ac12FXydtC8sCmyVIL2kV7d40fMYa7UCCvGtXLUd5j8l8uhl2N8GgNLhWb1HUXY
Message-ID: <CAEemH2dRgdg2tH7G3QPn-SmGndf+p2himEQ49VxURrigXwMQHw@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7WcrFer2rwzoiSHymqqhjRRvCpl8bAk_lzyedjSZVy4_1750768619
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2] tst_test: Add min_runtime to control lower
 bound of scaled runtime
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

Hi All,

Li Wang <liwang@redhat.com> wrote:


> But the default 1024 min_samples I still have no idea how long
> the .min_runtime needs. Maybe we can estimate and set .min_runtime
> on a slow system manually.
>

I choose to run the fuzzy_sync tests on a Cortex-A55 CPU with
only one core assigned, using the taskset command to simulate
an extreme single-core execution scenario.

Tested on:
    Cortex-A55, 1.2GHz
    Linux 5.14, aarch64

For example:
    time taskset -c 0 ./cve-2016-7117 (hacked the test only do sampling)

This setup allows me to evaluate how long the sampling phase
takes under constrained conditions.

Based on the observed sampling duration, I apply the following policy
for setting .min_runtime:

  1. If the sampling time is very short (less than 1 second),
      I simply set .min_runtime = 2.

  2. If the sampling time is longer than 2 seconds but still less than
     .runtime, I set .min_runtime to twice the sampling time, while
     keeping .runtime unchanged.

  3. If the sampling time exceeds .runtime, I also double the sampling
      time for .min_runtime, but leave .runtime as is.


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
