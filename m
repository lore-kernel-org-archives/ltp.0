Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CEAFC27C53
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 10:20:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 79BE53D0DC7
	for <ltp@archiver.kernel.org>; Wed, 19 Jun 2024 12:20:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D664D3D0B3E
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 12:20:24 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 81FB21015453
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 12:20:23 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718792421;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/sJlGqLQQodCbJFnF9L8V557bMeyDGO6okE176iLe0E=;
 b=gDzpIQPs9Zu8vNjV5lbKqME0AWlUXQvnljjwaA+ZV+1fsxUfY6hd2K4DMezno7boqhX3mp
 WjAGx2oiZztpalJQpHCBTLeWZuw4N1/dbQytHwc6dMFVlAyHdKGQapUHyCkj+nfYBKOWUf
 0Fy/7rDHWdNxT2Zo0JQOMTZYizeYPwQ=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-436-V6aEcQRlN7WYJ9IxQbUs2w-1; Wed, 19 Jun 2024 06:20:19 -0400
X-MC-Unique: V6aEcQRlN7WYJ9IxQbUs2w-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2c7a8fa8013so1230194a91.2
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 03:20:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718792419; x=1719397219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/sJlGqLQQodCbJFnF9L8V557bMeyDGO6okE176iLe0E=;
 b=A+g7qjqOinU5uNnPu2ngMcS7kTyaLPAwN7MEcE6vS3AwnvBEV5EnJE94OKihsbzz+X
 /fmtE0b+y8goriWEISz6UDWUT0roc9HoSv92xBtd9gI3PCAX9f2IdduweZpWLS+HKiDN
 NZJ8AiZ6QMi7BeaAa5vYBPPn8kwvjgBvyfA9GzfvhDgffzK7L1oIN8ePP/3n3VWlV9/f
 MO7mu2d14vAP9nYvU93PuPfEZYLeT81JKdP5JL6XTEBaxD7UTZp0l8cCTJhuUwq9VqP/
 /+I5TeqTfPjha1p6Tbc2z33bDUF7CrrBMphzKebJ59D+F15g+zIYXQzPW2eyyNGKXete
 B2hA==
X-Gm-Message-State: AOJu0Yz//CWQduTHImb6oEG2Emgg4EFbrKj0i2SI5oCb0CrdI1lJabgZ
 N6BjXL2NIfjcPLoIUZd2IoJoeBVkEY2mR7wLZCF6rnDAonLrW8Hj1Vyw0Lt9cszIvCtMNwfqBVr
 TC9Jz9a5In4emK5qx6s3npvYXKNwKk9cj9K7o1Wp17/fmUiNNed4/yH3hjZByxyVEzZlQhO1iJT
 TYsGhl7teFDNUA7rYnnIw0znc=
X-Received: by 2002:a17:90a:8c16:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2c7b5c8ff3fmr2280752a91.18.1718792418937; 
 Wed, 19 Jun 2024 03:20:18 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsxEl2TAq6ZITRGtlmsv85zsJM9tQJsAaaHzPexKvMM5eLrHNtQO01Fab1CBonDmgXiI7kTWCTw6WtL86TqP0=
X-Received: by 2002:a17:90a:8c16:b0:2c2:df58:bb8c with SMTP id
 98e67ed59e1d1-2c7b5c8ff3fmr2280737a91.18.1718792418570; Wed, 19 Jun 2024
 03:20:18 -0700 (PDT)
MIME-Version: 1.0
References: <20240619073345.326108-1-liwang@redhat.com>
 <20240619074703.GA410266@pevik>
In-Reply-To: <20240619074703.GA410266@pevik>
From: Li Wang <liwang@redhat.com>
Date: Wed, 19 Jun 2024 18:20:06 +0800
Message-ID: <CAEemH2d3gVj+cSvVc6-Qvj4CxhBO4pVnqfouYBg03myH+S87mw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] tst_kconfig: Avoid buffer overflow when parsing
 /proc/cmdline
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

T24gV2VkLCBKdW4gMTksIDIwMjQgYXQgMzo0N+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gPiBXaGVuIHRoZSB0ZXN0IGlzIHJ1biB3aXRoIGEga2VybmVsIGJvb3Rp
bmcgd2l0aCBtYW55IHBhcmFtZXRlcnMsIHRoZQo+ID4gYnVmZmVyIHNpemUgaXMgb2Z0ZW4gbm90
IGxhcmdlIGVub3VnaCB0byBzdG9yZSB0aGUgY29tcGxldGUgY29tbWFuZAo+ID4gbGluZS4gVGhp
cyByZXN1bHRzIGluIGEgYnVmZmVyIG92ZXJmbG93IGFuZCB0aGUgdGVzdCBjb21wbGFpbnMgd2l0
aAo+ID4gdGhlIGZvbGxvd2luZyBtZXNzYWdlOgo+Cj4gPiAgIHRzdF9rY29uZmlnLmM6NjA5OiBU
V0FSTjogQnVmZmVyIG92ZXJmbG93ZWQgd2hpbGUgcGFyc2luZyAvcHJvYy9jbWRsaW5lCj4KPiBU
aGFua3MgZm9yIHRoZSBmaXghCj4KPiBSZXZpZXdlZC1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1
c2UuY3o+Cj4gRml4ZXM6IDE4MDgzNDk4MiAoImtjb25maWc6IGFkZCBmdW50aW9uIHRvIHBhcnNl
IC9wcm9jL2NtZGxpbmUiKQo+Cj4gTk9URSB0c3Rfa2NvbmZpZ19yZWFkKCkgaGFzIGNoYXIgbGlu
ZVsxMjhdLCBhbHNvIHN0cnVjdCB0c3Rfa2NtZGxpbmVfdmFyCj4gbWVtYmVyCj4KClR5cGljYWxs
eSAxMjggaXMgbG9uZyBlbm91Z2ggZm9yIExpbnV4IGtlcm5lbCBwYXJhbWV0ZXJzLCBvdGhlcndp
c2UgaXQgaGFyZApmb3IgcGVvcGxlIHRvIG1lbW9yaXplIHRoZSBuYW1lIGFuZCB2YWx1ZS4KCgoK
PiBoYXMgdGhpcyBsZW5ndGguIFRoZSBsb25nZXN0IGxpbmUgb24gc29tZSBvbiBteSBzeXN0ZW1z
IGlzIDEwOSwgaXQncyBzdGlsbAo+IE9LLAo+IGhvcGVmdWxseSBpdCBzdGF5cyA6KS4KPgoKSG1t
LCBnb29kIHBvaW50LiBBZnRlciB0aGlua2luZyBpdCBvdmVyLCBzZWVtcyB0b28gaGFzdHkgdG8g
ZW5sYXJnZSB0aGUKYnVmW10gc2l6ZSB0byA1MTIuCgpXZSdkIGJldHRlciBrZWVwIHRoZSBzaXpl
IHNhbWUgYmV0d2VlbiAndHN0X2tjbWRsaW5lX3Zhci52YWx1ZScgdG8gdGhlCmxvY2FsICdidWZb
XScuCkFuZCB0aGUgb3ZlcmZsb3cgaXMgbm90IGEgcHJvYmxlbSwgaXQganVzdCBkcm9wcyBzb21l
IHVudXNlZCBpbmZvWzFdIHRvCnJlbG9vcCB0bwp0aGUgaGVhZCBmb3Igc2F2aW5nIG91ciB0YXJn
ZXQgcGFyYW1ldGVyLgoKWzFdIEJPT1RfSU1BR0U9KGhkMCxncHQyKS9vc3RyZWUvY2VudG9zLWRk
NzQxNWVkMmM3Y2MzZjY1YmRjNGJmOGY5YTYzYjk1YmJiMTNlZTBmZWU2MzNmNmI5MmE4NzI5NDRk
MWQ2ZTQvdm1saW51ei01LjE0LjAtNHh4LjR4eC40NDk1XzEzMzY1ODM5NDQuZWw5aXYueDg2XzY0
CgpJJ20gdGhpbmtpbmcgb2YgbG93ZXJpbmcgdGhlIHByaW9yaXR5IGluZm8gZnJvbSBUV0FSTiB0
byBUSU5GTyBpbiB0aGF0IGxpbmU6CiAgICB0c3RfcmVzKFRXQVJOLCAiQnVmZmVyIG92ZXJmbG93
ZWQgd2hpbGUgcGFyc2luZyAvcHJvYy9jbWRsaW5lIik7CgpJIHdpbGwgc2VuZCBhIHBhdGNoIFYy
IG9uY2UgZ2V0IGEgYmV0dGVyIHNvbHV0aW9uLgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
