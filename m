Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA107C5B543
	for <ltp@archiver.kernel.org>; Sat,  7 Jun 2025 04:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1749268939; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=HW8tHJLYLE6CRZUvSicr8IcrQ8i+bU47y8x9CckfjlI=;
 b=F3o3LuBx2eQvmwywwiXfelvrCAlRD/C7QU0qLDHR0tFv5HpOHQGH/QdYUy7Q9Uh0UvdtE
 x1ZAw/DxZ2cpwvKf+rxgng6nHDnhy/PXL0Q9yz7FzB0ZAsGKp5myevItVctGa6Rd4cBGEe0
 lKTnr3VJ7UBDnFGQIIE+j3Sjh2fUbgg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A53F83CA627
	for <ltp@archiver.kernel.org>; Sat,  7 Jun 2025 06:02:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F139B3C9B17
 for <ltp@lists.linux.it>; Sat,  7 Jun 2025 06:01:57 +0200 (CEST)
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 22BD720024F
 for <ltp@lists.linux.it>; Sat,  7 Jun 2025 06:01:57 +0200 (CEST)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-3a4f78ebec8so1627382f8f.0
 for <ltp@lists.linux.it>; Fri, 06 Jun 2025 21:01:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1749268916; x=1749873716; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i/I7ZJGMXj9JnrttNVV1gUFzwUnh4tf2RyDlxViGYwY=;
 b=NIQpP+nemDthjM497XvokbLz5Unfb9ueT8sx4Ncg/XS4j/FFnCu4ETOvjb1douAlWY
 cCZiNcZ3ov8Fb9zWakFuDyb7JcebOUm/1RJidKzjjhB74zxP0e9C7aIrpsQt9XVrJlqt
 PEYmr1Zi416aMIreTjpKuxOQ8cXY2GeDx2zwAe/Fw770z6j/MyN2DhfIiwSqZRhoDGWq
 3O8412fanNpze8YIS9vuytQDydABRiWTFMf3+O3mT7/9uubHQ89bKC/jdtqgPLUsTqlF
 SvMyDg4H9sz+c7eAIe9tWQXEpPFYaQD6VZmah/TAUXme8cPDiApCpCdf9FBy2phcTc37
 qIxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749268916; x=1749873716;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i/I7ZJGMXj9JnrttNVV1gUFzwUnh4tf2RyDlxViGYwY=;
 b=hw8DmpnIUEghXetTRWOL4RNtY9rHvgAE67zrQfSOOY0HwTf4RvFCWCGlqcCYSG9nSx
 ziJz4+jdHojVVcF/GkQvcgfrOyp+RDMfqdXMsdNVYz6S7f/j8b8AcA1pIyNkfiG+VIUE
 MPzYXiUnY15J7awbBWglmpvDWvP38nSZ2k7OsqpkMlfwseZH9MwWU0At5c90fNo+2e2m
 loMwYBM1fbERBBtQVHny9ClA9kidzjMMhNqBMQnuBmGtHVDop5i8HNAQmb8avUUeXUGl
 VOonacd7Ui+V4pUFOqPuI/WQon/RE0N/1lj/9N7A712N2f4u07VPNGp6XPJyasMsEhrj
 q46A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIoWrmULlzngWttqlBPbX0qHwxbC5Fs8sNStP4gTGoG10B45l5pWniAwv1GaMj5hXIkRM=@lists.linux.it
X-Gm-Message-State: AOJu0YzhvOAk3HbmzxyGriy92CsBAtrKV8QvL7+p07oYTkzZOQRvAZJ7
 LGz9V6KgIX1l7KBsNWrZLmJdhkLC0JKfgQdHmu10jHBAT+5LvjZzznpaVQ9BWvfdMtk0cOFpNZn
 7LTbn5MfhiHLGvEiu+lrBcsyy3JSYYiWVJefTJFYu
X-Gm-Gg: ASbGnctUfSyEPaVXqEzctvf7gBRkGacRnCTn/vb3oI+RnMn4YhLkhkfX6kw4WLWt8Zr
 KWJPK+mblIil9Wbu9d9qHF37Mtn2FOKmzO9dekE6zC+4rQFeasBQDeYEuXgbv9U1rrCV1/wsNNL
 PLnaVS0GCvGY3RmVt79eWvt/FaHWWh
X-Google-Smtp-Source: AGHT+IGpwADNOCWP1+z3K5i8C8peUT6dlf2RJi6nKdrAtEaDPoPi4EoGv1LsxJRZSMtOe7OEANbS/oWqgWcooOpRbcQ=
X-Received: by 2002:a05:6000:18a2:b0:3a5:2208:41e3 with SMTP id
 ffacd0b85a97d-3a5319ba177mr3814674f8f.4.1749268916375; Fri, 06 Jun 2025
 21:01:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250605142943.229010-1-wegao@suse.com>
 <20250605094019.GA1206250@pevik>
 <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
In-Reply-To: <orzx7vfokvwuceowwjctea4yvujn75djunyhsqvdfr5bw7kqe7@rkn5tlnzwllu>
Date: Sat, 7 Jun 2025 12:01:45 +0800
X-Gm-Features: AX0GCFtNqzsrwO-5FPZ6OtsI2qy_NWZ37XgJ5QgSA7Qo4bjLAtIWHXdMeiWVnFw
Message-ID: <CAJs-1pX-L=SD1=QQb3okn+yMcygLA8x9JhmbChfnFdP7Kw3n=w@mail.gmail.com>
To: =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] sched_rr_get_interval01.c: Put test process
 into absolute root cgroup (0::/)
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it, cgroups@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

IEBNaWNoYWwgS291dG7DvSA8bWtvdXRueUBzdXNlLmNvbT4gIFNvIHdlIHNob3VsZCBza2lwIHRl
c3QgY2dyb3VwdjIgd2l0aApDT05GSUdfUlRfR1JPVVBfU0NIRUQ9eWVzLCBjb3JyZWN0PyBMaWtl
IGZvbGxvd2luZyBjaGFuZ2U/CgpkaWZmIC0tZ2l0CmEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxs
cy9zY2hlZF9ycl9nZXRfaW50ZXJ2YWwvc2NoZWRfcnJfZ2V0X2ludGVydmFsMDEuYwpiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvc2NoZWRfcnJfZ2V0X2ludGVydmFsL3NjaGVkX3JyX2dldF9p
bnRlcnZhbDAxLmMKaW5kZXggNTU1MTZlYzg5Li5iMTJiZDc4NTcgMTAwNjQ0Ci0tLQphL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvc2NoZWRfcnJfZ2V0X2ludGVydmFsL3NjaGVkX3JyX2dldF9p
bnRlcnZhbDAxLmMKKysrCmIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zY2hlZF9ycl9nZXRf
aW50ZXJ2YWwvc2NoZWRfcnJfZ2V0X2ludGVydmFsMDEuYwpAQCAtNDMsMTAgKzQzLDkgQEAgc3Rh
dGljIHZvaWQgc2V0dXAodm9pZCkKCiAgICAgICAgdHAudHlwZSA9IHR2LT50c190eXBlOwoKKyAg
ICAgICBzdGF0aWMgY29uc3QgY2hhciAqIGNvbnN0IGtjb25mW10gPSB7IkNPTkZJR19SVF9HUk9V
UF9TQ0hFRD15IiwKTlVMTH07CisgICAgICAgaWYgKChhY2Nlc3MoIi9zeXMvZnMvY2dyb3VwL2Nn
cm91cC5jb250cm9sbGVycyIsIEZfT0spID09IDApICYmCiF0c3Rfa2NvbmZpZ19jaGVjayhrY29u
Zl9zdHJpY3QpKSB7CisgICAgICAgICAgICAgICB0c3RfYnJrKFRDT05GLCAiQ09ORklHX1JUX0dS
T1VQX1NDSEVEIG5vdCBzdXBwb3J0IG9uCmNncm91cHYyIik7CisgICAgICAgfQoKICAgICAgICBp
ZiAoKHN5c19zY2hlZF9zZXRzY2hlZHVsZXIoMCwgU0NIRURfUlIsICZwKSkgPT0gLTEpCgoKT24g
VGh1LCBKdW4gNSwgMjAyNSBhdCAxMTo1NuKAr1BNIE1pY2hhbCBLb3V0bsO9IDxta291dG55QHN1
c2UuY29tPiB3cm90ZToKCj4gT24gVGh1LCBKdW4gMDUsIDIwMjUgYXQgMTE6NDA6MTlBTSArMDIw
MCwgUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gd3JvdGU6Cj4gPiBATWljaGFsIEBMaSBX
RFlUPwo+Cj4gUlRfR1JPVVAgc2NoZWR1bGluZyBpcyB2MSBmZWF0dXJlIGFzIG9mIG5vdy4KPgo+
IFRlc3RpbmcgY2dyb3VwIHYyIG1ha2VzIG9ubHkgc2Vuc2Ugd2l0aAo+IENPTkZJR19SVF9HUk9V
UF9TQ0hFRD15IGFuZCBDT05GSUdfUlRfR1JPVVBfU0NIRURfREVGQVVMVF9ESVNBQkxFRD15Cj4g
KHRoaXMgY29tYmluYXRpb24gaXMgZXF1aXZhbGVudCB0byBDT05GSUdfUlRfR1JPVVBfU0NIRUQ9
biBvbiB2MikuCj4KPiBIVEgsCj4gTWljaGFsCj4KCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
