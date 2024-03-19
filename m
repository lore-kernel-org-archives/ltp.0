Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41679C54E5D
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 08:39:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 75BB03CE72F
	for <ltp@archiver.kernel.org>; Tue, 19 Mar 2024 09:39:11 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 315A93CD4CA
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 09:38:51 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 030E21000C20
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 09:38:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710837529;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Bd6/dudhoL7clAUAOqaEdJw7IctW3+R1/TultflhSZE=;
 b=JHZ1JZ8Pde19/XNZfQZSZo7zJNbvowvM7HiCN4/NsgVLmtNN5bx7yqoVpTx80eZWUtQya5
 lEZlsKXfV6T54bC/V/zaeX02DXfPd5R1GIAlCSaQJIBczC/8772AUNScYW/TNZI+N0l9SA
 kSsdv1Y9H5x/l5zrktuNiRJLPafr4ag=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-179-tjVCP_9LOiSknPu1syn-oQ-1; Tue, 19 Mar 2024 04:38:47 -0400
X-MC-Unique: tjVCP_9LOiSknPu1syn-oQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-29f96135606so1952458a91.1
 for <ltp@lists.linux.it>; Tue, 19 Mar 2024 01:38:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710837525; x=1711442325;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bd6/dudhoL7clAUAOqaEdJw7IctW3+R1/TultflhSZE=;
 b=h6F9ik70YZlW2tASnVEOHdyR3uy8JL2js2/hMNf5V/j4qLOuna8Ff2lHqiqE4iX7Nw
 RqSa0Xh1IwrcnZDknwsziqSyt9hhDZCk8QzLcYoG0bdPTGA4+PWhJC2D5mfeGJwi3kSo
 Xio15cEO4s0mkXNKZV3uGx1cHEoqzkZyh74SlOH9ABN65ma8X3Pu6Wb0sWSylYmFjzRJ
 gzNi9WULG+fjPQiYegGcRRkGJwpDgVmEQH0WymjO7O/ReYH3THoCaFrlikL5bnkOTiby
 HnSUvEP+b/sxQ1z9hnfaPBRN6kDnVElzvGUubzLPx+sdn2u4UDJzbeKTmf2efbrRT4Gp
 RA7A==
X-Gm-Message-State: AOJu0YyRvK+huvn3KR1//By9OT4qq8mu8DB3+UgSVCn3A+x9U2Qmh7zj
 WzxulMy7bhoxEi9d0+DaY7iwgXDysVij8BIcGaJt7gga21wOmB5gCKBtD1rm4FSYwltukDcZqN4
 qdWSUcvhHrJzWHGSOp9xorhHzlaRbrrKWCjin89Fcgh23v5Htt191f8d/EstgiYEVGr0yxhAS2H
 psr/8UxefiXrcX6JtbCSbgXsUSp4Z8m9sf5/Lm
X-Received: by 2002:a17:90b:617:b0:29b:fa9f:af9f with SMTP id
 gb23-20020a17090b061700b0029bfa9faf9fmr13069840pjb.18.1710837524644; 
 Tue, 19 Mar 2024 01:38:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFX3iMhJSNDfrPASuYi30N32PW97nhjt4/2zGSgVBNWk3t7t5SZcpPryhjUj6InOeJh693tGdGXHmBVHWMhDxU=
X-Received: by 2002:a17:90b:617:b0:29b:fa9f:af9f with SMTP id
 gb23-20020a17090b061700b0029bfa9faf9fmr13069828pjb.18.1710837524204; Tue, 19
 Mar 2024 01:38:44 -0700 (PDT)
MIME-Version: 1.0
References: <20240319070040.3239539-1-liwang@redhat.com>
In-Reply-To: <20240319070040.3239539-1-liwang@redhat.com>
From: Li Wang <liwang@redhat.com>
Date: Tue, 19 Mar 2024 16:38:31 +0800
Message-ID: <CAEemH2c+gLkjP-3j+SnN=qvnLKZF4LMjCMxWtPd-6TpUM2i55w@mail.gmail.com>
To: ltp@lists.linux.it, Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/3] libswap: add two method to create swapfile
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

T24gVHVlLCBNYXIgMTksIDIwMjQgYXQgMzowMeKAr1BNIExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQu
Y29tPiB3cm90ZToKCj4gVGhpcyBpbnRyb2R1Y2VzIG5ldyBmdW5jdGlvbmFsaXR5IHRvIHRoZSBs
aWJzd2FwIGxpYnJhcnkgYnkgYWRkaW5nCj4gdHdvIG1ldGhvZHMgZm9yIGNyZWF0aW5nIGEgc3dh
cGZpbGU6IFNXQVBGSUxFX0JZX1NJWkUgYW5kCj4gU1dBUEZJTEVfQllfQkxPQ0tTLgo+IFRoZSBt
YWtlX3N3YXBmaWxlIGZ1bmN0aW9uIGlzIHVwZGF0ZWQgdG8gYWNjZXB0IGFuIGFkZGl0aW9uYWwg
ZW51bQo+IHN3YXBmaWxlX21ldGhvZCBwYXJhbWV0ZXIgdG8gc3BlY2lmeSB0aGUgY3JlYXRpb24g
bWV0aG9kLgo+Cj4gVHdvIG1hY3JvcywgTUFLRV9TV0FQRklMRV9TSVpFIGFuZCBNQUtFX1NXQVBG
SUxFX0JMS1MsIGFyZSBkZWZpbmVkCj4gdG8gc2ltcGxpZnkgdGhlIGludGVyZmFjZSBmb3IgY3Jl
YXRpbmcgc3dhcGZpbGVzIGJ5IHNpemUgYW5kIGJ5Cj4gYmxvY2tzIHJlc3BlY3RpdmVseS4KPiAt
LS0KPiAgaW5jbHVkZS9saWJzd2FwLmggICAgICAgICB8IDE2ICsrKysrKysrKysrKysrLS0KPiAg
bGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKystLS0t
LS0tLQo+ICAyIGZpbGVzIGNoYW5nZWQsIDM2IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGlic3dhcC5oIGIvaW5jbHVkZS9saWJzd2FwLmgK
PiBpbmRleCA4Yzc1ZTIwYWUuLjFkZWU5MDdmMCAxMDA2NDQKPiAtLS0gYS9pbmNsdWRlL2xpYnN3
YXAuaAo+ICsrKyBiL2luY2x1ZGUvbGlic3dhcC5oCj4gQEAgLTExLDEwICsxMSwyMiBAQAo+ICAj
aWZuZGVmIF9fTElCU1dBUF9IX18KPiAgI2RlZmluZSBfX0xJQlNXQVBfSF9fCj4KPiArZW51bSBz
d2FwZmlsZV9tZXRob2Qgewo+ICsgICAgU1dBUEZJTEVfQllfU0laRSwKPiArICAgIFNXQVBGSUxF
X0JZX0JMT0NLUwo+ICt9Owo+ICsKPiAgLyoKPiAtICogTWFrZSBhIHN3YXAgZmlsZQo+ICsgKiBD
cmVhdGUgYSBzd2FwZmlsZSBvZiBhIHNwZWNpZmllZCBzaXplIG9yIG51bWJlciBvZiBibG9ja3Mu
Cj4gICAqLwo+IC1pbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFyICpzd2FwZmlsZSwgaW50IGJs
b2NrcywgaW50IHNhZmUpOwo+ICtpbnQgbWFrZV9zd2FwZmlsZShjb25zdCBjaGFyICpzd2FwZmls
ZSwgdW5zaWduZWQgaW50IG51bSwKPiArICAgICAgICAgICAgICAgICAgICAgICBpbnQgc2FmZSwg
ZW51bSBzd2FwZmlsZV9tZXRob2QgbWV0aG9kKTsKPiArCj4gKyNkZWZpbmUgTUFLRV9TV0FQRklM
RV9TSVpFKHN3YXBmaWxlLCBzaXplLCBzYWZlKSBcCj4gKyAgICBtYWtlX3N3YXBmaWxlKHN3YXBm
aWxlLCBzaXplLCBzYWZlLCBTV0FQRklMRV9CWV9TSVpFKQo+ICsKPiArI2RlZmluZSBNQUtFX1NX
QVBGSUxFX0JMS1Moc3dhcGZpbGUsIGJsb2Nrcywgc2FmZSkgXAo+ICsgICAgbWFrZV9zd2FwZmls
ZShzd2FwZmlsZSwgYmxvY2tzLCBzYWZlLCBTV0FQRklMRV9CWV9CTE9DS1MpCj4KPiAgLyoKPiAg
ICogQ2hlY2sgc3dhcG9uL3N3YXBvZmYgc3VwcG9ydCBzdGF0dXMgb2YgZmlsZXN5c3RlbXMgb3Ig
ZmlsZXMKPiBkaWZmIC0tZ2l0IGEvbGlicy9saWJsdHBzd2FwL2xpYnN3YXAuYyBiL2xpYnMvbGli
bHRwc3dhcC9saWJzd2FwLmMKPiBpbmRleCBhMjZlYTI1ZTQuLjZhMGYyNGVkMiAxMDA2NDQKPiAt
LS0gYS9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jCj4gKysrIGIvbGlicy9saWJsdHBzd2FwL2xp
YnN3YXAuYwo+IEBAIC0xMzMsMjMgKzEzMywzNyBAQCBvdXQ6Cj4gICAgICAgICByZXR1cm4gY29u
dGlndW91czsKPiAgfQo+Cj4gLWludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKnN3YXBmaWxl
LCBpbnQgYmxvY2tzLCBpbnQgc2FmZSkKPiAraW50IG1ha2Vfc3dhcGZpbGUoY29uc3QgY2hhciAq
c3dhcGZpbGUsIHVuc2lnbmVkIGludCBudW0sIGludCBzYWZlLCBlbnVtCj4gc3dhcGZpbGVfbWV0
aG9kIG1ldGhvZCkKPiAgewo+ICAgICAgICAgc3RydWN0IHN0YXR2ZnMgZnNfaW5mbzsKPiAgICAg
ICAgIHVuc2lnbmVkIGxvbmcgYmxrX3NpemUsIGJzOwo+ICAgICAgICAgc2l6ZV90IHBnX3NpemUg
PSBzeXNjb25mKF9TQ19QQUdFU0laRSk7Cj4gICAgICAgICBjaGFyIG1udF9wYXRoWzEwMF07Cj4g
KyAgICAgICB1bnNpZ25lZCBpbnQgYmxvY2tzOwo+Cj4gICAgICAgICBpZiAoc3RhdHZmcygiLiIs
ICZmc19pbmZvKSA9PSAtMSkKPiAgICAgICAgICAgICAgICAgcmV0dXJuIC0xOwo+Cj4gICAgICAg
ICBibGtfc2l6ZSA9IGZzX2luZm8uZl9ic2l6ZTsKPgo+IC0gICAgICAgLyogVG8gZ3VhcmFudGVl
IGF0IGxlYXN0IG9uZSBwYWdlIGNhbiBiZSBzd2FwcGVkIG91dCAqLwo+IC0gICAgICAgaWYgKGJs
a19zaXplICogYmxvY2tzIDwgcGdfc2l6ZSkKPiAtICAgICAgICAgICAgICAgYnMgPSBwZ19zaXpl
Owo+IC0gICAgICAgZWxzZQo+IC0gICAgICAgICAgICAgICBicyA9IGJsa19zaXplOwo+CgoKCj4g
KyAgICAgICBzd2l0Y2ggKG1ldGhvZCkgewo+ICsgICAgICAgY2FzZSBTV0FQRklMRV9CWV9CTE9D
S1M6Cj4gKyAgICAgICAgICAgICAgIGJsb2NrcyA9IG51bTsKPiArICAgICAgICAgICAgICAgaWYg
KGJsa19zaXplICogYmxvY2tzIDwgcGdfc2l6ZSkKPiArICAgICAgICAgICAgICAgICAgICAgICBi
cyA9IHBnX3NpemU7Cj4gKyAgICAgICAgICAgICAgIGVsc2UKPiArICAgICAgICAgICAgICAgICAg
ICAgICBicyA9IGJsa19zaXplOwo+ICsgICAgICAgYnJlYWs7Cj4gKyAgICAgICBjYXNlIFNXQVBG
SUxFX0JZX1NJWkU6Cj4gKyAgICAgICAgICAgICAgIGlmIChudW0gKiAxMDI0ICogMTAyNCA8IHBn
X3NpemUpCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnMgPSBwZ19zaXplOwo+ICsgICAgICAg
ICAgICAgICBlbHNlCj4gKyAgICAgICAgICAgICAgICAgICAgICAgYnMgPSBibGtfc2l6ZTsKPiAr
ICAgICAgICAgICAgICAgYmxvY2tzID0gKG51bSAqIDEwMjQgKiAxMDI0KSAvIGJsa19zaXplOwo+
ICsgICAgICAgYnJlYWs7Cj4gKyAgICAgICBkZWZhdWx0Ogo+ICsgICAgICAgICAgICAgICByZXR1
cm4gLTE7Cj4gKyAgICAgICB9Cj4KCk9idmlvdXNseSwgdGhpcyBwYXJ0IGlzIHRvbyB1Z2x5LCBJ
IHdvdWxkIHRha2UgdGhlIHdheSBXZWkgcG9zdGVkIGluCmFub3RoZXIgdGhyZWFkLCB0aGFua3Mu
CgpTb21ldGhpbmcgbGlrZToKCisgICAgICAgaWYgKG1ldGhvZCA9PSBTV0FQRklMRV9CWV9TSVpF
KQorICAgICAgICAgICAgICAgYmxvY2tzID0gbnVtICogMTAyNCAqIDEwMjQgLyBibGtfc2l6ZTsK
KyAgICAgICBlbHNlIGlmIChtZXRob2QgPT0gU1dBUEZJTEVfQllfQkxPQ0tTKQorICAgICAgICAg
ICAgICAgYmxvY2tzID0gbnVtOworICAgICAgIGVsc2UKKyAgICAgICAgICAgICAgIHRzdF9icmso
VEJST0ssICJJbnZhbGlkZSBtZXRob2QuIik7CgoKCj4KPiAgICAgICAgIGlmIChzc2NhbmYoc3dh
cGZpbGUsICIlW14vXSIsIG1udF9wYXRoKSAhPSAxKQo+ICAgICAgICAgICAgICAgICB0c3RfYnJr
KFRCUk9LLCAic3NjYW5mIGZhaWxlZCIpOwo+IEBAIC0xNzUsMTMgKzE4OSwxMyBAQCBpbnQgbWFr
ZV9zd2FwZmlsZShjb25zdCBjaGFyICpzd2FwZmlsZSwgaW50IGJsb2NrcywKPiBpbnQgc2FmZSkK
PiAgICAgICAgIGFyZ3ZbMl0gPSBOVUxMOwo+Cj4gICAgICAgICByZXR1cm4gdHN0X2NtZChhcmd2
LCAiL2Rldi9udWxsIiwgIi9kZXYvbnVsbCIsIHNhZmUgPwo+IC0gICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgVFNUX0NNRF9QQVNTX1JFVFZBTCB8Cj4gVFNUX0NNRF9UQ09ORl9PTl9N
SVNTSU5HIDogMCk7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgVFNUX0NNRF9QQVNTX1JFVFZB
TCB8IFRTVF9DTURfVENPTkZfT05fTUlTU0lORyA6Cj4gMCk7Cj4gIH0KPgo+ICBib29sIGlzX3N3
YXBfc3VwcG9ydGVkKGNvbnN0IGNoYXIgKmZpbGVuYW1lKQo+ICB7Cj4gICAgICAgICBpbnQgaSwg
c3dfc3VwcG9ydCA9IDA7Cj4gLSAgICAgICBpbnQgcmV0ID0gbWFrZV9zd2FwZmlsZShmaWxlbmFt
ZSwgMTAsIDEpOwo+ICsgICAgICAgaW50IHJldCA9IE1BS0VfU1dBUEZJTEVfQkxLUyhmaWxlbmFt
ZSwgMTAsIDEpOwo+ICAgICAgICAgaW50IGZpX2NvbnRpZ3VvdXMgPSBmaWxlX2lzX2NvbnRpZ3Vv
dXMoZmlsZW5hbWUpOwo+ICAgICAgICAgbG9uZyBmc190eXBlID0gdHN0X2ZzX3R5cGUoZmlsZW5h
bWUpOwo+ICAgICAgICAgY29uc3QgY2hhciAqZnN0eXBlID0gdHN0X2ZzX3R5cGVfbmFtZShmc190
eXBlKTsKPiAtLQo+IDIuNDAuMQo+Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZvOiBodHRwczov
L2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgot
LSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cg==
