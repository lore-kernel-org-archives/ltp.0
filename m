Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FCBE77198
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 02:46:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 061DF3C1934
	for <ltp@archiver.kernel.org>; Wed,  8 Jan 2025 03:46:00 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 586CB3C180F
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 03:45:43 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 979C91032C3D
 for <ltp@lists.linux.it>; Wed,  8 Jan 2025 03:45:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736304339;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sHzCuC1WFLNiWgnUOcKLeAllGPtuGlt/0FVmopWfxX8=;
 b=AU5MAn6l7fUZh3kxtfV5TSLeh2KyJro5QRyiXQZdjxrEFhQAZCb1K1ouNstk9I1I4T0Xgl
 xQmDhm8HRr/hoL0zylCpsF19Nl0vMwz0fztXz2SVS3WDzEPNNAfSYWBj2glWx8wtGbkbhG
 KXkK2VsI3GEvHEfdIzZ9NUhQ02mf9hw=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-NoUPzVbNMjGHpMC1CLFNrg-1; Tue, 07 Jan 2025 21:45:38 -0500
X-MC-Unique: NoUPzVbNMjGHpMC1CLFNrg-1
X-Mimecast-MFC-AGG-ID: NoUPzVbNMjGHpMC1CLFNrg
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ef79d9c692so36592772a91.0
 for <ltp@lists.linux.it>; Tue, 07 Jan 2025 18:45:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736304335; x=1736909135;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sHzCuC1WFLNiWgnUOcKLeAllGPtuGlt/0FVmopWfxX8=;
 b=Uya1aNJ3guxtcQp4gRO8+DADsU1u418mfZb7Ftko4H94YFXvHqoygE3pPu1NGIor04
 v7lGYDVpKhBksbONIRYmHBGM6QISUKn/uPL0WM1fbp1DRKU7Wt7Q0UA/zTbt36WgLpMJ
 Eft1t7qCdripVj8Hw2CXBCqm++mVSZSpwDi6brsrmV2iuvLU6PHbTHXxtL8CGWklA6Xt
 rlY0AMqGntivggQGb2r+XbSk9ZItRgcK7LHrZVr8fCn5qIT8Pg0xGWyUVT8qD4ZX1FhF
 YY3lIByvm6QPHtLrPlIaqHZPnpIttvJLU8OUKzwme0zm+DpdZt/5rlHvSwqeSOpbHNHA
 sRaA==
X-Gm-Message-State: AOJu0Yxq4ANRzpZdqRQff340wp2LjNHKaOjcXw4wcfXhcyR9HjMpX60u
 Oi8go8X6DNhqF9RzrjJOI8re2xQvUjdhzWA0hyZ5OncSI74Wg/a+TEM1X43j8Z0MrS3qIStPezx
 wlH4nif6P6Zr8MQOzfWFmDUCPZUp1c5wn16oc76VQq6V+cjQdz0hWZHMEqk0IXOCnbr94gp98iB
 axAQZWCsbMQWtlDxH9W5yry2oD/Nphjp5p0A==
X-Gm-Gg: ASbGncv3XiJgFLIfw4irt5rvit09fXgFB9SxUp2Ys2Ur8KETbKNaqagbmhipvDK6CDU
 Zdi3rTVHtZEDK3JxrCeiHDDWE6G1SWPiA/SjgVy8=
X-Received: by 2002:a17:90b:2747:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-2f548e9c9bcmr1817813a91.2.1736304335380; 
 Tue, 07 Jan 2025 18:45:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH+sES5MLbpyFeK+mq7cFIB5BEAymxGMQ78nG4KB4KiI45I17sc+Hjjj4ij6pQUAc/pouaFPLU/MVyuBaFg/Ko=
X-Received: by 2002:a17:90b:2747:b0:2f2:a664:df1a with SMTP id
 98e67ed59e1d1-2f548e9c9bcmr1817799a91.2.1736304335105; Tue, 07 Jan 2025
 18:45:35 -0800 (PST)
MIME-Version: 1.0
References: <20241222075102.14536-1-liwang@redhat.com>
 <20250102144104.GB94207@pevik>
In-Reply-To: <20250102144104.GB94207@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 8 Jan 2025 10:45:22 +0800
X-Gm-Features: AbW1kvYNxnlHLBOxRlbY0D_M0Q-YdAkhgrjfZHd5kWfkLhOB_MKFKCLyf2T1DOw
Message-ID: <CAEemH2eKKqrKrnu-oL6YFiNuPzHPzY8h2CzAOdbyWS3jiQaLyA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: U5POEes_BOb9i1l77AX6n6y4qJjT3u9ojsqm-KWL-h0_1736304337
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] tst_fuzzy_sync: refine code and comment
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

T24gVGh1LCBKYW4gMiwgMjAyNSBhdCAxMDo0MeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiB3b3VsZCB5b3UgbWluZCB0byBjaGFuZ2UgYmVmb3Jl
IG1lcmdlIHRyYWlsaW5nICJcKi8iIHRvICIqLyIKPiAocmVtb3ZpbmcgIi8iKSBpbiBib3RoIGZp
bGVzIGFuZCBleHRyYSBibGFuayBsaW5lIHdpdGggIioiIGluCj4gdHN0X2Z1enp5X3N5bmMwMi5j
Pwo+CgpUaGFua3MgZm9yIHRoZSByZXZpZXcsIEkgbWVyZ2UgdGhlIHBhdGNoIHNldCAod2l0aCB5
b3VyIHN1Z2dlc3Rpb25zKS4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
