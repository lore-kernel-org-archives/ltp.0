Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F770C3ABC3
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 04:03:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1746763436; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=9cfIJYHKSwVJQWSc96L5tvG9QKkY9+OG+77R0KShtqM=;
 b=gv3skxNHdysDQ6/7jaFqHY5GxLpM1mSiVcm3qnaHUBElFbBjADghpUtQc6/0vGWZcQZEC
 yg98l8G3gkyFYGZKUzBzIobHOEWc2yI7PdstByl1rg7xkUQamRt9/TXLpT2ADPIFc/TU7oo
 Ep1rCeVx6ISd1eCjq3ETdO5bdzv3mUk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7578F3CC142
	for <ltp@archiver.kernel.org>; Fri,  9 May 2025 06:03:56 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E5EB3C768C
 for <ltp@lists.linux.it>; Fri,  9 May 2025 06:03:33 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 33465600BFF
 for <ltp@lists.linux.it>; Fri,  9 May 2025 06:03:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746763411;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uPRhZyFpuJbEqbdKl8crq+gqk3/ebJpAqZm5Z0aoCfg=;
 b=OzqaWHy8vo8aH3qMlQGcW6MxW89MjKbkedo3lLw4EnkVZQYjIRXXyAUis33eVvQyeFv7t9
 w9K/3iWf8Oo7GjYhRextCWNO6r5Y8DlCzSyDe3UDGF7Bw+nMGcSB0GOLtjsvkPdgUR2gHH
 NH+qu0vrzcjgLmFPKsRN4kJTw8ES1EI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-121-PkupeibNOJGy6nOCsWKGfw-1; Fri, 09 May 2025 00:03:28 -0400
X-MC-Unique: PkupeibNOJGy6nOCsWKGfw-1
X-Mimecast-MFC-AGG-ID: PkupeibNOJGy6nOCsWKGfw_1746763408
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-22e40e747a3so17962375ad.0
 for <ltp@lists.linux.it>; Thu, 08 May 2025 21:03:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746763408; x=1747368208;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uPRhZyFpuJbEqbdKl8crq+gqk3/ebJpAqZm5Z0aoCfg=;
 b=M1Xc0U9/RmY1DhY+nS2d5mQSmUZkLu1g1YWpz0o0vka5YlgPkIhkSsrQp70qUH4hz+
 PvDtSsnlrCKrM1P+PBY+FdS49n3EbiSPbkqzi+UzOPynkknFWHuMRS9vRae/W1ilBzfh
 dhInpkdhi71okU/5lAbLYKYHwCqQ12HMrDOJs4rYxIAk249NpolntpDIMV9DZC0Ws91i
 WAEvjYRcGvo9Pr47Ee1lXyM+NjAFNHJPsPxjsgdaMsp5vEgedesvP/VSq/cdGtMPHAii
 kLwdfe7gU3EOy2qbLoDEpw7FyF+c6rhDi0dS7h9aeleFJE90kheMlJkZm+ED6usvJEV9
 FH2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgfR1CjPfBuJLPg0+Vbf7jIoLhDH7lAVCaiWKhk8L0uAk4uXM8dIoNI86m3Zyfns9Z22I=@lists.linux.it
X-Gm-Message-State: AOJu0Yx44/lZ8KxdiqwaBiENzRHqjF9EIg5A047hYByFOmWDhV0IoQRd
 rKBslGJV3uZkH8hbmoHa9l6vPeC81LrRfrbVKBBELc18lXnf+/D83CwPwe5Q1nEKRFyAYEGjpEx
 7W886KobnQOrAWNCIfWwuklySPBIvuAif/qLx2nhTTV0yu6zW3S1sO3TWnnMFxlqBFRdPofqMtB
 6YOx6cC6gaMKueOFot76DfZ5U=
X-Gm-Gg: ASbGnct/0JbT9D0z+x6tTP2YyNMQ9BeulmqOSKwP1BPMVmMXkQqZmsNKh113bkq/TM3
 ytTLd6igBCJCylijrnC1KQUsE8d89KJeVD6cLQiABiUt7YDLE/t56br1aJ/9+tVapuflqiA==
X-Received: by 2002:a17:902:f70a:b0:22e:a59:af6f with SMTP id
 d9443c01a7336-22fc8c8d2d9mr32948275ad.28.1746763407979; 
 Thu, 08 May 2025 21:03:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGN/xEx6QKJUOYKJFX/B1TO27tAG0zOD6xRxmXw+E9ChaQUYas3aWVF/XibahfqkUJZADOk0uSNlnpxKtNkI2g=
X-Received: by 2002:a17:902:f70a:b0:22e:a59:af6f with SMTP id
 d9443c01a7336-22fc8c8d2d9mr32947875ad.28.1746763407624; Thu, 08 May 2025
 21:03:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250507154543.22309-1-mdoucha@suse.cz>
 <20250507175328.GA182617@pevik>
In-Reply-To: <20250507175328.GA182617@pevik>
Date: Fri, 9 May 2025 12:03:15 +0800
X-Gm-Features: AX0GCFtCeXzWpL9D6j4qih_r89WhCCV7QEwmAG5I5bqJmagRn2RFjRiQ1YTKbp8
Message-ID: <CAEemH2d1Ae6r_7N2V2KBm0pb0wxedWMxwKkN4nnub19-P5YTEQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2r_UUWA6wJPWwfflFoiPFvSDR8Uk7I177bPnCJXOQBc_1746763408
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mmap_24-1: Change vm.max_map_count if needed
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

T24gVGh1LCBNYXkgOCwgMjAyNSBhdCAxOjUz4oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBNYXJ0aW4sCj4KPiA+IElmIHZtLm1heF9tYXBfY291bnQgc3lzdGVt
IHBhcmFtZXRlciBpcyB0b28gaGlnaCwgbW1hcDI0LTEgbWF5IGdldAo+ID4ga2lsbGVkIGJ5IE9P
TS4gU2V0IHRoZSBwYXJhbWV0ZXIgdG8gYSByZWFzb25hYmxlIGxvdyB2YWx1ZSBzbyB0aGF0Cj4g
PiBtbWFwKCkgcXVpY2tseSBmYWlscyBhcyBleHBlY3RlZC4KPgo+IExHVE0uCj4gUmV2aWV3ZWQt
Ynk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6Pgo+Cj4gVGhlIG9ubHkgdGhpbmcgd2hpY2gg
Ym90aGVycyBtZSBpcyB0aGF0IHdyaXRpbmcgL3Byb2Mvc3lzL3ZtL21heF9tYXBfY291bnQKPiBy
ZXF1aXJlcyByb290LiBCdXQgSSdtIG5vdCBzdXJlIGlmIGl0J3Mgd29ydGggdG8gYWRkIG1vcmUg
Y29kZSB0byBjaGVjawo+IFVJRCAwLgo+Cj4gQExpIEBDeXJpbDogV0RZVD8KPgoKVGhlcmUgYXJl
IG1hbnkgd2F5cyB0byBhdm9pZCBPT00gKGUuZy4sIG92ZXJjb21taXRfbWVtb3J5LCBvb21fc2Nv
cmVfYWRqLAp1bGltaXQsIGV0Yy4pLiBIb3dldmVyLCB0aGUgcHVycG9zZSBvZiB0aGUgbW1hcF8y
NC0xLmMgdGVzdCBpcyB0byBleGhhdXN0CnRoZSB2aXJ0dWFsCmFkZHJlc3Mgc3BhY2UgYW5kIHRy
aWdnZXIgRU5PTUVNLgoKTGltaXRpbmcgdm0ubWF4X21hcF9jb3VudCBtYXkgcHJldmVudCBPT00s
IGJ1dCBpdCBjaGFuZ2VzIHRoZSBmYWlsdXJlIGNhdXNlCnRvCmhpdHRpbmcgdGhlIG1hcCBjb3Vu
dCBsaW1pdCwgbm90IGFjdHVhbCBhZGRyZXNzIHNwYWNlIGV4aGF1c3Rpb24sIHdoaWNoIG1pZ2h0
CmJlIGF3YXkKZnJvbSB0aGUgdGVzdCdzIGludGVudC4KCkkgZ3Vlc3MgdXNpbmcgc2V0cmxpbWl0
KFJMSU1JVF9BUywgLi4uKSBpcyBtb3JlIGFwcHJvcHJpYXRlIGhlcmUsIGFzIGl0CmVuZm9yY2Vz
IGFkZHJlc3MKc3BhY2UgbGltaXRzIHdoaWxlIHByZXNlcnZpbmcgdGhlIG9yaWdpbmFsIHRlc3Qg
Z29hbC4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
