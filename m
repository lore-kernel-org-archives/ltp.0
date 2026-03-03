Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1FF6EC1423
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 10:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1772533730; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=NeTqhSuDax65sr7XQ4QFzgqoRFsGgI8gEB83SQYI1Gs=;
 b=dXzqdpBIQ4g3iC6Y+Vr3kRoIkP0tz3ikVDZLXVIsxBmqex2ZM6/K6dTlKSfctGgUW8TMy
 uGE7GfqPI7yBDAelIjcWmJ3NyLrX4wSc8MloLk+LSPWs4QZCMveAmJ8KbQqdeahQYSNlvl5
 7ZuZY5f1WK32MOjdPdFxZaRY+0A4IKk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F15F3D9EA0
	for <ltp@archiver.kernel.org>; Tue,  3 Mar 2026 11:28:50 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2FF2B3CD7CC
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:28:27 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 93C46600BC5
 for <ltp@lists.linux.it>; Tue,  3 Mar 2026 11:28:26 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4837634de51so22699145e9.1
 for <ltp@lists.linux.it>; Tue, 03 Mar 2026 02:28:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1772533706; x=1773138506; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=IqYbugZNUTKrPkBQZj6nAPrkSDE7eYIriBro+YSs9f0=;
 b=XZT7aTEwJQkzOGCxhQAd1Tds4tLu74etwZjKhCPNymmiZfgn3+MycZJs2k0oS8IvLS
 hPfBkg71w6JqummtbHwHSMFwvcppNN0LflW30maZ+kSJvnLbOBYyN2IEBvgZNbXwGpq6
 RIwcENYMgSkajmREAdza592Q8olzvJlDpQSVbXN+Ra3Q4sv4aTcDgfzg4xKMewHOj4zN
 adRKkhWkQC2uguWzdLO+D6BdKlGQt8MeU7oM8D/6m5zGkBJRre4Bwo1SPMc/GY2mLjSr
 LT8EGSF/szXpmL50La+DbFnkIcKYYGoARCpy8hUGQw5jurEDP/Ks/HcSCYChy6/lDmuC
 WMtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772533706; x=1773138506;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IqYbugZNUTKrPkBQZj6nAPrkSDE7eYIriBro+YSs9f0=;
 b=KC54Ssd1QwiRzoIZazln15WYpgFGf2AkcqTmN70RX5wd3FHoaSsOZuTFjeAM3G0hJf
 H4x/9SlulmE0GyBLvJzB6wy7wuMWvlrsiP/wm0uAY+UStEqoakJ7oeRsZpmkQrIQd2w1
 qB2pedqejWyN/EzHPkJX0jVgU51XZDZHJGtqC1Hh3JyPaHdJ4UkLKP/4ursu/9n7AqFA
 OtrQxLE2S1/1usyMWWVAC2goLWoh+xnzARLZP4kPrctHN590LxGQKLAMV0FQD3rjpgr4
 XYqphpwFcPZGhMFqmpcrlnhi+KnKLmXLwwSR7iDunb6kBC9SKUQEkBEnys0bOse3rGTL
 fumg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA2vjhg0//ij9IXQc/YYEJRkhE1bv70pxPnM1HQJpiZ62dchzRGcfp9QCFvZv6sK/D1C0=@lists.linux.it
X-Gm-Message-State: AOJu0Yw8TGC+KBPh7oYNL8zSoC6esTz5YjuBDElZDxgx1aEWmPRK3BG2
 aF1Jb0ApcAMfgzr0/b5BHmkO2XTsB8oTg+oLWThV8xVUNbQ47Y9s53w8NkR7pVttAl+kY+wTtsp
 3BuiWvQo=
X-Gm-Gg: ATEYQzzVIhAFuKC5DORsItUbskQDbpgBpYHtQh1HavK3HNAj3eNF/ZWF0sVRkmeRNxG
 RdT2gF0i/jbQRFE8DVdTYoT8sZnL9EM3K8ND/I7RTZWPo1tWm8v4Z/z8ccUDi4gJ8rWh94A+sZZ
 te+6vpkGnyX6Y6kYSoPk8nMXHZ5JC/pDXse2y0tHbY0f4KsXy5SEtYIt3jmpUlMwDjUWNXBLtbo
 +kuG5apNbG9NpcKyxxY74zQ4ropsvJq/E1SBpblILbCJEA93TKA0HhUEIeSTQ8W+/Yymv1EFlTW
 frmSwKxu4u3I3W2L4pdzI/6RP6bJ05XbSQJPNFWh3/ScRBdy976zu4DjypVUtJ/mp6+x4LBspp4
 PSdh6WAxlm7/D68MYp7qwxeJ4EtV+NEyWdZ0uPlF5Vjd90rC/C5l4hwbCKllQt4aaMJngRd/gFy
 7+1x2q37tsBhhuyFV0xYG3MowhcXC1nTTvlcahFSF9Tq9M2Zkb1r9spht+C0/m0QhzLV63UzotT
 KgFPhdyxfmVo6FQd7D8ciEV6xDRN3DAnqU=
X-Received: by 2002:a05:600c:1f91:b0:47e:e2ec:9947 with SMTP id
 5b1f17b1804b1-483c9c2d7d6mr261638765e9.33.1772533705919; 
 Tue, 03 Mar 2026 02:28:25 -0800 (PST)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b59723fesm14968930f8f.38.2026.03.03.02.28.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Mar 2026 02:28:25 -0800 (PST)
Message-ID: <69a6b7c9.df0a0220.2ea96.efef@mx.google.com>
To: "Li Wang" <liwang@redhat.com>, ltp@lists.linux.it
In-Reply-To: <20260303032311.38988-2-liwang@redhat.com>
Date: Tue, 03 Mar 2026 10:28:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/2] lib: Extend LTP_ENABLE_DEBUG to support
 verbosity levels
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgpJIHJhbiBhIHJldmlldyB3aXRoIG15IExMTSBjb25maWcgYW5kIG9idGFpbmVkIHRo
ZSBmb2xsb3dpbmcgcmVwb3J0LgpJIHRob3VnaHQgaXQgd2FzIGludGVyZXN0aW5nIHRvIHNoYXJl
IGhvdyB0aGUgTFRQIHJldmlldyBhZ2VudCBJJ20KZGV2ZWxvcGluZyBpcyBncm93aW5nLiBUZXN0
ZWQgd2l0aCBDbGF1ZGUgU29ubmV0IDQuNgoKIElzc3VlcyBGb3VuZAoKICAxLiAiRW5hYmxpbmcg
ZGVidWcgaW5mbyIgcHJpbnRlZCBmb3IgbGV2ZWwgMCDigJQgbWlzbGVhZGluZyBtZXNzYWdlCiAg
ICAgKHN0aWxsIHVuYWRkcmVzc2VkIGZyb20gdjEpCgogIEJvdGggLUQwIGFuZCBMVFBfRU5BQkxF
X0RFQlVHPTAgcHJpbnQgIkVuYWJsaW5nIGRlYnVnIGluZm8gKGxldmVsIDApIiwKICB3aGljaCBp
cyB0aGUgb3Bwb3NpdGUgb2Ygd2hhdCBpcyBoYXBwZW5pbmcuIExldmVsIDAgbWVhbnMgZGlzYWJs
ZSBhbGwKICBkZWJ1ZyBvdXRwdXQuIFRoaXMgd2FzIHJhaXNlZCBpbiB0aGUgdjEgcmV2aWV3IGFu
ZCByZW1haW5zIHVuZml4ZWQuCgogICQgLi9nZXRwaWQwMSAtRDAKICB0c3RfdGVzdC5jOjgzMzog
VElORk86IEVuYWJsaW5nIGRlYnVnIGluZm8gKGxldmVsIDApCgogIEFkZGl0aW9uYWxseSwgTFRQ
X0VOQUJMRV9ERUJVRz0wIGlzIGEgYmVoYXZpb3IgcmVncmVzc2lvbjogcHJldmlvdXNseQogIGl0
IHdhcyBzaWxlbnRseSBpZ25vcmVkIChubyBvdXRwdXQpLCBub3cgaXQgcHJpbnRzIGEgbWlzbGVh
ZGluZyAiRW5hYmxpbmciCiAgbWVzc2FnZS4gVGhlIGZpeCBmb3IgdGhlIC1EIHBhdGggaXMgdG8g
Z3VhcmQgdGhlIG1lc3NhZ2U6CgogIGlmIChjb250ZXh0LT50ZGVidWcpCiAgICAgIHRzdF9yZXMo
VElORk8sICJFbmFibGluZyBkZWJ1ZyBpbmZvIChsZXZlbCAlZCkiLCBjb250ZXh0LT50ZGVidWcp
OwoKICBTYW1lIGZpeCBuZWVkZWQgaW4gdGhlIGVudiB2YXIgcGF0aC4KCiAgMi4gTFRQX0VOQUJM
RV9ERUJVRyBzdGlsbCBzaWxlbnRseSBvdmVycmlkZXMgYSBtb3JlIHNwZWNpZmljIC1EIGZsYWcK
ICAgICDigJQgY29yZSBvcmRlcmluZyBpc3N1ZSB1bmZpeGVkIGZyb20gdjEKCiAgVGhlIGVudiB2
YXIgY2hlY2sgcnVucyBhZnRlciBwYXJzZV9vcHRzKCksIHNvIExUUF9FTkFCTEVfREVCVUcgYWx3
YXlzCiAgd2lucyBvdmVyIHRoZSBjb21tYW5kLWxpbmUgLUQgZmxhZzoKCiAgJCBMVFBfRU5BQkxF
X0RFQlVHPTEgLi9nZXRwaWQwMSAtRDIKICB0c3RfdGVzdC5jOjgzMzogVElORk86IEVuYWJsaW5n
IGRlYnVnIGluZm8gKGxldmVsIDIpICAg4oaQIGZyb20gLUQyCiAgdHN0X3Rlc3QuYzoxNDU3OiBU
SU5GTzogRW5hYmxpbmcgZGVidWcgaW5mbyAobGV2ZWwgMSkgIOKGkCBlbnYgdmFyIG92ZXJyaWRl
cyEKCiAgQW5kIGV2ZW4gZGlzYWJsaW5nIHZpYSB0aGUgZW52IHZhciBvdmVycmlkZXMgYW4gZXhw
bGljaXQgY29tbWFuZC1saW5lIGVuYWJsZToKICAkIExUUF9FTkFCTEVfREVCVUc9MCAuL2dldHBp
ZDAxIC1EMgogIHRzdF90ZXN0LmM6ODMzOiBUSU5GTzogRW5hYmxpbmcgZGVidWcgaW5mbyAobGV2
ZWwgMikgICDihpAgZnJvbSAtRDIKICB0c3RfdGVzdC5jOjE0NTc6IFRJTkZPOiBFbmFibGluZyBk
ZWJ1ZyBpbmZvIChsZXZlbCAwKSAg4oaQIGVudiB2YXIga2lsbHMgaXQKCiAgQ29tbWFuZC1saW5l
IHNob3VsZCB0YWtlIHByZWNlZGVuY2Ugb3ZlciBlbnZpcm9ubWVudCB2YXJpYWJsZXMuIFRoZQog
IGZpeCBpcyB0byBza2lwIHRoZSBlbnYgdmFyIGFzc2lnbm1lbnQgd2hlbiAtRCB3YXMgYWxyZWFk
eSB1c2VkOgoKICBpZiAodGRlYnVnX2VudiAmJiAhY29udGV4dC0+dGRlYnVnKSB7ICAgLyogb25s
eSBpZiAtRCB3YXNuJ3QgcGFzc2VkICovCiAgICAgIC4uLgogIH0KCiAgT3IsIG1vcmUgcm9idXN0
bHksIGNoZWNrIHRoZSBlbnYgdmFyIGJlZm9yZSBwYXJzZV9vcHRzKCkgc28gdGhlCiAgY29tbWFu
ZC1saW5lIG5hdHVyYWxseSB3aW5zLgoKClBvaW50IDEuIGlzIGNsZWFybHkgdHJ1ZSwgdGhlIFBv
aW50IDIuIG1pZ2h0IGJlIGEgZGVzaWduIGNob2ljZS4gSSBkb24ndAptaW5kIHRoZSBwcmlvcml0
eSBvZiBjb21tYW5kIGxpbmUgb3IgZW52IHZhcmlhYmxlLCBidXQgaXQncyBhY3R1YWxseQpjb3Jy
ZWN0IHRvIGFzc3VtZSB0aGF0IGVudiBzaG91bGQgYmUgc2tpcHBlZCBpZiAtRCBpcyBkZWZpbmVk
LgoKCktpbmQgcmVnYXJkcywKLS0KQW5kcmVhIENlcnZlc2F0bwpTVVNFIFFFIEF1dG9tYXRpb24g
RW5naW5lZXIgTGludXgKYW5kcmVhLmNlcnZlc2F0b0BzdXNlLmNvbQoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
