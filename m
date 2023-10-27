Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB8CC25B48
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 02:35:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A5E8C3CF4C3
	for <ltp@archiver.kernel.org>; Fri, 27 Oct 2023 04:35:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1B12A3C99B6
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 04:35:07 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C60781A00CDF
 for <ltp@lists.linux.it>; Fri, 27 Oct 2023 04:35:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698374105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlBczf5gt9WYs2DtozNwhWBzl2iUie+jM9EvWWKGAN0=;
 b=IyFMc19Tc2msuAa0Ds2tv2167XM4J0FuEgQLKkKO6JZZR9dcQy0Qt+nuPh0LlEagFmCCmZ
 aRpyGXdN36Y6zzJYPHcCEVbIl6zYPxGo0dMXZLReX9dMU4hlC+gqvUuTJRopPRbCy9YYBL
 iiT/oXMcFVKLASqeDRiM5LMToTw903I=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-PPyRKsp6MJyL1rshyZcS3A-1; Thu, 26 Oct 2023 22:35:02 -0400
X-MC-Unique: PPyRKsp6MJyL1rshyZcS3A-1
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5079a3362afso1796430e87.3
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 19:35:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698374101; x=1698978901;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZlBczf5gt9WYs2DtozNwhWBzl2iUie+jM9EvWWKGAN0=;
 b=iPRZJ4njeg+91+c7FqnrStEFVKNSY9thSOf/y62GbbMQdKdM2eChoejN8l3+BRgvt9
 gVNnUcZgH8JK/arjRcg+DHOFTyn6SI7lHT+L9oxSGShGatHo/dRKsHtH4HK97qb3WIWC
 dOS7FzILgrF0Hg/tzyMk6YbNOpJdXSogw/DvW/w0OYA/MEG9a8JitikY+QhHJJ9OJO6O
 Bof/TwMp7XRaMlX+yNEBMMx04c93ivR7bHUOPFhF1skKt7qR9VUvpaGgIN2qIsF0PlY4
 lsf/7WRhGfpnL7hSKwalgt98mSZ9TNC8kHZI8RkxGQpwPSRT8MQZBUe0NMXIw1F5drYV
 3T1g==
X-Gm-Message-State: AOJu0YxTHTgxr+fsunmzlW1onDtuai+uWRlyBhidr8Ljlsf6kfsME18w
 Ugeqh0H3RyNjVFvjr64TbEPVRWqHXKKYFO7uCUnN0dwmWr3/gX6ND6FM6Ve8glj8cTtuQqlBIXx
 WmgL/Rsd3bDzFHzSGYmwzWTi7RGI=
X-Received: by 2002:a05:6512:49b:b0:500:83dd:27e6 with SMTP id
 v27-20020a056512049b00b0050083dd27e6mr767239lfq.27.1698374101529; 
 Thu, 26 Oct 2023 19:35:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiG0ZKQdVMmhegJa+cRIXrlzlIvuycYOdeyQttHPb+QrgnK9cS4oR/pSql0Bkiil+xsEVI9kM9GHBvQeK6WoM=
X-Received: by 2002:a05:6512:49b:b0:500:83dd:27e6 with SMTP id
 v27-20020a056512049b00b0050083dd27e6mr767230lfq.27.1698374101172; Thu, 26 Oct
 2023 19:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <875y33vsks.fsf@suse.de> <87lebpu02a.fsf@suse.de>
In-Reply-To: <87lebpu02a.fsf@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Fri, 27 Oct 2023 10:34:49 +0800
Message-ID: <CAEemH2cc1KMYba93WFD5ttXywMnF5+M3ySKEnvcMaExwGgBL1w@mail.gmail.com>
To: rpalethorpe@suse.de
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Open monthly meeting 1st of November 09:00 UTC
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
Cc: Andrea Cervesato <acervesato@suse.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljaGFyZCwKCk9uIFRodSwgT2N0IDI2LCAyMDIzIGF0IDY6NTPigK9QTSBSaWNoYXJkIFBh
bGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuZGU+Cndyb3RlOgoKPiBIZWxsbywKPgo+IEFmdGVy
IHJldmlld2luZyB0aGUgcmVzcG9uc2VzIHRvIHRoZSBSRkMgSSBoYXZlIGNvbWUgdXAgd2l0aCB0
aGUKPiBmb2xsb3dpbmcgbWVldGluZyBkZXRhaWxzLgo+Cj4gVGltZSBhbmQgZGF0ZTogRmlyc3Qg
V2VkbmVzZGF5IGVhY2ggbW9udGggYXQgMDk6MDAgVVRDLgo+IFBsYXRmb3JtOiBodHRwczovL21l
ZXQuaml0LnNpL2xpbnV4LXRlc3QtcHJvamVjdAo+Cj4gVGhlIGZpcnN0IG1lZXRpbmcgd2lsbCBi
ZSBvbiB0aGUgMXN0IG9mIE5vdmVtYmVyIGF0IDA5OjAwIFVUQy4KPgo+IEkgaGF2ZW4ndCB0cmll
ZCB0byBhZGRyZXNzIHRoZSBsYWNrIG9mIGNoYXQgYnJvdWdodCB1cCBieSBMaS4gSSBzdWdnZXN0
Cj4gdHJ5aW5nIEppdHNpIGFuZCBpZiB0aGVyZSBhcmUgaXNzdWVzIHRoZW4gd2UgZ28gZnJvbSB0
aGVyZS4KPgoKVGhhbmtzIGZvciBjb29yZGluYXRpbmcgdGhpcywgbG9va3MgZ29vZCB0byBtZS4K
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
