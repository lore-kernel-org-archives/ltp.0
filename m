Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 083FEC77B73
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 12:55:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73BF93CCA6E
	for <ltp@archiver.kernel.org>; Tue,  6 Jun 2023 14:55:49 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 951143C995F
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 14:55:38 +0200 (CEST)
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com
 [IPv6:2607:f8b0:4864:20::b2b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E62531A002EE
 for <ltp@lists.linux.it>; Tue,  6 Jun 2023 14:55:37 +0200 (CEST)
Received: by mail-yb1-xb2b.google.com with SMTP id
 3f1490d57ef6-bacbc7a2998so6769124276.3
 for <ltp@lists.linux.it>; Tue, 06 Jun 2023 05:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1686056136; x=1688648136;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D+sL6Qyfb5k94SqKPG3OA6A676jFcc/TCiC7OLxdKOs=;
 b=SUI/MB+ZsOMg1JlAs4ozmems9pf/4XZfKOUBsdstblb/y7p7+ai50C43/PtSFzh/U2
 hbrHCIMmCpHfagzzeXSjqaFjrgUXa+IZ8RBM9k89W117nJ9CUKDalAHCfl+cgk51elvQ
 kN8KcKHvHQvmsPoLVpI/H6MoSh/QJnvJ9hq2sVeMt/2QP8Wr9BopEoZFR5nqAlOYG22O
 5W6N9dGSQLTcXXEPYXZOsmfotbiyr/Ks0TdfcPkz7xmEkoR3t4eHLF+5Qm5+KWByuw3g
 tg+gLLZvxVVKy3aS8vJcPv+6IBlBl8ERcKOks5m98/Rej4NvkohxGJUKWzv7LT1fimjH
 U4eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1686056136; x=1688648136;
 h=content-transfer-encoding:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=D+sL6Qyfb5k94SqKPG3OA6A676jFcc/TCiC7OLxdKOs=;
 b=AO/V5eCzO1oQrJC5DylN3Nm9TbPkSXy76CNBmbUu914V1Hbu6/adDl90sH6yWKRSQC
 igowu+aM8y/95U0B46GbluCVhmDlRzbBpO4MG1T47SDgQ6H0ShJLOoMQElja/5jzInKZ
 BtoaVfbs9DxDnt77P1fLVZ8XETvjRiAiwid9NkjHUyq/nBkpB3bGi7Aaoa6YB4ksgyav
 CLSEEZbIfPPCQkl2fY1+nfKKMrV/anDQKFYNidkwuZeueB0mvpi1HAGg1R2PtRCqPWop
 2eqYrqtISojFBrhuRj/uTUFiRLSK/dGz5cTbJ6vJZXZYmUog34QExsQPx9/fc1Nszfik
 CcwQ==
X-Gm-Message-State: AC+VfDy8t4ZbZjBg7IAvxTMsGoUedOMsHuwDo86LfyF5zLIu8CGL+30g
 8U+Zqg1Xemg92LLXveOPlrNJs3e2n63+E8VuxQw8HuzY
X-Google-Smtp-Source: ACHHUZ45++SHZSL8sqTfcLCwMZR5dwtBBXj+S2SMgeiBBA759zVJTo1eLz5OR8Dl0x778iL+JS17kHLjWM6B5meDDEI=
X-Received: by 2002:a25:870c:0:b0:ba7:54ab:d676 with SMTP id
 a12-20020a25870c000000b00ba754abd676mr1887793ybl.63.1686056136504; Tue, 06
 Jun 2023 05:55:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230604094936.3543223-1-jencce.kernel@gmail.com>
In-Reply-To: <20230604094936.3543223-1-jencce.kernel@gmail.com>
From: Murphy Zhou <jencce.kernel@gmail.com>
Date: Tue, 6 Jun 2023 20:55:25 +0800
Message-ID: <CADJHv_sNiLnFzPARf_NJWDkcmGu=w1TxnN=e85MSsfoP+TcxYA@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.1 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] df01.sh: put output file to tmp dir
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

UGxlYXNlIGlnbm9yZSB0aGlzLiAgSSByZWFkICBpdCB3cm9uZy4KCk9uIFN1biwgSnVuIDQsIDIw
MjMgYXQgNTo0OeKAr1BNIE11cnBoeSBaaG91IDxqZW5jY2Uua2VybmVsQGdtYWlsLmNvbT4gd3Jv
dGU6Cj4KPiBCZWNhdXNlIHRoZSBvdXRwdXQgZmlsZSBpdHNlbGYgd2lsbCBjb25zdW1lIGRpc2sg
c3BhY2UuCj4gVGhpcyBtYXkgYWZmZWN0cyB0aGUgZGYgbnVtYmVycy4gVGhlIGNoYW5jZSBpcyBo
aWdoZXIKPiBpbiBsYXJnZSBibG9jayBzaXplIGZpbGVzeXN0ZW1zLgo+Cj4gU2lnbmVkLW9mZi1i
eTogTXVycGh5IFpob3UgPGplbmNjZS5rZXJuZWxAZ21haWwuY29tPgo+IC0tLQo+ICB0ZXN0Y2Fz
ZXMvY29tbWFuZHMvZGYvZGYwMS5zaCB8IDE4ICsrKysrKysrKystLS0tLS0tLQo+ICAxIGZpbGUg
Y2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMvY29tbWFuZHMvZGYvZGYwMS5zaCBiL3Rlc3RjYXNlcy9jb21tYW5kcy9kZi9k
ZjAxLnNoCj4gaW5kZXggNWFmNGY2OGU2Li45MTlkZjk4MTggMTAwNzU1Cj4gLS0tIGEvdGVzdGNh
c2VzL2NvbW1hbmRzL2RmL2RmMDEuc2gKPiArKysgYi90ZXN0Y2FzZXMvY29tbWFuZHMvZGYvZGYw
MS5zaAo+IEBAIC0xMiw2ICsxMiw3IEBAIFRTVF9DTlQ9MTIKPiAgVFNUX1NFVFVQPXNldHVwCj4g
IFRTVF9URVNURlVOQz10ZXN0Cj4gIFRTVF9ORUVEU19ST09UPTEKPiArT1VUUFVUPSQobWt0ZW1w
KQo+Cj4gIHNldHVwKCkKPiAgewo+IEBAIC01NywxNSArNTgsMTUgQEAgZGZfdGVzdCgpCj4KPiAg
ZGZfdmVyaWZ5KCkKPiAgewo+IC0gICAgICAgJEAgPm91dHB1dCAyPiYxCj4gKyAgICAgICAkQCA+
JE9VVFBVVCAyPiYxCj4gICAgICAgICBpZiBbICQ/IC1uZSAwIF07IHRoZW4KPiAtICAgICAgICAg
ICAgICAgZ3JlcCAtcSAtRSAidW5yZWNvZ25pemVkIG9wdGlvbiB8IGludmFsaWQgb3B0aW9uIiBv
dXRwdXQKPiArICAgICAgICAgICAgICAgZ3JlcCAtcSAtRSAidW5yZWNvZ25pemVkIG9wdGlvbiB8
IGludmFsaWQgb3B0aW9uIiAkT1VUUFVUCj4gICAgICAgICAgICAgICAgIGlmIFsgJD8gLWVxIDAg
XTsgdGhlbgo+ICAgICAgICAgICAgICAgICAgICAgICAgIHRzdF9yZXMgVENPTkYgIickQCcgbm90
IHN1cHBvcnRlZC4iCj4gICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIDMyCj4gICAgICAg
ICAgICAgICAgIGVsc2UKPiAgICAgICAgICAgICAgICAgICAgICAgICB0c3RfcmVzIFRGQUlMICIn
JEAnIGZhaWxlZC4iCj4gLSAgICAgICAgICAgICAgICAgICAgICAgY2F0IG91dHB1dAo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGNhdCAkT1VUUFVUCj4gICAgICAgICAgICAgICAgICAgICAgICAg
cmV0dXJuIDEKPiAgICAgICAgICAgICAgICAgZmkKPiAgICAgICAgIGZpCj4gQEAgLTg2LDEyICs4
NywxMiBAQCBkZl9jaGVjaygpCj4gICAgICAgICAgICAgICAgIHVzZWQ9JCgoKCR1c2VkICogJGJz
aXplICsgNTEyKSAvIDEwMjQpKQo+ICAgICAgICAgZmkKPgo+IC0gICAgICAgZ3JlcCAkVFNUX0RF
VklDRSBvdXRwdXQgfCBncmVwIC1xICIke3RvdGFsfS4qJHt1c2VkfSIKPiArICAgICAgIGdyZXAg
JFRTVF9ERVZJQ0UgJE9VVFBVVCB8IGdyZXAgLXEgIiR7dG90YWx9Lioke3VzZWR9Igo+ICAgICAg
ICAgaWYgWyAkPyAtbmUgMCBdOyB0aGVuCj4gICAgICAgICAgICAgICAgIGVjaG8gInRvdGFsOiAk
e3RvdGFsfSwgdXNlZDogJHt1c2VkfSIKPiAtICAgICAgICAgICAgICAgZWNobyAiZGYgc2F2ZWQg
b3V0cHV0OiIKPiAtICAgICAgICAgICAgICAgY2F0IG91dHB1dAo+IC0gICAgICAgICAgICAgICBl
Y2hvICJkZiBvdXRwdXQ6Igo+ICsgICAgICAgICAgICAgICBlY2hvICJkZiBzYXZlZCAkT1VUUFVU
OiIKPiArICAgICAgICAgICAgICAgY2F0ICRPVVRQVVQKPiArICAgICAgICAgICAgICAgZWNobyAi
ZGYgJE9VVFBVVDoiCj4gICAgICAgICAgICAgICAgICRACj4gICAgICAgICAgICAgICAgIHJldHVy
biAxCj4gICAgICAgICBmaQo+IEBAIC0xNzUsNyArMTc2LDcgQEAgdGVzdDEyKCkKPiAgICAgICAg
ICAgICAgICAgcmV0dXJuCj4gICAgICAgICBmaQo+Cj4gLSAgICAgICBncmVwICRUU1RfREVWSUNF
IG91dHB1dCB8IGdyZXAgLXEgJFRTVF9NTlRQT0lOVAo+ICsgICAgICAgZ3JlcCAkVFNUX0RFVklD
RSAkT1VUUFVUIHwgZ3JlcCAtcSAkVFNUX01OVFBPSU5UCj4gICAgICAgICBpZiBbICQ/IC1uZSAw
IF07IHRoZW4KPiAgICAgICAgICAgICAgICAgdHN0X3JlcyBUUEFTUyAiJyRjbWQnIHBhc3NlZC4i
Cj4gICAgICAgICBlbHNlCj4gQEAgLTE4NSwzICsxODYsNCBAQCB0ZXN0MTIoKQo+Cj4gIC4gdHN0
X3Rlc3Quc2gKPiAgdHN0X3J1bgo+ICtybSAtZiAkT1VUUFVUCj4gLS0KPiAyLjMxLjEKPgoKLS0g
Ck1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
