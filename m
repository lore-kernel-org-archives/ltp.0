Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1095C47077
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 01:42:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5F73B3CFFD7
	for <ltp@archiver.kernel.org>; Wed, 17 Jan 2024 02:42:40 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8FDE03CCA9E
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 02:42:26 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6698A1A0237A
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 02:42:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705455743;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2UErMaWyfwBmziQJ49l7qAjF/KhayztvjEoyrbsiSv4=;
 b=D2mYd9eEhzrdC6MfzwK0dnFQRb6UpVOIKfxcmLpBivVZ5WtbzqJBBLu534UCcvjD2J8b3k
 QgBGIoQRBRMLaqVVTyuR306d2LqFl6CBHpfpDIrYoS0USbwVrtYuPrdH2kDCRwMqCOeve9
 QFzjeucXCAxwWE+xyhfL7Kb0qg/bt7o=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-Mag5ouLPM-ytKKEMq9EITw-1; Tue, 16 Jan 2024 20:42:16 -0500
X-MC-Unique: Mag5ouLPM-ytKKEMq9EITw-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1d5f04b0b81so9773425ad.1
 for <ltp@lists.linux.it>; Tue, 16 Jan 2024 17:42:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705455735; x=1706060535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2UErMaWyfwBmziQJ49l7qAjF/KhayztvjEoyrbsiSv4=;
 b=n7TnU6QFK5W6PpzpQiZ6bpLyeKGhbTnZx4dNz4OihawnArwxK/H2CPuHXCPNWopbCM
 Ugr8JzmV56UkEXd1mLCg/xLaD3ZoQhY3Bc4oYrzFkQ8Z5LQK7qbKbPPTSNJD7EHqGBz3
 oHupK7/47ePq+YriXYqOiNAXTabXEZXp2Op94VUuejrOzJsrqa2B61oxegMXqmbWmw2J
 GzbHMcn2Sg6U3Xj4lXgNA/A7t+dl9n0y0AftL84ZYAL9S/f9gxftlHxq+/ltW+gLzUJH
 /BKJdWbDCP7Fv9nY6mPt2vIbL/vvnfXqYz49ON5U0BqaqLB+1L24f3fmO3dk9gsrlpQ4
 b/WA==
X-Gm-Message-State: AOJu0YzTSMLCtc+UwJFpGt05HB5eikxl132apQBXsPryyJOGG/KzIDp2
 3Vq8fVFtZrEnImL1sRbvKWBriQJnY3V2dBBZaOb4oxLflKZUqtiB+zNLrB8WQudax1F3h5ESzlz
 WVbrBqgMwEpckAjjBlHjkmLheCte1opGQABM=
X-Received: by 2002:a17:902:db04:b0:1d4:e575:5224 with SMTP id
 m4-20020a170902db0400b001d4e5755224mr10990064plx.122.1705455735230; 
 Tue, 16 Jan 2024 17:42:15 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1jPDfIfxSujJ1DBTSQT8Ai3C/Sh87nOUchw/grjyjtXnqQZWENGKPkvdXv/aWQzXWbY4CdMQmv25Za4jxnUE=
X-Received: by 2002:a17:902:db04:b0:1d4:e575:5224 with SMTP id
 m4-20020a170902db0400b001d4e5755224mr10990047plx.122.1705455734727; Tue, 16
 Jan 2024 17:42:14 -0800 (PST)
MIME-Version: 1.0
References: <20240116031728.2500892-1-liwang@redhat.com>
 <20240116121235.GA2582913@pevik>
In-Reply-To: <20240116121235.GA2582913@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 17 Jan 2024 09:42:02 +0800
Message-ID: <CAEemH2dOHxT__TjWuDJY7Dq0p8-n7ZdRHD2nU7sw9aawUFqLfg@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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
Cc: Martin Doucha <martin.doucha@suse.com>, jhs@mojatatu.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKYW4gMTYsIDIwMjQgYXQgODoxMuKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgTGksLAo+Cj4gPiBUaGUgY2hhbmdlIGFkZHJlc3NlcyBjb21waWxh
dGlvbiBlcnJvcnMgZW5jb3VudGVyZWQgaW4gdGhlIHRjaW5kZXgwMS5jCj4gPiB0ZXN0IHdoZW4g
Y29tcGlsZWQgYWdhaW5zdCBrZXJuZWwtNi43IGFuZCBhYm92ZS4KPgo+ICJhZ2FpbnN0IGtlcm5l
bC02LjciLiBCdXQgODJiMjU0NWVkOWEgd2lsbCBiZSByZWxlYXNlZCBpbiA2LjgsIHJpZ2h0Pwo+
CgpJdCdzIGFscmVhZHkgY29udGFpbmVkIGluIHRoZSBrZXJuZWwtNi43IHJlbGVhc2UuCgpQYXRj
aCBtZXJnZWQsIHRoYW5rcyEKCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
