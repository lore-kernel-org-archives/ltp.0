Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB094CD98DA
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 11:27:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 40AA93E5970
	for <ltp@archiver.kernel.org>; Tue, 16 Jun 2026 13:27:50 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5C5193C2B0D
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:27:33 +0200 (CEST)
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C68791A007B0
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 13:27:32 +0200 (CEST)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so6808973a12.1
 for <ltp@lists.linux.it>; Tue, 16 Jun 2026 04:27:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1781609252; cv=none;
 d=google.com; s=arc-20240605;
 b=ghzh/vrDiJhNMp8wRsVPNPTiW8/Uy97IQAB87miAeVxU/zsO82NF9WanNE267IMG0K
 1Uw/1iUXFflXzFA72lu+1COuu2SiLADcIt57H+hYVwCr0YgkMXReKtUke1VQ3bMlt6/V
 9xCphIAlxiMY9p/7GK2TWbwKD83DlbHgVjmqcUchp+NwDgyu68F4KyeXdzBCZgjHSZn4
 Vv9t+voCVsAn+W4sAavaCV8qco7aPezzpG7dn7VPoM1PMYburoTImZnBWJdNDS+76+X/
 yT6yUOYlSEdXH7laa5ocHQG39y/ta6fz2k0fMpvKO2pM2/qu534jEtnAjj/OE8d+RL29
 kPJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=dzXKbokt7wsuPkNeJsGUc9OFMirXjLFfvJWs1FY3bwY=;
 fh=kwEKwHe0660m1gqhpHtsIqKTcbrzJpDwURmEfCqRgIU=;
 b=BER4uH30xShg4mOVF/Xtf5GJPYgJS5RC1BCt11CzR9mg94/U5vsYUwK/e8LMGNwqDW
 IQJcMcWIaBFj7Z/0pzFDXX7Q93pyau0/NGLAWPPNjlrd0/ap6ZSEX+SPq6XB1GLqnLjm
 D4qB2hV+oFsIcGOKJFvEY2EaWt4ZHesr/VOLefLnPPl9aOX5ROIm7bO0QX8cP50+hbun
 wbiaY3o7fO6UWl2NrDcoAGQ+qfr5mdrak+Cjs33qOqiKEXng7ifg1HsUJPdDaq2E9MAB
 cOcmt3Yvlr7ZKuMrxW5OkZuirZ7hcg7LyH+cRqIxPxTAIoc4JbL/wZ82Da4IFXolt6cl
 zGtw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781609252; x=1782214052; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dzXKbokt7wsuPkNeJsGUc9OFMirXjLFfvJWs1FY3bwY=;
 b=BsP4WNi5JMQDlETwEl+xm611OFGrq7usVsM5sDe69w/Tts13ZgzMgZRpXmdSJSWkct
 0kPMjHJpCTPnkbqReJIvf1GRGfFk4GFmMsg3aC2sQLL9qWUUxq7KlOYGJid3WTQX65iY
 AkU5AuTgJz9la1MaU8d/t7vgn+NTN7Vvn03exEpMQoeBHqrR2lvYIdAr9KeB+RuHnZSB
 UtjzEKkzBeEW7hoHRhY8wdvLkyhCmJQPPNgha/Y99HpXZtOpFjWlLPHA+SlcW1LMyKkH
 zgMH43VTIOt6csgvEJ7m6Q6rTmAhBxWtX3HNapUj4SwoebBUZUWR7M4AaSDrdwadBhX2
 34tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781609252; x=1782214052;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dzXKbokt7wsuPkNeJsGUc9OFMirXjLFfvJWs1FY3bwY=;
 b=Ho05dQjuc61UbNGBlqnaUot+l7jneckC1IvX+AaLNEowgN4li8wyZjealdOtvR5yip
 dwPfbIMKu1Ddy2UrhwbxdJZEXbWuD/VuKaPTqwpnYOANonYuOuYfHhtEh5erS5jE2Ekz
 qqSh2IFPnNupCMq92TtcyKRRNoxDDiLdvHK4qFanHr+LmYOdkMvyLm+LKvX19G/iP0x8
 sMz6qKgC2Td9jopIGrUKFM0J5cTHvc/si39o6zVHFXyjpU08wZAxz7OrHNAQFMCOa3Tg
 ZOf3zYssyMVLIGHxGr5N6oRl4rla4LBYFjoag2pPi52egRmGulm0kjOfH0FhMtlwo8x4
 2ygA==
X-Forwarded-Encrypted: i=1;
 AFNElJ85hlCtqjyy83bAXBcwjWJZHCerjdhpmC9ulZ46RPqvbWCI9v1HL47e+Xg6Z3MdGlhWOAU=@lists.linux.it
X-Gm-Message-State: AOJu0Yw2z7rQ4hHp0gQYpjTEWBS1sYCJkIiKQSB1j6992UHY+1reGX9d
 laZXyNpLzqJMFhLgNixDmOVk1TCYmyjOVFlRJniSlie9XFnPMATv678xoTLjrRtjRzpEYy3mOwp
 pFMTBqTeHHpWg6DQ5gdub2INp/JistCA=
X-Gm-Gg: Acq92OENGXrYco7xIY+IO4766CHvO+9vTQf1t3w3HxWU6e/Tq2K7/i+3w2bcTIC7q2T
 SyHJY6Hy/5/oGINV+hd0ibZ2/y8OhUYoaaVrLVsxryFTlEY0Pgge1PT2aK2q/CgZ2MQK0MLSvkF
 JqK4CXfugDblIwY7qcpxkgrGeIq68JNJQB4OUsftuPXCBI9Ey13eAloOYrsH7RObPy/swT4yR9v
 W7YVO46wGc1oLL0OgDkEd5fO/YgDIOsPoUozuMObinpSB3UN3kvpTb3XTYdKdWsc6zr07EeGVir
 InTBt8C3N2KM1ZBJsxdRbk0bqZKXa5zX91tnZh5S7g==
X-Received: by 2002:a05:6402:3219:b0:693:2a2:9e41 with SMTP id
 4fb4d7f45d1cf-695087dead8mr1785443a12.19.1781609251941; Tue, 16 Jun 2026
 04:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <em6fgj3mkdyapnpi5yszfj563gwjoehyxxo6mk6cwiyyydkiah@vpunmf3gm5nt>
 <20260615180629.7148-1-anonymemeow@gmail.com>
 <20260615180629.7148-2-anonymemeow@gmail.com>
 <ate4q7znqlhitd4y5wsrxx2rtq7u6btfeheep6svgvw5zhtbbn@y7cau7ke55ij>
In-Reply-To: <ate4q7znqlhitd4y5wsrxx2rtq7u6btfeheep6svgvw5zhtbbn@y7cau7ke55ij>
From: Amir Goldstein <amir73il@gmail.com>
Date: Tue, 16 Jun 2026 13:27:20 +0200
X-Gm-Features: AVVi8CfjH4pV5A_KIp3lA3zV2ZMjGe3AxCPVfsLmUkDVBLuyBTi5Q2nrpRFhnDQ
Message-ID: <CAOQ4uxhnrH3=XsCBhuO3oYtS=pZcRjkAchtrVwtnfJzBVmpNfQ@mail.gmail.com>
To: Jan Kara <jack@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] fanotify20: Allow FAN_REPORT_PIDFD with
 FAN_REPORT_TID on v7.2+
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
Cc: ltp@lists.linux.it, AnonymeMeow <anonymemeow@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVHVlLCBKdW4gMTYsIDIwMjYgYXQgOTo0MOKAr0FNIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+
IHdyb3RlOgo+Cj4gT24gVHVlIDE2LTA2LTI2IDAyOjA2OjI1LCBBbm9ueW1lTWVvdyB3cm90ZToK
PiA+IGZhbm90aWZ5X2luaXQoKSB1c2VkIHRvIHJlamVjdCBGQU5fUkVQT1JUX1BJREZEIGNvbWJp
bmVkIHdpdGgKPiA+IEZBTl9SRVBPUlRfVElEIHdpdGggRUlOVkFMLiBTaW5jZSBMaW51eCB2Ny4y
LCBmYW5vdGlmeSBzdXBwb3J0cwo+ID4gcmVwb3J0aW5nIHBpZGZkcyBmb3IgdGhyZWFkIElEcywg
c28gdGhpcyBjb21iaW5hdGlvbiBpcyBleHBlY3RlZCB0bwo+ID4gc3VjY2VlZC4KPiA+Cj4gPiBL
ZWVwIGV4cGVjdGluZyBFSU5WQUwgb24gb2xkZXIga2VybmVscyBhbmQgYWRqdXN0IHRoZSB0ZXN0
IGV4cGVjdGF0aW9uCj4gPiBiYXNlZCBvbiB0aGUgcnVubmluZyBrZXJuZWwgdmVyc2lvbi4KPiA+
Cj4gPiBTaWduZWQtb2ZmLWJ5OiBBbm9ueW1lTWVvdyA8YW5vbnltZW1lb3dAZ21haWwuY29tPgo+
Cj4gVGhhbmtzIGZvciB0aGUgZml4ZXMhIFNvbWUgY29tbWVudCBiZWxvdy4gQW5kIHRha2UgeW91
ciB0aW1lIHdpdGggZmluYWwKPiBleGFtcywgdGhhdCdzIG1vcmUgaW1wb3J0YW50IHRoYW4gc29t
ZSBmYWlsaW5nIExUUCB0ZXN0cyA6KQo+Cj4gPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5l
bC9zeXNjYWxscy9mYW5vdGlmeS9mYW5vdGlmeTIwLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2Nh
bGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MjAuYwo+ID4gaW5kZXggYjMyZWNmNmFhLi45YTc4ZjZmZjAg
MTAwNjQ0Cj4gPiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90
aWZ5MjAuYwo+ID4gKysrIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9mYW5vdGlmeS9mYW5v
dGlmeTIwLmMKPiA+IEBAIC04LDEzICs4LDE0IEBACj4gPgo+ID4gIC8qXAo+ID4gICAqIFRoaXMg
c291cmNlIGZpbGUgY29udGFpbnMgYSB0ZXN0IGNhc2Ugd2hpY2ggZW5zdXJlcyB0aGF0IHRoZQo+
ID4gLSAqIDptYW5wYWdlOmBmYW5vdGlmeSg3KWAgQVBJIHJldHVybnMgYW4gZXhwZWN0ZWQgZXJy
b3IgY29kZSB3aGVuIHByb3ZpZGVkIGFuCj4gPiAtICogaW52YWxpZCBpbml0aWFsaXphdGlvbiBm
bGFnIGFsb25nc2lkZSBGQU5fUkVQT1JUX1BJREZELiBBZGRpdGlvbmFsbHksIGl0Cj4gPiAtICog
Y2hlY2tzIHRoYXQgdGhlIG9wZXJhYmlsaXR5IHdpdGggZXhpc3RpbmcgRkFOX1JFUE9SVF8qIGZs
YWdzIGlzIG1haW50YWluZWQKPiA+IC0gKiBhbmQgZnVuY3Rpb25pbmcgYXMgaW50ZW5kZWQuCj4g
PiArICogOm1hbnBhZ2U6YGZhbm90aWZ5KDcpYCBBUEkgcmV0dXJucyBhbiBleHBlY3RlZCBlcnJv
ciBjb2RlIHdoZW4gcHJvdmlkZWQKPiA+ICsgKiB1bnN1cHBvcnRlZCBpbml0aWFsaXphdGlvbiBm
bGFncywgZS5nLiBGQU5fUkVQT1JUX1BJREZEIGNvbWJpbmVkIHdpdGgKPiA+ICsgKiBGQU5fUkVQ
T1JUX1RJRC4gQWRkaXRpb25hbGx5LCBpdCBjaGVja3MgdGhhdCB0aGUgb3BlcmFiaWxpdHkgd2l0
aAo+ID4gKyAqIHN1cHBvcnRlZCBGQU5fUkVQT1JUXyogZmxhZ3MgaXMgbWFpbnRhaW5lZCBhbmQg
ZnVuY3Rpb25pbmcgYXMgaW50ZW5kZWQuCj4gPiAgICoKPiA+ICAgKiBOT1RFOiBGQU5fUkVQT1JU
X1BJREZEIHN1cHBvcnQgd2FzIGFkZGVkIGluIHY1LjE1LXJjMSBpbgo+ID4gICAqIGFmNTc5YmVi
NjY2YSAoImZhbm90aWZ5OiBhZGQgcGlkZmQgc3VwcG9ydCB0byB0aGUgZmFub3RpZnkgQVBJIiku
Cj4gPiArICogRkFOX1JFUE9SVF9QSURGRCBjb21iaW5lZCB3aXRoIEZBTl9SRVBPUlRfVElEIGlz
IHN1cHBvcnRlZCBzaW5jZSB2Ny4yLXJjMS4KCkNhbiBhZGQgdGhlIHVwc3RyZWFtIGNvbW1pdCBo
ZXJlLgoKPiA+ICAgKi8KPiA+Cj4gPiAgI2RlZmluZSBfR05VX1NPVVJDRQo+ID4gQEAgLTI2LDgg
KzI3LDEwIEBACj4gPgo+ID4gICNkZWZpbmUgTU9VTlRfUEFUSCAgICJmc19tbnQiCj4gPiAgI2Rl
ZmluZSBGTEFHU19ERVNDKHgpIC5mbGFncyA9IHgsIC5kZXNjID0gI3gKPiA+ICsjZGVmaW5lIFBJ
REZEX1RJRF9GTEFHUyAoRkFOX1JFUE9SVF9QSURGRCB8IEZBTl9SRVBPUlRfVElEKQo+ID4KPiA+
ICBzdGF0aWMgaW50IGZkOwo+ID4gK3N0YXRpYyBpbnQgdGhyZWFkX3BpZGZkX3N1cHBvcnRlZDsK
PiA+Cj4gPiAgc3RhdGljIHN0cnVjdCB0ZXN0X2Nhc2VfdCB7Cj4gPiAgICAgICB1bnNpZ25lZCBp
bnQgZmxhZ3M7Cj4gPiBAQCAtNTEsMTcgKzU0LDIxIEBAIHN0YXRpYyB2b2lkIGRvX3NldHVwKHZv
aWQpCj4gPiAgICAgICAgKi8KPiA+ICAgICAgIFJFUVVJUkVfRkFOT1RJRllfSU5JVF9GTEFHU19T
VVBQT1JURURfT05fRlMoRkFOX1JFUE9SVF9QSURGRCwKPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTU9VTlRfUEFUSCk7Cj4gPiArCj4gPiArICAg
ICB0aHJlYWRfcGlkZmRfc3VwcG9ydGVkID0gdHN0X2t2ZXJjbXAoNywgMiwgMCkgPj0gMDsKPiA+
ICB9Cj4gPgo+ID4gIHN0YXRpYyB2b2lkIGRvX3Rlc3QodW5zaWduZWQgaW50IGkpCj4gPiAgewo+
ID4gICAgICAgc3RydWN0IHRlc3RfY2FzZV90ICp0YyA9ICZ0ZXN0X2Nhc2VzW2ldOwo+ID4gKyAg
ICAgaW50IGV4cF9lcnJubyA9ICh0Yy0+ZmxhZ3MgJiBQSURGRF9USURfRkxBR1MpID09IFBJREZE
X1RJRF9GTEFHUyAmJgo+ID4gKyAgICAgICAgICAgICAgICAgICAgIHRocmVhZF9waWRmZF9zdXBw
b3J0ZWQgPyAwIDogdGMtPmV4cF9lcnJubzsKPiA+Cj4gPiAtICAgICB0c3RfcmVzKFRJTkZPLCAi
VGVzdCAlcyBvbiAlcyIsIHRjLT5leHBfZXJybm8gPyAiZmFpbCIgOiAicGFzcyIsCj4gPiArICAg
ICB0c3RfcmVzKFRJTkZPLCAiVGVzdCAlcyBvbiAlcyIsIGV4cF9lcnJubyA/ICJmYWlsIiA6ICJw
YXNzIiwKPiA+ICAgICAgICAgICAgICAgdGMtPmRlc2MpOwo+ID4KPiA+ICAgICAgIFRTVF9FWFBf
RkRfT1JfRkFJTChmZCA9IGZhbm90aWZ5X2luaXQodGMtPmZsYWdzLCBPX1JET05MWSksCj4gPiAt
ICAgICAgICAgICAgICAgICAgICAgICAgdGMtPmV4cF9lcnJubyk7Cj4gPiArICAgICAgICAgICAg
ICAgICAgICAgICAgZXhwX2Vycm5vKTsKPgo+IEh1bSwgdGhpcyBsb29rcyBzb21ld2hhdCB1Z2x5
LiBJZGVhbGx5IHdlJ2QgaW5pdGlhbGl6ZSB0ZXN0IGNhc2UgLmV4cF9lcnJubwo+IGFjY29yZGlu
Z2x5IHRvIHRoZSBleHBlY3RlZCByZXR1cm4gb2YgdGhlIHN5c2NhbGwgKGJ1dCB0aGF0J3Mgbm90
IHJlYWxseQo+IHBvc3NpYmxlIGJlY2F1c2UgdGhlIGluaXRpYWxpemVyIGhhcyB0byBiZSBjb25z
dGFudCkuIENoZWNraW5nIGhvdyBvdGhlcgo+IHRlc3RzIGhhbmRsZSBpdCwgSSB0aGluayB3ZSBj
YW4gY2xvbmUgdGhlIHRlc3RzIHRvIHR3by4gT25lIHRoYXQgZXhwZWN0cwo+IGZhaWx1cmUgYW5k
IGlzIHNraXBwZWQgZm9yIGtlcm5lbHMgPj0gNy4yIGFuZCBvbmUgdGhhdCBleHBlY3RzIHN1Y2Nl
c3MgYW5kCj4gaXMgc2tpcHBlZCBmb3Iga2VybmVscyA8IDcuMi4gQW5kIHdlIGNhbiBoYXZlIGlu
IHRoZSB0ZXN0IGRlc2NyaXB0aW9uCj4gLm1pbl9rdmVyIGFuZCAubWF4X2t2ZXIgZmllbGRzIHRo
YXQgd291bGQgc3RvcmUgZm9yIHdoaWNoIGtlcm5lbCB2ZXJzaW9ucwo+IHRoZSB0ZXN0IHNob3Vs
ZCBiZSBwZXJmb3JtZWQuCgpMT0wgdGhlcmUgaXMgbm90aGluZyB0byB0ZXN0IGluIHRoZSA+PSA3
LjIgdGVzdC4KClRoZSB0ZXN0IHRoYXQgdGhlc2UgZmxhZyBjb21iaW5hdGlvbiBhcmUgYWxsb3dl
ZDoKICAgICAgICAgICAgICAgIEZMQUdTX0RFU0MoRkFOX1JFUE9SVF9QSURGRCB8IEZBTl9SRVBP
UlRfVElEKSwKICAgICAgICAgICAgICAgIEZMQUdTX0RFU0MoRkFOX1JFUE9SVF9QSURGRCB8IEZB
Tl9SRVBPUlRfRklEIHwKRkFOX1JFUE9SVF9ERklEX05BTUUpLAoKSXMgYWxyZWFkeSAidGVzdGVk
IiBieSB0aGUgdGVzdHMgdGhhdCB1c2UgdGhlbS4KYW5kIHdlIGRvbid0IGhhdmUgYW55IHRlc3Rz
IHRoYXQgPj0gNS4xMCBoYXMgc3VwcG9ydCBmb3IKRkFOX01BUktfRklMRVNZU1RFTSBldGMuCgpF
YXNpZXN0IGlzIHRvIGp1c3Qgc2tpcCBmYW5vdGlmeTIwIGZvciB2ZXJzaW9uID49IDcuMgoKVGhh
bmtzLApBbWlyLgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
