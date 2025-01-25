Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D3EAC02181
	for <ltp@archiver.kernel.org>; Sat, 25 Jan 2025 02:43:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE8A23C092F
	for <ltp@archiver.kernel.org>; Sat, 25 Jan 2025 03:43:47 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1CD233C06E9
 for <ltp@lists.linux.it>; Sat, 25 Jan 2025 03:43:30 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93A92632803
 for <ltp@lists.linux.it>; Sat, 25 Jan 2025 03:43:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737773007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=J9v6ICz4p1ldLC665n/GpOzpU5Fsq9BGv3l6rHbUDcQ=;
 b=b/45nWA2Nd+kUkkXnvM5l/1yskNigoHvrilU0CDzYFhxVK5YXvp/GTl0Mr3Tz6dNBEr3gs
 OpIqcbco4G8G/W7x6Tcw9ZbnqC0S3LpcfSQXgJpQ5TJA2AsADKNDN+6kQbAUVx4Wz4PXXC
 tsUTI8O60YnTKUce4SXvEE+Fo/ZugCg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-VAMGYE6eP6e_Cn0s-oeCPQ-1; Fri, 24 Jan 2025 21:43:24 -0500
X-MC-Unique: VAMGYE6eP6e_Cn0s-oeCPQ-1
X-Mimecast-MFC-AGG-ID: VAMGYE6eP6e_Cn0s-oeCPQ
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2ee9f66cb12so5560747a91.1
 for <ltp@lists.linux.it>; Fri, 24 Jan 2025 18:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737773003; x=1738377803;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=J9v6ICz4p1ldLC665n/GpOzpU5Fsq9BGv3l6rHbUDcQ=;
 b=WzDOLwEQY9BYCvGWDCI5+kJNk18SLbnL1MY9bRNIdURKAEdQyn1QuPhhgT2ZK5+zmr
 YGdoujHhjJlY5nhJLcfT+MU2d1NKn3fezVYQ7lg0JEeCUH+bG6Z0SqaJuru88olCw+WT
 vGEl2uKNCuynDQJSEe9MXG9jAWGxx0KcJ/nSCG9re4px2hsh/y9khc2JvKk9czU6vbFR
 G5oazsqX6iW08+5nFafFipQN8S/W+ZI0XTz3QXhifZo0xzCObs1DnawGaw2r+/IsRSZt
 oIbIy1jza9kDxgkeroFG1M9okge1LKA940J26oiAQ9+XlQ94lGvMWIPXB35mXJ+Ozwwo
 Kauw==
X-Gm-Message-State: AOJu0YxXq5JdY8OqhBQbldQ+JJsMjUyfTfetJN9VhX9KZa5FAAhEEnj3
 JdlM10UAp3OsPQvIuWypflvoz7QxRxYPy2jACaW0UpDLvmdaTlPIkC9yIhNhJihslOkIsQG2FLm
 +t1pXaq8cK3+LiZA0zizjN2fIzx2q5vhKcN2L7nnwqXJiuKmt3ISX2Kca31GcoXbvPLSRHm+Yrh
 B4Y5Yl85/KoQPQpBaQULXTcaw=
X-Gm-Gg: ASbGncsygYIgY/YaOCrKMVeQTELRe7UQLmx+Y9YDBqs0OrcyjkIJ2ErB5yFoZbL8g+H
 bIF6MoHTrLwLtWsUxvNM3YQX7ZVPjFaCDDceeK8CPJXMfcJRgw48NnNj/Qv8I1/0=
X-Received: by 2002:a17:90b:3a0c:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2f782c70168mr46119851a91.8.1737773003595; 
 Fri, 24 Jan 2025 18:43:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEm73jayuZCYBkCyGvIK/64SZ7JfsDDEvZfvNnVS1H2rTXytnxAo+QWk12V1MSVSggmdlXW3/id+3wA16PZ9r0=
X-Received: by 2002:a17:90b:3a0c:b0:2ee:e113:815d with SMTP id
 98e67ed59e1d1-2f782c70168mr46119829a91.8.1737773003217; Fri, 24 Jan 2025
 18:43:23 -0800 (PST)
MIME-Version: 1.0
References: <20250118102615.127485-1-liwang@redhat.com>
 <Z5N3XdwnqOthwIps@yuki.lan>
In-Reply-To: <Z5N3XdwnqOthwIps@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Sat, 25 Jan 2025 10:43:11 +0800
X-Gm-Features: AWEUYZkojyHJ3GsFspldlSZ0MxlkVrlbLxwSnxwizgqAW4sNBulpMvWgBcKy2JI
Message-ID: <CAEemH2dt4SoupdQ4f+OShMss6Ukau=DeeF8jtve_PFKqAz+ggg@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9wbOeRJiVKbgUxji518W80lr8EkmidrEvJfHyzkqn2s_1737773003
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: switch cgroup bit-fields from signed to
 unsigned int
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

T24gRnJpLCBKYW4gMjQsIDIwMjUgYXQgNzoyMOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBUaGVyZSBpcyBhIHByb2JsZW0gaW4gY2dyb3VwIGxp
YiB0aGF0IHRoZSBkZWNsZWFyYXRpb24gaW50Cj4gPiBjYW4gbGVhZCB0byAtMSBkdXJpbmcgdGhl
IHwgb3BlcmF0aW9uLgo+ID4KPiA+IEJlY2FzdWUgaWYgdGhlIGZpZWxkIGNvbnRhaW5zIHVuaW5p
dGlhbGl6ZWQgZ2FyYmFnZSBkYXRhLAo+ID4gYSBiaXQtZmllbGQgZGVjbGFyZWQgYXMgaW50IGNv
dWxkIGludGVycHJldCAwYjEgYXMgLTEgZHVlCj4gPiB0byBzaWduZWQgYXJpdGhtZXRpYy4KPgo+
IFVmZiwgc28gd2UgaGF2ZSBhIG51bWJlciB0aGF0IGNhbiBiZSBlaXRoZXIgLTEgb3IgMC4gV2hl
cmUgZGlkIGl0IGJyZWFrPwo+CgpJdCBkb2Vzbid0IGJyZWFrIGFueXRoaW5nIHNvIGZhciwgSSBm
b3VuZCB0aGF0IGlzc3VlIHdoaWxlIHJldmlld2luZwpHdW9qaWUncyBwYXRjaC12Miwgd2hlbiB0
aGF0IG1lbW9yeV9yZWN1cnNpdmVwcm90IGRlY2xhcmVkIGFzIGludCwKdGhlIHRlc3QgcmVzdWx0
IGlzIGFsd2F5cyB3cm9uZy4KCkhvd2V2ZXIsIHRoZSByb290LT5uc2RlbGVnYXRlIGF2b2lkcyB0
aGlzIHByb2JsZW0gYnkgbmVnYXRpbmcgdmFsdWUgdHdpY2U6CgpzdGF0aWMgaW50IGNncm91cF92
Ml9uc2RlbGVnYXRlKHZvaWQpCnsKICAgIHJldHVybiAhIXJvb3RzWzBdLm5zZGVsZWdhdGU7Cn0K
CkJ1dCBJIHRoaW5rIHdlIHNob3VsZCBmaXggdGhpcyBmcm9tIHRoZSByb290LgoKCgo+IEkgc3Vw
cG9zZSB0aGF0IHRoaW5ncyBhcmUgb2theSBhcyBsb25nIGFzIHdlIGRvIGlmIChzLT5iYXIgfCBz
LT5iYXIpLgo+Cj4KPiBBbnl3YXlzOgo+Cj4gUmV2aWV3ZWQtYnk6IEN5cmlsIEhydWJpcyA8Y2hy
dWJpc0BzdXNlLmN6Pgo+Cj4gLS0KPiBDeXJpbCBIcnViaXMKPiBjaHJ1YmlzQHN1c2UuY3oKPgo+
CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xp
c3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
