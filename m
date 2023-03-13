Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5101C61DA4
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 17:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 023BC3CD540
	for <ltp@archiver.kernel.org>; Mon, 13 Mar 2023 18:17:27 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0A7983CA013
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 18:17:15 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 166E8600742
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 18:17:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678727833;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dtBoXHXWXr1hOjkhCczQTmTKMYq+JO6hEl6rGHCGwog=;
 b=EDBVd0MalJSz9mfAzGup2tfSYne/Mem/d2/h6NNeb1m7U12i2h0oVa8xPPUXh4fNOdyTTo
 WLMDxk3phyqYaHMbuVQUXktZOEqywnG/dsl5azGiS/tuRDnWx2TTskxUWhh7BtiS336tko
 1WE4lEB3i77/FTedKqZJeWmaPoSgz/0=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-nvR0hOZxNjmHiGVb9ABw8g-1; Mon, 13 Mar 2023 13:17:09 -0400
X-MC-Unique: nvR0hOZxNjmHiGVb9ABw8g-1
Received: by mail-vs1-f69.google.com with SMTP id
 r6-20020a67d006000000b0041f6dcff59aso3915397vsi.8
 for <ltp@lists.linux.it>; Mon, 13 Mar 2023 10:17:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678727829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dtBoXHXWXr1hOjkhCczQTmTKMYq+JO6hEl6rGHCGwog=;
 b=TKpkrLc06bZ/mrmWPcm7WVXWtteo6aqbJPToaDIzdF7d04JWCS/OclQ1gO5O393zdd
 xFD58TjGoPePqjZFP6BxxpLR8NWVgGH+APk3588tkglJntxPht+xkqL34KNAZDQRZUQv
 d7xR5rLt8HZI/JZSqoLonJhnlDBramHtm5kvItpCbAlbBvVBo4n0ovG2upcIIqQw9BvA
 2dGgoVfXpSLvKXXyR+I/RK+G1ud4cFsWwiOtpKG9M7H781surtAY8u2RkGEzZx+u15k2
 YKSe9JTnGrFpx5KY+B832NGDV/81Mm5xF8Kbct3/DHP73h1ia7ToZhQ6LEr625QezVhw
 Mi2A==
X-Gm-Message-State: AO0yUKVPUwzJP70WPn2hjYDQPfiOqyQwvALqkq1Dk/2Efq18aei4y95M
 u4Yi2Q9xZ8mEj879xFxO0yoqSuoWenuSGnxCJjY5XVIquEgmhD2KQvdPIpvWcVbEazZDskJuOG+
 Tr/ThQfNCv4JE3vXG5CVzGD00wZ4=
X-Received: by 2002:a1f:cac3:0:b0:406:6b94:c4fe with SMTP id
 a186-20020a1fcac3000000b004066b94c4femr21548893vkg.0.1678727829059; 
 Mon, 13 Mar 2023 10:17:09 -0700 (PDT)
X-Google-Smtp-Source: AK7set+ahTPOsnjlOrRSQSOoRskTnSK3U72otoJ5xVPx5akpQKyzdRI6okTPG2GKGxuow7LFBaLAnid7hsgDZj1Js6Y=
X-Received: by 2002:a1f:cac3:0:b0:406:6b94:c4fe with SMTP id
 a186-20020a1fcac3000000b004066b94c4femr21548886vkg.0.1678727828781; Mon, 13
 Mar 2023 10:17:08 -0700 (PDT)
MIME-Version: 1.0
References: <fb88846b13f4b0c39c6e3f44b67454f5c3857f6d.1678432077.git.jstancek@redhat.com>
 <ZA8zFQrQIDXrFrmg@yuki>
In-Reply-To: <ZA8zFQrQIDXrFrmg@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 13 Mar 2023 18:17:11 +0100
Message-ID: <CAASaF6x25QHOM4B06km7DtRjA3KNtLjTwaHYUzDQSJWTxRgoSQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] endian_switch01.c: drop unused main4()
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UHVzaGVkLgoKT24gTW9uLCBNYXIgMTMsIDIwMjMgYXQgMzoyN+KAr1BNIEN5cmlsIEhydWJpcyA8
Y2hydWJpc0BzdXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+IFJldmlld2VkLWJ5OiBDeXJpbCBIcnVi
aXMgPGNocnViaXNAc3VzZS5jej4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNl
LmN6Cj4KCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlz
dGluZm8vbHRwCg==
