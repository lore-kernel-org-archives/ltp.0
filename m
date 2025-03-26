Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2977C36008
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 09:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1742980330; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=DwtzlQoa3aHcV+490LY7oGIVtD49GOiiJW9i4LJ9Utg=;
 b=bw4R0BwBn6LiMF2cB2otQxbtkoXnmy4JrAOkVSep6j+czyTM0NzLuWRKxNCBkGe/xuEml
 1rMD3zHnHnc1btJpnGaiKE2Eh+ERn0s4hASsW2Mv4ONQF79Tlera3aBuoVAfXmpBSqz3Mtl
 7gSScU37rEO2N4YOcz8xkvHYXVmK1aw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1B0593C7249
	for <ltp@archiver.kernel.org>; Wed, 26 Mar 2025 10:12:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47AA13C7249
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 10:11:47 +0100 (CET)
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com
 [IPv6:2a00:1450:4864:20::342])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id BC7EF1A007FD
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 10:11:46 +0100 (CET)
Received: by mail-wm1-x342.google.com with SMTP id
 5b1f17b1804b1-43cf05f0c3eso42006125e9.0
 for <ltp@lists.linux.it>; Wed, 26 Mar 2025 02:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1742980306; x=1743585106; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=yBEA/Rvl3dggf60h57uK4dUocz1m6Tgi3/O0xDwvdVw=;
 b=LCzuCXiwvkmd1PeGbFrpK18Aq6ubsJ3eMIflyE7ozXDVCg2CU6SUtXwnTxw1Hcqnwn
 ZH0XAgcYoUrnSsxh63UHQ4LfcWLnvuCripgQ6+pK0yv3hJd2zmqSfRtat8a4GrBda84v
 NpM7+d+McKkn6IAKx+kI/HyZmpR+wDjCtfQWcNUpIa42iVj1/lnTYk6u3fZ1p/K/phcd
 U1bPZzX3lCMGEtNKTiQGjc0cD47mY8j1Qyov9ml35llpT1ZepiViZSUjwtBc15YH8U5S
 Lk6TeYynrB7O06X+n+tq3bF4ZRb72nAvFkmbBdcZRIqehB6nv2GfWw/jOVxDv7sZacPT
 KCsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742980306; x=1743585106;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yBEA/Rvl3dggf60h57uK4dUocz1m6Tgi3/O0xDwvdVw=;
 b=Mljnt9TMUWC9LQDEBt+ibVhqI1sMHPaAkGFEwbMF8n5kq01deKa+esmVztklZywLuo
 J+xeILuyiT0uk43j5ZRY/IvqgwrgBTB2j/WW32MWZD0xSczkCWLNLZfu8TP9PgKgT62h
 WWBnT6HUsv2tq43yyjT3FSOGp+/NjwBR0KaaSSHzCRt7u3honoMwMoUra5XVQ04ntp4s
 28bH+2+o3C9X6iE4ARgEqszMmz3WkxGcH0rX1y/1tSiVhl/4eDI2hnDNyNhcbrYkRwux
 mnw9tvYLCF5v2e7WTwYZPAYG8Q/ZgPiNxiS3MVsL9L8XMCFtH18ZhHgG8ofRA2Sq+JBG
 875g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcQQCblkdvTRGFpcmi34bdilswSoh8pNACaS6FEs9ZJnAfPKWZtLithGsj2ZVbZgiJcx8=@lists.linux.it
X-Gm-Message-State: AOJu0YwEBstaoL4OGrTybVdCfLe01MqqqRi93DRTlcGNwopX2J1pPm9y
 BeLJUltxbfiLBOjzeXsbvAQ5c8FoM8nBA03yl7n7wX7baEOcNSerhNolr9uh8w==
X-Gm-Gg: ASbGnct5918g79oiActDXFoXA2MFq6Rf99ihfykTo6bu9ckvxV536vtF0Tao/4hzK1i
 kZWB9wPEwqYNslpnuls7OqTdcq2pFi8LvY+5qrVEGlOvt7xdCnYgXuF9b+rP4Zvqtl3+yiu1HeB
 LJpTqHanotqSzeR/eAh1TxoD/1nQd1SUC/0DVN/uiG/hxg68SLjSaZO/U1TVJzVQP4rrbhqUEPw
 0D9YGTTDv5A/uW3h91doBkyO6GIhyr6uiBTEXgTUG5aKbY8T0CL1LXFviPxRlNE4oQC8I+rCQmB
 nE7uJwaAv/Sn08m8weHFfrhqun4S
X-Google-Smtp-Source: AGHT+IHzXK68sFHYBTFquFRjmb7+uptz7MZZBm0RTMlklbL9OJO0hs465eB5Bat0Uh1iwZSdUjqLBQ==
X-Received: by 2002:a05:600c:4712:b0:43c:fc04:6d48 with SMTP id
 5b1f17b1804b1-43d7836b759mr17853405e9.0.1742980306070; 
 Wed, 26 Mar 2025 02:11:46 -0700 (PDT)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efe61sm16514706f8f.97.2025.03.26.02.11.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Mar 2025 02:11:45 -0700 (PDT)
Date: Wed, 26 Mar 2025 05:11:39 -0400
To: Li Wang <liwang@redhat.com>
Message-ID: <Z+PEy9Ap9OBeNDkI@wegao>
References: <20250305050805.7905-1-wegao@suse.com>
 <20250324120049.29270-1-wegao@suse.com>
 <20250324120049.29270-2-wegao@suse.com>
 <20250325140018.GA448693@pevik> <Z+N/LjYbZJKq3qsS@wegao>
 <CAEemH2dNduMxZZzvC-ENpCMLcrD7CXYuV8iLsRJXisRu6LLSLA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2dNduMxZZzvC-ENpCMLcrD7CXYuV8iLsRJXisRu6LLSLA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXIgMjYsIDIwMjUgYXQgMDM6Mzg6MzVQTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBPbiBXZWQsIE1hciAyNiwgMjAyNSBhdCAxMjoxNeKAr1BNIFdlaSBHYW8gdmlhIGx0cCA8bHRw
QGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiAKPiA+IE9uIFR1ZSwgTWFyIDI1LCAyMDI1IGF0IDAz
OjAwOjE4UE0gKzAxMDAsIFBldHIgVm9yZWwgd3JvdGU6Cj4gPiA+IEhpIFdlaSwKPiA+ID4KPiA+
ID4gLi4uCj4gPiA+ID4gK3N0YXRpYyB2b2lkIHJ1bl90ZXN0KHZvaWQpCj4gPiA+ID4gK3sKPiA+
ID4gPiArICAgaW50IHBpZDsKPiA+ID4gPiArICAgY2hhciBub2RlX2lkX3N0clsyNTZdOwo+ID4g
PiA+ICsKPiA+ID4gPiArICAgY2dfY3B1c2V0XzAgPSB0c3RfY2dfZ3JvdXBfbWsodHN0X2NnLCAi
MCIpOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgc3ByaW50Zihub2RlX2lkX3N0ciwgIiV1IiwgY2hl
Y2tfbm9kZV9pZCk7Cj4gPiA+ID4gKyAgIFNBRkVfQ0dfUFJJTlQoY2dfY3B1c2V0XzAsICJjcHVz
ZXQubWVtcyIsIG5vZGVfaWRfc3RyKTsKPiA+ID4gPiArICAgU0FGRV9GSUxFX1BSSU5URigiL3By
b2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyIsICIlZCIsIDEpOwo+ID4gPgo+ID4gPiBZb3UgY2hhbmdl
ZCB0aGUgL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyB0byAxLCBiZWNhdXNlIEN5cmlsIG9iamVj
dGVkCj4gPiB0aGUgY29kZQo+ID4gPiBpbiB2NjoKPiA+ID4KPiA+ID4gU0FGRV9GSUxFX1BSSU5U
RigiL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyIsICIlZCIsIDIgKiBub2RlLT5jbnQpOwo+ID4g
Pgo+ID4gPiBCdXQgYXMgSSBub3RlIHRoZXJlIFsxXSwgdGhlIG9yaWdpbmFsIHNoZWxsIHRlc3Qg
ZGlkIGl0IHRoaXMgd2F5IGFuZAo+ID4ga2VybmVsIGRvY3MKPiA+ID4gYWxsb3dzIG1vcmUgdGhh
biAxIHRvIGFsbG9jYXRlLiBJJ20gb2J2aW91c2x5IG1pc3Npbmcgc29tZXRoaW5nLgo+ID4gPgo+
ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbHRwLzIwMjUwMzI1MTMzNjExLkdCMzcy
NDE3QHBldmlrLwo+ID4gPgo+ID4gTXkgdW5kZXJzdGFuZGluZyBmcm9tIEN5cmlsJ3MgY29tbWVu
dHMgaXMgbm8gbmVlZCByZXNlcnZlIG1vcmUgaHVnZXBhZ2VzLAo+ID4gc2luY2UKPiA+IHRoaXMg
dGVzdCBjYXNlIE9OTFkgYWxsb2NhdGUgMSBwYWdlIHRocm91Z2ggbW1hcC4KPiAKPiAKPiBJdCBk
ZXBlbmRzIG9uIHdoYXQgeW91IHdhbnRlZCB0aGVyZSwgaWYgb25seSAxIGdlbmVyYWwgaHVnZSBw
YWdlLAo+ICBgZWNobyAxID4gL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlc2Agd2lsbCB0cnkgdG8g
cmVzZXJ2ZSAxCj4gZnJvbSBhIE5VTUEgbm9kZSByYW5kb21seS4KVGhhbmtzIGZvciB5b3VyIHZh
bHVhYmxlIGluZm9ybWF0aW9uLCBub3cgaSBndWVzcyBpIGZpbmQgb3V0IHdoeSAKb3JpZ2luYWwg
Y29kZSB1c2luZyAyICogbm9kZS0+Y250IGluc3RlYWQgb2YgMSwgaXQgdHJ5IHRvIG1ha2UgCnN1
cmUgZXZlcnkgbm9kZSBoYXZlIGF0IGxlYXN0IHJlc2VydmUgc29tZSBwYWdlcy4KPiAKPiBCdXQg
aWYgeW91IHByZWZlciB0byBnZXQgMSBodWdlcGFnZSBmcm9tIGEgc3BlY2lmaWVkIG5vZGUsIHdl
IG5lZWQ6Cj4gIGBlY2hvIDEgPgo+IC9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlJXUvaHVn
ZXBhZ2VzL2h1Z2VwYWdlcy0lZGtCL25yX2h1Z2VwYWdlc2AKPiAKPiBIb3dldmVyLCBib3RoIHdh
eXMgd29uJ3QgZ3VhcmFudGVlIHRoZSByZXNlcnZhdGlvbiB3aWxsIGJlIDEwMCUgc3VjY2Vzc2Z1
bCwKPiB3aGljaCBpcyBiYXNlZCBvbiB0aGUgbWVtb3J5IGZyYWdtZW50YXRpb24gc2l0dWF0aW9u
cy4KPiAKPiBUbyBiZSBvbiB0aGUgc2FmZSBzaWRlLCBJIHdvdWxkIHN1Z2dlc3QgdXNpbmcgTFRQ
IHVuaWZpZWQgQVBJIHRvIHJlc2VydmU6Cj4gaHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3Qt
cHJvamVjdC9sdHAvYmxvYi9tYXN0ZXIvZG9jL29sZC9DLVRlc3QtQVBJLmFzY2lpZG9jIzEzNC1y
ZXNlcnZpbmctaHVnZXBhZ2VzCj4gCj4gWW91IGNvdWxkIHJlZmVyZW5jZSB1c2FnZSBmcm9tOgo+
ICAgbWVtL2h1Z2V0bGIvaHVnZW1tYXAvaHVnZW1tYXAxNi5jLAo+ICAgc3lzY2FsbHMvbW92ZV9w
YWdlcy9tb3ZlX3BhZ2VzMTIuYwpUaGlzIGNhc2UgaXMgY2hlY2sgYWxsb2NhdGUgbWVtb3J5IG9u
IHNwZWNpZmljIG5vZGUsIHNvIGlmIHdlIHNldCAuaHVnZXBhZ2VzID0gezEsIFRTVF9ORUVEU30s
IAp0aGVuIDEgcGFnZSB3aWxsIHJlc2VydmUgb24gTlVNQSBub2RlIHJhbmRvbWx5LCB0aGF0IG1l
YW5zIGNhc2Ugc3RpbGwgaGFzIGNoYW5jZSB0byBmYWlsLgpBbHNvIGkgZ3Vlc3MgY3VycmVudCAu
aHVnZXBhZ2VzIGNhbiBub3Qgc3VwcG9ydCAiLmh1Z2VwYWdlcyA9IHsyICogbm9kZS0+Y250LCBU
U1RfTkVFRFN9IgpTbyB0aGUgZWFzeSB3YXkgaXMga2VlcCB2NiBpbXBsZW1lbnRhdGlvbiBsaWtl
IGZvbGxvd2luZzoKU0FGRV9GSUxFX1BSSU5URigiL3Byb2Mvc3lzL3ZtL25yX2h1Z2VwYWdlcyIs
ICIlZCIsIDIgKiBub2RlLT5jbnQpOwoKQ29ycmVjdCBtZSBpZiBhbnkgbWlzdW5kZXJzdGFuZGlu
Zy4KPiAKPiAKPiAKPiA+Cj4gPiBAQ3lyaWwgY291bGQgeW91IGhlbHAgY29uZmlybSB0aGlzPwo+
ID4KPiA+ID4KPiA+ID4gS2luZCByZWdhcmRzLAo+ID4gPiBQZXRyCj4gPgo+ID4gLS0KPiA+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+ID4K
PiA+Cj4gCj4gLS0gCj4gUmVnYXJkcywKPiBMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
