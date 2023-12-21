Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69BFC35274
	for <ltp@archiver.kernel.org>; Thu, 21 Dec 2023 10:09:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0C7273CF27E
	for <ltp@archiver.kernel.org>; Thu, 21 Dec 2023 11:09:31 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1E88C3C990B
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 11:09:21 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 0CFB91400E1C
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 11:09:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1703153359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dkVQIyA1l66wYENMOTjTtkFkK5QM64Rr7RcC4s5fkZA=;
 b=WZsNi0gnJfzObT0BKJHXD62jl1v6iGIU98sSw48E1FnqDEwOFPiEd3zwkh1egNofXz1ZQ3
 eU8ijO4tho9bFHUf9s/+W6mqnxlLIqHXR6JyZ0OtBKN3l/fM+p/FGNEuqVsntH2IqCG7X8
 2B0b291txmC0MW73cQrWXuBi9s9EY28=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-uP0eaJGNOu2rlRs8WGDgxw-1; Thu, 21 Dec 2023 05:09:17 -0500
X-MC-Unique: uP0eaJGNOu2rlRs8WGDgxw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2cc7608666dso4176041fa.1
 for <ltp@lists.linux.it>; Thu, 21 Dec 2023 02:09:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703153354; x=1703758154;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dkVQIyA1l66wYENMOTjTtkFkK5QM64Rr7RcC4s5fkZA=;
 b=idzrW3daV5O9dqw48nYyR8YSShh+GiQPZeR7OjjbGQF1Pr08a0PFBLxgOP7Goonhq1
 fC6elofozKmCh4Vafk01cIiOAL3u6g/I0UQc3nd4O53I15oB6wAQKg+BpjIaUq9Y+1RJ
 VseFQlZ4PFXFHyjH9ilR6RuYpyONu3Rg+W3f5o9ZYBZifx0Y8WlkjbTrVCBrKgf9YdJR
 aS4lhdZw5og5fhxMcjlY1hIszfJfSqZuufaWAgzaHhQ2RD5MEsWYWbcX06CSFpDVYmsd
 C+mES7XbaPUyvLqVnyoYZ/G8lYuwhVegCp0Q/q5DZsn99CPbKuOCoP1d0emSOLhG4iUp
 yXyg==
X-Gm-Message-State: AOJu0Yyz+mTZxlr6t+omxAOk1SheTodcqxh1gLwsB8/AXfrq5WvhPgbp
 489Xb+RviMj3/SKOq4SfAp5EZ/kEjbllktcMIQ1DgqxHFgqiYkGSpa4eCjnK6VFitlzPDFVprK2
 J9gG0AeLijKNlh1Yo+P45bBrXMre1vKIk2HfHiGZ8
X-Received: by 2002:a2e:8183:0:b0:2cc:9dd4:e539 with SMTP id
 e3-20020a2e8183000000b002cc9dd4e539mr391288ljg.66.1703153354261; 
 Thu, 21 Dec 2023 02:09:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf27KiEpAm1ubBlmOa70H9cgM25h4qX6wCpZ8hYYM3z1ryxVFWgOh7O0Y9ob/pD5AESWvfWNCcaE1KTtBaYgQ=
X-Received: by 2002:a2e:8183:0:b0:2cc:9dd4:e539 with SMTP id
 e3-20020a2e8183000000b002cc9dd4e539mr391283ljg.66.1703153353926; Thu, 21 Dec
 2023 02:09:13 -0800 (PST)
MIME-Version: 1.0
References: <20231219054803.136732-1-xuyang2018.jy@fujitsu.com>
In-Reply-To: <20231219054803.136732-1-xuyang2018.jy@fujitsu.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 21 Dec 2023 18:09:01 +0800
Message-ID: <CAEemH2cpUcaYJ3Pyu-n0zNYH91wydmdbXArLFiecdnCMT+pteA@mail.gmail.com>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] gettimeofday01: test EFAULT error for single bad
 address tv/tz
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

Pushed with the description polishing, thank you!

-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
