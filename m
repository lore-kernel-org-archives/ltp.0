Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D9E9D132C2
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 13:21:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EAD2B3D0AE8
	for <ltp@archiver.kernel.org>; Mon,  4 Nov 2024 14:21:01 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B08783D0718
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:20:46 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=jstancek@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5F20B10002B0
 for <ltp@lists.linux.it>; Mon,  4 Nov 2024 14:20:44 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730726443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SLANeXJgf0AREy3tLGI6mKOhCR72qZHr/3iy1EOh2hk=;
 b=ExQw/SpJtr5FwFLNkrL6STSjoYq0Inujntd9eRRKLNj8CIaQc+c3Nmnp/bt+h/9O2aAE3r
 ubMnl810rImQ933qHtjewF5WCx/6s0cJAr+8krF5CsYrLBB59Fsc7i4NbMy+NoisbpKddv
 aoLihfmKwjBZwSp0Ik2Tb/o32O2eqKo=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-280-0Kv3P4PsOyuw79AhuckHhA-1; Mon, 04 Nov 2024 08:20:41 -0500
X-MC-Unique: 0Kv3P4PsOyuw79AhuckHhA-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-28cc1cea79cso3046399fac.3
 for <ltp@lists.linux.it>; Mon, 04 Nov 2024 05:20:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730726441; x=1731331241;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SLANeXJgf0AREy3tLGI6mKOhCR72qZHr/3iy1EOh2hk=;
 b=N4pDMRkboscqXktxKQAiysWpm7NXIZuBBLtI4GZnrJ1buT6Msj0MmhYp7fD0C1XeWa
 pZ7dew7Sj6AaGbfnTP8GITPL3A5bzMT73Oc4gpXn7KbRHhHKvnAqGv/uNkqSAd57Wb04
 I+HH45K9dj9l+BpQ1jI15NVdWTaSLQpUXwf8uYrN4AuOplBngGCUlVFyD7GmP+QIvsFT
 J5ijgsjFvG7NBT0zyVA7atYU2ZTNy4BIneZnGiT0suXU1AWH3vPzg+ssswrcPQi1Amq2
 Kj2SNEhuAPBSVYKzo7B5/pWs3RFNHJcguXEz81I6WD5eCh79BXK+uhkUdroG3AsP8emN
 y0Tw==
X-Gm-Message-State: AOJu0Yx6nmMGmwerils+8wcHjuMSKaQWXqlJrUcJOjgSt6CwIGTxL5XP
 k9NF4LVCydmBwkhx10/o+6vzJJKkiarJiWprVov3kU21riG3SiH47h71sUE5Kztow0u+VYXVbKb
 3bwwnO6eOKQQS3SaH5hnfBFRPUxCy/he6p35YClBWAYUlJdr6rqpPc/Cxyv7976TJ3Tiqnj0+cD
 9ARq5FMBwI8w0/SElOFFmCDFc=
X-Received: by 2002:a05:6871:8801:b0:277:f9d5:e85 with SMTP id
 586e51a60fabf-294844d625dmr12125053fac.22.1730726441066; 
 Mon, 04 Nov 2024 05:20:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFluKoliswPJOTRKXGIA6rcSsUxKXnI80Jw6CsKgUqEhR3W02PCjPTtDZpVA1hzNc29TY17TlvG0L8uyL1x72o=
X-Received: by 2002:a05:6871:8801:b0:277:f9d5:e85 with SMTP id
 586e51a60fabf-294844d625dmr12125033fac.22.1730726440782; Mon, 04 Nov 2024
 05:20:40 -0800 (PST)
MIME-Version: 1.0
References: <a0c8683d576671c055a4fe5edde45b5232a27660.1730714163.git.jstancek@redhat.com>
 <ZyjIYpYv_o6osllR@yuki.lan>
In-Reply-To: <ZyjIYpYv_o6osllR@yuki.lan>
From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Nov 2024 14:20:12 +0100
Message-ID: <CAASaF6yoHUXrstLA9TGChkrLWTwnF=mVXxSViSEt==p9UqupOQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/sched.h: don't include itself
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

T24gTW9uLCBOb3YgNCwgMjAyNCBhdCAyOjEz4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgo+Cj4gSGkhCj4KPiBBZGRlZCBieToKPgo+IGNvbW1pdCA0NWY2OTE2YmFl
NGNmNDE3ZmQ1YTc1N2VhOGNhNTE2ZDE3ODY1MDc1Cj4gQXV0aG9yOiBXZWkgR2FvIHZpYSBsdHAg
PGx0cEBsaXN0cy5saW51eC5pdD4KPiBEYXRlOiAgIFRodSBBdWcgMzEgMDI6NDc6MjcgMjAyMyAt
MDQwMAo+Cj4gICAgIGNsb25lMzogQWRkIGNsb25lMydzIGNsb25lX2FyZ3MgY2dyb3VwCj4KPiAg
ICAgU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gICAgIFJldmlld2Vk
LWJ5OiBSaWNoYXJkIFBhbGV0aG9ycGUgPHJwYWxldGhvcnBlQHN1c2UuY29tPgo+ICAgICBbcnBh
bGV0aG9ycGU6IHJtIG1heF9ydW50aW1lXQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGFwaS9z
Y2hlZC5oIGIvaW5jbHVkZS9sYXBpL3NjaGVkLmgKPiBpbmRleCAxMDY1NjY1ZDEuLmFjNzY2ZWZj
NSAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xhcGkvc2NoZWQuaAo+ICsrKyBiL2luY2x1ZGUvbGFw
aS9zY2hlZC5oCj4gQEAgLTEzLDYgKzEzLDcgQEAKPiAgI2luY2x1ZGUgPGludHR5cGVzLmg+Cj4g
ICNpbmNsdWRlICJjb25maWcuaCIKPiAgI2luY2x1ZGUgImxhcGkvc3lzY2FsbHMuaCIKPiArI2lu
Y2x1ZGUgImxhcGkvc2NoZWQuaCIKPgo+Cj4gQWxvbmcgd2l0aCBhIGZldyBhZGRpdGlvbnMuIExv
b2tzIGxpa2UgYSBtaXN0YWtlIHRvIG1lIGFzIHdlbGwuIEFuZCBpdCdzCj4gbm8tb3AgZHVlIHRv
IHRoZSBoZWFkZXIgZ3VhcmRzIGVpdGhlciB3YXkuCj4KPiBSZXZpZXdlZC1ieTogQ3lyaWwgSHJ1
YmlzIDxjaHJ1YmlzQHN1c2UuY3o+CgpQdXNoZWQuCgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBj
aHJ1YmlzQHN1c2UuY3oKPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
