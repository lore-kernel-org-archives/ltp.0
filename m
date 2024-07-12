Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAF54C2BD09
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 08:38:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2BBF33D1990
	for <ltp@archiver.kernel.org>; Fri, 12 Jul 2024 10:38:04 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B65593C2220
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:37:49 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6B723618FC9
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 10:37:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720773466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JQt1psJvuzhz9WCwTCYGbYrDV87aaAniQwIZ3mRyHb0=;
 b=DS4FTfcdEY6j2qi8X2RJn5FJfck9TXld5av16FKbOAbboBFW8Pk+AX2cj6scX/CEN6VNBq
 BCL5uDbfGs3au6r1bGi3Q/7tfiJDOc2HwBljyYLmWq7a992Xo6UgLBA/kmrfuHlNWshmkU
 VV/sIvUxhAZuTo9Cge3FvJB1cEV3vZk=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-486-85XiKXxfP0OAIkaxMisV-A-1; Fri, 12 Jul 2024 04:37:39 -0400
X-MC-Unique: 85XiKXxfP0OAIkaxMisV-A-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2c9f8793a71so1773549a91.2
 for <ltp@lists.linux.it>; Fri, 12 Jul 2024 01:37:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720773458; x=1721378258;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JQt1psJvuzhz9WCwTCYGbYrDV87aaAniQwIZ3mRyHb0=;
 b=jecaUM2rMGuG5dvZDDn69GmbCBwVqeH0iONssoOqJGeXne0ecsYPBa6B7FI2Y2Puwx
 0Jq8P4C6FFSheyPxU7ZEG/7+Vrau+yJerpr5JzkYc10PtqqgZxz9fZMoL5egkI3p+yvU
 B3sQy/BV0KlGRQ1zCaVupYUnjHTgUXh8FVQy6m4ZdZbowVbJTC6PvWjropDBgAlGUTeK
 u4HXKny1AxZTlxUIUMVqGMzykj7dus9wNJHbdA2P7IcG2RqLev2jXjhNeEdlXg28LJnq
 oFs84y6YhTSRKXoqNrSQaU5IyfQTeTQpJemfZykuiabRKrZ8GxKeqnMyTwNNh+Gl9jiv
 CaHg==
X-Gm-Message-State: AOJu0YwHAcWVP/ewbUzHEaUwV358WyXYGKh0B6TKMxyI5zAX6pasIVl+
 4YeRyYHJhuZQ7nTA27y0xyZ30pjALBGaw6M1TnRRFhxEGRbK+mxMiUsmDTQq9MdrR6+Pn1IixeZ
 fC7VJ1uam96jLB7SdL6wlcv/+fEVDFJ1HUkVZRmSh+cqa5Ca4M2RSsQqztptlb1vl3ncDDXbwfZ
 X+EEh26L1uJfUBQIlMcNw/OM/sDd1pKl5LUQ==
X-Received: by 2002:a17:90a:c684:b0:2c9:6920:d2c1 with SMTP id
 98e67ed59e1d1-2ca35bdc28emr8920658a91.10.1720773458136; 
 Fri, 12 Jul 2024 01:37:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFhuGyvHJQwjy/MmNCUX0C4yabSIDD9BwnBC6S+yIen1E1zpXRZn3xg+DUHCgtiXLJXDuxfaJ/Q42n198P3ZTg=
X-Received: by 2002:a17:90a:c684:b0:2c9:6920:d2c1 with SMTP id
 98e67ed59e1d1-2ca35bdc28emr8920647a91.10.1720773457654; Fri, 12 Jul 2024
 01:37:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240712081359.116227-1-pvorel@suse.cz>
 <20240712081359.116227-3-pvorel@suse.cz>
In-Reply-To: <20240712081359.116227-3-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 12 Jul 2024 16:37:25 +0800
Message-ID: <CAEemH2ego2+xvOxDm_56cP1g8hRdQ=vo77ZmeVT+UcAhpTd+7Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/2] doc/C API: Add tst_tmpdir.h
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

Rm9yIGJvdGg6ClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCk9uIEZy
aSwgSnVsIDEyLCAyMDI0IGF0IDQ6MTTigK9QTSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4g
d3JvdGU6Cgo+IEhlYWRlciBjcmVhdGVkIGluIHRoZSBwcmV2aW91cyBjb21taXQuCj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiAgZG9jL2RldmVs
b3BlcnMvYXBpX2NfdGVzdHMucnN0IHwgNCArKysrCj4gIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2Vy
dGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9kb2MvZGV2ZWxvcGVycy9hcGlfY190ZXN0cy5yc3QK
PiBiL2RvYy9kZXZlbG9wZXJzL2FwaV9jX3Rlc3RzLnJzdAo+IGluZGV4IDE2NGY4MjUwNDQuLjc0
MTg1YzI5ZWMgMTAwNjQ0Cj4gLS0tIGEvZG9jL2RldmVsb3BlcnMvYXBpX2NfdGVzdHMucnN0Cj4g
KysrIGIvZG9jL2RldmVsb3BlcnMvYXBpX2NfdGVzdHMucnN0Cj4gQEAgLTM3LDMgKzM3LDcgQEAg
Q2FwYWJpbGl0aWVzCj4gIGxpYmx0cHN3YXAKPiAgLS0tLS0tLS0tLQo+ICAuLiBrZXJuZWwtZG9j
OjogLi4vLi4vaW5jbHVkZS9saWJzd2FwLmgKPiArCj4gK1RlbXBvcmFyeSBkaXJlY3RvcnkKPiAr
LS0tLS0tLS0tLS0tLS0tLS0tLQo+ICsuLiBrZXJuZWwtZG9jOjogLi4vLi4vaW5jbHVkZS90c3Rf
dG1wZGlyLmgKPiAtLQo+IDIuNDUuMgo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
