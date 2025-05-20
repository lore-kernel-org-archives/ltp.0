Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28D44C2D0CD
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 00:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1747701555; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=m9gOKEmDsdKuohfchJHrjHHBu+qo8IQCoAKt+2pmsBs=;
 b=jWlCQYXe5+uMIrwg4RC0lTELnVdyrwQA+/2kP1JZVuCQuyaGrAqVqzhW7W2k3Aw64wZoD
 w8rsMglWUlaiJboOtpCQ8Dic6QZvfEf7Cv6jLsHfqp8sz5vVm5NMxB/1rPr1ck731x2MuO4
 ANoIjT8p0ZHLid1bis3AoV55ON63cIM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 001D83CC734
	for <ltp@archiver.kernel.org>; Tue, 20 May 2025 02:39:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 288DC3C68A4
 for <ltp@lists.linux.it>; Tue, 20 May 2025 02:38:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D4F3D1400325
 for <ltp@lists.linux.it>; Tue, 20 May 2025 02:38:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747701528;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CxFlkqJBhXV4AKtwaQYhDtWLCqPwMO1nDO19D1W2/Wg=;
 b=INg9hEM8wHpR/VY/0uCX8CIht6nHdbgwC8IdmSohIG+40zKjxDcN6J2EJSkx2m+RM5+J6e
 QHZawvKyC2ugzJZMuaTDa0A30YyckwAgr/NNAMlqu65jxjiJV2XeKG3GZhU8/XpkcefgF1
 xwQpwQnN3nQE2J3hTJFCWVovMe7XRIY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-g9NF-P2sPJaD9uE75uNE9w-1; Mon, 19 May 2025 20:38:46 -0400
X-MC-Unique: g9NF-P2sPJaD9uE75uNE9w-1
X-Mimecast-MFC-AGG-ID: g9NF-P2sPJaD9uE75uNE9w_1747701526
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-23205cb56c0so18780565ad.3
 for <ltp@lists.linux.it>; Mon, 19 May 2025 17:38:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747701526; x=1748306326;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=CxFlkqJBhXV4AKtwaQYhDtWLCqPwMO1nDO19D1W2/Wg=;
 b=G8sondWvrqaeNrTLCRhuGbTrdlmdb2RFt6pIIQpVM9fsD/T5QmN8mDoud1hJYit8Qz
 HQnV51CyL18DB/2NniUOtLclVio1IHAx69VBrQFLmEA8kXFLTUNTM0toZXUrpsR3TylA
 B+guGQnkdFOKAbXRsIz/v2Y7/HDN5q9hshCQp60X2MTxCF9nBzJb1K4zgp+ix/Y1EzjM
 21tsaGTZvHFTcgVUkdDfc+C7Ecz5YKUl1HDBmOWjjO6cq6v8UUH7X7yy7yISK9/bSwiX
 fbzWzReovhTkAn78DktBAJFPS/xEkorzvZuxG0ByqU4ZEooky3dG+qtb8wKxCd8tVpgv
 O54A==
X-Gm-Message-State: AOJu0YwYL0xebc9pL5kLDO1EbtXasxYMi6xAPKWqky7ZhIgV7g/pt7u/
 Xi5CHZhpEQXlUbYh2MISwr1cICoFJ6/dxw1UxcOXuB4QOt23gg7MSQDvz6iVhMPtF6YI7cDeuIv
 JD/KUDKbv7vOI0k1PwzgvpAccWZBBlnBGmTgX82IIqaajdzuF2jG96U3oHZjaQUfYsk8BFg0kv2
 lMQwkeO3tAEYrB8bYgDVESOEeDQF4=
X-Gm-Gg: ASbGncsAUJNzzdGAGecKUPonBqsfvyYivsAf+e0XteAlREiSJAygPfz46o4zPsXUsrP
 GXukj8s0qQOfcXWWqi9ovBpbTO8JxkPySBihc8cJWLg8fQbnVJrCXCpiMeZWpuJv6vr9fBA==
X-Received: by 2002:a17:902:ea0a:b0:231:8030:74a5 with SMTP id
 d9443c01a7336-231d45a9c7cmr210814495ad.32.1747701525811; 
 Mon, 19 May 2025 17:38:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHq15/JVcg891NGr43Z9EWLFP7TtJ5n+mL3nOtExH1ee0vg2ruuZrN0kC+grAPNYFYb2/JDg//Oyqc27RGTYXo=
X-Received: by 2002:a17:902:ea0a:b0:231:8030:74a5 with SMTP id
 d9443c01a7336-231d45a9c7cmr210814185ad.32.1747701525418; Mon, 19 May 2025
 17:38:45 -0700 (PDT)
MIME-Version: 1.0
References: <5964b0f9-e422-46b9-bab1-04e699e2f5f6@oracle.com>
In-Reply-To: <5964b0f9-e422-46b9-bab1-04e699e2f5f6@oracle.com>
Date: Tue, 20 May 2025 08:38:33 +0800
X-Gm-Features: AX0GCFvKvhFzP_AtQoUoOh2cp3Ks9ANrZ5dxtB2ziiuO7QOQoV3wJuO749U43ZU
Message-ID: <CAEemH2e7+2o=rM3sCoDVXgepjWessmtX9FOgHa15Ue7uFLwUSg@mail.gmail.com>
To: Chuck Lever <chuck.lever@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 7Uxya8KEwGdHLLMd5Di3n1modGHdbYLl3oj_EuimAdw_1747701526
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] latest ltp not building on RHEL 9.6 ?
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

T24gVHVlLCBNYXkgMjAsIDIwMjUgYXQgMjo0MOKAr0FNIENodWNrIExldmVyIHZpYSBsdHAgPGx0
cEBsaXN0cy5saW51eC5pdD4gd3JvdGU6Cj4KPiBIaSAtCj4KPiBNeSBkYWlseSBDSSBidWlsZHMg
bHRwIGFuZCBydW5zIGl0IGFnYWluc3QgbXkgbmZzZC10ZXN0aW5nIGJyYW5jaC4KPiBGb3IgdGhl
IHBhc3Qgd2VlayBvciBzbywgdGhlIGx0cCBidWlsZCBmYWlscyB3aXRoOgo+Cj4gSW4gZmlsZSBp
bmNsdWRlZCBmcm9tIGN2ZS0yMDE3LTE2OTM5LmM6Mjg6Cj4gLi4vLi4vaW5jbHVkZS9sYXBpL3Nj
aGVkLmg6MTg6ODogZXJyb3I6IHJlZGVmaW5pdGlvbiBvZiDigJhzdHJ1Y3Qgc2NoZWRfYXR0cuKA
mQo+ICAgIDE4IHwgc3RydWN0IHNjaGVkX2F0dHIgewo+ICAgICAgIHwgICAgICAgIF5+fn5+fn5+
fn4KPiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gL3Vzci9pbmNsdWRlL2JpdHMvc2NoZWQuaDo2MCwK
PiAgICAgICAgICAgICAgICAgIGZyb20gL3Vzci9pbmNsdWRlL3NjaGVkLmg6NDMsCj4gICAgICAg
ICAgICAgICAgICBmcm9tIC4uLy4uL2luY2x1ZGUvbGFwaS9zY2hlZC5oOjEwLAo+ICAgICAgICAg
ICAgICAgICAgZnJvbSBjdmUtMjAxNy0xNjkzOS5jOjI4Ogo+IC91c3IvaW5jbHVkZS9saW51eC9z
Y2hlZC90eXBlcy5oOjEwMjo4OiBub3RlOiBvcmlnaW5hbGx5IGRlZmluZWQgaGVyZQo+ICAgMTAy
IHwgc3RydWN0IHNjaGVkX2F0dHIgewo+ICAgICAgIHwgICAgICAgIF5+fn5+fn5+fn4KPgo+IFRo
ZSB0ZXN0IHJ1bm5lciBpcyBhIFJIRUwgOS42IGd1ZXN0LiBJIGRvbid0IHNlZSBhbnkgcmVjZW50
IGNoYW5nZXMgdG8KPiBsdHAgaW4gdGhpcyBhcmVhLCBzbyBwZXJoYXBzIDkuNiBtb2RpZmllZCAv
dXNyL2luY2x1ZGUvbGludXgvc2NoZWQuaCA/CgpJIHNhdyB0aGF0IExUUCBoYXMgYWxyZWFkeSBo
YW5kbGUgdGhhdCBjb25mbGljdCBpbiBsYXBpIGhlYWRlciBmaWxlLCBpbiBjb21taXQKaHR0cHM6
Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvY29tbWl0L2M0ODcwMGQ4Y2RiZTZk
MGQ3OGZkYTZlNmNjNjU4OTcyNDY0YjVjY2QKCkNhbiB5b3UgcHJvdmlkZSB0aGUgdmVyc2lvbiBv
ZiB5b3VyIGtlcm5lbC1oZWFkZXIgYW5kIGdsaWJjPwoKZS5nLgokIHJwbSAtcWYgL3Vzci9pbmNs
dWRlL2xpbnV4L3NjaGVkL3R5cGVzLmgKCiQgcnBtIC1xZiAvdXNyL2luY2x1ZGUvYml0cy9zY2hl
ZC5oCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBz
Oi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
