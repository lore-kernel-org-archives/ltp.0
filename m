Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C5AFC87FD1
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 06:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754375440; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=pLMOwS1HiwFnw5Sb3mHAehdPbuxjkPRxUCeOOJ4Tw60=;
 b=Qn6keLzcc4mhr7L7y0ou+js1N9vIXWBr08N4wv20Z5huJBB2syU6GH6J7Ck3LbIWvbE75
 v4CXUZIdb4F5Uaw6iFtMPCIdJeZs7IOuNk2fGu5QUiFkQEcnkTUpmeLPfFbhSiJL6czFbzd
 UohfMWO0ouj51ur/Zx9euD7jkhmMr+E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FB073C7F6B
	for <ltp@archiver.kernel.org>; Tue,  5 Aug 2025 08:30:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F8E93C6715
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 08:30:18 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5CF65600958
 for <ltp@lists.linux.it>; Tue,  5 Aug 2025 08:30:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754375415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d/JiItOpvIH3Q9iwrcTk6APGXynK6so6KuX/VfQknVA=;
 b=Oe5lXDC73/BZLQxa7Bxx2jfei9EsVnLEYRtPbKqwKuul6uZYhhlYt4O3aobrWwIWX/6Bvv
 mkp8S7nqTXN8ALW1qC1WG0bjWbD+J2lFlVklPXkKY//zM4VF53mYcLe9DC0CtDwa6P1Dbb
 LgYye2+ZImZAR291JJwYaIwiI2w5alo=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-480-ZLcgNbNkPLeHwg4l6euqmQ-1; Tue, 05 Aug 2025 02:30:13 -0400
X-MC-Unique: ZLcgNbNkPLeHwg4l6euqmQ-1
X-Mimecast-MFC-AGG-ID: ZLcgNbNkPLeHwg4l6euqmQ_1754375413
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-76bfab12672so4529549b3a.0
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 23:30:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754375412; x=1754980212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=d/JiItOpvIH3Q9iwrcTk6APGXynK6so6KuX/VfQknVA=;
 b=xH6J4Ii8DKpFrsPOtNnS9Sg74i0ifep85qLgLGfxkscsjIuiwG+VgZWn4jHuhMtgye
 PoT7E+tbx7AuToJ8MEKHG/xIz+lYrGsVrul5V9B/CZI6NIsc+nXWt2lBUCyI5/pBsEHb
 l+xREGILlkeARWbEAQerwBrzICghTZ/2fpkvB1YhXDxS6toVO993g51vuA6JNk+qwW1W
 6tc5EZ+3hzfiDJmyP8bIidf2Cm8Q6+D4NzzQ9YiEYiAM/YpvIQn1J/RIj4n4OalOvMAt
 va1HEHexGMZgZ4nz+25q4X7pu7m9eCZxDmx9ZOQI/7ZLXCOZzyee/LoMacNztrdqyw97
 5ACw==
X-Gm-Message-State: AOJu0YyE8cwPbjnNkZcgvJ1s7eZP/+8+uIiZ831KXM+tX4cPTwBfNidg
 CmCF3mp6fPE28UaBRXATA0JP4rmv7BNIMps16iAEEOCs6w5ygKhmFJ9NA5zBakqKvnhB7Ohlqhb
 DNZAJiqhSavAbU+V7EyiQsF70YRWDFgtA2feMgc8EfDU14Jh0HdTYajvd7jzkE6DtyzqRpKXcs3
 621GDcZ//aiOYFOaOFSjPMWXyT6Ws=
X-Gm-Gg: ASbGncuiwRRQmlEq1Wb564AO4PywiklSW2m/pyiBpYzxunRxYKRyn61zPeTlUghQ6k0
 eHbkg8//+bWB0sDvqrlc5LBbtthdynFuZBAfWmsKKniajWwvoRMIlgh9Oh1ZsSL0kFqzodw4bdn
 kXFyjNW+guMErK/gaNuMs6oA==
X-Received: by 2002:a05:6a20:a121:b0:240:7ed:402b with SMTP id
 adf61e73a8af0-24007ed4640mr9908070637.33.1754375412631; 
 Mon, 04 Aug 2025 23:30:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFeoEcP5aQ4bY2Ed12XYHnZxrKVyL36RvJgwZlTFGcqhaVW1JGEyMppu0NqTUiDQ6TTAYmtrJYd4JUPQQKcLaI=
X-Received: by 2002:a05:6a20:a121:b0:240:7ed:402b with SMTP id
 adf61e73a8af0-24007ed4640mr9908037637.33.1754375412260; Mon, 04 Aug 2025
 23:30:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250804201141.y5pncvmjhqv7mpjz@lida.tpb.lab.eng.brq.redhat.com>
In-Reply-To: <20250804201141.y5pncvmjhqv7mpjz@lida.tpb.lab.eng.brq.redhat.com>
Date: Tue, 5 Aug 2025 14:30:00 +0800
X-Gm-Features: Ac12FXz4JIka2M9PRFfj3s_kwT7OLTQXOA5M1JExTrB6WvGd8o3-r4vS0fCxr-8
Message-ID: <CAEemH2ckrLa=e5o9Y+KGRXKN7+irfku=6ccGFcX56i7QROoKYA@mail.gmail.com>
To: Martin Cermak <mcermak@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yCEvTEEchcPJ5dw-HAXgGCtZLQsj0Ic7LBCscUxDZzo_1754375413
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] Make sure 32-bit powerpc syscall defs don't leak to
 64-bit powerpc systems
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
Cc: ltp@lists.linux.it, mjw@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLAoKWWVzLCB3ZSBwcmVmZXIgdG8gc2VlIHBhdGNoZXMgb24gdGhlIG1haWxpbmcg
bGlzdCwgbmV4dCB0aW1lLAp5b3UgY2FuIHRyeSBzZW5kaW5nIHRoZW0gZGlyZWN0bHkgdmlhIGdp
dCBzZW5kLWVtYWlsLgoKZS5nLgogIGdpdCBzZW5kLWVtYWlsCjAwMDEtTWFrZS1zdXJlLTMyLWJp
dC1wb3dlcnBjLXN5c2NhbGwtZGVmcy1kb24tdC1sZWFrLXRvLS5wYXRjaCAtLXRvCmx0cEBsaXN0
cy5saW51eC5pdApCdXQgYW55d2F5LCB0aGlzIHBhdGNoIG1ha2VzIHNlbnNlLCB0aGFua3MgZm9y
IGZpeGluZyBpdC4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgpP
biBUdWUsIEF1ZyA1LCAyMDI1IGF0IDQ6MTLigK9BTSBNYXJ0aW4gQ2VybWFrIHZpYSBsdHAgPGx0
cEBsaXN0cy5saW51eC5pdD4Kd3JvdGU6Cgo+IEhlbGxvIGZvbGtzLAo+Cj4gSSB0aGluayBJIHNl
ZSBhIHByb2JsZW0gaW4gaG93IGdlbmVyYXRlX3N5c2NhbGxzLnNoIGdlbmVyYXRlcyB0aGUKPiBz
eXNjYWxscy5oIGhlYWRlciBvbiA2NC1iaXQgcG93ZXJwYyBzeXN0ZW1zLiAgSSd2ZSBmaWxlZCBb
MV0gdG8KPiBjb3ZlciB0aGlzLiAgQnV0IGZvbGtzIHNlZW0gdG8gcHJlZmVyIHRoZSBtYWlsaW5n
IGxpc3QgcGF0Y2gKPiBzdWJtaXNzaW9uLCBzbyBsZXQgbWUgdHJ5IDopICBQbGVhc2UgcmV2aWV3
IHRoZSBhdHRhY2hlZCBwYXRjaC4KPgo+IFRoYW5rcywKPiBNYXJ0aW4KPgo+Cj4gLS0tLS0tLS0t
LS0tLS0tCj4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2lz
c3Vlcy8xMjUxCj4KPgo+IC0tCj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCj4KCgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcg
bGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
