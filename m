Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49731C4707B
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 09:58:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7ECD63CE2E8
	for <ltp@archiver.kernel.org>; Thu, 18 Jan 2024 10:58:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1FDAB3CC991
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 16:52:53 +0100 (CET)
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com
 [IPv6:2607:f8b0:4864:20::b34])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id C7F1D10085F5
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 16:52:52 +0100 (CET)
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-dc223463ee4so1980035276.2
 for <ltp@lists.linux.it>; Wed, 17 Jan 2024 07:52:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mojatatu-com.20230601.gappssmtp.com; s=20230601; t=1705506771; x=1706111571;
 darn=lists.linux.it; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W9dXBuJy2lnyXOqHtUWzAKtPIcsujNRdJV/KwN/vGko=;
 b=Vj4lg0LGXwnAGq4gyGXgqRXoJtt2rAgNUBiuIEHx8/BQ8ohxEjqdFWddB/j+RYDJwf
 YI/nj3Si3cONzWKLQDjX0qdQ1zPQLGflA14WHyEbJMjp+llP5cWyKMJerymuZCh1MbhW
 MCpTodUTy6ddgbCsjCc3xl+0BVDdJDRPMIWopbfePU339ibEPQPl3qqA9AnQ55i63pxo
 NjlcNPZbdTqwvtMnN5jAEYgQePcCI403aSW6cN917rkiy6+k1PVyAwwQTR/ZazfHLeSG
 l+RwucUsJO4ryc31XMyyWPTdztj7FMTyDeOIERnQpr0hJrXmKUaaQK3r8nV3Mwtz3kdh
 aoow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705506771; x=1706111571;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=W9dXBuJy2lnyXOqHtUWzAKtPIcsujNRdJV/KwN/vGko=;
 b=Nmu0aB/BegBxTqknAlyo9ho97RxzQb3B/P5Q+FvLsJIlLjliaXCKugKxgRUkPxBNPV
 bPYAaL5LuCOVevaTf5rU50LyDUKmqpzBqVS3OusD5JbFPBTnGklpi6Xbnf5+LQnKAODu
 rSNHvuLTclA5GqAjlByQdZUHwA0lbrG/zlsjkiZZ1B8912uAUSInLW1Uv3h3M9tonz1g
 QlQ5qyAVftJFeZFV1OKPiwpP3vEGAnxrrK1p0LiM4+L0r+5vc++E6FBd++hs1G+yGXw+
 hjiP/dYsjDdypaxTAUFMtw3lmXdQl9DNPNXJ49H7TPXaeHfFLL/JTp6tymQkgkLwuZi2
 WWkg==
X-Gm-Message-State: AOJu0Yz5MuGshTItFYjvrpQ8qcLjGfjP/RiF4u92oMRNsmdFk/hpxHHm
 RECT9Hyi+uENmy71hBo273D0mAqLJpuxzGOARfsZXCESeM7I
X-Google-Smtp-Source: AGHT+IGP5wHqIG2Ch5JUWnyYR4B5jXqgCmjWXhRQASMyo+mzE8dn6zl2nvMDlp2S6716cWeFrAoH4TQiXGl8Wwatp0g=
X-Received: by 2002:a25:8104:0:b0:dbe:a65c:fdf0 with SMTP id
 o4-20020a258104000000b00dbea65cfdf0mr5496409ybk.34.1705506770004; Wed, 17 Jan
 2024 07:52:50 -0800 (PST)
MIME-Version: 1.0
References: <20240116031728.2500892-1-liwang@redhat.com>
In-Reply-To: <20240116031728.2500892-1-liwang@redhat.com>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Wed, 17 Jan 2024 10:52:38 -0500
Message-ID: <CAM0EoMns7T+JkJquM21_9S0FUoPdPQxw1Ebg4jBPLer5cOF+uQ@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Thu, 18 Jan 2024 10:58:38 +0100
Subject: Re: [LTP] [PATCH] tcindex01: fix compilation errors due to missing
 TCA_TCINDEX_ constants
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

T24gTW9uLCBKYW4gMTUsIDIwMjQgYXQgMTA6MTfigK9QTSBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4KPiBUaGUgY2hhbmdlIGFkZHJlc3NlcyBjb21waWxhdGlvbiBlcnJvcnMg
ZW5jb3VudGVyZWQgaW4gdGhlIHRjaW5kZXgwMS5jCj4gdGVzdCB3aGVuIGNvbXBpbGVkIGFnYWlu
c3Qga2VybmVsLTYuNyBhbmQgYWJvdmUuCj4KPiAgIHRjaW5kZXgwMS5jOjY3OjQ6IGVycm9yOiDi
gJhUQ0FfVENJTkRFWF9NQVNL4oCZIHVuZGVjbGFyZWQgaGVyZSAobm90IGluIGEgZnVuY3Rpb24p
Owo+ICAgICAgZGlkIHlvdSBtZWFuIOKAmFRDQV9DT0RFTF9NQVjigJk/Cj4gICAgICB7VENBX1RD
SU5ERVhfTUFTSywgJm1hc2ssIHNpemVvZihtYXNrKSwgTlVMTH0sCj4gICAgICAgXn5+fn5+fn5+
fn5+fn5+fgo+ICAgICAgIFRDQV9DT0RFTF9NQVgKPiAgIHRjaW5kZXgwMS5jOjY4OjQ6IGVycm9y
OiDigJhUQ0FfVENJTkRFWF9TSElGVOKAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1bmN0
aW9uKTsKPiAgICAgIGRpZCB5b3UgbWVhbiDigJhUQ0FfRkxPV19SU0hJRlTigJk/Cj4gICAgICB7
VENBX1RDSU5ERVhfU0hJRlQsICZzaGlmdCwgc2l6ZW9mKHNoaWZ0KSwgTlVMTH0sCj4gICAgICAg
Xn5+fn5+fn5+fn5+fn5+fn4KPiAgICAgICBUQ0FfRkxPV19SU0hJRlQKPiAgIENDIHRlc3RjYXNl
cy9jdmUvY3ZlLTIwMTYtNzExNwo+ICAgQ0MgdXRpbHMvc2N0cC9mdW5jX3Rlc3RzL3Rlc3RfZ2V0
bmFtZV92Ni5vCj4gICB0Y2luZGV4MDEuYzo2OTo0OiBlcnJvcjog4oCYVENBX1RDSU5ERVhfQ0xB
U1NJROKAmSB1bmRlY2xhcmVkIGhlcmUgKG5vdCBpbiBhIGZ1bmN0aW9uKTsKPiAgICAgIGRpZCB5
b3UgbWVhbiDigJhUQ0FfRkxPV0VSX0NMQVNTSUTigJk/Cj4gICAgICB7VENBX1RDSU5ERVhfQ0xB
U1NJRCwgJmNsc2lkLCBzaXplb2YoY2xzaWQpLCBOVUxMfSwKPiAgICAgICBefn5+fn5+fn5+fn5+
fn5+fn5+Cj4gICAgICAgVENBX0ZMT1dFUl9DTEFTU0lECj4KPiBUaGUgZXJyb3JzIHdlcmUgZHVl
IHRvIHRoZSByZW1vdmFsIG9mIGNlcnRhaW4gVENBX1RDSU5ERVhfIGNvbnN0YW50cwo+IGZyb20g
dGhlIGtlcm5lbCdzIHVzZXIgQVBJICh1YXBpKSwgYXMgaW5kaWNhdGVkIGJ5IHRoZSBrZXJuZWwg
Y29tbWl0Lgo+Cj4gICBjb21taXQgODJiMjU0NWVkOWEgKG5ldC9zY2hlZDogUmVtb3ZlIHVhcGkg
c3VwcG9ydCBmb3IgdGNpbmRleCBjbGFzc2lmaWVyKQo+Cj4gVGhlIHJlYXNvbiB3aHkgSSBkaWRu
J3QgYWRkIHRoaXMgaW50byBMVFAgbGlicmFyeSBpcyB0aGF0IHRoZSBkZWZpbmVzCj4gaGF2ZSBi
ZWVuIGRyb3BwZWQgd2UganVzdCBuZWVkIHRvIHNhdGlzZnkgdGhpcyBvbmUgY2FzZS4KPiAtLS0K
Pgo+IE5vdGVzOgo+ICAgICBXZSBuZWVkIHRvIG1lcmdlIHRoaXMgcGF0Y2ggYmVmb3JlIHRoZSBu
ZXcgcmVsZWFzZS4KPgo+ICB0ZXN0Y2FzZXMvY3ZlL3RjaW5kZXgwMS5jIHwgMTcgKysrKysrKysr
KysrKysrKysKPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKykKPgoKClBhcmRvbiBt
eSBpZ25vcmFuY2UgLSB3aGF0IGlzIHRoaXMgdHJlZT8gSSBkb250IHJlY2FsbCBzZWVpbmcgdGhp
cwphbnl3aGVyZS4gSWYgeW91IHB1bGwgdWFwaSBoZWFkZXJzIGZyb20gdGhlIGtlcm5lbCBvbiB5
b3VyIHRyZWUgeW91CmNhbiBjYXRjaCB0aGVzZSBkZWxldGlvbnMgc29vbmVyLi4KCmNoZWVycywK
amFtYWwKCj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9jdmUvdGNpbmRleDAxLmMgYi90ZXN0Y2Fz
ZXMvY3ZlL3RjaW5kZXgwMS5jCj4gaW5kZXggYjRmMmJiMDFhLi43MGU1NjM5ZjEgMTAwNjQ0Cj4g
LS0tIGEvdGVzdGNhc2VzL2N2ZS90Y2luZGV4MDEuYwo+ICsrKyBiL3Rlc3RjYXNlcy9jdmUvdGNp
bmRleDAxLmMKPiBAQCAtMzIsNiArMzIsMjMgQEAKPgo+ICAjZGVmaW5lIERFVk5BTUUgImx0cF9k
dW1teTEiCj4KPiArI2lmbmRlZiBUQ0FfVENJTkRFWF9NQVgKPiArZW51bSB7Cj4gKyAgICAgICBU
Q0FfVENJTkRFWF9VTlNQRUMsCj4gKyAgICAgICBUQ0FfVENJTkRFWF9IQVNILAo+ICsgICAgICAg
VENBX1RDSU5ERVhfTUFTSywKPiArICAgICAgIFRDQV9UQ0lOREVYX1NISUZULAo+ICsgICAgICAg
VENBX1RDSU5ERVhfRkFMTF9USFJPVUdILAo+ICsgICAgICAgVENBX1RDSU5ERVhfQ0xBU1NJRCwK
PiArICAgICAgIFRDQV9UQ0lOREVYX1BPTElDRSwKPiArICAgICAgIFRDQV9UQ0lOREVYX0FDVCwK
PiArICAgICAgIF9fVENBX1RDSU5ERVhfTUFYCj4gK307Cj4gKwo+ICsjZGVmaW5lIFRDQV9UQ0lO
REVYX01BWCAgICAgKF9fVENBX1RDSU5ERVhfTUFYIC0gMSkKPiArI2VuZGlmCj4gKwo+ICsKPiAg
c3RhdGljIGNvbnN0IHVpbnQzMl90IHFkX2hhbmRsZSA9IFRDX0hfTUFLRSgxIDw8IDE2LCAwKTsK
PiAgc3RhdGljIGNvbnN0IHVpbnQzMl90IGNsc2lkID0gVENfSF9NQUtFKDEgPDwgMTYsIDEpOwo+
ICBzdGF0aWMgY29uc3QgdWludDMyX3Qgc2hpZnQgPSAxMDsKPiAtLQo+IDIuNDAuMQo+CgotLSAK
TWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
