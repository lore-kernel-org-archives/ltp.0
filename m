Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 205C2EC144C
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 14:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772546606; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=V8WWpiRDAnkgmILImeOVYFmFJnUkbvm4Y0DnXTVJ5go=;
 b=YLXNd9NjA3kM9qcg+6qcqkbyuA3mFQgQQSCZ5DVSDBti8eiKPl4KEQ8IIb0UejFg49Adj
 FO7US48WXjJ5nsRWHkYMYU/DML9b05van54keiksZoyEoPC0aM3FT3vAz2Vx7Ne1rMLBbK5
 IXBDk7pPzhNFNC+frF8nts5CmqBAZnI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC2D43DAC04
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 15:03:26 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B7F003D900A
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 15:03:04 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F2007600843
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 15:03:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772546582;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vjh49QQVB1kHyKZ9qEPY/y0AMqpK20W9kFpFNNmbIQI=;
 b=NLPyjLSsKzj9hs3hhPncRiYoOFonTpQhDGVWsHbXPnS9Wa8OVX2r7DyyhzQnCxNJB4g1w1
 N3ASnRbHq8Y5TzeFBGO/jRP2EE9DAI7NjkFt+hw5Vgm+K+LtB5jeFHtWpmfmL7m63qFKlT
 T9Bs1WbyZhWYFRziN97kvFLMskiVsIk=
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-216-7XCabFM_PdODvk2YgX1uHw-1; Tue, 03 Mar 2026 09:03:00 -0500
X-MC-Unique: 7XCabFM_PdODvk2YgX1uHw-1
X-Mimecast-MFC-AGG-ID: 7XCabFM_PdODvk2YgX1uHw_1772546580
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2be21146933so1295286eec.1
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 06:03:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772546579; x=1773151379;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vjh49QQVB1kHyKZ9qEPY/y0AMqpK20W9kFpFNNmbIQI=;
 b=taPwtkjOCQi17u4oAGiR9EsV2wnyJ5sNPm3hl/c5gOqSsDVUHAuXFMhTu9rNFE2/ih
 hsHNU+VniqgdE9qU8ILi7IERAIR6xVCyLZTGozkwD1lUW7uN/Iif/s3f3P7e/W5VLxGU
 jWJiGQ63tRTFgfu+O0nonmfSM5CRAGYlxH0xEXaowUYnhdWLxtmLr4wmtZrRXaqc7H4r
 6SsVNGAvh3fDklnaENwSr4D8LycEXiJ2xscLHGTy94Vgg1u6qUcjvmqfbyMpgt/b4wVY
 j283gv95K9e5bXFC82GXWurkeIzH3m4U5XlUK8LQTAbvoozlQcMIohFSb4rvd7lqddkn
 nkXg==
X-Gm-Message-State: AOJu0YwfR83tqIKI2dUA83G4ocU1WssyD2hynTrGvzR4nxcGswq/iJpI
 ViTL4wyxl1KA/BGpNNo4y/mPgIz8TO3QjgseZ5nZH4jjvX2AEAnVcdvbU6Zhaxt+Gn8pAZvF8az
 l2fnizF2BRsfa3zStqUtOLkUhh1Fxa8cV/a/AVMYdamgqK206laTZ8VE/jDw3Cr+49WbktSk075
 sNZel/s0bIBqWbgUsY+Ly9N3DR7hY=
X-Gm-Gg: ATEYQzwMiLW65OZ2Xn+jZ4zVzU5K4k4mOTj8GTDd5N/0/QuN1fhqOJLFv+qPEuxX5Ca
 hX9egdDz/VF/kaYUXw3E3JjsRrPx+ZBy81zoJp6TnOMCL+b8bR/DjEBBbbGKOvDWMzBN4iokLML
 KWzdEU1IJXOL7LZmtN/lcyQMQZwNc+yS0CpZnaWh6MvIPOvAST6QuRgf6ZVxOIpaHGcdjj3g2Pq
 SK9ais=
X-Received: by 2002:a05:7022:618c:b0:11b:9386:8256 with SMTP id
 a92af1059eb24-1278fc584dcmr5203965c88.43.1772546579422; 
 Tue, 03 Mar 2026 06:02:59 -0800 (PST)
X-Received: by 2002:a05:7022:618c:b0:11b:9386:8256 with SMTP id
 a92af1059eb24-1278fc584dcmr5203948c88.43.1772546578830; Tue, 03 Mar 2026
 06:02:58 -0800 (PST)
MIME-Version: 1.0
References: <20260303032311.38988-2-liwang@redhat.com>
 <69a6b7c9.df0a0220.2ea96.efef@mx.google.com>
In-Reply-To: <69a6b7c9.df0a0220.2ea96.efef@mx.google.com>
Date: Tue, 3 Mar 2026 22:02:46 +0800
X-Gm-Features: AaiRm52Tvk3PcfBzgqcqoPHag8j6lmhUkQAfYdqHPDq8XThgTwxWVHyxvafoOXo
Message-ID: <CAEemH2dHAxyxhcEGk55R7nynZb020yDMc8mSkdwf9zVHVtdnvQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yAj8_sOIJ3vazMOylArbr9kcTHbCIx_wTKP1qqTfBT4_1772546580
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] lib: Extend LTP_ENABLE_DEBUG to support
 verbosity levels
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
From: Li Wang via ltp <ltp@lists.linux.it>
Reply-To: Li Wang <liwang@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQW5kcmVhLAoKVGhlIHR3byBwb2ludHMgbWFrZSBzZW5zZSwgd2lsbCBmaXggaW4gVjMuIFRo
YW5rcyBmb3IgdGhlIGZlZWRiYWNrIQoKT24gVHVlLCBNYXIgMywgMjAyNiBhdCA2OjI44oCvUE0g
QW5kcmVhIENlcnZlc2F0byA8YW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbT4Kd3JvdGU6Cgo+IEhp
IExpLAo+Cj4gSSByYW4gYSByZXZpZXcgd2l0aCBteSBMTE0gY29uZmlnIGFuZCBvYnRhaW5lZCB0
aGUgZm9sbG93aW5nIHJlcG9ydC4KPiBJIHRob3VnaHQgaXQgd2FzIGludGVyZXN0aW5nIHRvIHNo
YXJlIGhvdyB0aGUgTFRQIHJldmlldyBhZ2VudCBJJ20KPiBkZXZlbG9waW5nIGlzIGdyb3dpbmcu
IFRlc3RlZCB3aXRoIENsYXVkZSBTb25uZXQgNC42Cj4KPiAgSXNzdWVzIEZvdW5kCj4KPiAgIDEu
ICJFbmFibGluZyBkZWJ1ZyBpbmZvIiBwcmludGVkIGZvciBsZXZlbCAwIOKAlCBtaXNsZWFkaW5n
IG1lc3NhZ2UKPiAgICAgIChzdGlsbCB1bmFkZHJlc3NlZCBmcm9tIHYxKQo+Cj4gICBCb3RoIC1E
MCBhbmQgTFRQX0VOQUJMRV9ERUJVRz0wIHByaW50ICJFbmFibGluZyBkZWJ1ZyBpbmZvIChsZXZl
bCAwKSIsCj4gICB3aGljaCBpcyB0aGUgb3Bwb3NpdGUgb2Ygd2hhdCBpcyBoYXBwZW5pbmcuIExl
dmVsIDAgbWVhbnMgZGlzYWJsZSBhbGwKPiAgIGRlYnVnIG91dHB1dC4gVGhpcyB3YXMgcmFpc2Vk
IGluIHRoZSB2MSByZXZpZXcgYW5kIHJlbWFpbnMgdW5maXhlZC4KPgo+ICAgJCAuL2dldHBpZDAx
IC1EMAo+ICAgdHN0X3Rlc3QuYzo4MzM6IFRJTkZPOiBFbmFibGluZyBkZWJ1ZyBpbmZvIChsZXZl
bCAwKQo+Cj4gICBBZGRpdGlvbmFsbHksIExUUF9FTkFCTEVfREVCVUc9MCBpcyBhIGJlaGF2aW9y
IHJlZ3Jlc3Npb246IHByZXZpb3VzbHkKPiAgIGl0IHdhcyBzaWxlbnRseSBpZ25vcmVkIChubyBv
dXRwdXQpLCBub3cgaXQgcHJpbnRzIGEgbWlzbGVhZGluZwo+ICJFbmFibGluZyIKPiAgIG1lc3Nh
Z2UuIFRoZSBmaXggZm9yIHRoZSAtRCBwYXRoIGlzIHRvIGd1YXJkIHRoZSBtZXNzYWdlOgo+Cj4g
ICBpZiAoY29udGV4dC0+dGRlYnVnKQo+ICAgICAgIHRzdF9yZXMoVElORk8sICJFbmFibGluZyBk
ZWJ1ZyBpbmZvIChsZXZlbCAlZCkiLCBjb250ZXh0LT50ZGVidWcpOwo+Cj4gICBTYW1lIGZpeCBu
ZWVkZWQgaW4gdGhlIGVudiB2YXIgcGF0aC4KPgo+ICAgMi4gTFRQX0VOQUJMRV9ERUJVRyBzdGls
bCBzaWxlbnRseSBvdmVycmlkZXMgYSBtb3JlIHNwZWNpZmljIC1EIGZsYWcKPiAgICAgIOKAlCBj
b3JlIG9yZGVyaW5nIGlzc3VlIHVuZml4ZWQgZnJvbSB2MQo+Cj4gICBUaGUgZW52IHZhciBjaGVj
ayBydW5zIGFmdGVyIHBhcnNlX29wdHMoKSwgc28gTFRQX0VOQUJMRV9ERUJVRyBhbHdheXMKPiAg
IHdpbnMgb3ZlciB0aGUgY29tbWFuZC1saW5lIC1EIGZsYWc6Cj4KPiAgICQgTFRQX0VOQUJMRV9E
RUJVRz0xIC4vZ2V0cGlkMDEgLUQyCj4gICB0c3RfdGVzdC5jOjgzMzogVElORk86IEVuYWJsaW5n
IGRlYnVnIGluZm8gKGxldmVsIDIpICAg4oaQIGZyb20gLUQyCj4gICB0c3RfdGVzdC5jOjE0NTc6
IFRJTkZPOiBFbmFibGluZyBkZWJ1ZyBpbmZvIChsZXZlbCAxKSAg4oaQIGVudiB2YXIKPiBvdmVy
cmlkZXMhCj4KPiAgIEFuZCBldmVuIGRpc2FibGluZyB2aWEgdGhlIGVudiB2YXIgb3ZlcnJpZGVz
IGFuIGV4cGxpY2l0IGNvbW1hbmQtbGluZQo+IGVuYWJsZToKPiAgICQgTFRQX0VOQUJMRV9ERUJV
Rz0wIC4vZ2V0cGlkMDEgLUQyCj4gICB0c3RfdGVzdC5jOjgzMzogVElORk86IEVuYWJsaW5nIGRl
YnVnIGluZm8gKGxldmVsIDIpICAg4oaQIGZyb20gLUQyCj4gICB0c3RfdGVzdC5jOjE0NTc6IFRJ
TkZPOiBFbmFibGluZyBkZWJ1ZyBpbmZvIChsZXZlbCAwKSAg4oaQIGVudiB2YXIga2lsbHMgaXQK
Pgo+ICAgQ29tbWFuZC1saW5lIHNob3VsZCB0YWtlIHByZWNlZGVuY2Ugb3ZlciBlbnZpcm9ubWVu
dCB2YXJpYWJsZXMuIFRoZQo+ICAgZml4IGlzIHRvIHNraXAgdGhlIGVudiB2YXIgYXNzaWdubWVu
dCB3aGVuIC1EIHdhcyBhbHJlYWR5IHVzZWQ6Cj4KPiAgIGlmICh0ZGVidWdfZW52ICYmICFjb250
ZXh0LT50ZGVidWcpIHsgICAvKiBvbmx5IGlmIC1EIHdhc24ndCBwYXNzZWQgKi8KPiAgICAgICAu
Li4KPiAgIH0KPgo+ICAgT3IsIG1vcmUgcm9idXN0bHksIGNoZWNrIHRoZSBlbnYgdmFyIGJlZm9y
ZSBwYXJzZV9vcHRzKCkgc28gdGhlCj4gICBjb21tYW5kLWxpbmUgbmF0dXJhbGx5IHdpbnMuCj4K
Pgo+IFBvaW50IDEuIGlzIGNsZWFybHkgdHJ1ZSwgdGhlIFBvaW50IDIuIG1pZ2h0IGJlIGEgZGVz
aWduIGNob2ljZS4gSSBkb24ndAo+IG1pbmQgdGhlIHByaW9yaXR5IG9mIGNvbW1hbmQgbGluZSBv
ciBlbnYgdmFyaWFibGUsIGJ1dCBpdCdzIGFjdHVhbGx5Cj4gY29ycmVjdCB0byBhc3N1bWUgdGhh
dCBlbnYgc2hvdWxkIGJlIHNraXBwZWQgaWYgLUQgaXMgZGVmaW5lZC4KPgo+Cj4gS2luZCByZWdh
cmRzLAo+IC0tCj4gQW5kcmVhIENlcnZlc2F0bwo+IFNVU0UgUUUgQXV0b21hdGlvbiBFbmdpbmVl
ciBMaW51eAo+IGFuZHJlYS5jZXJ2ZXNhdG9Ac3VzZS5jb20KPgo+CgotLSAKUmVnYXJkcywKTGkg
V2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3Rp
bmZvL2x0cAo=
