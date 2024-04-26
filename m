Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D6AC4345F
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 02:32:33 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D29543CFE97
	for <ltp@archiver.kernel.org>; Fri, 26 Apr 2024 04:32:31 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D0E093CE955
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 04:32:14 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2348E6009DA
 for <ltp@lists.linux.it>; Fri, 26 Apr 2024 04:32:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714098732;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VRUKfnBcWBUutS8b1QTgD0ktmbN+HTHXmiAxaTvGtzc=;
 b=GadFsklhdN/vLTit4Z0u8r9X5rszBZk14HBODyjMwZflwehQ2jgGLUi16YRjiu9iGCCwIE
 7g+kESHP29uXh7RPWwmAix1Spz+wtPIDn4nTZEfrU2bxinu4+l/suCZwAcJw+FMD+ODqts
 NpUZHJeegA+mhaa33UNUOZ/HHaxl9mc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-423-eNtlHnJHNsCrQR0x5UDYGg-1; Thu, 25 Apr 2024 22:32:09 -0400
X-MC-Unique: eNtlHnJHNsCrQR0x5UDYGg-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-2a5c5e69461so2057710a91.2
 for <ltp@lists.linux.it>; Thu, 25 Apr 2024 19:32:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714098729; x=1714703529;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VRUKfnBcWBUutS8b1QTgD0ktmbN+HTHXmiAxaTvGtzc=;
 b=ccnufaqeI72LqsPEqGtzNTjuJbbkaijiqJ/wr+Dp+RqFat+OYDZXa+dzQYMJvHtD5Q
 6Fx4dMq81aUtmWNWbJjgq8Fr375fkR+GeeQiy767TYqfKF+ME/TTuEU4JJhNOLGE7IfQ
 c5ijN5zcH+Yz8ArwG8GYV//9m8LNkxItxlesDBy8mLR0k9itjAMOH/ybGMoxtvIcv/BL
 y7GiJ0b9r0cFhMiFarmdj9BvrGmmtvLQ9ebYJ3cYVDaWA/NPZfrEDGbc75sKF9VZgeJd
 H1cAZpOrGSH9D22bNmmz1GRA1ifBX4He3MndI4CJt8017Jqmv8VUf6cmftmOFM8B0kfG
 qy5A==
X-Gm-Message-State: AOJu0Yy82nyFOZFhsVgwb6mj2rq5bhAjEWdkaJq/9sp/IUQUjBp18otj
 DjT2Ipva3xD0v7pDMQ/k8aecpC9GwcKpQJTQrtauCpQIv2xG6LY27LUB4VS296XJpB7GfVAJYzs
 09PnKgDFZ91aGTgbFQ1kgS+YQZ6koUikJTocm8qwA00V+hAnUJHzKyljYIX7ZH6v/PqZ3MRcYok
 aFGY0jqoI9EAWA0ySRfkeO+sQ=
X-Received: by 2002:a17:90a:7408:b0:2ae:7e7b:ac with SMTP id
 a8-20020a17090a740800b002ae7e7b00acmr1559352pjg.13.1714098728878; 
 Thu, 25 Apr 2024 19:32:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFshG7CLEN+WyUDHtWS6JKqZlC78Tvlmbb4mzrm5dWt9T1NFNCHO/3maRfoM9knnuF9tZ8ZJuVXDriZdU033VQ=
X-Received: by 2002:a17:90a:7408:b0:2ae:7e7b:ac with SMTP id
 a8-20020a17090a740800b002ae7e7b00acmr1559340pjg.13.1714098728572; Thu, 25 Apr
 2024 19:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240425211042.299714-1-pvorel@suse.cz>
 <20240425211042.299714-2-pvorel@suse.cz>
In-Reply-To: <20240425211042.299714-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Fri, 26 Apr 2024 10:31:56 +0800
Message-ID: <CAEemH2ekBY=-DR0ksjB2SjK6di_9hDpnrE58AA+vwxix0R8chw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 1/2] libswap: Add {SAFE_,
 }MAKE_SMALL_SWAPFILE() macros
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

T24gRnJpLCBBcHIgMjYsIDIwMjQgYXQgNToyNuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gNjU1MzYgYnl0ZXMgdHJpZ2dlcmVkIHdhcm5pbmcgb24gc3lzdGVtcyB3
aXRoIDY0IGtiIHBhZ2Ugc2l6ZSAoZS5nLiBvbgo+IGFhcmNoNjQgd2l0aCBDT05GSUdfQVJNNjRf
NjRLX1BBR0VTPXkgb3Igb24gcHBjNjRsZSB3aXRoCj4gQ09ORklHX1BBR0VfU0laRV82NEtCPXkp
Ogo+Cj4gICAgIFRXQVJOOiBTd2FwZmlsZSBzaXplIGlzIGxlc3MgdGhhbiB0aGUgc3lzdGVtIHBh
Z2Ugc2l6ZS4gVXNpbmcgcGFnZSBzaXplCj4gICAgICg2NTUzNiBieXRlcykgaW5zdGVhZCBvZiBi
bG9jayBzaXplICg0MDk2IGJ5dGVzKS4KPgo+IDEgTUIgc2hvdWxkIGJlIG9rIGZvciBtb3N0IG9m
IHRoZSBzeXN0ZW1zLgo+Cj4gU3VnZ2VzdGVkLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3Vz
ZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPgoKIFJl
dmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCi0tLQo+ICBpbmNsdWRlL2xp
YnN3YXAuaCB8IDE4ICsrKysrKysrKysrKysrKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlic3dhcC5oIGIvaW5jbHVkZS9s
aWJzd2FwLmgKPiBpbmRleCA4N2UzMjMyOGUuLmY3NTcwNzNjYyAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL2xpYnN3YXAuaAo+ICsrKyBiL2luY2x1ZGUvbGlic3dhcC5oCj4gQEAgLTIzLDYgKzIzLDI0
IEBAIGludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKmZpbGUsIGNvbnN0IGludCBsaW5lbm8s
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgY2hhciAqc3dhcGZpbGUsIHVuc2lnbmVk
IGludCBudW0sCj4gICAgICAgICAgICAgICAgICAgICAgICAgaW50IHNhZmUsIGVudW0gc3dhcGZp
bGVfbWV0aG9kIG1ldGhvZCk7Cj4KPiArLyoqIDY1NTM2IGJ5dGVzIGlzIG1pbmltdW0gZm9yIDY0
a2IgcGFnZSBzaXplLCBsZXQncyB1c2UgMSBNQiAqLwo+ICsjZGVmaW5lIE1JTklNQUxfU1dBUF9T
SVpFX01CIDEKPiArCj4gKy8qKgo+ICsgKiBNYWNybyB0byBjcmVhdGUgbWluaW1hbCBzd2FwZmls
ZS4KPiArICovCj4gKyNkZWZpbmUgTUFLRV9TTUFMTF9TV0FQRklMRShzd2FwZmlsZSkgXAo+ICsg
ICAgbWFrZV9zd2FwZmlsZShfX0ZJTEVfXywgX19MSU5FX18sIHN3YXBmaWxlLCBNSU5JTUFMX1NX
QVBfU0laRV9NQiwgMCwgXAo+ICsgICAgICAgICAgICAgICAgIFNXQVBGSUxFX0JZX1NJWkUpCj4g
Kwo+ICsvKioKPiArICogTWFjcm8gdG8gY3JlYXRlIG1pbmltYWwgc3dhcGZpbGUuCj4gKyAqIElu
Y2x1ZGVzIHNhZmV0eSBjaGVja3MgdG8gaGFuZGxlIHBvdGVudGlhbCBlcnJvcnMuCj4gKyAqLwo+
ICsjZGVmaW5lIFNBRkVfTUFLRV9TTUFMTF9TV0FQRklMRShzd2FwZmlsZSkgXAo+ICsgICAgbWFr
ZV9zd2FwZmlsZShfX0ZJTEVfXywgX19MSU5FX18sIHN3YXBmaWxlLCBNSU5JTUFMX1NXQVBfU0la
RV9NQiwgMSwgXAo+ICsgICAgICAgICAgICAgICAgIFNXQVBGSUxFX0JZX1NJWkUpCj4gKwo+ICAv
KioKPiAgICogTWFjcm8gdG8gY3JlYXRlIHN3YXBmaWxlIHNpemUgaW4gbWVnYWJ5dGVzIChNQiku
Cj4gICAqLwo+IC0tCj4gMi40My4wCj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
