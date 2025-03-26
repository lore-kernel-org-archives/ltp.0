Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12151C36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742974766; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Ciy7vXg4My7+PoZbvZJj6jGl65p088yLqNh3XosDLcY=;
 b=h5JT/X1KGy3FYPBQfwMxdaYgav2h7qUbCLX7c/9D8u5AR9XSrhW/9LmnE6/A2nac4lc5u
 DOLYyR+ix4PVYu5YIKERwfUpuCb09krVQJorIlL3601z33sPR9THpnVKKsKuifH5PxPiXHf
 IB+ybPVCozQ2q6beOaZxNILXPQ1TS1I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3D6F53C8546
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 08:39:26 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D9D683C103A
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 08:39:03 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5005A140C9B5
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 08:39:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742974740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EmaywLWcbAgLVfc9zEX7rs9WuZs1hFvhzZuYJmCE50Y=;
 b=G3sR7B/XnzqDHg+6Z7NM2K0HACB4KFNeeErAqtQuRJwcu+RZx0NlfabM7La4ft2N0NmiKt
 Fra82me+wl/lwX4nO+eEXDYZUOr2qY8gBSu5f5JJuCS3RHPjly5u0icjpocryta0p+5MHU
 7y5c7edpYRtaUJ6wPE0TUSlRTcm6G04=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-gxbCzOEqOiygsT2A2RjhVA-1; Wed, 26 Mar 2025 03:38:56 -0400
X-MC-Unique: gxbCzOEqOiygsT2A2RjhVA-1
X-Mimecast-MFC-AGG-ID: gxbCzOEqOiygsT2A2RjhVA_1742974735
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-ab39f65dc10so34705566b.1
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 00:38:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742974735; x=1743579535;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EmaywLWcbAgLVfc9zEX7rs9WuZs1hFvhzZuYJmCE50Y=;
 b=v9qCZU+vnjCo0zzWa8gPnG6LdQk8zYreYytPlRmH8bo34f97QnUCmZIQ9TdkC6lx2D
 +MKIZZKdg6M7UlKx2MFu9nNtna53Ep8fgpfWwRPtyd76pzperjzx0ZuTQv3RB1PQ9bl0
 Nl7Q+oSkXw6Xs3KHRwM1Il4V7yXrE1aVcAkFjaFDj/8vGSynHNMxSL7Lp6aWuTtr7SEd
 FlAkGcNuPOyuFUbnGS/P42uIQy46TiTz/DEowMseGo91Jpu0r3ScrwRyOb4rvWSFobvX
 5tEkLrVN9M0/IuV82Lj8YXzOyCAez+zyofJs3G7SclLXDZvhzEOHlRiNpxG5k6To1wZq
 4Gkw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVEJzKenFrtEgmmdo8RgFbE44EKLFUjw8WXT+cnQFqnlVJPRCAb0fMyQSF6MPVGFX1epcg=@lists.linux.it
X-Gm-Message-State: AOJu0YxwowuLVkSctC5612fGrb5ezDVSEbiYnmmpkt48oqXxrmFSc+qP
 tbFVcARwQqBCQr8lPKtgVHdqt7efk5tazJSIhRZ2z11MWiyjMAq50NJnyHW01n9K5j+n9PQIsM6
 qip/4gyCSeKZCN59sc37JwiEZQyylnOZeE4Ns1RMYU+VqTMpLuQeJNfN0p2JkEvrW8M2vYoXGsz
 YalAXRYiVbHw/o5eYVF+YWpOI=
X-Gm-Gg: ASbGncsEWPpuu2xHJNwASTH+7KGAqJfIw7x5jdk/X6mg5l1HH/3+JpI1BU26gRTuVOq
 5mm7ZD9C9d1gkRC4rs5/q6dSyqq5oRm9w7VsY9jtJJGUogRIV/naoqth2Xnv5y7c4OLV289sPLQ
 ==
X-Received: by 2002:a17:907:da0:b0:abf:6cc9:7ef2 with SMTP id
 a640c23a62f3a-ac3f24d5d6bmr2076480966b.42.1742974734636; 
 Wed, 26 Mar 2025 00:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERsA15EpTr7GEb1e5VvKFbcrbyfQ5rcTYs6SqzdFgBKX5Jjq5j2Fp7iIydItTCu0ysBYLeZPSZRpYhq3KwSkQ=
X-Received: by 2002:a17:907:da0:b0:abf:6cc9:7ef2 with SMTP id
 a640c23a62f3a-ac3f24d5d6bmr2076478766b.42.1742974734115; Wed, 26 Mar 2025
 00:38:54 -0700 (PDT)
MIME-Version: 1.0
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-2-wegao@suse.com> <20250325140018.GA448693@pevik>
 <Z+N/LjYbZJKq3qsS@wegao>
In-Reply-To: <Z+N/LjYbZJKq3qsS@wegao>
Date: Wed, 26 Mar 2025 15:38:35 +0800
X-Gm-Features: AQ5f1JpNeR0qC3dRXS7dmrC43-qu5rDn0K6872lToBazA_TtaqTzk38s4_mpxxk
Message-ID: <CAEemH2dNduMxZZzvC-ENpCMLcrD7CXYuV8iLsRJXisRu6LLSLA@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mBTG07ndpTXqqXx2Cm26XXGUAuzatIpg9KqBY0s2zGs_1742974735
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v7 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

T24gV2VkLCBNYXIgMjYsIDIwMjUgYXQgMTI6MTXigK9QTSBXZWkgR2FvIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cgo+IE9uIFR1ZSwgTWFyIDI1LCAyMDI1IGF0IDAzOjAwOjE4
UE0gKzAxMDAsIFBldHIgVm9yZWwgd3JvdGU6Cj4gPiBIaSBXZWksCj4gPgo+ID4gLi4uCj4gPiA+
ICtzdGF0aWMgdm9pZCBydW5fdGVzdCh2b2lkKQo+ID4gPiArewo+ID4gPiArICAgaW50IHBpZDsK
PiA+ID4gKyAgIGNoYXIgbm9kZV9pZF9zdHJbMjU2XTsKPiA+ID4gKwo+ID4gPiArICAgY2dfY3B1
c2V0XzAgPSB0c3RfY2dfZ3JvdXBfbWsodHN0X2NnLCAiMCIpOwo+ID4gPiArCj4gPiA+ICsgICBz
cHJpbnRmKG5vZGVfaWRfc3RyLCAiJXUiLCBjaGVja19ub2RlX2lkKTsKPiA+ID4gKyAgIFNBRkVf
Q0dfUFJJTlQoY2dfY3B1c2V0XzAsICJjcHVzZXQubWVtcyIsIG5vZGVfaWRfc3RyKTsKPiA+ID4g
KyAgIFNBRkVfRklMRV9QUklOVEYoIi9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMiLCAiJWQiLCAx
KTsKPiA+Cj4gPiBZb3UgY2hhbmdlZCB0aGUgL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyB0byAx
LCBiZWNhdXNlIEN5cmlsIG9iamVjdGVkCj4gdGhlIGNvZGUKPiA+IGluIHY2Ogo+ID4KPiA+IFNB
RkVfRklMRV9QUklOVEYoIi9wcm9jL3N5cy92bS9ucl9odWdlcGFnZXMiLCAiJWQiLCAyICogbm9k
ZS0+Y250KTsKPiA+Cj4gPiBCdXQgYXMgSSBub3RlIHRoZXJlIFsxXSwgdGhlIG9yaWdpbmFsIHNo
ZWxsIHRlc3QgZGlkIGl0IHRoaXMgd2F5IGFuZAo+IGtlcm5lbCBkb2NzCj4gPiBhbGxvd3MgbW9y
ZSB0aGFuIDEgdG8gYWxsb2NhdGUuIEknbSBvYnZpb3VzbHkgbWlzc2luZyBzb21ldGhpbmcuCj4g
Pgo+ID4gWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2x0cC8yMDI1MDMyNTEzMzYxMS5HQjM3
MjQxN0BwZXZpay8KPiA+Cj4gTXkgdW5kZXJzdGFuZGluZyBmcm9tIEN5cmlsJ3MgY29tbWVudHMg
aXMgbm8gbmVlZCByZXNlcnZlIG1vcmUgaHVnZXBhZ2VzLAo+IHNpbmNlCj4gdGhpcyB0ZXN0IGNh
c2UgT05MWSBhbGxvY2F0ZSAxIHBhZ2UgdGhyb3VnaCBtbWFwLgoKCkl0IGRlcGVuZHMgb24gd2hh
dCB5b3Ugd2FudGVkIHRoZXJlLCBpZiBvbmx5IDEgZ2VuZXJhbCBodWdlIHBhZ2UsCiBgZWNobyAx
ID4gL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlc2Agd2lsbCB0cnkgdG8gcmVzZXJ2ZSAxCmZyb20g
YSBOVU1BIG5vZGUgcmFuZG9tbHkuCgpCdXQgaWYgeW91IHByZWZlciB0byBnZXQgMSBodWdlcGFn
ZSBmcm9tIGEgc3BlY2lmaWVkIG5vZGUsIHdlIG5lZWQ6CiBgZWNobyAxID4KL3N5cy9kZXZpY2Vz
L3N5c3RlbS9ub2RlL25vZGUldS9odWdlcGFnZXMvaHVnZXBhZ2VzLSVka0IvbnJfaHVnZXBhZ2Vz
YAoKSG93ZXZlciwgYm90aCB3YXlzIHdvbid0IGd1YXJhbnRlZSB0aGUgcmVzZXJ2YXRpb24gd2ls
bCBiZSAxMDAlIHN1Y2Nlc3NmdWwsCndoaWNoIGlzIGJhc2VkIG9uIHRoZSBtZW1vcnkgZnJhZ21l
bnRhdGlvbiBzaXR1YXRpb25zLgoKVG8gYmUgb24gdGhlIHNhZmUgc2lkZSwgSSB3b3VsZCBzdWdn
ZXN0IHVzaW5nIExUUCB1bmlmaWVkIEFQSSB0byByZXNlcnZlOgpodHRwczovL2dpdGh1Yi5jb20v
bGludXgtdGVzdC1wcm9qZWN0L2x0cC9ibG9iL21hc3Rlci9kb2Mvb2xkL0MtVGVzdC1BUEkuYXNj
aWlkb2MjMTM0LXJlc2VydmluZy1odWdlcGFnZXMKCllvdSBjb3VsZCByZWZlcmVuY2UgdXNhZ2Ug
ZnJvbToKICBtZW0vaHVnZXRsYi9odWdlbW1hcC9odWdlbW1hcDE2LmMsCiAgc3lzY2FsbHMvbW92
ZV9wYWdlcy9tb3ZlX3BhZ2VzMTIuYwoKCgo+Cj4gQEN5cmlsIGNvdWxkIHlvdSBoZWxwIGNvbmZp
cm0gdGhpcz8KPgo+ID4KPiA+IEtpbmQgcmVnYXJkcywKPiA+IFBldHIKPgo+IC0tCj4gTWFpbGlu
ZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
