Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2232C4725D
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 06:57:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9840D3CE2D2
	for <ltp@archiver.kernel.org>; Fri, 19 Jan 2024 07:57:55 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1D2F3CB5A2
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 07:57:41 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 071ED60156F
 for <ltp@lists.linux.it>; Fri, 19 Jan 2024 07:57:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1705647459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oH1hF6T+lnsxmpt5sm2lbIj7lJAQnTbZF82P/JVPaYw=;
 b=CBWqBxNh67NIO0nXFxFWLfCoenmkTAdHvS09Kneo9Lm6YY8yIcxUKI13P6o1HahwWCM14Q
 OPwC+7wB2fWQI6dGSrl6XtdHkf/zsHoOg34me4RWOR5ibe4eaD5WEPuHnjEvLpN2xsak60
 z0EG38fCErNLZg7mQQPbtp0DT4/gCcM=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-_ORFSvnzM4Ow6l4TXwALUQ-1; Fri, 19 Jan 2024 01:57:36 -0500
X-MC-Unique: _ORFSvnzM4Ow6l4TXwALUQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-28e7186f23aso406324a91.0
 for <ltp@lists.linux.it>; Thu, 18 Jan 2024 22:57:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705647455; x=1706252255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oH1hF6T+lnsxmpt5sm2lbIj7lJAQnTbZF82P/JVPaYw=;
 b=oGyeiNhu18niJ8SHWGJS20MMqxD4rnjhyBF0V+HOMGGIJ8EKsGd1Y/f8D7+Qz/3EXq
 QDyWIl4a0YxyOypB2d4FNwiffxtAjQGc2q8UgcIGQxTyN73PiYSx2bdBruO/aoUSU9uo
 P7lW8NIc4qAPrfA0tzfWrPLvaSapxb/8JK2KMMH/DZC2DWywLRkZLGvHwM358DiiGLTB
 hJo6DcS8Y87QDJkKpXSA9IGWazOvlS90ym8tZK3Js8DvL6/oRBMjXjaRA5Fgx1ZIIvME
 DIZA/fZPcaJmKEVyiJdFT/aE7IpAw/hml3wNaqhMPwLrUwZwkytoQGgzMVBZIQHXIG7j
 16Xg==
X-Gm-Message-State: AOJu0YyACifgrwTo8HPm3xlTUD0UMn43CT40CKYhKy/0MQGqUdQ5NScT
 Q7+XmICWkuKxFcJApQU83Axoe6NXwZ/ibPgxHn659+0is9no1KtUxndJfO8oWVI6LiuPEDCnDPp
 4XtnEooEBserviNjYL4yolL1kA0pv7uiwNl8iqvuSTQtBuxyAfRSO3EqlRqiO/lDQo90e2PzQOp
 hJPvqQdXd1psaemm6Q8GE3qBg=
X-Received: by 2002:a17:90b:f0f:b0:28b:d8ed:7fc5 with SMTP id
 br15-20020a17090b0f0f00b0028bd8ed7fc5mr1491493pjb.89.1705647455730; 
 Thu, 18 Jan 2024 22:57:35 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGoEIsI3GBtANf6ebJm0285LJBo+66ScNSXmztjzU4fi1b1CMA4WrW3RZUSh7yOKb/z9RJX8TSQirhodDJBbAY=
X-Received: by 2002:a17:90b:f0f:b0:28b:d8ed:7fc5 with SMTP id
 br15-20020a17090b0f0f00b0028bd8ed7fc5mr1491487pjb.89.1705647455374; Thu, 18
 Jan 2024 22:57:35 -0800 (PST)
MIME-Version: 1.0
References: <20240118191353.2815915-1-pvorel@suse.cz>
In-Reply-To: <20240118191353.2815915-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 19 Jan 2024 14:57:23 +0800
Message-ID: <CAEemH2dHt5nFGo8zBfEsjvScLcPY9=a6xi4GLmBxRSS-mFVb9Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [RFC PATCH 1/1] readahead01: Pass also on memfd secret
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
Cc: Dominique Leuenberger <dimstar@opensuse.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUGV0ciwgQWxsLAoKSSdtIG5vdCBzdXJlIGJ1dCBvbmUgcG9pbnQgSSBndWVzcyB0aGF0IHNo
b3VsZCBiZSBzaW1pbGFyIHRvICdUU1RfRkRfTUVNRkQnCnNpbmNlIHRoZSBmaWxlIGlzIFJBTS1i
YXNlZCBzbyByZWFkYWhlYWQoKSBpcyBub3QgbmVlZGVkLgoKWW91ciBwYXRjaCBsb29rcyBnb29k
LCBob3dldmVyLCBJIHdhcyB1bmFibGUgdG8gZ2V0IHRoZSBjbHVlIGluIGtlcm5lbCBjb2RlCnRv
IHByb3ZlIHRoYXQuCgoKT24gRnJpLCBKYW4gMTksIDIwMjQgYXQgMzoxNOKAr0FNIFBldHIgVm9y
ZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSXQgZml4ZXMgZmFpbHVyZSBvbiA2LjYga2Vy
bmVsczoKPgo+IFRGQUlMOiByZWFkYWhlYWQoKSBvbiBtZW1mZCBzZWNyZXQgc3VjY2VlZGVkCj4K
PiBGaXhlczogZWNmODFkNzI5ICgic3lzY2FsbHM6IHJlYWRhaGVhZDAxOiBNYWtlIHVzZSBvZiB0
c3RfZmQiKQo+IFJlcG9ydGVkLWJ5OiBEb21pbmlxdWUgTGV1ZW5iZXJnZXIgPGRpbXN0YXJAb3Bl
bnN1c2Uub3JnPgo+IFNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+
IC0tLQo+IEhpLAo+Cj4gSSB3b25kZXIgaWYgdGhpcyBpcyBhIGJ1ZyBvciBqdXN0IGNoYW5nZWQg
ZnVuY3Rpb25hbGl0eS4KPgo+IEkgYWxzbyB0ZXN0ZWQgb24gNS4xNCBTTEVTIGFuZCA1LjEwIERl
YmlhbiBhbmQgYm90aCBUQ09ORiBkdWUgRU5PU1lTOgo+Cj4gdHN0X2ZkLmM6MjYwOiBUQ09ORjog
U2tpcHBpbmcgbWVtZmQgc2VjcmV0OiBFTk9TWVMgKDM4KQo+Cj4gS2luZCByZWdhcmRzLAo+IFBl
dHIKPgo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMS5j
IHwgMSArCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+Cj4gZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAxLmMKPiBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcmVhZGFoZWFkL3JlYWRhaGVhZDAxLmMKPiBpbmRleCBl
ODZhNzNlM2UuLmExZjMxMzYwNSAxMDA2NDQKPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL3JlYWRhaGVhZC9yZWFkYWhlYWQwMS5jCj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNj
YWxscy9yZWFkYWhlYWQvcmVhZGFoZWFkMDEuYwo+IEBAIC01MSw2ICs1MSw3IEBAIHN0YXRpYyB2
b2lkIHRlc3RfaW52YWxpZF9mZChzdHJ1Y3QgdHN0X2ZkICpmZCkKPiAgICAgICAgIC8qIFRoZXNl
IHN1Y2NlZWQgKi8KPiAgICAgICAgIGNhc2UgVFNUX0ZEX0ZJTEU6Cj4gICAgICAgICBjYXNlIFRT
VF9GRF9NRU1GRDoKPiArICAgICAgIGNhc2UgVFNUX0ZEX01FTUZEX1NFQ1JFVDoKPiAgICAgICAg
IGNhc2UgVFNUX0ZEX1BST0NfTUFQUzoKPiAgICAgICAgICAgICAgICAgcmV0dXJuOwo+ICAgICAg
ICAgZGVmYXVsdDoKPiAtLQo+IDIuNDMuMAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
