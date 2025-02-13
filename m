Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7082EC0219D
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 12:17:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D7E8C3C9A8B
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 13:17:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 033E13C9A70
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 13:17:30 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 28E09142238A
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 13:17:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739449048;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7/veilCP3XrUAnC+WfOVztayMfZ6Ttn0DZHhj58QsZU=;
 b=BD0DrxjdI4KSkbyIFTpIfa0xliHbEwkLwg5bRa2GUkkAlrwa6Xu5AYosPikvER75iWBY0R
 St7yLafnTxiVX3f4P8xciOOuQ0NTq5tyMkWmDUrBuH+yL0XmKLhM711+dhPJxUk2tzS3p7
 SvEph9/wa0+eDPlVGTQ2kG16pSGBdJ4=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-VZmWX2VIOMasKSdpuZB9og-1; Thu, 13 Feb 2025 07:17:26 -0500
X-MC-Unique: VZmWX2VIOMasKSdpuZB9og-1
X-Mimecast-MFC-AGG-ID: VZmWX2VIOMasKSdpuZB9og_1739449045
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2fa440e16ddso2109899a91.0
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 04:17:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739449045; x=1740053845;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7/veilCP3XrUAnC+WfOVztayMfZ6Ttn0DZHhj58QsZU=;
 b=WvN1vEOqEGf3Zd4PY0kP+m6MRLuGjtrfMrtOSk1SG3vBJ2fcnWi8sgmmQeif92j83/
 5Z7M+HVh8OnzVxrhLHC9gQHEj6mgBKEhbBUTERcRlR9Qo+pFNvWKdDTsrJtfGTL7J1ZH
 dgb7BAKdvmh8M+chQ9SC55Gyy+sFyy1+U9KFpXAB+XPhcHyszSHdqYrc5hjggVa9s6jB
 ytbRGir24fO1h+tLyrnCCDm8LvEBMtSP7F+P2xbVWNdfQFCxUjwK4llvZYIVEEJOyjm4
 FpXXQaMp1BKsWCIHONrOxRpaR/k6ZnuswcFS+aq1YsWc4fjNpSF6MLeaQBdurbKizQNQ
 P1UA==
X-Gm-Message-State: AOJu0YyRzva8QJuqL/hlQmj8cOWiQTXypufF/85OQNDbaPbkmLThqetq
 LQ1POogEh0ZlNxLQ8or5tJxsADhaE5tcJwv8qQl+YIJCgXK6McvCnV7kuOvpqBriHmO/B2UNLTy
 llT2JloKYKtDBt60dcMc9VH5zAO0E0fftkGix4+GYp50BELi359BLTLf8wxQZt9TAqcejqffeiG
 X+qIzVXgCitiRpUELCDJhCG84=
X-Gm-Gg: ASbGncuMHN3faSwdoxilyM/xa/03lXWYOlTxe5seFKv1//WIUqxTv4V/1gCxjn+NcCL
 locHV2IqWG0B8A0sjKE9VsMFt6w6a2kguGcmzIyS7UHC34pBMK+X+LTAleqfkH3s=
X-Received: by 2002:a17:90b:4f8b:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2fbf5baec63mr10658124a91.4.1739449045001; 
 Thu, 13 Feb 2025 04:17:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgn013DB2gBJVvEclHYGkWMpG1caYu4jBW0uUXIlwk/lXhhq6KYZ5EwQ2kDdxLIX80NFWZAQlEcSK3msgpeSw=
X-Received: by 2002:a17:90b:4f8b:b0:2ee:5bc9:75b5 with SMTP id
 98e67ed59e1d1-2fbf5baec63mr10658093a91.4.1739449044636; Thu, 13 Feb 2025
 04:17:24 -0800 (PST)
MIME-Version: 1.0
References: <cf44d644-bfce-4c88-8011-7fa5c15a8d9d@oracle.com>
 <CAEemH2fxMxbApmaszJGLvRSG9e0T7ZAYUD=hxBSw9JFZgqan7A@mail.gmail.com>
In-Reply-To: <CAEemH2fxMxbApmaszJGLvRSG9e0T7ZAYUD=hxBSw9JFZgqan7A@mail.gmail.com>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Feb 2025 20:17:12 +0800
X-Gm-Features: AWEUYZkxRpbSVWW0t7Z7VwJk1AtgokPwtBYPedbdQC87gu4qnWDBay_X85DJdC4
Message-ID: <CAEemH2cmPbDp15DOmOy3dmoLjRYHPcAD9Q_fts==EF8YDUJMGQ@mail.gmail.com>
To: Harshvardhan Jha <harshvardhan.j.jha@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RLV-9rieMffYSRC3i8j_3o0Jll2IMXRNkzc7gYOXxUw_1739449045
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Test failures obtained on 6.14 kernel in memcontrol04 test
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
Cc: cgroups@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBGZWIgMTMsIDIwMjUgYXQgODoxNuKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gV2hhdCBraW5kIG9mIGZhaWx1cmVzIGRpZCB5b3UgaGl0Pwo+IENhbiB5
b3UgdHJ5IHRoaXMgc29sdXRpb24gdG8gc2VlIGlmIGl0IHByb3Blcmx5IHdvcmtzICh3aXRoIENn
cm91cCB2Mik/Cj4KCkkgbWVhbiB0aGlzOgpodHRwczovL2xpc3RzLmxpbnV4Lml0L3BpcGVybWFp
bC9sdHAvMjAyNS1KYW51YXJ5LzA0MTY1My5odG1sCgoKCj4KPgo+IE9uIFRodSwgRmViIDEzLCAy
MDI1IGF0IDY6NTfigK9QTSBIYXJzaHZhcmRoYW4gSmhhIHZpYSBsdHAgPAo+IGx0cEBsaXN0cy5s
aW51eC5pdD4gd3JvdGU6Cj4KPj4gSGkgdGhlcmUsCj4+IEkgZW5jb3VudGVyZWQgYSBmZXcgdmFy
aWFibGVzIGZvciBtZW1jb250cm9sMDQgdGVzdCBvbiA2LjE0IGtlcm5lbC4KPj4gVGhlc2UgaGFk
IGNncm91cCB2MiBlbmFibGVkLiBUaGUgZmFpbHVyZXMgZGlzYXBwZWFyIHdoZW5ldmVyIGNncm91
cCB2MQo+PiBpcyBpbnN0ZWFkIHVzZWQuCj4+Cj4+Cj4+IFRoYW5rcyAmIFJlZ2FyZHMsCj4+IEhh
cnNodmFyZGhhbgo+Pgo+PiAtLQo+PiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAKPj4KPgo+Cj4gLS0KPiBSZWdhcmRzLAo+IExpIFdhbmcKPgoK
Ci0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlz
dHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
