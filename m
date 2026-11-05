Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E451606A32E
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 08:05:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ZuMf+sAM;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X/XY9+l0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793865933; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ZdpzrNeEIsBpE8Bi7l4ivpxwe9aTZY1ZC0czH3hs+ZA=;
 b=ZuMf+sAMWsqMybGAv0WEqaMIxwXaUdtfiqiUByx673l+tf4ecUdXESQuZdKDXiW/adva3
 Pre/v88bsasOFgoqXLe3+p9CXEL0KxCk93ktsbqEQf3VAnlHjvGehL9Y5A5rT8MqLVB9GtB
 4ZBI2fG+vCCshWbU46nlG8T+YmUssDE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B6773CB27C
	for <ltp@archiver.kernel.org>; Thu,  5 Nov 2026 09:05:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 247033C22F5
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 09:05:14 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 78F281400DA3
 for <ltp@lists.linux.it>; Thu,  5 Nov 2026 09:05:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793865911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AD9gjD5Q4Qnxfm4TZtQlJGuyS1cnoIziGVo78c1dIyI=;
 b=X/XY9+l06JyYMnFjnC4gTggfy7ZQN2bXOCJIzf5o8MA/W5SKBtXSIInXLDIG48S+RTrrOc
 tXHH/ggRPOFiXi1BsihYuJUdYPbnVENOR32aDTC9q6Au8IA99JPMjodZ7QFEg8Q5/n6rD3
 +JiFla09zvIrsBSnVuMDKZc+063lmSA=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-246-hikif8lXOWiK4aNSRgphbg-1; Thu, 05 Nov 2026 03:05:10 -0500
X-MC-Unique: hikif8lXOWiK4aNSRgphbg-1
X-Mimecast-MFC-AGG-ID: hikif8lXOWiK4aNSRgphbg_1793865909
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-8b0cd41e7aaso25540277b3.3
 for <ltp@lists.linux.it>; Thu, 05 Nov 2026 00:05:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793865909; x=1794470709;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=AD9gjD5Q4Qnxfm4TZtQlJGuyS1cnoIziGVo78c1dIyI=;
 b=igD48nDE3GqiVWsElMbsMAofHZjZtH5pCn5WG+Ku1Lt7/yzDLodWQJvcsCylsEdaY6
 n705r6ddSHtOAdcGKN3SekNgM6zkeVlv1dJY9F225DNQOatYCbFqmChZHTp90NjIOvdK
 oFedPzRlDPuv/gsqIvQAojTOZCD3ReH8mapzqI/SqnrtnSvXLIorLgkQDgD/K5l+UZz5
 lDopeGffsCXbc3kkotMNSuWcWQuXlBipqdn7Zu8u0A6WRdPStoYAFYOOf7Ng/rHZSUvO
 Bnh+XBxrnY1dWcL1cfQAvRZLJC5QG8qkjG63407gfH3hsqRS9y+uhjFVZScg+cFnN+AK
 B4sQ==
X-Gm-Message-State: APuU4Z9BRr6CU5ou3rxtZMMCoc9gbpTBYvkkgM/8DR7jRsGf2xSo9yXT
 ZmC1IRxjGgiTlgP1pBkOAyQAu1QqsR2wtxw/M3AsHFakwiO5Me+m5kfZipwqsNoIa8HfEEM+Ozm
 9us9sXFTNGFZbEwA0CTNbJ6m+7QBQdJZ7fcGpPrthFDsWYEICv13CqjDCbrxXz3wwUPdltjwcbK
 AuNgAMORx+SjGUZjga/KKvi+yMTrbr9BAo1dc=
X-Gm-Gg: AYBFou2Xr78FieVQI+Uv6A9MCsfUF7jMLojP/IJDAIfPhZD0zBoOtN/L99/XfV+50QM
 oyPq1OH7RJLmBf+fSDrwi2L8emu67/jw0xkDt6gEp34vLBlPuMWYlHKYfIpn+tXGUROJqzYyAjQ
 Mw5F/QycUrwpdTHozEwQ6rTiyDP9oP8Gb7imwUYwFtAWBRmaOd2KS1u0rXadCD+E+IjeT2Ta2DT
 P7twxlu8ZJcNBAkajvB3CxEFRD432q8oWfAqOhvNmVctEerHW0=
X-Received: by 2002:a05:690c:c6d1:b0:8b0:cc41:a12b with SMTP id
 00721157ae682-8b2b6740d19mr82887867b3.38.1793865909432; 
 Thu, 05 Nov 2026 00:05:09 -0800 (PST)
X-Received: by 2002:a05:690c:c6d1:b0:8b0:cc41:a12b with SMTP id
 00721157ae682-8b2b6740d19mr82887797b3.38.1793865908830; Thu, 05 Nov 2026
 00:05:08 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261102105704.1577364-1-afazekas@redhat.com>
 <auteByNCMzYWA5uV@yuki.lan>
In-Reply-To: <auteByNCMzYWA5uV@yuki.lan>
Date: Thu, 5 Nov 2026 09:04:57 +0100
X-Gm-Features: AclHuK_3LeczrA99JkK2gK7X8xdqKGAWnpxRWEKXyt7mCB1-kp9b8-PrEc4V2hg
Message-ID: <CAMTxPK0ZBX8gRmpWNfbQ+8jYhZuzKnSxCN3yefdROA+dw4da0g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ptSqE5I_nzcM8yGKtsv96sQhZaVWhG9OfoyEblu9EAI_1793865909
X-Mimecast-Originator: redhat.com
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] mmap22: Bound child memory allocation to avoid OOM
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Attila Fazekas via ltp <ltp@lists.linux.it>
Reply-To: Attila Fazekas <afazekas@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBOb3YgNCwgMjAyNiBhdCA1OjQx4oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IEFzc2lzdGVkLWJ5OiBHZW1pbmkgQ0xJCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBBdHRpbGEgRmF6ZWthcyA8YWZhemVrYXNAcmVkaGF0LmNvbT4KPiA+IC0tLQo+
ID4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYyB8IDcgKysrKystLQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4gPgo+
ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbW1hcC9tbWFwMjIuYwo+
IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFwL21tYXAyMi5jCj4gPiBpbmRleCAwYjk1
YzU3OGYuLjE2ZmNiNmRkOCAxMDA2NDQKPiA+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvbW1hcC9tbWFwMjIuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9tbWFw
L21tYXAyMi5jCj4gPiBAQCAtMjYsNiArMjYsNyBAQAo+ID4KPiA+ICAjZGVmaW5lIE1FTV9MSU1J
VCAoMjU2ICogVFNUX01CKQo+ID4gICNkZWZpbmUgQUxMT0NfU0laRSAoMTI4ICogVFNUX01CKQo+
ID4gKyNkZWZpbmUgQ0hJTERfQUxMT0NfTUFYIChBTExPQ19TSVpFICsgMzIgKiBUU1RfTUIpCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBXb3VsZG4ndCB0aGlzIGJlIGJldHRlcjoKPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIChNRU1fTElNSVQgLSBBTExPQ19TSVpFICsgMzIqVFNUX01CKQo+Cj4gVGhpcyBpcyBiZXR0
ZXIsIEkgc2VudCB2Mi4KVGhhbmtzIGZvciB0aGUgcmV2aWV3LgoKCj4gVGhhdCB3YXkgdGhpcyB3
b3VsZCBzdGlsIHdvcmsgaWYgd2UgY2hhbmdlIGVpdGhlciBNRU1fTElNSVQgb3IKPiBBTExPQ19T
SVpFLgo+Cj4gT3RoZXJ3aXNlIHRoZSBjaGFuZ2UgbG9va3MgZ29vZC4KPgo+IC0tCj4gQ3lyaWwg
SHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRw
czovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
