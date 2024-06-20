Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 698B0C27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 06:44:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CA9C93D0E10
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 08:44:11 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5A2323D081B
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 08:43:54 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=canonical.com (client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=po-hsu.lin@canonical.com; receiver=lists.linux.it)
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 89BF720D1BA
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 08:43:52 +0200 (CEST)
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 6BDAA3F1AF
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 06:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20210705; t=1718865832;
 bh=VuZwDHbIRYvdmFlpgVilT+dNYu0pTsFmZEmZoizMPcM=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=GNLPpSa6SPMTYOgSuHt78+dDpqnddmoBHzpQFJsLuAsmzIj47LKYPF72wcKpR7f5s
 SIXY/61zzTngcoRL/1d1uda/bmT97DD4/8hOaYA5+q4KxVeZtSBjc5nsoF1U5vZUfG
 JGZeu1ehKEje3obSspCdPSdgdCrxXPoQI9aP32cc1Tco3nLQP83p72lazZZ0dBJmB1
 KrmocJBHocaot3VOmzmCIVxrxVK23FULjMjJMY0+A7EBSwWzSAJZ/rKcqrTpGzsIuA
 tFPY9TYAZ+06C1dWHJ8SrM9Hze6jrC98xNyvJDZLyOMJT/3qtdItVXHGHi8rVuH1TA
 bEKJG3vHl9wEA==
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a6f571c3eefso8650166b.2
 for <ltp@lists.linux.it>; Wed, 19 Jun 2024 23:43:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718865832; x=1719470632;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VuZwDHbIRYvdmFlpgVilT+dNYu0pTsFmZEmZoizMPcM=;
 b=ktsN9Rx1HXC5vX9L12qO1pKqHuTDufhlFT+yJRmCIkuKHvMSqBzhoHgPfP+DYcmWd9
 rrw5Z1/NVsIn5tI0tzlc6Qlz/D7SZnKmQzIvy5BuNmk3pBKdGJdxA3ypgpmFs/WpLC6+
 3jB1E03mj4+6bkt9j9GG3fJ0DGIPAHA/GWEiVUuYg2etpOq45yWq9MUNZPtMOrLwuO0q
 qrk5BE1llqDEU9Hjgz63VJCF6J3Vlo/e50HxDMvZmP72zuUsyx8UYnfuujaFRgsPvny5
 gryTLAXdomBjClbY0SH1FNfnK3YtNTtmsjAy87IUXcDItbXtTM/5zbt7DXu/G5B4M+8v
 QIKA==
X-Gm-Message-State: AOJu0Ywq/9gxTfTY0QQ3qrWA8H6Mdr4nsPefjBEyD6UvS9EjtmEUud3B
 jkzS09/OYOpmOEJJUKTYZgrfXmErrKeK7TNUdJ0WfBVbRd1jytUQbDXgNucqmMNwB/tdO91CiAA
 1X5TJxO+wnAbITotR0DlM38OAkTPxytcQmRy05lqy7Z8T2f/CXamADxkU5vO0hRL0WVVM9u91cW
 MSWxRMyac70Prvvp4Vj6qU/kxH/JoGFHKi6mtC8RPhVMF8Ds+V
X-Received: by 2002:a17:906:d83:b0:a65:7643:3849 with SMTP id
 a640c23a62f3a-a6fab7d6be4mr249126866b.73.1718865832101; 
 Wed, 19 Jun 2024 23:43:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFV9KGwPCPmZP6b0TlFx3HU5N1Ehmns7sO3wnBkRVT1x/lo2dIcseWInS7b2Q+dvc3hLQTCANUNAQ0ET0QQOnM=
X-Received: by 2002:a17:906:d83:b0:a65:7643:3849 with SMTP id
 a640c23a62f3a-a6fab7d6be4mr249126466b.73.1718865831788; Wed, 19 Jun 2024
 23:43:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240620032737.1421923-1-po-hsu.lin@canonical.com>
 <20240620050900.GB537887@pevik>
In-Reply-To: <20240620050900.GB537887@pevik>
From: Po-Hsu Lin <po-hsu.lin@canonical.com>
Date: Thu, 20 Jun 2024 14:43:34 +0800
Message-ID: <CAMy_GT_CiQCuHQ=EdDy52uVjWb=eWeYugc97f3neOL670WO8WA@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCHv2] logrotate: fix permission issue for test2
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

T24gVGh1LCBKdW4gMjAsIDIwMjQgYXQgMTowOeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgUG8tSHN1LAo+Cj4gPiBXaGVuIHJ1bm5pbmcgdGhpcyBsb2dyb3Rh
dGUgdGVzdCBvbiBVYnVudHUsIHRoaXMgdGVzdCB3aWxsIGZhaWwgd2l0aDoKPiA+ICAgbG9ncm90
YXRlX3Rlc3RzIDIgVElORk86IHNsZWVwIDEgbWluIHRvIHdhaXQgZm9yIHJvdGF0aW5nIGxvZ3MK
PiA+ICAgbG9ncm90YXRlX3Rlc3RzIDIgVEZBSUw6IFsgLWYgL3Zhci9sb2cvdHN0X2xhcmdlbG9n
ZmlsZS4xLmd6IF0gZmFpbGVkCj4gdW5leHBlY3RlZGx5Cj4gPiAgIGxvZ3JvdGF0ZV90ZXN0cyAy
IFRGQUlMOiBGYWlsZWQgdG8gY3JlYXRlIGEgY29tcHJlc3NlZCBmaWxlCj4KPiA+IExvb2sgbW9y
ZSBjbG9zZWx5IHRvIHdoYXQgdGhpcyB0ZXN0IGlzIHRyeWluZyB0byBkbyB3ZSB3aWxsIHNlZSB0
aGVyZQo+ID4gYXJlIHR3byBpc3N1ZXMgaGVyZSBpbiB0aGUgdHN0X2xhcmdlbG9nLmNvbmY6Cj4K
PiA+IDEuICJpbmNsdWRlIC9ldGMvbG9ncm90YXRlLmQiCj4gPiBUaGlzIHdpbGwgcm90YXRlIG90
aGVyIGxvZyBmaWxlcyBkZWZpbmVkIGhlcmUsIHNpbmNlIHdlIGFyZSBqdXN0IHRlc3RpbmcKPiA+
IHRoZSBsb2cgcm90YXRpb24gY2FwYWJpbGl0eSBJIHRoaW5rIHRoZXJlIGlzIG5vIG5lZWQgdG8g
cm90YXRlIGxvZyBmaWxlcwo+ID4gb3RoZXIgdGhhbiB0aGUgdGVzdGZpbGUgaXRzZWxmLgo+Cj4g
QlRXIChmb3IgbmV4dCB0aW1lKTogSSB3b3VsZCBoYXZlIHNlcGFyYXRlZCB0aGVzZSAyIGNoYW5n
ZXMgaW50byAyIGNvbW1pdHMuCj4KPiBPSyBubyBwcm9ibGVtLAp0aGFuayB5b3UuClBvLUhzdQoK
Cgo+IEtpbmQgcmVnYXJkcywKPiBQZXRyCj4KPiA+IDIuIFBlcm1pc3Npb24gaXNzdWUKPiA+IFRy
eWluZyB0byByb3RhdGUgdGhlIHRhcmdldCBmaWxlIG9uIFVidW50dSB3aWxsIGNhdXNlIHRoZSBm
b2xsb3dpbmcKPiBlcnJvcjoKPiA+ICAgZXJyb3I6IHNraXBwaW5nICIvdmFyL2xvZy90c3RfbGFy
Z2Vsb2dmaWxlIiBiZWNhdXNlIHBhcmVudCBkaXJlY3RvcnkKPiBoYXMKPiA+ICAgICAgICAgIGlu
c2VjdXJlIHBlcm1pc3Npb25zIChJdCdzIHdvcmxkIHdyaXRhYmxlIG9yIHdyaXRhYmxlIGJ5IGdy
b3VwCj4gd2hpY2gKPiA+ICAgICAgICAgIGlzIG5vdCAicm9vdCIpIFNldCAic3UiIGRpcmVjdGl2
ZSBpbiBjb25maWcgZmlsZSB0byB0ZWxsCj4gbG9ncm90YXRlCj4gPiAgICAgICAgICB3aGljaCB1
c2VyL2dyb3VwIHNob3VsZCBiZSB1c2VkIGZvciByb3RhdGlvbi4KPgo+Cj4KCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
