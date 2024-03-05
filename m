Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86AC2C54798
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 03:15:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7AC983C8910
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 04:15:52 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E40093C0E51
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 04:15:36 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 14A28200973
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 04:15:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709608534;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PNfsmJkRWDHDPSQN+pkXggS4QTdAtaYJ0wz+bbyqLT0=;
 b=ZKbzZQhbDrnjEtZQC+SF2lFcHDgIJ7cgfs9X0KWq4hMszzhClkfE5TgQmXb1gS+JNpPx/a
 SRlOlvFxoFORMEPsoLhzsBnWXVEtieq/HgxF7GJRlOAm3Wj9aomiwSJBuDvBoHFU2S4j2D
 7uEI4ZnKoNpgCzwLzA9msh3hLrjjHVY=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-L4vYSl57OJK2690B9WvSjw-1; Mon, 04 Mar 2024 22:15:31 -0500
X-MC-Unique: L4vYSl57OJK2690B9WvSjw-1
Received: by mail-pj1-f72.google.com with SMTP id
 98e67ed59e1d1-299ba5ae65eso3887066a91.3
 for <ltp@lists.linux.it>; Mon, 04 Mar 2024 19:15:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709608531; x=1710213331;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PNfsmJkRWDHDPSQN+pkXggS4QTdAtaYJ0wz+bbyqLT0=;
 b=JkGEIbXtgkCcVkQQnxT1dZcmh5uTWnM3SLPq4BvPH7NpO762QZavISY+n1Pd2NUS7n
 c6wz4YQ4OQRZNYG1SiR0TpiptCzBYG+yZF5pT2eqXwb1eel7JQpcqpNAqCAJeVamhKfS
 TjKrEVjdRshl1BHxbyfiOqdlFUlqHYgbAVRb5qweMcNwLf3yK2y0+YeYP/ZjnoFkpuJT
 /4b8i4kr6I4c4/XM+6iB8xXUSxzdbTzVF8j1yUqGFY8U5Sj+q46miFS52CHgM7hc+csi
 EDnC1krKDiITmPOhC6lr2po1sWYF0qX7BVugXwqzJHAI0tq3c6wB7jnO5FmmSWPU7RDg
 vAJg==
X-Gm-Message-State: AOJu0YyvDaIceyW0zE/H84bFctJTj63/D3HVTAFFQrzRAZu9PGu9yct1
 SlwOosUNr0T/Xf+XkHQiZ2u4HcdUyHw810/m/PABvRcS7L8lxhrnKm2Igys7Ws1thYy9eafiPDa
 t+X7R9Yg0iKqADkSnzSgaByPGIskxWqN194YZdg/7LJeeuo2t3UkmkKf1Dd1CVeCO/vcBK2+kXm
 UGeHflva0EyjsF2ysUzwPSNh0=
X-Received: by 2002:a17:90b:782:b0:299:75aa:8949 with SMTP id
 l2-20020a17090b078200b0029975aa8949mr7714854pjz.22.1709608530916; 
 Mon, 04 Mar 2024 19:15:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHT/xLQobOne4R6VYIVk/bYV3kfd95yvFVBj263hJry7RY2gzxuieQKpABK+m2Z2XSyVLcAeyArhVP3ww4PPls=
X-Received: by 2002:a17:90b:782:b0:299:75aa:8949 with SMTP id
 l2-20020a17090b078200b0029975aa8949mr7714847pjz.22.1709608530626; Mon, 04 Mar
 2024 19:15:30 -0800 (PST)
MIME-Version: 1.0
References: <CAEemH2e0Rmua9XimhfPHJ4xfEpidvYfXuDfsxRrA-VRv=YytQg@mail.gmail.com>
 <ZeXngYU344mMmWE0@yuki>
In-Reply-To: <ZeXngYU344mMmWE0@yuki>
From: Li Wang <liwang@redhat.com>
Date: Tue, 5 Mar 2024 11:15:18 +0800
Message-ID: <CAEemH2cijquqpgirbPH-7HpRfR9K7BQinROB9AOgOfdsCWqZ_A@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] function tst_parse_cmdline exist?
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgNCwgMjAyNCBhdCAxMToyNOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBEbyB3ZSBoYXZlIGEgZnVuY2lvbiBzaW1pbGFyIHRv
IHRzdF9wYXJzZV9jbWRsaW5lKCkgaW4gTFRQIGxpYj8KPgo+IE5vdCB5ZXQuCj4KPiA+IEkgYXNr
aW5nIHRoaXMgYmVjYXVzZSByZWNlbnRseSBwZW9wbGUgcmVhY2hlZCB0byBtZSBhYm91dCB0aGUK
PiA+IGluaXRfbW9kdWxlMDEgZmFpbGluZyBvbiB0aGUgc3lzdGVtIHdpdGggJyBtb2R1bGUuc2ln
X2VuZm9yY2U9MScKPiA+IGtlcm5lbCBwYXJhbWV0ZXIuIFRoYXQgbWFrZXMgbWUgdGhpbmsgdGhl
cmUgYXJlIHF1aXRlIG1hbnkKPiA+IHZhcmlvdXMga2VybmVsIHBhcmFtZXRlciBjaGFuZ2VzIGlu
IHNvbWUgYmVoYXZpb3Igd2hlbiBhZGRlZCBpbiwKPiA+IHNvIGlmIG5vdCwgSSBjYW4gaGVscCB0
byBjcmVhdGUgb25lIHRvIGRvIHN1Y2ggYSB0aGluZy4KPgo+IEkgc3VwcG9zZSB0aGF0IHRoZXJl
IGlzIG5vIG90aGVyIHdheSB0byBmaWd1cmUgb3V0IHRoYXQgdGhlIHNpZ25hdHVyZXMKPiBhcmUg
ZW5mb3JjZWQgdmlhIGNvbW1hbmRsaW5lLCByaWdodD8KPgoKUmlnaHQgKGF0IGxlYXN0IGJhc2Vk
IG9uIG15IGtub3dsZWRnZSksIHdlIGhhdmUgdG8gcGFyc2UgJy9wcm9jL2NtZGxpbmUnCmFuZCBk
ZXRlY3QgdGhlIGtleSBwYXJhbWV0ZXJzIGZvciBkZXRlcm1pbmluZyB3aGVyZSB0aGUgdGVzdCBn
b2VzIG5leHQuCgooaS5lLiBpbml0X21vZHVsZTAxOiBQQVNTIHdpdGhvdXQgdGhhdCBwYXJhbWV0
ZXIgJ21vZHVsZS5zaWdfZW5mb3JjZT0xJywKRkFJTCBhcyBleHBlY3RlZCB3aXRoIGhhdmluZyBp
dCkKCgoKPgo+ID4gSW4gYSB3b3JkLCB0aGUgbWFpbiBwdXJwb3NlIGlzIGp1c3QgdG8gcGFyc2Ug
Jy9wcm9jL2NtZGxpbmUnIGNvbnRlbnRzCj4gPiBhbmQgZXhwb3J0IHRoZSBuZWNlc3NhcnkgdmFs
dWUgdG8gdGVzdCBjYXNlLgo+ID4KPiA+IE9yLCBhbnkgc3VnZ2VzdGlvbnMgb24gdGhlIHRvcGlj
Pwo+Cj4gV2UgYWxyZWFkeSBwYXJzZSBjbWRsaW5lIGluIHRoZSBzdGFja19jbGFzaC5jIHRlc3Qs
IHNvIEkgc3VwcG9zZSB3ZSBtYXkKPiBhcyB3ZWxsIGFkZCBhIGZ1bmN0aW9uIHRvIHRoZSB0ZXN0
IGxpYnJhcnkuCj4KClRoYW5rcyBmb3IgdGhlIGluZm8sIEkgZ3Vlc3Mgd2UgbmVlZCBhIG1vcmUg
Z2VuZXJpYyBmdW5jdGlvbiBmb3Igd2lkZSB1c2UKaW4gdGhlIGxpYiwgSSBwcmVmZXIgdG8gbmFt
ZSBpdCB0c3RfcGFyc2Vfa2NtZGxpbmUoKSBzaW1wbHkgYnV0IG1heWJlIGV4dGVuZApzb21ldGhp
bmcgaWYgbmVjZXNzYXJ5LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
