Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ABB7CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:01:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755846112; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vLEV0mLBzI5oXs9lZd+1B5UjFYVsMlFvgbLyU+vkHGc=;
 b=iCmPFtYKtv931iphTSl//xurigrewe3MVWmQ/wjQ/oRzb1sSrQ2F22CAC8G2iiPbssCbC
 SZLrY05SqkV87B3Y68phqNdBjGJwdUwhW0c2IpyCI4YzwWDK9TjA1qLWuH3A4+hP+NtXdV9
 4+RGM8DNDJzbNKoF1wygxberi8fvtx0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 499F63CCE57
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 09:01:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 891253C07BB
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:01:31 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 89E731A00346
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:01:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755846088;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YbZabpTKloiAP26XSszoJng27lgzvSTU6Kfu5rwm99o=;
 b=Y04oENLPycVV12WMjsxm2jVKwuYuZJJ3FxJn4NcfUHJfV03VXwpQ5iA0C0VeIENAlnq+6T
 eRpjb0Z0lawI8y4YZGzBAjW7cZQG3d0fs6+4MHX1HJ5+WMAnl/+jJbB4WH63i/W3wCoewc
 qWlOuAzTqLuc7ArXhO37NEbMvs/Ww7U=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-5HklxljWOVuAs2B3K-SJMQ-1; Fri, 22 Aug 2025 03:01:26 -0400
X-MC-Unique: 5HklxljWOVuAs2B3K-SJMQ-1
X-Mimecast-MFC-AGG-ID: 5HklxljWOVuAs2B3K-SJMQ_1755846085
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-32515e8e4b3so661156a91.2
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 00:01:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755846085; x=1756450885;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YbZabpTKloiAP26XSszoJng27lgzvSTU6Kfu5rwm99o=;
 b=Au/qATyJKDCEb0K4m+tF3iwPynqUNG5zb4wEui7e/cVpTraMz001ZDn5gdg8nN9wZX
 Pzlh6uHGVvgAZR6LG9f4meQuZ8valIRxSX6Lm3KeoFLRc0mK3OWUIdKj2qXcSy+W1uUC
 R1w8WbgEz9V0DtHjKBmxK9PM6fMqZPkJf+ao7cYD1Qc2saVfTNMNVfrkwk1zClosR/l1
 cFEmkOlBy11oLkk16SxNkQKZq07nNjXpQHiaPw6RcL15GK8A9EA34DsL/HjxdCZMtizc
 Qtp7nN1M3jfdE9zEDoFPRGY4CXeosoy0N1IkJLu1PnHC+XD/iP/7TE7gwVFa3VkhPYiw
 Xkjw==
X-Gm-Message-State: AOJu0Yyv9f1QQhOQwtailo074LCiDK1NS5UYyDyXT3DWfVcD8ZarSMlr
 P80yffQJ26xrvUXLn/C2Adn7rPVb3M1jDEtI0JawO3HEjnoMLzUzsNwU99BDITeUH1a5G10zC4q
 +sZSObTDJBg/oxhw4aRWq4Iq9AUyRlAZUl37CSXavn6ZKofc0f4Nr3gQA/BAW7kIFpfmBBmp1uw
 PUGpud1F5zbOVAWfjZMBO6Puy4g9M=
X-Gm-Gg: ASbGncszHERJe6ex2tNoD9BtggprzascR6hB0fmKjRgwUuXOW8kIp5reu6ov9SednF9
 3zymYtIDuI5GyVKGfFa+ondml/rpZewaKiwe436x8msXouUveSNZr3ks2ly9a0lZSUEAVir+hJH
 Y1Vmhta/E6VtZACKYose8PLw==
X-Received: by 2002:a17:90a:ec84:b0:31e:3bbc:e9e6 with SMTP id
 98e67ed59e1d1-32517749935mr3212935a91.19.1755846085182; 
 Fri, 22 Aug 2025 00:01:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoy9AFZURc4J23Bu1uYNHW9ry7vwf0rMef8YEr7ZFwRgGaBFlR7hawusUSt7Msez5vZIloZR/kftYXrzpQLHw=
X-Received: by 2002:a17:90a:ec84:b0:31e:3bbc:e9e6 with SMTP id
 98e67ed59e1d1-32517749935mr3212863a91.19.1755846084566; Fri, 22 Aug 2025
 00:01:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250822040501.28640-1-wegao@suse.com>
 <20250822063331.28886-1-wegao@suse.com>
 <20250822063331.28886-2-wegao@suse.com>
In-Reply-To: <20250822063331.28886-2-wegao@suse.com>
Date: Fri, 22 Aug 2025 15:01:10 +0800
X-Gm-Features: Ac12FXwft6h2_MvTsLz31WSFD2e76RpYh-Um7sjSlBNryeTlPsgtcESI8KpyZnU
Message-ID: <CAEemH2fw1Oa2GyaigQqNtc0YtM4X6USAvyjO_L9+dWdcrH=fVg@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sn33Pohh6AHJyzt5P9IxTekqDFqGIzS1fujW14bEsJE_1755846085
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v4 1/2] tst_device.c: Add tst_is_mounted_ro/w
 check mount option
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

T24gRnJpLCBBdWcgMjIsIDIwMjUgYXQgMjozM+KAr1BNIFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29t
PiB3cm90ZToKCj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gLS0t
Cj4gIGluY2x1ZGUvdHN0X2RldmljZS5oIHwgIDIgKysKPiAgbGliL3RzdF9kZXZpY2UuYyAgICAg
fCA0OCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ICAyIGZp
bGVzIGNoYW5nZWQsIDUwIGluc2VydGlvbnMoKykKPgo+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3Rz
dF9kZXZpY2UuaCBiL2luY2x1ZGUvdHN0X2RldmljZS5oCj4gaW5kZXggMjU5N2ZiNGUyLi4zZWE3
YjU1MDAgMTAwNjQ0Cj4gLS0tIGEvaW5jbHVkZS90c3RfZGV2aWNlLmgKPiArKysgYi9pbmNsdWRl
L3RzdF9kZXZpY2UuaAo+IEBAIC0zNCw2ICszNCw4IEBAIGludCB0c3RfdW1vdW50KGNvbnN0IGNo
YXIgKnBhdGgpOwo+ICAgKi8KPiAgaW50IHRzdF9pc19tb3VudGVkKGNvbnN0IGNoYXIgKnBhdGgp
Owo+ICBpbnQgdHN0X2lzX21vdW50ZWRfYXRfdG1wZGlyKGNvbnN0IGNoYXIgKnBhdGgpOwo+ICtp
bnQgdHN0X2lzX21vdW50ZWRfcm8oY29uc3QgY2hhciAqcGF0aCk7Cj4gK2ludCB0c3RfaXNfbW91
bnRlZF9ydyhjb25zdCBjaGFyICpwYXRoKTsKPgo+ICAvKgo+ICAgKiBDbGVhcnMgYSBmaXJzdCBm
ZXcgYmxvY2tzIG9mIHRoZSBkZXZpY2UuIFRoaXMgaXMgbmVlZGVkIHdoZW4gZGV2aWNlIGhhcwo+
IGRpZmYgLS1naXQgYS9saWIvdHN0X2RldmljZS5jIGIvbGliL3RzdF9kZXZpY2UuYwo+IGluZGV4
IDZkMWFiZjA2NS4uN2Y5YTJiMmY2IDEwMDY0NAo+IC0tLSBhL2xpYi90c3RfZGV2aWNlLmMKPiAr
KysgYi9saWIvdHN0X2RldmljZS5jCj4gQEAgLTQ3Myw2ICs0NzMsNTQgQEAgaW50IHRzdF9pc19t
b3VudGVkX2F0X3RtcGRpcihjb25zdCBjaGFyICpwYXRoKQo+ICAgICAgICAgcmV0dXJuIHRzdF9p
c19tb3VudGVkKG1wYXRoKTsKPiAgfQo+Cj4gK3N0YXRpYyBpbnQgdHN0X21vdW50X2hhc19vcHQo
Y29uc3QgY2hhciAqcGF0aCwgY29uc3QgY2hhciAqb3B0KQo+ICt7Cj4gKyAgICAgICBjaGFyIGxp
bmVbUEFUSF9NQVhdOwo+ICsgICAgICAgRklMRSAqZmlsZTsKPiArICAgICAgIGludCByZXQgPSAw
Owo+ICsgICAgICAgY2hhciBhYnNwYXRoW1BBVEhfTUFYXTsKPiArCj4gKyAgICAgICBpZiAoIXJl
YWxwYXRoKHBhdGgsIGFic3BhdGgpKSB7Cj4gKyAgICAgICAgICAgICAgIHRzdF9yZXNtKFRXQVJO
IHwgVEVSUk5PLCAicmVhbHBhdGgoJXMpIGZhaWxlZCIsIHBhdGgpOwo+ICsgICAgICAgICAgICAg
ICByZXR1cm4gMDsKPiArICAgICAgIH0KPiArCj4gKyAgICAgICBmaWxlID0gU0FGRV9GT1BFTihO
VUxMLCAiL3Byb2MvbW91bnRzIiwgInIiKTsKPiArCj4gKyAgICAgICB3aGlsZSAoZmdldHMobGlu
ZSwgc2l6ZW9mKGxpbmUpLCBmaWxlKSkgewo+ICsgICAgICAgICAgICAgICBjaGFyIG1vdW50X3Bv
aW50W1BBVEhfTUFYXSwgb3B0aW9uc1tQQVRIX01BWF07Cj4gKwo+ICsgICAgICAgICAgICAgICBp
ZiAoc3NjYW5mKGxpbmUsICIlKnMgJXMgJSpzICVzIiwgbW91bnRfcG9pbnQsIG9wdGlvbnMpIDwK
PiAyKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOwo+ICsKPiArICAgICAgICAg
ICAgICAgaWYgKHN0cmNtcChtb3VudF9wb2ludCwgYWJzcGF0aCkgIT0gMCkKPiArICAgICAgICAg
ICAgICAgICAgICAgICBjb250aW51ZTsKPiArCj4gKyAgICAgICAgICAgICAgIGNoYXIgKnRvayA9
IHN0cnRvayhvcHRpb25zLCAiLCIpOwo+ICsgICAgICAgICAgICAgICB3aGlsZSAodG9rKSB7Cj4g
KyAgICAgICAgICAgICAgICAgICAgICAgaWYgKHN0cmNtcCh0b2ssIG9wdCkgPT0gMCkgewo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0ID0gMTsKPiArICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIGJyZWFrOwo+ICsgICAgICAgICAgICAgICAgICAgICAgIH0KPiArICAg
ICAgICAgICAgICAgICAgICAgICB0b2sgPSBzdHJ0b2soTlVMTCwgIiwiKTsKPiArICAgICAgICAg
ICAgICAgfQo+ICsgICAgICAgICAgICAgICBpZiAocmV0KQo+ICsgICAgICAgICAgICAgICAgICAg
ICAgIGJyZWFrOwo+ICsgICAgICAgfQo+ICsKPgoKUGF0Y2ggc2V0IHB1c2hlZCB3aXRoIG1pbm9y
IGFkanVzdG1lbnRzLCB0aGFuayB5b3UuCgorICAgICAgIFNBRkVfRkNMT1NFKE5VTEwsIGZpbGUp
OwoKKyAgICAgICByZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICtpbnQgdHN0X2lzX21vdW50ZWRfcm8o
Y29uc3QgY2hhciAqcGF0aCkKPiArewo+ICsgICAgICAgcmV0dXJuIHRzdF9tb3VudF9oYXNfb3B0
KHBhdGgsICJybyIpOwo+ICt9Cj4gKwo+ICtpbnQgdHN0X2lzX21vdW50ZWRfcncoY29uc3QgY2hh
ciAqcGF0aCkKPiArewo+ICsgICAgICAgcmV0dXJuIHRzdF9tb3VudF9oYXNfb3B0KHBhdGgsICJy
dyIpOwo+ICt9Cj4gKwo+ICBzdGF0aWMgaW50IGZpbmRfc3RhdF9maWxlKGNvbnN0IGNoYXIgKmRl
diwgY2hhciAqcGF0aCwgc2l6ZV90IHBhdGhfbGVuKQo+ICB7Cj4gICAgICAgICBjb25zdCBjaGFy
ICpkZXZuYW1lID0gc3RycmNocihkZXYsICcvJykgKyAxOwo+IC0tCj4gMi40My4wCj4KPgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
