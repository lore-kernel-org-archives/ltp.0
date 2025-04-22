Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF58EC369C2
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 12:29:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1745324979; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=U3YjccDHbYjiisAu0PsNro0nHiLL/31Xv5wDqY3SFG8=;
 b=krDQA5E4qWmwLjQysB7Nzv+R9xPDxdZ+hZufc1dxaXdaIgyuItRQOMe9e0VtxJlA08jOb
 7QG6iLiZ0XWoJEEhqgLv8j9N7Lq07urIDJdyRs4gmgfc1kJM4D3VlMzIUkZzACkHBvlUGaB
 L/5DFRRofoGjqUAca6Z4ciNEb+zqZYQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1F85F3C2869
	for <ltp@archiver.kernel.org>; Tue, 22 Apr 2025 14:29:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8CB713C1895
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:29:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5EB0E600944
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 14:29:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745324955;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ruLZ6UYubiM0q5H2yqGUsFAU6zJ1LLXc5uCn0d4u+W0=;
 b=H/QT/VU73FXbnfpCzphR99NeOyh3adBPxvIf+df8rVWgsPHSBBoftbab6mhDC3/42+Dtxl
 YkahFtdR8FQWDllJlzhd720/ge1niqa0VeXl6J8/u2/JUIADzZdmYsrFQQpggQL1LEDjvo
 G1PxiYwAp6k4g96LCW/pSlIvTNU9TbY=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-1LANnzSNNE-hmHmzz__gyg-1; Tue, 22 Apr 2025 08:29:12 -0400
X-MC-Unique: 1LANnzSNNE-hmHmzz__gyg-1
X-Mimecast-MFC-AGG-ID: 1LANnzSNNE-hmHmzz__gyg_1745324951
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-2ff58318acaso7055080a91.0
 for <ltp@lists.linux.it>; Tue, 22 Apr 2025 05:29:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745324949; x=1745929749;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ruLZ6UYubiM0q5H2yqGUsFAU6zJ1LLXc5uCn0d4u+W0=;
 b=ozh2WWIgYZS17n/fQxrMOIg39qxGslMRUmJEPax9738d7+yEV2oAHDlbyP2VBsjmQU
 vj0kBVByRZJnQEHXlS/lEp30uplIazLJ2LixSNtF6/JzxdM2N+ykSuGYRsBcZAui6zjM
 WAerssdyU0TWPhSSiyve7Osq/KBZXv3SKkhKu87rG40ftSJtv7yoqM8n6zw/Rgw7URas
 5Jz5Ld6dc2RxchOE6OFOHmLm5WCgI4rfvdg+fQ5SoJxLFpXExnkGIHnPDPfnA4wlpPL8
 UeBqcJ9fBhQ2mFPGvS0yFj5O5iLCqkLnHGJ62vhNpN3sDYBxyzr8HjTaJ7fSu3ZZk1dH
 Zz0Q==
X-Gm-Message-State: AOJu0YwnGOkYKnIkGIjPhTP38lTTrg2vGPPjdXM7aA5fV+aySLhOmDGF
 FGAg0axm1MOHX0eHn9cuLPfMuX2Cgdc4fDXDyr2l8xFBUo1/7OIb01V+r6PIjRTZWHX+puOcRn4
 glFYwKE7SKbNoVYt3bfF5rWh0tN2SqEsEs4ylHqPa7Cx4u8ZtbinpbZGTRPxb+5dmiMTpJhOGJ3
 oh1ZNXVn6AhjidLlpqPwC2WHHCbW1n+uCTRCSv
X-Gm-Gg: ASbGncvrUEBTh0AGzmKYg1CtWFizrEHKZ8/qyuriAn6JAWnCGQk7fHnbVn+GgwgIL11
 ezAR5Qk2hjo4TcJEfFJemnu/Q9+h6UmEZygOMaZRew4Da5sNmJmzCUw61CaJ3dTwlv9vZ5w==
X-Received: by 2002:a17:90b:2dc5:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-3087bb69a99mr27321172a91.18.1745324949520; 
 Tue, 22 Apr 2025 05:29:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGSHDwzwFTs7SJybDNgqMKqbrKbqfPwMjgFfnepf39EyukHFGIpiSAwZwOcAUqY7ndAhcPuYlHj/udtJaewOFo=
X-Received: by 2002:a17:90b:2dc5:b0:2ef:2f49:7d7f with SMTP id
 98e67ed59e1d1-3087bb69a99mr27321138a91.18.1745324949178; Tue, 22 Apr 2025
 05:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <63e8ded5-9aff-4e47-9bb7-13c5c1fb80e9@suse.com>
In-Reply-To: <63e8ded5-9aff-4e47-9bb7-13c5c1fb80e9@suse.com>
Date: Tue, 22 Apr 2025 20:28:57 +0800
X-Gm-Features: ATxdqUEDH3LAid9NqIDaFGhw5er8nTgSFjTgvpxBAXoAk1zaz_5ntrr6TTO4ZaY
Message-ID: <CAEemH2fH-7P+DSzgbUFJ6jyy62gGroy2nb57r5sWkq98nDi8DQ@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: aMWeiEqOr5FEp9UUH1dES6DYYnydlmpX2NQz5dknTyw_1745324951
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Open LTP meeting 24th of April
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBBcHIgMjIsIDIwMjUgYXQgODoyMeKAr1BNIEFuZHJlYSBDZXJ2ZXNhdG8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0Pgp3cm90ZToKCj4gSGVsbG8gZXZlcnlvbmUsCj4KPiB0aGlz
IGlzIGEgZnJpZW5kbHkgcmVtaW5kZXIgZm9yIHRoZSBMVFAgbWFpbGluZyBsaXN0IGFib3V0IHRo
ZSBuZXh0IExUUAo+IG1lZXRpbmcuCj4gQXMgcHJldmlvdXNseSBkaXNjdXNzZWQuCj4KPiBOZXh0
IG1lZXRpbmcgaXQncyBzdXBwb3NlZCB0byBiZSBvbiB0aGUgMjR0aCBvZiBBcHJpbCAwOTowMCBV
VEMuCj4gUGxhdGZvcm06IGh0dHBzOi8vbWVldC5nb29nbGUuY29tL2pvbi1neXRmLXVlaQo+Cj4g
QnV0IHdlIHNob3VsZCBzdGFydCB0byB0YWtlIGludG8gYWNjb3VudCBhbiBhbm90aGVyIHN0YXJ0
aW5nIGhvdXIsIHNvCj4gUmljYXJkbyBNYXJsaWVyZSBjYW4gam9pbiBhcyB3ZWxsIChoZSBsaXZl
cyBpbiBCcmF6aWwpLiBJZiBpdCdzIG9rIGZvcgo+IHlvdSwgd2UgY2FuIG1vdmUgaXQgdG8gMTA6
MDAgVVRDLgo+CgpCb3RoIDk6MDAgYW5kIDEwOjAwIFVUQyBhcmUgZmluZSB3aXRoIG1lLgooMTA6
MDAgVVRDIGlzIDZwbSBCZWlqaW5nIHRpbWUpCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
