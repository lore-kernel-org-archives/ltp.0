Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CA88C48BF6
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 04:09:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 346A03D1CD6
	for <ltp@archiver.kernel.org>; Thu,  7 Mar 2024 05:09:33 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0E79F3CEC25
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 05:09:15 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C8F91601B2F
 for <ltp@lists.linux.it>; Thu,  7 Mar 2024 05:09:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709784552;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JJ6Cx9BUS1FBffH4GaR4URD90qjhXWh+fi93pRqM3xk=;
 b=gReISqbloIRnt4fG/9+loP9rV32Hii3FYaKrD1/d/MfnOBZFl3ZIG5wW61neYGXL0iB2yN
 noGEBoGhlax3ccFHgFoFYxyRamSHSKgw2iIH3dlnafgfmlwrlcKQxaxW5lIahREVoJnFlY
 M49Sqs31gzVE4Lr5ej6MfDQUBgfzM0A=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-C6QiZSnVN-WC7aMvqr4diw-1; Wed, 06 Mar 2024 23:09:09 -0500
X-MC-Unique: C6QiZSnVN-WC7aMvqr4diw-1
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-29ab1ccc257so319200a91.2
 for <ltp@lists.linux.it>; Wed, 06 Mar 2024 20:09:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709784548; x=1710389348;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JJ6Cx9BUS1FBffH4GaR4URD90qjhXWh+fi93pRqM3xk=;
 b=FbFsvk+Go09zx0yMMR1IYlxNEfsU9bQhaM4JPuFgtvzcEeOvCKRP4jEKwMNYPisz0C
 bJfY+UD+9y3qDLCXqvvQAzDovUDn+jUPjxs28DKBtamGGngGlyY4/ox2pYxaLOQ92l96
 ZWqVr7spKy0CihgUBZJByAVQbKTw4m8u0UkKroqTGUg+kYTRm1om1VQKpE9xik1qzZtR
 tOYRMxJTs5o1eBBSEf/FfB5ocborvHobePbW2wpqnT2pxD7OIyeXCY6zBaNsYTn4Tq0Z
 SWrCVsUwY1zksTM5tVXoR9Siza5DWpDNGRiAX6lWUVvuFNHMRB+5cpLsih1pTIT8acrB
 WMkw==
X-Gm-Message-State: AOJu0YwvWtSLatTa0nfPuxOrXv58Spiygu61Jg9hkMHNJbHgQuH7TaX+
 BmP+OLidg1ejtwXbBRJ8zzSDauAH67ExyYuJmhsAouh2GF5HOQtpLorWAsBQSSeCEBGV9DSGVW+
 BHiBjbyi2j6E1BmSsYoY7G9/Hn0JgOVpaETH+5dZoPIcMG9BBIQW8ODKaDAgRgmMdPKDPKIYAlo
 5kCggNk29a9jHI+QJ+KYw9xIM=
X-Received: by 2002:a17:90a:f317:b0:29a:ca64:b8d with SMTP id
 ca23-20020a17090af31700b0029aca640b8dmr14315420pjb.31.1709784548100; 
 Wed, 06 Mar 2024 20:09:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGr0/cLTrpmmbm1Mh+rOpV6CHPZfMMQewTbCnvGWUpPEoZ2bA2c2vq/bqh9rxgo7a0tMYsDvJxnl1NcVq9m5Zg=
X-Received: by 2002:a17:90a:f317:b0:29a:ca64:b8d with SMTP id
 ca23-20020a17090af31700b0029aca640b8dmr14315403pjb.31.1709784547729; Wed, 06
 Mar 2024 20:09:07 -0800 (PST)
MIME-Version: 1.0
References: <20240306085254.534940-1-dbrendel@redhat.com>
 <CAEemH2fi7pQUX2WVWqz1-px5reA3mcGjAHm=A3j3xnOVqF9vDg@mail.gmail.com>
 <20240306104110.GC558578@pevik>
 <4d7c9726-d74f-41da-982c-91abca628649@redhat.com>
 <20240306124436.GA746976@pevik>
In-Reply-To: <20240306124436.GA746976@pevik>
From: Li Wang <liwang@redhat.com>
Date: Thu, 7 Mar 2024 12:08:55 +0800
Message-ID: <CAEemH2cjM_C5WNM6mDeeUL7+ftugOJQXKHP2ByTQoW9OYDXi0w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>, Dennis Brendel <dbrendel@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] munlockall: add test case that verifies memory
 has been unlocked
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

SGkgUGV0ciBhbmQgRGVubmlzLAoKQXMgdGhpcyBpcyB0aGUgZmlyc3QgcGF0Y2ggRGVubmlzKHRo
YW5rcyEhKSB3cml0ZXMgZG93biBmb3IgTFRQLgoKSSB3b3VsZCBzdWdnZXN0IHNlbmRpbmcgYSBw
YXRjaCBWNCAoaW5jbHVkaW5nIFNCVCwgQ3lyaWwncyBuZXcgcmV2aWV3cykKdG8gbWFrZSB5b3Ug
ZmFtaWxpYXIgd2l0aCB0aGUgd29ya2Zsb3cgb2YgdGhlIGNvbW11bml0eTopLgoKCk9uIFdlZCwg
TWFyIDYsIDIwMjQgYXQgODo0NOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90
ZToKPgo+IEhpIERlbm5pcywKPgo+ID4gSGkgUGV0ciBhbmQgTGksCj4KPiA+IFRoYW5rIHlvdSB2
ZXJ5IG11Y2ggZm9yIHlvdXIgdmFsdWFibGUgZmVlZGJhY2shCj4KPiA+IFdoYXQncyBsZWZ0IHRv
IGRvIGZvciBtZT8gUmUtc3VibWl0IGFzIHY0IHdpdGggc2lnbi1vZmYgYW5kCj4gPiBwcm9wZXIg
Y29tbWl0IG1lc3NhZ2U/Cj4KPiB2MyBpcyByZWFkeSB0byBiZSBtZXJnZWQsIEknbGwgYWRkIHlv
dXIgU0JUIGFuZCBjbGVhbnVwIHRoZSBjb21taXQgbWVzc2FnZSwKPiB3aGlsZSBJJ2xsIGJlIGFk
ZGluZyBteSBhbmQgTGkncyBSQlQuCj4KPiBJJ20ganVzdCB3YWl0aW5nIGEgbGl0dGxlIGJpdCBi
ZWNhdXNlIEN5cmlsIGxvb2tlZCBpbnRvIHRoaXMgcGF0Y2hzZXQsCj4gaGUgbWlnaHQgaGF2ZSBs
b29rIChJIG1lcmdlIHRvbmlnaHQpLgo+Cj4gS2luZCByZWdhcmRzLAo+IFBldHIKPgo+ID4gVGhh
bmtzLAo+ID4gRGVubmlzCj4KPiA+IE9uIDMvNi8yNCAxMTo0MSwgUGV0ciBWb3JlbCB3cm90ZToK
PiA+ID4gSGkgRGVubmlzLCBMaSwKPgo+ID4gPj4gSGkgRGVubmlzLAo+Cj4gPiA+PiBHb29kIHRv
IHNlZSB5b3VyIHBhdGNoIHNvb24sIG5pY2Ugd29yayEKPgo+ID4gPj4gTmV4dCB0aW1lIHJlbWVt
YmVyIHRvIGNvbW1pdCB0aGUgcGF0Y2ggd2l0aCBTaWduZWQtb2ZmLWJ5Lgo+ID4gPj4gICBgZ2l0
IGNvbW1pdCAtc20gIHh4eHhgCj4KPiA+ID4gKzEgKHBsYW5uaW5nIHRvIGFkZCB0aGF0IGJlZm9y
ZSBtZXJnZSkuCj4KPiA+ID4gQWxzbyB0aGVzZSBjb21tZW50cyAiQ2hhbmdlcyBjb21wYXJlZCB0
byB2MjoiIHNob3VsZCBiZSBiZWxvdyAiLS0tIiwKPiA+ID4gdGhhdCB3YXkgd2UgY2FuIHJlYWQg
dGhlbSBidXQgdGhleSB3aWxsIG5vdCBlbmR1cCBpbiB0aGUgZ2l0IGNvbW1pdCBtZXNzYWdlIHdo
ZW4KPiA+ID4gd2UgYXBwbHkgdGhlIHBhdGNoLgo+Cj4gPiA+IEtpbmQgcmVnYXJkcywKPiA+ID4g
UGV0cgo+Cj4KPgo+Cj4KPgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
