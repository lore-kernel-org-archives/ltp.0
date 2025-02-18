Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0040FC02198
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 12:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1739881638; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=FstddlL8IsizcU/P1Qe1N7Q2yROJ/DZqr2Bltf2TTWM=;
 b=dqJoviQ/okFwoTdrHhZjoFz/qy1znRmFk92/jVhF8GOUkBdE0UHffFhWF4PXeGzvUwdmN
 RMXUJZpLc/1G2JMP7ST47loBKvWgWqdu3ClGqeHPCGfVnfH3oZElvH7JoZMHOqI15cif1Af
 +PvA9nSLNWPFyy25O+38xOEV2oKxMYw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53F043C9C88
	for <ltp@archiver.kernel.org>; Tue, 18 Feb 2025 13:27:18 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6E6E03C91B5
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:26:56 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6B9D720004B
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 13:26:55 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-38f2f783e4dso2957109f8f.3
 for <ltp@lists.linux.it>; Tue, 18 Feb 2025 04:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1739881615; x=1740486415; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j0FkIFgsA7VhG6nM6VrTuTRe3HnB+toTyMvMB0U0wCc=;
 b=DOdV1DjQd03Hq0wI29JBR7HQA0hS/cId0HpS2md30jT0QPh2vMqtXQIUtY6/qmXuvc
 XzfaPu/hKuW5710nT6HSR5ReWEhhm0gh5381vBwXS5N3wTEbn944HQo06mLv6v/R1YJ8
 LYJNh8rLWIZfqiPnrqnxApnV8KzjfCn4MvmJWJFLejlKyy6LpOc1i3zRrvE2I0azqDWx
 9WWZMOdwxyXUBm83Wj4EFoLl5CzWnbXd1vjjgqCx6iXeDSYrzgHuDYiNxx//eDgSbwFJ
 JOnTQGQZ236ehLsfqlqDzR6z/nyO/Uxd5YJB8LcoMc9tmKz8rDcTuqb9+w6My1SHEtRO
 v0TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739881615; x=1740486415;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j0FkIFgsA7VhG6nM6VrTuTRe3HnB+toTyMvMB0U0wCc=;
 b=PwmsW+06otVYCFy4RHDQLewXtUnLVpvfCSRJbRtHTo3AVQY6zFdnhK6z8iK6Yy7sMw
 5TZZL6Z1IV4kcGPUxwUzplVuyxlKwq9+NYsuA8tVYGu7KBybA7QeHh8XGvQntKWl0/JT
 qJTSda0GGZyA1+TAKkq6mmZYr89nY95mZLgPH5DYRMvHo6Tl9ccdTbm7bZJ3ws6LtHUZ
 F+TaxB2mT4ZSdInZRoQHwUkz3sAN/SnGHWFPIJBhqv90xicghIAfKAl2kDNNYYH0S3tJ
 SICMpADtD0XJ+O1MHDq+kwJSBjHO2L/WVc0y7KHoewC8OVMd0oa35vnjaqkyV7Se/VbM
 Hb3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIeZgAOq/XN538Obv9+t3gT6w9aarDviihUCmJeXrmgOJA8FbHZ0e6A9Y7w9Cyji2bHDs=@lists.linux.it
X-Gm-Message-State: AOJu0YxjJvPm6IMxh+PYvWTvzKueEsrjkcf7TEGbq8Yh0c+8T8GRCO7V
 L8hE54IvZsYsDwx3QZH614/ibXUS9gGyKfEkU+mRh6mNU4U7sgdpijnPAC9WPZvG7Dtm8qb3Qfr
 X
X-Gm-Gg: ASbGnctoJdHSocYoi+4isBDw1TBc7de58yONyTX6m8S7m7U1wvSrw+6auB2qKbBBWHL
 1g/rR/e4KfsHyf+y+m+f5Zvn3FdRj1zcVDVl2sDD2wYxamAnV3ds/JentATsnbur480Vr880mi2
 aSsDhAFC7NRvQdmeSFfRGtQ1fhjA9WMA17CEanZS3Bl8aLMzQeh7jFvGOiAi7suynBi6sKBW7Xn
 OPKm8A0sliLGataEsYxF8QB8poqxP9b8lHo5hkYYedlvInzldAPpKhzHNtQlixRXiSo+TKa7kh1
 C+fVB4cE4fDCSKCipmgeTercbg==
X-Google-Smtp-Source: AGHT+IEgD3JnMvZAKw/OfpMqV93d/r09FUyt0S/BGKELFlZeRA8FWzxAJXP5q2p7iWymGV2pphkpcA==
X-Received: by 2002:a5d:6d8e:0:b0:38f:3e39:20a1 with SMTP id
 ffacd0b85a97d-38f3e392fa2mr6784299f8f.11.1739881614807; 
 Tue, 18 Feb 2025 04:26:54 -0800 (PST)
Received: from [10.232.133.75] ([88.128.90.10])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f258b43d4sm14643427f8f.4.2025.02.18.04.26.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Feb 2025 04:26:53 -0800 (PST)
Message-ID: <4af38d4e-37b2-4730-824a-af137e95ff23@suse.com>
Date: Tue, 18 Feb 2025 13:26:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <ricardo@marliere.net>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250217-conversions-pause-v1-0-be8be41cb154@marliere.net>
 <20250217-conversions-pause-v1-2-be8be41cb154@marliere.net>
Content-Language: en-US
In-Reply-To: <20250217-conversions-pause-v1-2-be8be41cb154@marliere.net>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/pause03: Refactor into new API
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCgpPbiAyLzE3LzI1IDIzOjAxLCBSaWNhcmRvIEIuIE1hcmxpw6hyZSB3cm90ZToKPiBTaWdu
ZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmljYXJkb0BtYXJsaWVyZS5uZXQ+Cj4g
LS0tCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDMuYyB8IDExNCAr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyNSBpbnNl
cnRpb25zKCspLCA4OSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDMuYyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMv
cGF1c2UvcGF1c2UwMy5jCj4gaW5kZXggNDU5MjIyMDQ1YzA4ZGMxZmM0ODA0ZWZkMmVjZTAyMzE2
ZmU1NWEwZS4uNjQxNjEwYTc4MjkwZGUxZjI1YzFmODM4OGM3ZWM1MDIzZGQwMDE4MCAxMDA2NDQK
PiAtLS0gYS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3BhdXNlL3BhdXNlMDMuYwo+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvcGF1c2UvcGF1c2UwMy5jCj4gQEAgLTEsMTA0ICsx
LDQwIEBACj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4g
ICAvKgo+ICAgICogQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVz
ICBDb3JwLiwgMjAwMQo+IC0gKiAgMDcvMjAwMSBQb3J0ZWQgYnkgV2F5bmUgQm95ZXIKPiAtICoK
PiAtICogVGhpcyBwcm9ncmFtIGlzIGZyZWUgc29mdHdhcmU7ICB5b3UgY2FuIHJlZGlzdHJpYnV0
ZSBpdCBhbmQvb3IgbW9kaWZ5Cj4gLSAqIGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIEdl
bmVyYWwgUHVibGljIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5Cj4gLSAqIHRoZSBGcmVlIFNvZnR3
YXJlIEZvdW5kYXRpb247IGVpdGhlciB2ZXJzaW9uIDIgb2YgdGhlIExpY2Vuc2UsIG9yCj4gLSAq
IChhdCB5b3VyIG9wdGlvbikgYW55IGxhdGVyIHZlcnNpb24uCj4gLSAqCj4gLSAqIFRoaXMgcHJv
Z3JhbSBpcyBkaXN0cmlidXRlZCBpbiB0aGUgaG9wZSB0aGF0IGl0IHdpbGwgYmUgdXNlZnVsLAo+
IC0gKiBidXQgV0lUSE9VVCBBTlkgV0FSUkFOVFk7ICB3aXRob3V0IGV2ZW4gdGhlIGltcGxpZWQg
d2FycmFudHkgb2YKPiAtICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElD
VUxBUiBQVVJQT1NFLiAgU2VlCj4gLSAqIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZSBm
b3IgbW9yZSBkZXRhaWxzLgo+IC0gKgo+IC0gKiBZb3Ugc2hvdWxkIGhhdmUgcmVjZWl2ZWQgYSBj
b3B5IG9mIHRoZSBHTlUgR2VuZXJhbCBQdWJsaWMgTGljZW5zZQo+IC0gKiBhbG9uZyB3aXRoIHRo
aXMgcHJvZ3JhbTsgIGlmIG5vdCwgd3JpdGUgdG8gdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
biwKPiAtICogSW5jLiwgNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBN
QSAwMjExMC0xMzAxIFVTQQo+ICsgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwg
MjAyNQo+ICsgKiAwNy8yMDAxIFBvcnRlZCBieSBXYXluZSBCb3llcgpIZXJlIHdlIGFyZSBtaXNz
aW5nIHRoZSAiQ29weXJpZ2h0IChjKSBJbnRlcm5hdGlvbmFsIEJ1c2luZXNzIE1hY2hpbmVzwqAg
CkNvcnAuLCAyMDAxIiBjb3B5cmlnaHQgc3RyaW5nIGJlZm9yZSBjcmVkaXQuIEFsc28sIHRoZSAi
UG9ydGVkIiBtZXNzYWdlIApzaG91bGQgYmUgYWxpZ25lZCB0byB0aGUgY29weXJpZ2h0IHdpdGgg
YSB0YWIuIFlvdSBjYW4gYWRkIHlvdXIgb3duIApjcmVkaXQgYXMgd2VsbCBsaWtlIGluIHRoZSBw
cmV2aW91cyBwYXRjaC4KPiAgICAqLwo+ICsKPiAgIC8qCk1pc3NpbmcgZG9jdW1lbnRhdGlvbiAv
Klwgc3RyaW5nLgo+IC0gKiBUZXN0IERlc2NyaXB0aW9uOgo+IC0gKiAgcGF1c2UoKSBkb2VzIG5v
dCByZXR1cm4gZHVlIHRvIHJlY2VpcHQgb2YgU0lHS0lMTCBzaWduYWwgYW5kIHNwZWNpZmllZAo+
IC0gKiAgcHJvY2VzcyBzaG91bGQgYmUgdGVybWluYXRlZC4KPiArICogVGhpcyB0ZXN0IHZlcmlm
aWVzIHRoYXQgcGF1c2UoKSBkb2VzIG5vdCByZXR1cm4gYWZ0ZXIgcmVjZWl2aW5nIGEgU0lHS0lM
TAo+ICsgKiBzaWduYWwsIGF0IHdoaWNoIHBvaW50IHRoZSBwcm9jZXNzIHNob3VsZCBiZSB0ZXJt
aW5hdGVkLgo+ICAgICovCj4gLSNpbmNsdWRlIDx1bmlzdGQuaD4KPiAtI2luY2x1ZGUgPGVycm5v
Lmg+Cj4gLSNpbmNsdWRlIDxmY250bC5oPgo+IC0jaW5jbHVkZSA8c3lzL3dhaXQuaD4KPiAtCj4g
LSNpbmNsdWRlICJ0ZXN0LmgiCj4gLSNpbmNsdWRlICJzYWZlX21hY3Jvcy5oIgo+IC0KPiAtc3Rh
dGljIHBpZF90IGNwaWQ7Cj4gLQo+IC1jaGFyICpUQ0lEID0gInBhdXNlMDMiOwo+IC1pbnQgVFNU
X1RPVEFMID0gMTsKPiAgIAo+IC1zdGF0aWMgdm9pZCBkb19jaGlsZCh2b2lkKTsKPiAtc3RhdGlj
IHZvaWQgc2V0dXAodm9pZCk7Cj4gLXN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCk7Cj4gKyNpbmNs
dWRlICJ0c3RfdGVzdC5oIgo+ICAgCj4gLWludCBtYWluKGludCBhYywgY2hhciAqKmF2KQo+ICt2
b2lkIHJ1bih2b2lkKQo+ICAgewo+IC0JaW50IGxjOwo+ICAgCWludCBzdGF0dXM7Cj4gKwlwaWRf
dCBwaWQ7Cj4gICAKPiAtCXRzdF9wYXJzZV9vcHRzKGFjLCBhdiwgTlVMTCwgTlVMTCk7Cj4gLQo+
IC0Jc2V0dXAoKTsKPiAtCj4gLQlmb3IgKGxjID0gMDsgVEVTVF9MT09QSU5HKGxjKTsgbGMrKykg
ewo+IC0JCXRzdF9jb3VudCA9IDA7Cj4gLQo+IC0JCWlmICgoY3BpZCA9IHRzdF9mb3JrKCkpID09
IC0xKQo+IC0JCQl0c3RfYnJrbShUQlJPSyB8IFRFUlJOTywgTlVMTCwgImZvcmsoKSBmYWlsZWQi
KTsKPiAtCj4gLQkJaWYgKGNwaWQgPT0gMCkKPiAtCQkJZG9fY2hpbGQoKTsKPiAtCj4gLQkJVFNU
X1BST0NFU1NfU1RBVEVfV0FJVChjbGVhbnVwLCBjcGlkLCAnUycpOwo+IC0KPiAtCQlraWxsKGNw
aWQsIFNJR0tJTEwpOwo+IC0KPiAtCQlTQUZFX1dBSVQoTlVMTCwgJnN0YXR1cyk7Cj4gLQo+IC0J
CWlmIChXSUZTSUdOQUxFRChzdGF0dXMpICYmIFdURVJNU0lHKHN0YXR1cykgPT0gU0lHS0lMTCkg
ewo+IC0JCQl0c3RfcmVzbShUUEFTUywgInBhdXNlKCkgZGlkIG5vdCByZXR1cm4gYWZ0ZXIgU0lH
S0lMTCIpOwo+IC0JCQljb250aW51ZTsKPiAtCQl9Cj4gLQo+IC0JCWlmIChXSUZTSUdOQUxFRChz
dGF0dXMpKSB7Cj4gLQkJCXRzdF9yZXNtKFRGQUlMLCAiY2hpbGQga2lsbGVkIGJ5ICVzIHVuZXhw
ZWN0ZWRseSIsCj4gLQkJCSAgICAgICAgIHRzdF9zdHJzaWcoV1RFUk1TSUcoc3RhdHVzKSkpOwo+
IC0JCQljb250aW51ZTsKPiAtCQl9Cj4gLQo+IC0JCXRzdF9yZXNtKFRGQUlMLCAiY2hpbGQgZXhp
dGVkIHdpdGggJWkiLCBXRVhJVFNUQVRVUyhzdGF0dXMpKTsKPiArCXBpZCA9IFNBRkVfRk9SSygp
Owo+ICsJaWYgKCFwaWQpIHsKPiArCQlwYXVzZSgpOwo+ICsJCXRzdF9yZXMoVEZBSUwsICJVbmV4
cGVjdGVkIHJldHVybiBmcm9tIHBhdXNlKCkiKTsKV2UgY2FuIHVzZSBUU1RfRVhQX1BBU1MocGF1
c2UoKSkKPiArCQlleGl0KDApOwo+ICAgCX0KPiAgIAo+IC0JY2xlYW51cCgpOwo+IC0JdHN0X2V4
aXQoKTsKPiArCVRTVF9QUk9DRVNTX1NUQVRFX1dBSVQocGlkLCAnUycsIDEwMDAwKTsKPiArCWtp
bGwocGlkLCBTSUdLSUxMKTsKPiArCVNBRkVfV0FJVFBJRChwaWQsICZzdGF0dXMsIDApOwo+ICAg
Cj4gKwlpZiAoV0lGU0lHTkFMRUQoc3RhdHVzKSAmJiBXVEVSTVNJRyhzdGF0dXMpID09IFNJR0tJ
TEwpCj4gKwkJdHN0X3JlcyhUUEFTUywgInBhdXNlKCkgZGlkIG5vdCByZXR1cm4gYWZ0ZXIgU0lH
S0lMTCIpOwo+ICsJZWxzZQo+ICsJCXRzdF9yZXMoVEZBSUwsICJDaGlsZCBleGl0ZWQgd2l0aCAl
aSIsIFdFWElUU1RBVFVTKHN0YXR1cykpOwo+ICAgfQo+ICAgCj4gLXZvaWQgZG9fY2hpbGQodm9p
ZCkKPiAtewo+IC0JVEVTVChwYXVzZSgpKTsKPiAtCj4gLQl0c3RfcmVzbShURkFJTCwgIlVuZXhw
ZWN0ZWQgcmV0dXJuIGZyb20gcGF1c2UoKSIpOwo+IC0KPiAtCWV4aXQoMCk7Cj4gLX0KPiAtCj4g
LXZvaWQgc2V0dXAodm9pZCkKPiAtewo+IC0JdHN0X3NpZyhGT1JLLCBERUZfSEFORExFUiwgY2xl
YW51cCk7Cj4gLQo+IC0JVEVTVF9QQVVTRTsKPiAtfQo+IC0KPiAtCj4gLXZvaWQgY2xlYW51cCh2
b2lkKQo+IC17Cj4gLQlraWxsKGNwaWQsIFNJR0tJTEwpOwo+IC19Cj4gK3N0YXRpYyBzdHJ1Y3Qg
dHN0X3Rlc3QgdGVzdCA9IHsKPiArCS50ZXN0X2FsbCA9IHJ1biwKPiArCS5mb3Jrc19jaGlsZCA9
IDEsCj4gK307CkFuZHJlYQoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxp
bnV4Lml0L2xpc3RpbmZvL2x0cAo=
