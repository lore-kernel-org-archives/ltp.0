Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32337CD5BB8
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 16:17:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A98BD3E6507
	for <ltp@archiver.kernel.org>; Sat, 23 May 2026 18:17:34 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 296043CD74C
 for <ltp@lists.linux.it>; Sat, 23 May 2026 18:17:14 +0200 (CEST)
Received: from mail-qv1-xf43.google.com (mail-qv1-xf43.google.com
 [IPv6:2607:f8b0:4864:20::f43])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 9C506200254
 for <ltp@lists.linux.it>; Sat, 23 May 2026 18:17:13 +0200 (CEST)
Received: by mail-qv1-xf43.google.com with SMTP id
 6a1803df08f44-8cc715824a0so20025626d6.3
 for <ltp@lists.linux.it>; Sat, 23 May 2026 09:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779553032; x=1780157832; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5YXe68JU45BsJ8QApNiXQ3OshKyCxA50oC/txvhLPIo=;
 b=lj5QDIo2wuDjXqGqVv+NyTY/tK1u+xc3DdrB5Q5yh/tGsLj3LFZnELO6rLgY9K2n4p
 FHopVtxx/JjgrutSfWxQa/Ucmf3uNEN/14wr69APT6rv5pKQ7cFKlRoP/+ERFEBZBrVv
 /n3BxhBTXAupJ5pEH7U0L39mc7fBQZ8HaLRHHYdaOo9lI/m3/xfcSq+ILaXFypEC+zYT
 LNw1howhWyj5LIEYzBIa1uaxGGXORxFPR3I50eUIFdj+NleJrYINYrQu9dZVPqhdqLEq
 oIf0odq5elPwj+Ta6yuHTia2I2xBrjyTzcoraFpqu74j8Ussa6ufzDt7DGCBFSJqOXLx
 gpgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779553032; x=1780157832;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5YXe68JU45BsJ8QApNiXQ3OshKyCxA50oC/txvhLPIo=;
 b=R2vJ0Hl4DY/BjFoJMQcCNzZKwxlEefbckBqeOCQ2kdUC5GABZZo1MKur2tNDTc1+L1
 66zq5HFPoUOn3H4h4lXbDm+bkCJhjpm7AgkxLYcUC8p5LK8O4tiShiBroiFCPFJ6FC4S
 g9k0r2FW/2eYLkO5fS5Nbm0Hytn7J9nAE9ZiYv5X8h6L47C9zUcpy3BSS0RsVVMLAe0N
 SC/BiSSdoKDOot8NNo3R10FFTF8xmSnW7Z4/JC98F3bQ43ESOhqMol/IaTwqt6SdHSj8
 cNLhwXWcSRdFS8m4Th/x8N6vLBzDg/IZXmwXgnJ0Go+aZdU/CbMPWSqt/nkczc44Znvl
 +u6A==
X-Gm-Message-State: AOJu0YwQJ+iavFvI57wTWvJGUmkPvXXJNlzsELZ/U8RaviQzLYZiTQT5
 oJvBGYN0rTahKzZudjqwF3UprkbYrsEX/JxNAfYVvniYwa8YqtARchNC
X-Gm-Gg: Acq92OHgzjx8vIhdULWggKhg38qsVX71NN+TfZ6zMd8Y1ikkWehO4xGOPDlrDaa9fGN
 xGG1so0bbBknlhLEX916XYbB+Za/t8iJROpdkfIOV6PkwrwOh24XX6uQLEk9NXxqnxX+oW4BFWZ
 6/zW/7coClI1QZgjRzknoKbmdPXzHNZ6TTqzQmwzWQmhly2CnzNsLOODvarxWAszLXbvI7/eZDs
 WKAy1LcCCWMOEWoxwN04zFZNz+EqjTR/lg2wp5v8lEKW7BzJIeQZQnhBDq3U8rM6jLwxviFJl0c
 A5Z4yN0SqYZsNe4DwKUM0ZkZL08jrSJtaEAshaCDgxPiFw74PWveTFMKWMx2LDUBOzgv46HP3hC
 7F/I804scFQHo5+iFbgarlH0zLnCF3OvD7+h0IrJcEGb4+dfhRuqBxcOEGx171GoItqSV0wOzwA
 SZORpydAyfplb1Ws1nq5Mf0UwX2suPeE7l/DWoU/qM+a1u819AWby7Yq4IAtXcebHWS0xd9TgAw
 dI+XyNsyUkZlr8Vnj42mffcsuHAVIxM3Mq0SSOgoRx/VWXgx8Q=
X-Received: by 2002:a05:6214:410b:b0:8ae:6460:c550 with SMTP id
 6a1803df08f44-8cc7b5cf73dmr143765186d6.36.1779553032250; 
 Sat, 23 May 2026 09:17:12 -0700 (PDT)
Received: from
 runnervmg397c.wgcyhu3ofd1ezmijxxwu5buxoe.bx.internal.cloudapp.net
 ([172.172.153.35]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8cc8130a1a3sm49234086d6.37.2026.05.23.09.17.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 09:17:11 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Sebastian Chlad <sebastianchlad@gmail.com>
Date: Sat, 23 May 2026 16:17:11 +0000
Message-ID: <20260523161711.4127-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260523151045.19446-1-sebastian.chlad@suse.com>
References: <20260523151045.19446-1-sebastian.chlad@suse.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] io_uring/pintheft: Add CVE-2026-43494 regression test
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

SGkgU2ViYXN0aWFuLAoKT24gU2F0LCAyMyBNYXkgMjAyNiAxNzoxMDo0NSArMDIwMCwgU2ViYXN0
aWFuIENobGFkIHdyb3RlOgo+IGlvX3VyaW5nL3BpbnRoZWZ0OiBBZGQgQ1ZFLTIwMjYtNDM0OTQg
cmVncmVzc2lvbiB0ZXN0Cgo+IEF1dGhvcjogU2ViYXN0aWFuIENobGFkIDxzZWJhc3RpYW5jaGxh
ZEBnbWFpbC5jb20+Cj4gU2lnbmVkLW9mZi1ieTogU2ViYXN0aWFuIENobGFkIDxzZWJhc3RpYW4u
Y2hsYWRAc3VzZS5jb20+CgpBdXRob3IgZW1haWwgYW5kIFNpZ25lZC1vZmYtYnkgZW1haWwgZG9u
J3QgbWF0Y2guIFRoZSBEQ08gcmVxdWlyZXMgdGhlClNPQiBpZGVudGl0eSB0byBtYXRjaCB0aGUg
Y29tbWl0IGF1dGhvci4gUGxlYXNlIHJlYmFzZSB3aXRoIGEgY29uc2lzdGVudAppZGVudGl0eSAo
bGlrZWx5IHRoZSBjb3Jwb3JhdGUgYWRkcmVzcyB0aHJvdWdob3V0LCBvciB2aWNlIHZlcnNhKS4K
ClsuLi5dCgo+ICsvKiBBcmd1bWVudCBmb3IgSU9SSU5HX1JFR0lTVEVSX0NMT05FX0JVRkZFUlMg
Ki8KPiArI2lmbmRlZiBIQVZFX1NUUlVDVF9JT19VUklOR19DTE9ORV9CVUZGRVJTX0FSRwo+ICtz
dHJ1Y3QgaW9fdXJpbmdfY2xvbmVfYnVmZmVyc19hcmcgewo+ICsgICAgICAgdWludDMyX3Qgc3Jj
X2ZkOwo+ICsgICAgICAgdWludDMyX3QgZmxhZ3M7Cj4gKyAgICAgICB1aW50MzJfdCBwYWRbNl07
Cj4gK307Cj4gKyNlbmRpZgoKVGhlIEhBVkVfU1RSVUNUX0lPX1VSSU5HX0NMT05FX0JVRkZFUlNf
QVJHIGd1YXJkIGlzIG5ldmVyIHNldCBiZWNhdXNlCnRoZXJlIGlzIG5vIGNvcnJlc3BvbmRpbmcg
QUNfQ0hFQ0tfVFlQRVMgZW50cnkgaW4gY29uZmlndXJlLmFjLiBTZWUgZS5nLgp0aGUgc3RydWN0
IGZ1dGV4X3dhaXR2IHBhdHRlcm46CgogIEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgZnV0ZXhfd2Fp
dHZdLCwsWyNpbmNsdWRlIDxsaW51eC9mdXRleC5oPl0pCgpXaXRob3V0IGl0IHRoZSBndWFyZCBp
cyBkZWFkIGFuZCBvbiBhIGtlcm5lbCB0aGF0IGRlZmluZXMgdGhpcyBzdHJ1Y3QKdW5kZXIgdGhl
IHNhbWUgbmFtZSB5b3UnbGwgZ2V0IGEgcmVkZWZpbml0aW9uIGVycm9yLiBQbGVhc2UgYWRkOgoK
ICBBQ19DSEVDS19UWVBFUyhbc3RydWN0IGlvX3VyaW5nX2Nsb25lX2J1ZmZlcnNfYXJnXSwsLAog
ICAgICAgICAgICAgICAgIFsjaW5jbHVkZSA8bGludXgvaW9fdXJpbmcuaD5dKQoKQWxzbzogdGhl
IHVwc3RyZWFtIGtlcm5lbCB1YXBpIGRlZmluZXMgdGhpcyBhcyBzdHJ1Y3QgaW9fdXJpbmdfY2xv
bmVfYnVmZmVycwoobm8gX2FyZyBzdWZmaXgpLiBJZiB0aGF0IGlzIHN0aWxsIHRoZSBuYW1lIGlu
IDcuMSwgdGhlIHN0cnVjdCBuYW1lIGFuZApndWFyZCBpbiBsYXBpIG5lZWQgdG8gbWF0Y2ggKGlv
X3VyaW5nX2Nsb25lX2J1ZmZlcnMgLwpIQVZFX1NUUlVDVF9JT19VUklOR19DTE9ORV9CVUZGRVJT
KSBzbyB0aGUgZmFsbGJhY2sgZmlyZXMgY29ycmVjdGx5IG9uCm9sZGVyIGhlYWRlcnMgYW5kIGRv
ZXNuJ3Qgc2hhZG93IHRoZSBzeXN0ZW0gZGVmaW5pdGlvbiBvbiBuZXdlciBvbmVzLiDimqDvuI8K
UGxlYXNlIHZlcmlmeSBhZ2FpbnN0IHRoZSA3LjEgdWFwaSBoZWFkZXIuCgpbLi4uXQoKPiArI2Rl
ZmluZSBHVVBfUElOX0NPVU5USU5HX0JJQVMJMTAyNAo+ICsKPiArCj4gK3N0YXRpYyBpbnQgcmlu
Z19mZDEgPSAtMTsKCkRvdWJsZSBibGFuayBsaW5lLiBPbmUgYmxhbmsgbGluZSBiZXR3ZWVuIGEg
bWFjcm8gYmxvY2sgYW5kIHRoZSB2YXJpYWJsZQpkZWNsYXJhdGlvbnMgaXMgZW5vdWdoLgoKWy4u
Ll0KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9mIHRoZSBwYXRj
aC4gVGhlIGZ1bGwgcmV2aWV3IGNhbiBiZQpmb3VuZCBhdDogKG5vdCBzZXQpCgpUaGUgYWdlbnQg
Y2FuIHNvbWV0aW1lcyBwcm9kdWNlIGZhbHNlIHBvc2l0aXZlcyBhbHRob3VnaCBvZnRlbiBpdHMK
ZmluZGluZ3MgYXJlIGdlbnVpbmUuIElmIHlvdSBmaW5kIGlzc3VlcyB3aXRoIHRoZSByZXZpZXcs
IHBsZWFzZQpjb21tZW50IHRoaXMgZW1haWwgb3IgaWdub3JlIHRoZSBzdWdnZXN0aW9ucy4KClJl
Z2FyZHMsCkxUUCBBSSBSZXZpZXdlcgpgYGAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
