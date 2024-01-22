Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B73ECC47DAF
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 09:21:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FB4F3CE23B
	for <ltp@archiver.kernel.org>; Mon, 22 Jan 2024 10:21:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D69193C9978
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:20:50 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1203A200067
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 10:20:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705915248;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n7PHtT60MF/kfhfN7gRQPFF9Zyh8rlV+0CwTourNxkA=;
 b=S3xt122oqnsXRCgEN3UeO2XNGHnRPdex9qOsyonAeQ2hZ7nfbxPaVsfgaKTW729iqR6m6+
 kU8sqRbF5KG/dyYulmePzofsEjNzfm2SU9cx0FmZH55Wu57ngQ4bb5Gjteh13uxq/Wdwiy
 M9eMQp8PPmZYxDe0L+yoPiE8FC32Ox4=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-487-eYIr97nXNDqH7XskTwLTfw-1; Mon, 22 Jan 2024 04:20:45 -0500
X-MC-Unique: eYIr97nXNDqH7XskTwLTfw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-28b3b3633f2so1683273a91.0
 for <ltp@lists.linux.it>; Mon, 22 Jan 2024 01:20:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705915244; x=1706520044;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n7PHtT60MF/kfhfN7gRQPFF9Zyh8rlV+0CwTourNxkA=;
 b=vucKLvHEStK7dtIoyuXwIpIAcq5gIaqpDU77Ef40vyRtUa/DuII1rDOl6bXh0GwOXf
 +w5aLqfBvtvQZLmvZr4szugwF2BFdO6Bq6e53AffzdTZM5gu/KEHCV0QmuZ2Fr8Ilt8I
 zRTuGvjvjDhc1ZCm/CdbbVVuU3g70EDAMNLL8N2z+hPFmW1tuG+kr0vNHLMzHALi1wbe
 85p4G/VJQa0lWtvqtFuUNE8u9fiSUhrUBVyvZ2IzyOkXWsEpaRLASzEJl8/5m6VHgU7G
 TKCK3cXqmA88cbZZI44LFsJ5zL9DBGXHeEsyp2W1jTXf4zuIm5C+nT8DN6p3vWrFi06Q
 eBvA==
X-Gm-Message-State: AOJu0YyeF5R+WFKprdRCWoo1QfY7NFyImzlGRJv18IrjNqtnDmx2bYUZ
 vOBWTNxQv5mI5tJaL7My5HuMt6x012aFj+5kBkSPyfTUvlY8tt04FN/V51JPCqPa+rm3un9twnu
 JDPsks5UlXLr9Q97M1AvUmN+DMPRHlU/ymCikIC2JCJwygduv/JsMEvOP0O7AI++fKe/jsNJOyd
 EVUv0fES55ch3gdzu++iOxEEM=
X-Received: by 2002:a17:90b:1713:b0:28f:f727:b402 with SMTP id
 ko19-20020a17090b171300b0028ff727b402mr999128pjb.90.1705915244701; 
 Mon, 22 Jan 2024 01:20:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGuQ9ksl7RBfTBaRVgBKF6tEavN3BNnKeIUoIh6hDZZSnHbJqe0J5bW5DjKnASM2m4VLU+Evrx5Hb0V+y6iSr8=
X-Received: by 2002:a17:90b:1713:b0:28f:f727:b402 with SMTP id
 ko19-20020a17090b171300b0028ff727b402mr999126pjb.90.1705915244479; Mon, 22
 Jan 2024 01:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20240122072948.2568801-1-liwang@redhat.com>
 <20240122072948.2568801-4-liwang@redhat.com>
 <20240122084000.GB76754@pevik> <20240122084748.GC76754@pevik>
In-Reply-To: <20240122084748.GC76754@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 22 Jan 2024 17:20:32 +0800
Message-ID: <CAEemH2ecf_p=cP+sk675PFVE7A+QdZF=UkLg_z8YP9YKQPCEPQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 4/4] libswap: add Btrfs noCOW attribute setting
 for swap files
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

T24gTW9uLCBKYW4gMjIsIDIwMjQgYXQgNDo0N+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksCj4KPiB0ZXN0aW5nIHRoZSBwYXRjaHNldCBvbiBTTEVTLCBh
dCBsZWFzdCBzd2Fwb24wMSByZXBvcnRzIHNvbWUgcmVzdWx0cwo+IG9uIHN5c3RlbXMgd2l0aCBU
TVBESVIgb24gdG1wZnMgb3IgYnRyZnMuCj4KPiBUaGVyZWZvcmUgSSBhZ3JlZSBpdCdkIGJlIGdv
b2QgdG8gdXNlIHRoZSBzYW1lIGFwcHJvYWNoIGZvciBhbGwgc3dhcG9uKiBhbmQKPiBzd2Fwb2Zm
KiB0ZXN0cy4KPgo+IEkgd291bGQgYmUgb2sgdG8gZ2V0IGl0IHRvIHRoZSByZWxlYXNlIChnZW5l
cmFsbHkgcGF0Y2hzZXQgTEdUTSksIGJ1dAo+IGRlcGVuZHMgb24KPiB5b3VyIGFuZCBDeXJpbCdz
IHRpbWUgKG5vIHByb2JsZW0gdG8gcG9zdHBvbmUgaXQpLgo+CgpUaGFua3MgYSBsb3QuIEkgY2Fu
IHNlbmQgb3V0IHRoZSBWMiBieSB0aGUgZW5kIG9mIHRvZGF5LgoKCi0tIApSZWdhcmRzLApMaSBX
YW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGlu
Zm8vbHRwCg==
