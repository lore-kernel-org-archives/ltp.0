Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8ED0BCD4F26
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 09:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782465500; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=nb+yExO/gdwedODCP4D0W2AlOajgvHngKslVXqA1rDs=;
 b=bF4lOjKsbGl1EDV6sw8NIJrHfaZH3icNRHelWlH7XU9uSmpA0Z1uKsDMzRgndYpiqS0f/
 PUMAjg7gj3c14h4f0ZUtcY0yLlV4xjA7S0vNcm0goWTQTygPW74+Nec9rEIBmuMC05XQe9r
 ArNioYmDqDFb63QZN4PgDopx15w/zbY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D02843CFA09
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 11:18:20 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A57F3CD6B2
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:17:59 +0200 (CEST)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 43DE81000D3A
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 11:17:58 +0200 (CEST)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-693c51a8a19so1329159a12.3
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 02:17:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782465478; cv=none;
 d=google.com; s=arc-20260327;
 b=jA/8a9qSpcMoZLgCXDJxisVgB6LY5iM71l/8F2qdXLf6zD8FFoXfyOyxESf6gIpDNk
 YjCpcmbLkuXTTB7nwPMFwpXZWoU3eCqBB800qAitehUBj5zQmNnV4xILzKfA85m6/guB
 1WEYuX74HX54LkhxG50BQo7MmLTHmWTDHPNCEKGZRjaICIXiuHbuk9C2VV8fZzSSvKgY
 wDt9XMfu2UgNqvO58zzAjcNL/Ds7pNfCkEVp39AKYYIrCzpMhI21cmMIGwm57TTlRsk7
 j3Qxb0YHZGmgaV7ZhtvZqTlLg2Pu7pz67zqG+1KzhtoWDC1u+85/Reb39q0kHGhML4gx
 Mdxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :dkim-signature;
 bh=IpPgQ44+0L9BH15/3rae/42d0PxJ+kpIwiYb5D5+wiE=;
 fh=MKsfrWBG6YfiFYjqRhfDZ8kd+0tmvrKUc5gXcb9qw9k=;
 b=O1ovxhh0qmyAlMNv0jreeLkDSyxFcZk42/eBDo7jgB0aO6X+xvppw9YDTQCbbKLsDV
 1WoM7KT6dMZok5x6l2qIxl3d1xGJrSQAQ36y+RKsLxSYmh9rCpO5u9lAVs8uiqp+YMD8
 +rn/9GPO502jeCvAAiKyPSlSNPzbwW6c4iZD1NJqDODiOxItFQif7cpSKDmDbRb+IX61
 lzlp6Gs7FBXV9DO1k2rueeaLs5alW30E6hX7smQYe7X+3IN8ghMexc+a0TTy+Nxjhuji
 hHk60oaJMZu7LHHHMlD7ihPOILBPWxzTNLzeeBeuDe6ekcPmXyUNaWScbli6EDYFlLPB
 duLw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782465478; x=1783070278; darn=lists.linux.it;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IpPgQ44+0L9BH15/3rae/42d0PxJ+kpIwiYb5D5+wiE=;
 b=E4HaD0LanOSGzKgFD++x9Lz9s/764tDdbSvEcQ6dX/lkW3Og8DTnplKZzdwjs+X+Bc
 DWKkAbud3Y7xPhGjzep7RouAm/MmzM62wJl2C4iyePURwqif3HOheJI6zok5xEttG8yg
 6EKszpnjCt3Y1amlFTscEcttzj4cAU+RtIYYyrRvu3AsdJKm7MI+vVHlxnjAgbQPGPxi
 IZsTu4Kh4mylr47v695OIOqBUwWdkpQX0so23K7RFRX+0BkAoPEbrQ2Eyl9hwcq4uSPN
 pX7oOy10h7dkLHAHMjwWeHwHSXt73aBO1RxsMZAyLf5F8oJ15ZWeMRJEMlGRUo0QWx0f
 mALg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782465478; x=1783070278;
 h=to:subject:message-id:date:from:in-reply-to:references:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IpPgQ44+0L9BH15/3rae/42d0PxJ+kpIwiYb5D5+wiE=;
 b=AjWLYzMolEckNMb+ddt0GIKVK/Ns8JJfCTl4YIEUG0JkOQDUZNHNXc41AendlQf70c
 KcGcf5Wfghx8omiAj4lW4MqCt3XzCPQZ77bB6ytkQhgWET5DvWFSJv7h9g3huNAg2RDh
 kN11gBSDykF57MVRrLThdCIYMnfRyZJIMLFi58SUrTo77Ih58fOxbXTvuN8w4KARiGdv
 G9LMPEvSy+pAPLVMyIqX34WiQZxbIQAYZwwSMWxzq8H9NuHMixIlixJgQqA5O7Zbu9ER
 ssa9zeaSWV/clMyHD5WqUEDI0gzR3AhQh2E7reBYaM7eCwyQwGBq1Fb299HhgEaNbb3G
 w5Bw==
X-Gm-Message-State: AOJu0YwntZTAzwZTMcqB+ldZ4B3mn4Q8x5LSG1RX/XdgU8RCw4+Dulhg
 ltQ9A/62/U4XQYBscfaTPbp7GJiI/HKChJ7ixgJn21/lvUwlw3LHbYthX/te2CUBopioAcXPopz
 UDWWVvVbQlHXyjlTBUzbECpFtxQBMYsD+ZAbujmiEN4iE9OEIRaBgWd1h
X-Gm-Gg: AfdE7cnz5C2O+cWVIK9/24T0kd50DeYkxfsywhtMGijtFYx9lgJTWp7W45Xh9hicYwS
 LqVgbrQA/JW0p5tZu4Jj7z070VzSqBnNkuM+DwmUkrF2hPgQkiOkjUU/JOMIgwXsQf3VwiVAnNy
 LSh2TCSeXJM5vHe3cfqiNUuhFXOcRCjMuVzkeBgyqYhSTT6aiufYFD3eYrTwd789SlHFcDg2rvq
 2HnTTIJooy7taMy1m6xhRZSdKC5dPH1nWOCtmJCUzoTIoFQfOzlfN4SMO7HxfUKXZJwYvb2
X-Received: by 2002:a05:6402:3490:b0:691:7054:8c6b with SMTP id
 4fb4d7f45d1cf-69810aedfc2mr1421811a12.19.1782465477636; Fri, 26 Jun 2026
 02:17:57 -0700 (PDT)
MIME-Version: 1.0
References: <20260626091338.15509-1-wegao@suse.com>
In-Reply-To: <20260626091338.15509-1-wegao@suse.com>
Date: Fri, 26 Jun 2026 17:17:46 +0800
X-Gm-Features: AVVi8CdXsRAx5GzgugSSekpCEzuRVZ1GMG8maGy-L0_dfk-9wj4xoP4g4CxLIcg
Message-ID: <CAJs-1pX1F6+=G=XUBEOBaP9VM7RoCEeLLQuthtUG9HaZMguW-A@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v1] set_mempolicy05: Require CONFIG_NUMA using
 .needs_kconfigs
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgQUxMCgpTb3JyeSAsIHBsZWFzZSBpZ25vcmUgdGhpcyBkdXBsaWNhdGUgcGF0Y2ggc2luY2Ug
d2UgYWxyZWFkeSBoYXZlCmh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcHJvamVjdC9sdHAv
cGF0Y2gvMjAyNjA2MjMxMjQ4MTIuNDYwMjItMS1hdmluZXNoLmt1bWFyQHN1c2UuY29tLwoKVGhh
bmtzLgpSZWdhcmRzCkdhbyBXZWkKCk9uIEZyaSwgSnVuIDI2LCAyMDI2IGF0IDU6MTPigK9QTSBX
ZWkgR2FvIDx3ZWdhb0BzdXNlLmNvbT4gd3JvdGU6Cgo+IFdoZW4gQ09ORklHX05VTUEgaXMgZGlz
YWJsZWQgaW4gdGhlIGtlcm5lbCwgdGhlIHNldF9tZW1wb2xpY3kgc3lzdGVtCj4gY2FsbCBpcyBu
b3QgY29tcGlsZWQgYW5kIHJldHVybnMgLUVOT1NZUy4KPgo+IERlY2xhcmUgQ09ORklHX05VTUEg
aW4gdGhlIC5uZWVkc19rY29uZmlncyBmaWVsZCBvZiBzdHJ1Y3QgdHN0X3Rlc3QuCj4gVGhpcyBl
bnN1cmVzIHRoYXQgdGhlIHRlc3QgY2xlYW5seSBza2lwcyAoVENPTkYpIG9uIGtlcm5lbHMgYnVp
bHQgd2l0aG91dAo+IE5VTUEgc3VwcG9ydCwgcHJldmVudGluZyBmYWxzZSBURkFJTCByZXN1bHRz
Lgo+Cj4gU2lnbmVkLW9mZi1ieTogV2VpIEdhbyA8d2VnYW9Ac3VzZS5jb20+Cj4gLS0tCj4gIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0X21lbXBvbGljeS9zZXRfbWVtcG9saWN5MDUuYyB8
IDQgKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRfbWVtcG9saWN5L3NldF9tZW1wb2xpY3kw
NS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF9tZW1wb2xpY3kvc2V0X21lbXBv
bGljeTA1LmMKPiBpbmRleCA3NDgxZGNkOGQuLmU5YzUyMWRmMiAxMDA2NDQKPiAtLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF9tZW1wb2xpY3kvc2V0X21lbXBvbGljeTA1LmMKPiAr
KysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldF9tZW1wb2xpY3kvc2V0X21lbXBvbGlj
eTA1LmMKPiBAQCAtMTE1LDYgKzExNSwxMCBAQCBzdGF0aWMgc3RydWN0IHRzdF90ZXN0IHRlc3Qg
PSB7Cj4gICAgICAgICAgICAgICAgICJwcGMiLAo+ICAgICAgICAgICAgICAgICBOVUxMCj4gICAg
ICAgICB9LAo+ICsgICAgICAgLm5lZWRzX2tjb25maWdzID0gKGNvbnN0IGNoYXIgKmNvbnN0IFtd
KSB7Cj4gKyAgICAgICAgICAgICAgICJDT05GSUdfTlVNQSIsCj4gKyAgICAgICAgICAgICAgIE5V
TEwKPiArICAgICAgIH0sCj4gICAgICAgICAudGFncyA9IChjb25zdCBzdHJ1Y3QgdHN0X3RhZ1td
KSB7Cj4gICAgICAgICAgICAgICAgIHsibGludXgtZ2l0IiwgImNmMDFmYjk5ODVlOCJ9LAo+ICAg
ICAgICAgICAgICAgICB7IkNWRSIsICIyMDE3LTc2MTYifSwKPiAtLQo+IDIuNTQuMAo+Cj4KCi0t
IApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
