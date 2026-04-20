Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E823F5580E
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 10:54:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4C16A3E540E
	for <ltp@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:06 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A57643E2D9C
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:53:46 +0200 (CEST)
Received: from mail-dl1-x1242.google.com (mail-dl1-x1242.google.com
 [IPv6:2607:f8b0:4864:20::1242])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2ABA66008C7
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 12:53:46 +0200 (CEST)
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-12c7212836bso7632943c88.0
 for <ltp@lists.linux.it>; Mon, 20 Apr 2026 03:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776682424; x=1777287224; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3LNIWJu65aMkjxWB2l7kPoANSSxnqlXrrVk/A/troYM=;
 b=OyCZmyT2hgzIyZfT6lA7/AIL4D4A1KCKApzZ+AyHlPJpI6dvUNdlxR811mCc0KJEeN
 TKN0yHwOmkSWeKR6gkSHIFlAeCch5p6idKqpwP+1rKtV+Fc0SgmB4Y1VRHfPIMtyhVGB
 BKzxX5ggK0eFesAH02Cin5x4QlQvV0ks9kx1LBIkYEIon1uNPlrsw0AQT+deXWMLNe+b
 WZxH02PQLOtaD3oDuh2oYGpL6GBIl0CA2IgfnQOSUxfhv9p+8b/W5aeGZ9sV96B+iERF
 C4Hd81AP3hcAcrFCdpFqCHol4faFH2PyKCVca/FEQAArO70yg0Xnub04HEVYLABh5XW4
 KTZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776682424; x=1777287224;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=3LNIWJu65aMkjxWB2l7kPoANSSxnqlXrrVk/A/troYM=;
 b=VZd2ooJAxRTLHpxpKsAk/DfAbFLD9hemqEb1U5bxHZDF3NiJAwoHyV7OEnonWsQFjO
 RnbQgX5aiHry1WavRT4FeByTMWPCRFLn/mo1YjGOplP5h0RXESZP3EelKIuSmveGpVXo
 tmxH9ZqUXULy+6fi2lrsip61Xsbyru+irdYktp3ls0u5ZeHLzW/emoarKAup8883VS0I
 No18PrA4aTK8Jcj4kT8O/ttm/fKDHyAANwEBbMaPHalIxxGPfg8T8L8PID+eoLHrgFS7
 w/wIgjtd/s4BnSuBb5J/bTY8dpAh1En8V5vtdTxIfg2v3dXF6GvZRe933rouGGEZQFvr
 IvjQ==
X-Gm-Message-State: AOJu0YzLWyza9rYz/1YhjHm7m8OtTuLY9VYRJAH3FM8c+mSmZnR64Qhx
 qDnl8YyzIpivklhaWnHDNwwhSnK81BcaGdCjBI1l9rSzuRoZXui2H3Go
X-Gm-Gg: AeBDietYEKz9AnUONBJst2s3P3RwLO6vMEE0e0BZ4NCf23vl0uocW1NLc7aPxDK8jOC
 J/FCT9K4IKQmksPCzmQ+RnzxOA+8es3hg6y8mCXPL2jtO8hg6CUC4mz3+0lMb0c3869h4WSztdn
 QXiV/DiRq737lYWQ1qQ4RQT14HHoYSaT0HwdDC/Q1dIB1dyAy/M3fm1KJqoSzmF3KGDzdm4w8Tj
 LOyPbfz2sORAloNl9f2TC9RA2wBXfmIj8212RbD1eiMpJ9+NnwpkBXaAkqIjTaYlyvviq6dSL5y
 jwRB2iS4G9lfOa5NwBFjxBHtlzaet+XzwANMnYDIm899Anjuta/HEz3RXqLojDux1/mzYdRojXO
 XmwtuwUJDQfeZ5f4+dluR0psEN8T4sG9Jm7o7oHCigS9P9kap074CyoR6rSnG0/xHgfE1XQbC5m
 UyAF9VOPKu39x4Ux8mkBXslHuIE+ndrzi0XxtBqha3GKEG9Q8Cx5i/O4QrY1iQ5VLnj6xNNjawt
 x8WrK1njg6rjrT1IpQqLN4pbFbWY5rj+pyoNAkF3+O1VWjc/6Y=
X-Received: by 2002:a05:7300:dc05:b0:2d9:6373:ad22 with SMTP id
 5a478bee46e88-2e46557cae8mr6510764eec.12.1776682424259; 
 Mon, 20 Apr 2026 03:53:44 -0700 (PDT)
Received: from
 runnervmeorf1.mwnkrarbjm5e5digrl2jy2mjca.dx.internal.cloudapp.net
 ([52.159.244.170]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2e53dcb487bsm13982708eec.31.2026.04.20.03.53.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Apr 2026 03:53:43 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Pavithra <pavrampu@linux.ibm.com>
Date: Mon, 20 Apr 2026 10:53:42 +0000
Message-ID: <20260420105342.3941-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420102339.729745-1-pavrampu@linux.ibm.com>
References: <20260420102339.729745-1-pavrampu@linux.ibm.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Fix hugeshmat05 test failure on lpar with 1GB hugepages.
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

SGkgUGF2aXRocmEsCgpPbiBNb24sIDIwIEFwciAyMDI2LCBQYXZpdGhyYSB3cm90ZToKPiBGaXgg
aHVnZXNobWF0MDUgdGVzdCBmYWlsdXJlIG9uIGxwYXIgd2l0aCAxR0IgaHVnZXBhZ2VzLgo+Cj4g
TW9kaWZpZWQgdGhlIHRlc3QgdG8gZGV0ZWN0IGxhcmdlIGh1Z2VwYWdlIHNpemVzICjiiaUxR0Ip
IGFuZCBhZGp1c3QgdGVzdCBzaXplcyBhY2NvcmRpbmdseS4KClRoZSBjb21taXQgYm9keSBkZXNj
cmliZXMgd2hhdCBjaGFuZ2VkIGJ1dCBub3Qgd2h5IHRoZSB0ZXN0IHdhcyBmYWlsaW5nLgpJcyBz
aG1nZXQgZmFpbGluZyBiZWNhdXNlIE4qaHBhZ2Vfc2l6ZT00R0IgZXhjZWVkcyB3aGF0IHRoZSBM
UEFSIGNhbgphbGxvY2F0ZSBpbiBvbmUgY2FsbCwgb3IgaXMgaXQgYSBwb29sIGV4aGF1c3Rpb24g
aXNzdWU/IFBsZWFzZSBkb2N1bWVudAp0aGUgcm9vdCBjYXVzZSBpbiB0aGUgY29tbWl0IG1lc3Nh
Z2UuCgo+ICsgICAgICAgaWYgKGhwYWdlX3NpemUgPj0gMTAyNCAqIDEwMjQgKiAxMDI0KQo+ICsg
ICAgICAgICAgICAgICBtdWx0aXBsaWVyID0gTiAvIDI7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAg
ICAgICAgICAgIG11bHRpcGxpZXIgPSBOOwoKV2l0aCBtdWx0aXBsaWVyPTIgZm9yIDFHQiBwYWdl
cyB0aGUgdGVzdCBuZWVkcyBhdCBtb3N0IDIgaHVnZXBhZ2VzIGF0CnBlYWssIGJ1dCAuaHVnZXBh
Z2VzID0ge04rMSwgVFNUX05FRURTfSBzdGlsbCByZXF1aXJlcyA1IGZyZWUgMUdCIHBhZ2VzCig1
IEdCKS4gT24gYW4gTFBBUiB3aXRoIDLigJM0IGZyZWUgMUdCIGh1Z2VwYWdlcyB0aGUgdGVzdCBz
dGlsbCBjYW5ub3QKcnVuLiBVcGRhdGUgLmh1Z2VwYWdlcyB0byBtYXRjaCB0aGUgcmVkdWNlZCBy
ZXF1aXJlbWVudC4KCi0tLQpOb3RlOgoKT3VyIGFnZW50IGNvbXBsZXRlZCB0aGUgcmV2aWV3IG9m
IHRoZSBwYXRjaC4gVGhlIGFnZW50IGNhbiBzb21ldGltZXMKcHJvZHVjZSBmYWxzZSBwb3NpdGl2
ZXMgYWx0aG91Z2ggb2Z0ZW4gaXRzIGZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UKZmluZCBp
c3N1ZXMgd2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UgY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9y
ZSB0aGUKc3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
