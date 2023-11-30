Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D12AC4167B
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 10:12:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41BE13CD625
	for <ltp@archiver.kernel.org>; Thu, 30 Nov 2023 11:12:54 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D2C03CC93A
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 11:12:43 +0100 (CET)
Received: from mail-qv1-xf2e.google.com (mail-qv1-xf2e.google.com
 [IPv6:2607:f8b0:4864:20::f2e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3DA79207CEF
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 11:12:43 +0100 (CET)
Received: by mail-qv1-xf2e.google.com with SMTP id
 6a1803df08f44-67a545a9462so4034546d6.0
 for <ltp@lists.linux.it>; Thu, 30 Nov 2023 02:12:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1701339162; x=1701943962; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yiOiTsAhC/GddQtEHoguqHfFubUt1i21XOCUKPPwAoA=;
 b=V0Fl7mPp4wWBC2F31SdwQTURkBP7btcdYOi3tqifG+BrAWUtTuOwbPkVpR18yuSlr7
 sWrYza/7kjS8Rea+j1OPXo55dgSkhR1Hj7GNHt/9+gc8LXy6DchZEJxzQff/Wt1BhYae
 90Rc/j+5EOk6bXORSWfNHE5ISl9KXSYwQ8uBxznYsVnKRWcYkuXPuzk1EgRvGGRelMrV
 yXOafzW4/qlFN8n6u8sSExmyDxhXt7SKVcMIAr6DGziZJ6tj4bZKWm66Ru/eTBJx4SjP
 RuHNrU7l4Ior7EjKS3j2WtSd3kD/N3mRosEhG3jN07tsLLkM3WrIhYFk0fYze5tJ9uJ/
 chvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1701339162; x=1701943962;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yiOiTsAhC/GddQtEHoguqHfFubUt1i21XOCUKPPwAoA=;
 b=NirnHVcoK0pLjuwpOCSskAxgC0A8hi88y7l84KHtOfxPSK4T61zvbyc+jHVXZtGEPn
 dnufBfIaTz9sLvJ74dJAuzl741ToNZZsvQckisHUXl4c96fXdTv+dduhBEKghDBXvehb
 iFDr7akbfALC8KOLK4e4sK0hh3RJ6yfwfSZcFV3h08zapXi3ZIP4fb8aDiSmwGZPhaZI
 WWhMsJ2WS/58DawTL7lAYVPFIDS3Rx7/TVdrVhAreDgb2EcLNJktH3CxfbJ+zEnDB6eU
 nHkz6RM6zF4JW3tM3mZJgRKz84yd2+xm4hcRP3asYHWQFhakobpbiLHpjAekT0yJmIkk
 5F5g==
X-Gm-Message-State: AOJu0YxVxTdZrDr+nB45jARO+QUCIy+GSQGNW3tcdSoOtP9usQ2omAhh
 /fHXc/W98nixAC0IqWSpnZjM6XKsockUHgk8sOU=
X-Google-Smtp-Source: AGHT+IFMHOxV+I/eQyy7Aqr1OFeVHoBn7eURLyUaaDgBIugVAax3aRbN4THUXeB+YQIp1JQhmuorDZ+3FB6adkrQCPQ=
X-Received: by 2002:ad4:504e:0:b0:67a:1f8c:9157 with SMTP id
 m14-20020ad4504e000000b0067a1f8c9157mr20275027qvq.17.1701339162064; Thu, 30
 Nov 2023 02:12:42 -0800 (PST)
MIME-Version: 1.0
References: <20231130093533.10036-1-jack@suse.cz>
 <20231130093711.20171-2-jack@suse.cz>
In-Reply-To: <20231130093711.20171-2-jack@suse.cz>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 30 Nov 2023 12:12:31 +0200
Message-ID: <CAOQ4uxiAaizGGGHAUaBNjf-r9qAEJZpUeuaopfVtqBazegJrTA@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/7] fanotify: Print more details on error from
 fanotify_flags_supported_on_fs()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBOb3YgMzAsIDIwMjMgYXQgMTE6MzfigK9BTSBKYW4gS2FyYSA8amFja0BzdXNlLmN6
PiB3cm90ZToKPgo+IFByaW50IG1vcmUgZGV0YWlscyBhYm91dCBmYWlsaW5nIGNhbGxzIGZyb20K
PiBmYW5vdGlmeV9mbGFnc19zdXBwb3J0ZWRfb25fZnMoKS4KPgo+IFNpZ25lZC1vZmYtYnk6IEph
biBLYXJhIDxqYWNrQHN1c2UuY3o+CgpSZXZpZXdlZC1ieTogQW1pciBHb2xkc3RlaW4gPGFtaXI3
M2lsQGdtYWlsLmNvbT4KCj4gLS0tCj4gIHRlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZmFub3Rp
ZnkvZmFub3RpZnkuaCB8IDkgKysrKysrLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlv
bnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9m
YW5vdGlmeS9mYW5vdGlmeS5oCj4gaW5kZXggZjM0NDQwZTBiZDQxLi4zYjg4MzhlOGRkNjggMTAw
NjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5o
Cj4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeS5oCj4g
QEAgLTE5NSw3ICsxOTUsOSBAQCBzdGF0aWMgaW5saW5lIGludCBmYW5vdGlmeV9mbGFnc19zdXBw
b3J0ZWRfb25fZnModW5zaWduZWQgaW50IGluaXRfZmxhZ3MsCj4gICAgICAgICAgICAgICAgIGlm
IChlcnJubyA9PSBFTk9TWVMpCj4gICAgICAgICAgICAgICAgICAgICAgICAgdHN0X2JyayhUQ09O
RiwgImZhbm90aWZ5IG5vdCBjb25maWd1cmVkIGluIGtlcm5lbCIpOwo+ICAgICAgICAgICAgICAg
ICBpZiAoZXJybm8gIT0gRUlOVkFMKQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHRzdF9icmso
VEJST0sgfCBURVJSTk8sICJmYW5vdGlmeV9pbml0KCkgZmFpbGVkIik7Cj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgdHN0X2JyayhUQlJPSyB8IFRFUlJOTywKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICJmYW5vdGlmeV9pbml0KCV4LCBPX1JET05MWSkgZmFpbGVkIiwKPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluaXRfZmxhZ3MpOwo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gLTE7Cj4gICAgICAgICB9Cj4KPiBAQCAtMjA0LDggKzIwNiw5IEBAIHN0YXRpYyBp
bmxpbmUgaW50IGZhbm90aWZ5X2ZsYWdzX3N1cHBvcnRlZF9vbl9mcyh1bnNpZ25lZCBpbnQgaW5p
dF9mbGFncywKPiAgICAgICAgICAgICAgICAgICAgICAgICBydmFsID0gc3RyY21wKGZuYW1lLCBP
VkxfTU5UKSA/IC0yIDogLTM7Cj4gICAgICAgICAgICAgICAgIH0gZWxzZSBpZiAoZXJybm8gIT0g
RUlOVkFMKSB7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgdHN0X2JyayhUQlJPSyB8IFRFUlJO
TywKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJmYW5vdGlmeV9tYXJrICglZCwg
RkFOX01BUktfQURELCAuLi4sIEFUX0ZEQ1dELCAlcykgZmFpbGVkIiwKPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIGZkLCBmbmFtZSk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAiZmFub3RpZnlfbWFyayAoJWQsIEZBTl9NQVJLX0FERCB8ICV4LCAlbGx4LCBBVF9G
RENXRCwgJXMpIGZhaWxlZCIsCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBmZCwg
bWFya19mbGFncywgKHVuc2lnbmVkIGxvbmcgbG9uZylldmVudF9mbGFncywKPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGZuYW1lKTsKPiAgICAgICAgICAgICAgICAgfSBlbHNlIHsK
PiAgICAgICAgICAgICAgICAgICAgICAgICBydmFsID0gLTE7Cj4gICAgICAgICAgICAgICAgIH0K
PiAtLQo+IDIuMzUuMwo+CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGlu
dXguaXQvbGlzdGluZm8vbHRwCg==
