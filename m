Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A15ABD5E133
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 11:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1765884323; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vXgWnFClzHp8UUKSDOT7NL9WvZgTJ5Lroqf/tCVcj3g=;
 b=pGwm7l916Fm+If5cgDdUWzwPaHO5VIN0NgatZHYQYUC0MKIvMlTaUp+5T9GE+KYLFH7NH
 nFBBctyDh+DNO73xN5LwzMRK/35uCKVnAjpLvE7MaA8NFS63MCjdnHJnwNLeAhd+g+BuXcD
 5f++xq0gGDp/o0MKF4nav9Ut4hyoMPc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 513243D0358
	for <ltp@archiver.kernel.org>; Tue, 16 Dec 2025 12:25:23 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D672E3D034B
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:24:50 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 1B0E1647872
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 12:24:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765884288;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=a3z/TiXRAXrehTJIvVkWfDniPqpUXhD6I5FkViO7kP0=;
 b=MzIDxWmkz3OaG+jOKk6hWMNdtVwlQFwjV0lveQGlicb4pM4d/tSBDD1cmUdaK+GMOY8oO6
 6KbMg1DWCsNrk8vmNBt+7CxBxPg9NiYVteYTMaYrHIdCEcDsjYxqVtN8RMCyBcbrECgDWH
 qWCceDhmmB7E9cMIgpintkWGAHdcRHw=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-492-WTLZ6yZTO06IA8OVfP-cxQ-1; Tue, 16 Dec 2025 06:24:47 -0500
X-MC-Unique: WTLZ6yZTO06IA8OVfP-cxQ-1
X-Mimecast-MFC-AGG-ID: WTLZ6yZTO06IA8OVfP-cxQ_1765884286
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-b630b4d8d52so4726150a12.3
 for <ltp@lists.linux.it>; Tue, 16 Dec 2025 03:24:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765884285; x=1766489085;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a3z/TiXRAXrehTJIvVkWfDniPqpUXhD6I5FkViO7kP0=;
 b=c04+2Mj3/bqNb0X7NoaeyqoJjHVm9gtHJ3cJzT7AMi47TXsgbL1GfzSTe5V2QXXTwe
 fzW/n8/cQWwhchUUW8X1mCT1T07cuB8fKqMoDIplm8+fOMYr4k+mvKRTLi5EEoDYRZVf
 T5KYjdyEPJ25sRpK0bz9Z5fzaMOtE5Vjh7OI1XEyUH86KbuSp19QwqgKNvuvVBeMOsva
 QKpljNoc/vNshPFjuo0ZBROmB5W4s7fI394FGq71hQqirHh63RpjDaJBoHabAEp25hvR
 MxRwO7DEW10EQfGLAt1pIUgKy1xdUHEohYO7UJPgrTxM1LLp1lRxrY80nmaj9A/i6/WH
 DaLw==
X-Gm-Message-State: AOJu0YyQwclUMb3yfFIEFYuNK4nui08FHxMI7e+ntPc7L1sBQ4WivECi
 xTvx7dN5239cVLDiHeYmjmmSWJqdepfI+X2UtFfTjvcagPBp2mPaexsySXZkcJmdD9Ga+9A8Z8h
 19xJzxcBblKGMlAm/OCa9m+Qhm020gLniQyYjc7mXTvu2YtHW62oju7qYnJxTC0+OkqVNxLIv51
 84P/UVviNf68kZZaXy7UTE73O5LfvHJuzdKO81JA==
X-Gm-Gg: AY/fxX63VmnRFTT1O2QUSUN1dFKR5byO/7D94mV42uuwBR1HtBJbDDyCvcmcaMYzqYQ
 0bvEXmbKVIChwNDqPCp6BS0zqKoodGWlDNJLS8ey5UfZ5a/v5uJOjA5bP5TbOFmpJokjNU1oZaL
 hncBUciQly4GvF8CE/lc7RGv06bU3jYJT9SivNBWo5c2UwwozreTIoBSWaxhzHVL7cGCQ=
X-Received: by 2002:a05:693c:40d0:b0:2ab:ca55:89ab with SMTP id
 5a478bee46e88-2ac3014dce6mr9256222eec.42.1765884285376; 
 Tue, 16 Dec 2025 03:24:45 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZfvKy/wZbBNWQ53oMi7cQ3bW8ZDJIkrNlGqa7E24w3a5Nh+XGlnI2NneToypSS8WQAAtpB/6tF1Us2ridnZc=
X-Received: by 2002:a05:693c:40d0:b0:2ab:ca55:89ab with SMTP id
 5a478bee46e88-2ac3014dce6mr9256195eec.42.1765884284571; Tue, 16 Dec 2025
 03:24:44 -0800 (PST)
MIME-Version: 1.0
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251215124404.16395-2-chrubis@suse.cz>
 <CAEemH2eDJf1OAF1q6WEegF4ZpSVjerYa2O7hp8hfd+7q=75gQQ@mail.gmail.com>
 <aUFBNIwaFo-YLPNR@yuki.lan>
In-Reply-To: <aUFBNIwaFo-YLPNR@yuki.lan>
Date: Tue, 16 Dec 2025 19:24:32 +0800
X-Gm-Features: AQt7F2rH7WZLpyxdP7I2ULYKx2-RWgLWgY39ZfU5WshUBER4WtpTAWEK_fG3d7s
Message-ID: <CAEemH2fX2_6HYLdTYspCdmMkJEYE01YGoGj9qYwQR6fpyUnRog@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VYTkAiF1cJdsuLNAn7ahr1b-biIOcuiUgDXb_kIskhI_1765884286
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 2/2] doc: Add ground rules page
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

T24gVHVlLCBEZWMgMTYsIDIwMjUgYXQgNzoyMuKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiBJdCdzIHJlYWxseSBnb29kIHRvIHdyaXRlIHRoZXNl
IHJ1bGVzIGRvd24sIGVzcGVjaWFsbHkgc2luY2UgbWFpbnRhaW5lcnMKPiA+IGNhbiByZXVzZSB0
aGVtIGluIHBhdGNoIHJldmlld3MgdG8gY29tbWVudCBvbiBpc3N1ZXMgYW5kIGF2b2lkIHJlcGVh
dGVkbHkKPiA+IHJlc3BvbmRpbmcgdG8gdGhlIHNhbWUgcXVlc3Rpb25zLiBCZWxvdyBhcmUgd2hh
dCBJIGNhbiB0aGluayBvZjoKPiA+Cj4gPiBEb27igJl0IHJlcXVpcmUgcm9vdCB1bmxlc3MgaXTi
gJlzIGVzc2VudGlhbAo+ID4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4gSWYgcm9v
dC9jYXBzIGFyZSBuZWVkZWQsIHNheSB3aHkgaW4gdGhlIHRlc3Qgb3V0cHV0LiBEcm9wIHByaXZp
bGVnZXMgZm9yCj4gPiB0aGUgcGFydCB0aGF0IGRvZXNu4oCZdCBuZWVkIHRoZW0gKGFuZCBhdm9p
ZCBydW5uaW5nIHRoZSB3aG9sZSB0ZXN0IGFzCj4gPiByb290IOKAnGJlY2F1c2UgaXTigJlzIGVh
c2llcuKAnSkuCj4gPgo+ID4KPiA+IEFsd2F5cyBjbGVhbiB1cCwgZXZlbiBvbiBmYWlsdXJlCj4g
PiA9PT09PT09PT09PT09PT09PT09PT09PT09PQo+ID4gRXZlcnkgdGVzdCBzaG91bGQgbGVhdmUg
dGhlIHN5c3RlbSBhcyBpdCBmb3VuZCBpdDogdW5tb3VudCwgcmVzdG9yZQo+IHN5c2N0bHMsCj4g
PiBkZWxldGUgdGVtcCBmaWxlcy9kaXJzLCBraWxsIHNwYXduZWQgcHJvY2Vzc2VzLCByZW1vdmUK
PiBjZ3JvdXBzL25hbWVzcGFjZXMsCj4gPiBkZXRhY2ggbG9vcCBkZXZpY2VzLCByZXN0b3JlIHVs
aW1pdHMsIGV0Yy4gQ2xlYW51cCBtdXN0IHJ1biBvbiBlYXJseS1leGl0Cj4gPiBwYXRocyB0b28u
Cj4gPgo+ID4KPiA+IFJlc3BlY3QgTFRQIHBvcnRhYmlsaXR5IGdvYWxzCj4gPiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT0KPiA+IEF2b2lkIG5vbnN0YW5kYXJkIGxpYmMgQVBJcyB3aGVuIGEg
cG9ydGFibGUgZXF1aXZhbGVudCBleGlzdHM7IGRvbuKAmXQKPiBhc3N1bWUKPiA+IDY0LWJpdCwK
PiA+IHBhZ2Ugc2l6ZSwgZW5kaWFubmVzcywgb3IgcGFydGljdWxhciB0b29sIHZlcnNpb25zLgo+
Cj4gU2hhbGwgSSBzZW5kIGEgVjMgd2l0aCB0aGVzZSBpbmNsdWRlZCwgb3IgZG8geW91IHdhbnQg
dG8gc2VuZCBhIHBhdGNoIG9uCj4gdGhlIHRvcCBvZiB0aGUgb25lIEkgc2VuZD8KPgoKQ3lyaWws
IHlvdSBjYW4gYWRkIHRob3NlIHRvcGljcyB3ZSBkaXNjdXNzZWQgaW50byB5b3VyIHBhdGNoIHYz
IGRpcmVjdGx5LgoKCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86
IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
