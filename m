Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18E89C021A4
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 15:01:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7665B3C9ABC
	for <ltp@archiver.kernel.org>; Thu, 13 Feb 2025 16:01:21 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A709F3C010E
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 16:01:04 +0100 (CET)
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 036571A0BC3D
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 16:01:04 +0100 (CET)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-5de594e2555so1572072a12.2
 for <ltp@lists.linux.it>; Thu, 13 Feb 2025 07:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739458863; x=1740063663; darn=lists.linux.it;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WRBQ6zIED0BoyiyeGBV30sXzN/86X/67b2OllilMlo=;
 b=QbxxnW7Wpd7gNzBmgCaKqoWuFPlAF+G5vZhyCwyQEbKjGuHUn8sOrUIQ2BS5GexGtp
 pJ/zwN75aetf9NbbGOP+y+TPLuG8uC4EBkonNkYf13DM6EzMhiYA5WjJNLO4kYf7xxdf
 0xSjkag0TUXE7gPWUoud14qgoSdf1ivCt13FrAl+BOiA7+LHoXJoKReiDXJMPeOVTNOW
 8GAq9UVDsEimWSpbN+iMeL2SZhipcebCc01R9uQ4Fx5/+AUVWxZFasKufluA8czSSoJb
 wDjBlktmles4025qgPzHk01ESfQbi88itNv87SQzDpwf8XStoj6nAN1GBt+QR4sTCczF
 qjfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739458863; x=1740063663;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4WRBQ6zIED0BoyiyeGBV30sXzN/86X/67b2OllilMlo=;
 b=GzeNwO/Cdhq4eCzQppftOuoqXYoYswVeKzsVuZpIEgcBCTtSBKlfEKN6BdZDnDltB8
 K/tL797P1NJIecx5bLWpN7jd4tsv28VLiuw5p/KQqonbOHylMaHs7AptXxVjdUOPFQZI
 IX/cPLeIhR5B1bDAK9Qivy/1B8ceotIy4AZO6iiKYoIEQH2yA+74p+Et0oNiMfbQNAfn
 lwZofCxPp7+DY60HT2DL4fJSTDlG8KPNMJGvSlFPmSm3CgvTa6F7Lg3vzDWuL4VMU6lG
 DuYPAwlt0Soc+upTcJSzctfjE+SGrmKpDhRy+O3ClLZA+sHtOMyGxIr7ri3zLFYZsFjT
 4RbQ==
X-Gm-Message-State: AOJu0Yx69jcQLdaIoeVESz7IG9SVdseLOwjlWKQYxA52vdYqI8KEn4JA
 /KSUuWSfm+sjm+OH1qOR/I0S8rq+6tSwg8FaA9bW4f9+JwsSEPSmuW03tJY7Jszp5vr4QoRpR/D
 3yv8VchDiiaDcdnlYBjc7sC1TyqU=
X-Gm-Gg: ASbGncsrrJBEYLnRQIlgPRUt9BHkiMWFoYi0x7uEB1Iz6xzgLMHmhVH13vTI5idjv9o
 a442r4lzA0mieBfWztojLUoazgYUA0pK88J0RRsKfgC23gxHtvz7Vz1qJpxoEiziHvS54hMk0
X-Google-Smtp-Source: AGHT+IEr8wgIUbZaLvqh9nemWbEk1cIBQNNjhWvTtqPjJtgwOaF4p7U5257rQxjuy+cd9DzZr7bkEI0uVPcx35LCKkc=
X-Received: by 2002:a05:6402:1e94:b0:5dc:72e1:63f5 with SMTP id
 4fb4d7f45d1cf-5deaddaa9f1mr6740910a12.12.1739458861086; Thu, 13 Feb 2025
 07:01:01 -0800 (PST)
MIME-Version: 1.0
References: <BLAPR10MB5380CCF4F8E99589DF0312EBBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
In-Reply-To: <BLAPR10MB5380CCF4F8E99589DF0312EBBCFF2@BLAPR10MB5380.namprd10.prod.outlook.com>
From: Amir Goldstein <amir73il@gmail.com>
Date: Thu, 13 Feb 2025 16:00:49 +0100
X-Gm-Features: AWEUYZlPHAWNNKdkxGExZvND9GZ94IHuZ6wXUdeTDd1UE5ba0L2-BditjlX1YgU
Message-ID: <CAOQ4uxg3wAr7Brse9xORsPp0XqCKTxMmnc_DRWuQ2bVZUSZRpQ@mail.gmail.com>
To: Rhythm Mahajan <rhythm.m.mahajan@oracle.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fanotify01 test fails on nfsv3& nfsv4
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
Cc: "jack@suse.cz" <jack@suse.cz>, Darren Kenny <darren.kenny@oracle.com>,
 Ramanan Govindarajan <ramanan.govindarajan@oracle.com>,
 Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBGZWIgMTMsIDIwMjUgYXQgMjoyOeKAr1BNIFJoeXRobSBNYWhhamFuCjxyaHl0aG0u
bS5tYWhhamFuQG9yYWNsZS5jb20+IHdyb3RlOgo+Cj4gSGksCj4KPiBmYW5vdGlmeTAxIHRlc3Qg
ZmFpbHMgb24gbmZzdjMmIG5mc3Y0IGZvciBtYWlubGluZSA2LjE0IGtlcm5lbHMuCj4KPgo+Cj4g
bWtkaXIgL3RtcGRpcgo+Cj4geXVtIGluc3RhbGwgbmZzLXV0aWxzICAteQo+Cj4gZWNobyAiL21l
ZGlhICoocncsbm9fcm9vdF9zcXVhc2gsc3luYykiID4vZXRjL2V4cG9ydHMKPgo+IHN5c3RlbWN0
bCBzdGFydCBuZnMtc2VydmVyLnNlcnZpY2UKPgo+IG1vdW50IC1vIHJ3LG5mc3ZlcnM9MyAxMjcu
MC4wLjE6L21lZGlhIC90bXBkaXIKPgo+Cj4KPiBjZCAvb3B0L2x0cAo+Cj4gLi9ydW5sdHAgLWQg
L3RtcGRpciAgLXMgZmFub3RpZnkwMQo+Cj4KPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBm
YW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4i
KSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlM
OiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwg
Ii4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRG
QUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEw
MCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6
IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwg
LTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzoz
NDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAw
OCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEu
YzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAw
MDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5
MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgw
MDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90
aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwg
MHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZh
bm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAw
MSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+
IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAw
MDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkK
Pgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgw
MDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgx
OCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwg
MHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVW
ICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25vdGlm
eSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6IEVY
REVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZkX25v
dGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9ERVY6
IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJrKGZk
X25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBFTk9E
RVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9tYXJr
KGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3RlZCBF
Tk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlmeV9t
YXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBlY3Rl
ZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5vdGlm
eV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBleHBl
Y3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBmYW5v
dGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4iKSBl
eHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlMOiBm
YW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwgIi4i
KSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+IGZhbm90aWZ5MDEuYzozNDA6IFRGQUlM
OiBmYW5vdGlmeV9tYXJrKGZkX25vdGlmeSwgMHgwMDAwMDAwMSwgMHgwMDAwMDAwOCwgLTEwMCwg
Ii4iKSBleHBlY3RlZCBFTk9ERVY6IEVYREVWICgxOCkKPgo+Cj4KPiBXZSBoYXZlIGJlZW4gc2Vl
aW5nIHRoaXMgZmFpbHVyZSBzaW5jZSA2LjkKPgo+Cj4KPiBUaGUgdGVzdCBubyBsb25nZXIgZmFp
bHMgd2l0aCB0aGUgcmV2ZXJ0IG9mIHRoZSBjb21taXQKPgo+IDM1OTA0N2M5NyBmYW5vdGlmeTAx
OiBUZXN0IHNldHRpbmcgdHdvIG1hcmtzIG9uIGRpZmZlcmVudCBmaWxlc3lzdGVtcwo+Cj4gaHR0
cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvY29tbWl0LzM1OTA0N2M5Nwo+
Cj4KPgo+IENvdWxkIHlvdSBwbGVhc2UgY29uZmlybSBpZiB0aGlzIGlzIGEgdGVzdCBjYXNlIGlz
c3VlIG9yIGEga2VybmVsIGlzc3VlPwoKVGVzdCBpc3N1ZSBmb3IgdGhlIGNhc2Ugd2hlcmUKIlRN
UERJUiBkb2VzIG5vdCBzdXBwb3J0IHJlcG9ydGluZyBldmVudHMgd2l0aCBmaWQgZnJvbSBtdWx0
aSBmcyIKZm9yIHJlYXNvbnMgb3RoZXIgdGhhbiBFWERFViAoaS5lLiBidHJmcyBzdWJ2b2wpLgoK
Q2FuIHlvdSB0ZXN0IHRoaXMgcGF0Y2guCgpUaGFua3MsCkFtaXIuCgotLS0gYS90ZXN0Y2FzZXMv
a2VybmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDEuYworKysgYi90ZXN0Y2FzZXMva2Vy
bmVsL3N5c2NhbGxzL2Zhbm90aWZ5L2Zhbm90aWZ5MDEuYwpAQCAtMzc1LDcgKzM3NSw3IEBAIHN0
YXRpYyB2b2lkIHNldHVwKHZvaWQpCiAgICAgICAgfQoKICAgICAgICBpZiAoZmFub3RpZnlfZmxh
Z3Nfc3VwcG9ydGVkX29uX2ZzKEZBTl9SRVBPUlRfRklELApGQU5fTUFSS19NT1VOVCwgRkFOX09Q
RU4sICIuIikpIHsKLSAgICAgICAgICAgICAgIGlub2RlX21hcmtfZmlkX3hkZXYgPSBlcnJubzsK
LSAgICAgICAgICAgICAgIHRzdF9yZXMoVElORk8sICJUTVBESVIgZG9lcyBub3Qgc3VwcG9ydCBy
ZXBvcnRpbmcKZXZlbnRzIHdpdGggZmlkIGZyb20gbXVsdGkgZnMiKTsKKyAgICAgICAgICAgICAg
IGlub2RlX21hcmtfZmlkX3hkZXYgPSAoZXJybm8gPT0gRU5PREVWKSA/IEVYREVWIDogZXJybm87
CisgICAgICAgICAgICAgICB0c3RfcmVzKFRJTkZPLCAiVE1QRElSIGRvZXMgbm90IHN1cHBvcnQg
cmVwb3J0aW5nCmV2ZW50cyB3aXRoIGZpZCBmcm9tIG11bHRpIGZzIgorICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICIgKGVycm5vID0gJWQpIiwgZXJybm8pOwogICAgICAgIH0KIH0KCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
