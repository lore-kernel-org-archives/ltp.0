Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B166CC44500
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 12:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769084918; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=IbMyO5ZuKG4Z1egvpCrDcWAHQufXk9YedcMUGmrYD00=;
 b=N7RCi2t3liGEb8i4kTYyz0irULbMZHat0p3MsqaiuyNQ6zHWbcuBsl92P6IKl3lEAnDTQ
 aQLZIrsGjhFaDlIMnxFZvEYgRKjyfh5BRLECuQp9pbAbmkfAGuDKJ+57YeSOIwlAIJ6l3cF
 fgFBEFlsmMXAhIAlii4xclIBFtYi64w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F4D03CB47C
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 13:28:38 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DD60C3CAEBB
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:28:13 +0100 (CET)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CF1F81000A58
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 13:28:09 +0100 (CET)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-42fb5810d39so539026f8f.2
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 04:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1769084889; x=1769689689; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=tHigd6zvIE+uqSUgeBwASLj2jrjfv6mdwJ2xKAGp3do=;
 b=HXKbmVpC3aLJqtYkh2iV+GyBO3lTrpaspJjyHEAbHQ/S18w+rLNth0XyP682+1fVPa
 /yt8tYXExjQLyJQwX5xtHzDTINbefdTrcPx4c072jYBTxq8xnRV0FtEQdx7TMCVOhP2J
 gGv9MQFtrbuZDHJL3sAh5es5Kn3MKeFcEyY9RIZxwATGDpV2Dkyw/l92aZ9VCSuLZuNO
 cm2fhLe+EraWWERZc94NFdl9cmRYh+akfgUFo8yzhrNnZqNDzA7/I69KPIcTv0wy/utL
 4IAF1GppjK3f2mnJf4wRoeIINRW3QmO5aJWvYQj2LzxZsE/zos8Cr/yDX7fz583UeX4J
 Ef1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769084889; x=1769689689;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=tHigd6zvIE+uqSUgeBwASLj2jrjfv6mdwJ2xKAGp3do=;
 b=g1RnZVjOxKRdjH/KSwPSAS6gzqdT37sJ7+S36T20XqMHsJlo5e1r6/A+e0oG1uDA58
 XZjnpNfIUEk4v38J1krxxNC0K1V2TZPVu2qwPN4Cs5g7aAg8aulWX8hTaPtrVU3Q5E58
 9YEO17fxoqSKrdiIua0prQh2lAtBHoP/bEMH1YcVq8WcxY466L2Tqe+XAJ+twN6eeG8a
 O/ErYRpXv3HYlFc5SqD06sPKkvNmY19YT69Ys50qlwVFhPQVg/ax+Yozo2Mg+yGQZdad
 SRyQ3qDeLvlRGX9yq9CvJWGTAmxNQ/S5dK3ZPqgWmXoV9nr69ldY0uF283b9nYVJbrUM
 L/EQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVmO3GWRU8mRq9/420Jj55nveBAzt8GwenD/9iiVtNXCpjZVaogUud/7UctH5plS4dIYF4=@lists.linux.it
X-Gm-Message-State: AOJu0YyImLB9xIeMuQLqxaDwAMzD0uAYgUzSMP14Sku14dLlBG+4WDWA
 MO5px870ZKeYNK9OXg/vWZYFF3m4+Ln4/C6dY/p7tcVvSWg/F3RoY40OwLG76ULpIg==
X-Gm-Gg: AZuq6aJ3wU6lpGj3qPoXZlIBcvdhz2yAzrqFb65QeHNTRSIX2GJpRCHbJWUeTZrUvjy
 oXHnAUc3Kf9jFxeP4CA+uxEkN7Aesdc9q1x45SOMj40P9jIeR5Gi+IAZ02ppDv+EcvWaHNsp7+1
 k5blcJBEdnjrAnDpAD25SyqpuLjJwY91ygQfU66CD7883xDpqAdvpbu6d4/JbtgmkGzHEIcjR4L
 F1ZErViq6Jo6yIBtjygPREADC+h2ssMqBqT8fu52G6oollAbB2SU7DU2D/C5uCbgdYNsT0RbwCF
 KtQqFaw1P8BGav79c1a5yHq8R7ST1AI5D2J4GLI7Gmhe6uSgDt60XdkfMPMFoNHEmX0ZGS9FSsm
 gJFNxa8WWn4EM+fClhRvNxdMOeaIdc9eelLj/ZSQCkW+saU0dxuHEvnhmJiFZLT61YoqFvfbLhB
 /OY/28p8ga7jM32mKsweGbT8b4fDRfxrUwxyA/Ymk=
X-Received: by 2002:a05:6000:4304:b0:432:8504:b8a9 with SMTP id
 ffacd0b85a97d-4356a06769cmr32731567f8f.62.1769084889192; 
 Thu, 22 Jan 2026 04:28:09 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921da2sm44844299f8f.1.2026.01.22.04.28.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Jan 2026 04:28:08 -0800 (PST)
Date: Thu, 22 Jan 2026 12:28:07 +0000
To: Jan Stancek <jstancek@redhat.com>, es@autotest-wegao.qe.prg2.suse.org
Message-ID: <aXIX15fDEukIUyCz@autotest-wegao.qe.prg2.suse.org>
References: <20260122102606.87754-1-liwang@redhat.com>
 <CAASaF6w3S2STiyS9LvOsK_uVEvRoO6uq=XNMG-cMNheC0k1RHg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6w3S2STiyS9LvOsK_uVEvRoO6uq=XNMG-cMNheC0k1RHg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] clone10: add support archs
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKYW4gMjIsIDIwMjYgYXQgMTE6NDE6NDBBTSArMDEwMCwgSmFuIFN0YW5jZWsgdmlh
IGx0cCB3cm90ZToKPiBPbiBUaHUsIEphbiAyMiwgMjAyNiBhdCAxMToyNuKAr0FNIExpIFdhbmcg
dmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5
OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4gIHRlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUxMC5jIHwgNiArKysrKysKPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgNiBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvY2xvbmUvY2xvbmUxMC5jIGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9u
ZS9jbG9uZTEwLmMKPiA+IGluZGV4IGE1MmFjMzU2OC4uOWZmYjQ5YzM3IDEwMDY0NAo+ID4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9jbG9uZS9jbG9uZTEwLmMKPiA+ICsrKyBiL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvY2xvbmUvY2xvbmUxMC5jCj4gPiBAQCAtOTEsNCArOTEs
MTAgQEAgc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ID4gICAgICAgICAuY2xlYW51
cCA9IGNsZWFudXAsCj4gPiAgICAgICAgIC5uZWVkc19jaGVja3BvaW50cyA9IDEsCj4gPiAgICAg
ICAgIC50ZXN0X2FsbCA9IHZlcmlmeV90bHMsCj4gPiArICAgICAgIC5zdXBwb3J0ZWRfYXJjaHMg
PSAoY29uc3QgY2hhciAqY29uc3QgW10pIHsKPiA+ICsgICAgICAgICAgICAgICAieDg2XzY0IiwK
PiA+ICsgICAgICAgICAgICAgICAiYWFyY2g2NCIsCj4gPiArICAgICAgICAgICAgICAgInMzOTB4
IiwKPiA+ICsgICAgICAgICAgICAgICBOVUxMCj4gPiArICAgICAgIH0KPiA+ICB9Owo+IAo+IEFj
a2VkLWJ5OiBKYW4gU3RhbmNlayA8anN0YW5jZWtAcmVkaGF0LmNvbT4KClJldmlld2VkLWJ5OiBX
ZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4KPiAKPiAKPiAtLSAKPiBNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
