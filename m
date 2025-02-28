Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35858C19F32
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 03:42:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 077BB3C9DEB
	for <ltp@archiver.kernel.org>; Fri, 28 Feb 2025 04:42:24 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DDCB33C66A0
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 04:42:08 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id EC3CA141CE78
 for <ltp@lists.linux.it>; Fri, 28 Feb 2025 04:42:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740714125;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DtNaW+GTq2QJTlD1/3zztIjNkWOpyQlGXpEjn7x3AdE=;
 b=Y8hiSJeh1suoQnoLhf6A2bnXqH/zxjMuOHxcOtZNhy7WXaBaRlA+BzT5VoiMTlgYq+nrCZ
 dyx19KVvXCArt+T4+ou6QN//n5gz3+/JLq/Kr8iuQXiNJMSU2IWFkE1Vv4/giVyBLMc/DG
 iJwuj3X7u1QsOseUf6L+EGFH9kb+HdY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-426-fFqM2GC0Nhqyuji7XO1etA-1; Thu, 27 Feb 2025 22:42:02 -0500
X-MC-Unique: fFqM2GC0Nhqyuji7XO1etA-1
X-Mimecast-MFC-AGG-ID: fFqM2GC0Nhqyuji7XO1etA_1740714122
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2feb4648d4dso3389109a91.1
 for <ltp@lists.linux.it>; Thu, 27 Feb 2025 19:42:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740714122; x=1741318922;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DtNaW+GTq2QJTlD1/3zztIjNkWOpyQlGXpEjn7x3AdE=;
 b=uKn9wnyO0Ero9u9vf6jYMCLZEnOgK5jbq5VkiEuoq6JAkzE22VGocPOgQPsWyXUu6C
 +QQsgHHWSULlY5NL9IHWdQ0AN0L7vk/r+R1Y+Newd7CVnG89Xzj3nci1sfHGfn9Gklry
 NG9/go+dcad3110z5SivDLTa3Cokt6Tibnx6vBUl+54Z/9H66Ti+ebsGjiYCd8zqA670
 PMrwmuPeMAHtg2KF0ckTBmMwCsUnxVgYtnUFHYRzN7LNcX38ahi8XfabxEzxRwUCsU3A
 Hrd/DTh7S4m8U8ocb15U8v08zrp/Eeeo7yXeGOyhZRJPqtjH62F1ortmHhXiMlMhL4UI
 tH7w==
X-Gm-Message-State: AOJu0YxHknJ7l9vaZHmxtCQc+7lH2ZMjfwjbhv1kmrZKzsKndIXTE9X1
 caAKyXjgDVj42sjuNBXFsHD6lL8fovTHkxEM6ndtyhru3E1Ke7MsQ9bj0/d7Atqo24sFLbSnZbv
 g89X2Qg3gtLUS5MlhUxqbIeNIIorJ2Fp4CyKCSZ0u+a0lZOFpPZ8U1VmtEGGAzRPa5CFyXSY4Yn
 4zOAvxXrE0nXuyR0VgfeW6t3k=
X-Gm-Gg: ASbGncuk9nvYEaZ6A2imopkADRlwi+6h+vSp1prgfbKiHuEumdJWU4/ZrtfEZ3rGvHT
 huKR0OOVypSZQElDKHuS2girRTFxTOzuHitWyTi6s/Ugv3TjVG2Np1lIvgnDGHiV0rGGJft5XpQ
 ==
X-Received: by 2002:a17:90b:4cc6:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2febab2ececmr3023539a91.4.1740714121896; 
 Thu, 27 Feb 2025 19:42:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEB4EEf6nxaH1yXug+sy59vNPiaScPziMYHfC8QyMZ1TDFwoE8o9Z5pry4ZExeoidoCIvmjvH8SKo8V/EyE3nE=
X-Received: by 2002:a17:90b:4cc6:b0:2ee:c91a:acf7 with SMTP id
 98e67ed59e1d1-2febab2ececmr3023525a91.4.1740714121681; Thu, 27 Feb 2025
 19:42:01 -0800 (PST)
MIME-Version: 1.0
References: <31878632-52fe-4aed-8018-8e30ebeae52d@suse.com>
 <20250224030743.1567840-1-chwen@redhat.com>
 <CAAA2g-1m5Hfq9nygiCnFFwt6Axgxjj3dO=2Ei_-cgSw3dT60Bg@mail.gmail.com>
In-Reply-To: <CAAA2g-1m5Hfq9nygiCnFFwt6Axgxjj3dO=2Ei_-cgSw3dT60Bg@mail.gmail.com>
From: Li Wang <liwan@redhat.com>
Date: Fri, 28 Feb 2025 11:41:49 +0800
X-Gm-Features: AQ5f1JoLSCxYNOuiaMTOyn1GORhUBI2-WGCeiluebn0ikDwYKHPIHNUAG8e7Ygw
Message-ID: <CAEemH2cpdqSViHfDcRfFqsWtz4kkrkhU4DymfXW+5REPEMvYTw@mail.gmail.com>
To: Chunfu Wen <chwen@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AFhL4YUHJy7r2rhg17EeqGAKJaftHAlmnJZxmoshnWI_1740714122
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4] Add test case to cover the setting resource
 limit64 for process
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
Cc: Charles Shi <cheshi@redhat.com>, Irene Diez <idiez@redhat.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBGZWIgMjYsIDIwMjUgYXQgOToxNeKAr0FNIENodW5mdSBXZW4gPGNod2VuQHJlZGhh
dC5jb20+IHdyb3RlOgoKPiBIZWxsbyBNYWludGFpbmVycywKPgo+IENvdWxkIHlvdSBwbGVhc2Ug
aGVscCBtZSByZXZpZXcgdGhlIFY0IHBhdGNoIHdoZW4geW91IGhhdmUgdGltZT8KPgoKSSBoZWxw
ZWQgcmVzb2x2ZSB0aGUgY29kZSBjb25mbGljdCBhbmQgcHVzaGVkLCB0aGFua3MhCgpMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
