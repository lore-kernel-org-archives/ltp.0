Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D4ECCD184
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 01:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760923372; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=+fmwuxWSiTCcc0jpP0r7qY56FWIPI0EMVvxP0iYK9f4=;
 b=FyA/oRUnCW7d/2dEPR4mZzfRL0prvPtFXwZZ4f8HLUxlD2HFcF1N5Lt8ElqNwT8C21bTt
 m9RRpk5L4KRO90Fi6DTg6XAAFh/36xh//coH4RB1tgApL475+e2IcBlQ0wPvKDRNSXudYh9
 poqjaMJcIP+P6+CK7fDP1z3ntyWGk+c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 408F03CEF20
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 03:22:52 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DC6ED3C08C0
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 03:22:30 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 21EA4600812
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 03:22:29 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-47100eae3e5so35498975e9.1
 for <ltp@lists.linux.it>; Sun, 19 Oct 2025 18:22:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760923348; x=1761528148; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hoktHDvl3ElvjbuVVZcQMBzt2wFlTBsa/2pI/kbpUk4=;
 b=dtxEhMVkV0fs1HBRIwEIQXr+Fzqz7l2zqA5P074fIpDUOl+GKZzshu+PTytO4C9RSB
 yG73+E/tXmoMGGFQ8jh8htM0nrK3NJnvW9DhW6a5Wj8rcf9+VRmeIB8DRe5npCfUM5AD
 pNV7r8n3zUgCRFZu0gtTIHKTJRnMVuVdC5Py5t+ceymoD0+XVGCb14vkQNBAZOqbQwU7
 DR4XK+iYgiX9MJ66TzpiME/Jze9/D71k39hnX5UQRDCSVlOmektdX+xJ9EpgFzjNWxbV
 YgcEgk5ooEmTMY/gYdOdoVlq+BIWhQ6OfRseyhpxfHvlIEFYhrW2onXo+CCnNOJbzI13
 yX/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760923348; x=1761528148;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hoktHDvl3ElvjbuVVZcQMBzt2wFlTBsa/2pI/kbpUk4=;
 b=N5PBU25b2WtHMcmYkUbR71h8xFFT5qa4U7cVi/a9iTLbr2uo/R/oWhTFn0mObC9AZM
 f4shwq1UvIVFJmSK/ayZjllnl/yoN0RD7zqwY6PAMJvI9LL58M3ql1DAy+jtKuWEUALf
 mDqAUzUQExdgDRWM6AKVYUJ56Xc+ZJRJpAm0qFwuSFVX2ry2dbb6XXCKWEgASg0MqwhW
 TfetBFRX5ZeYWSaaIyhNsNwBmrdXf9QHClH8X1o3mC49xr9Pdsut9KsQOg1Hr3IkKxOm
 d/Tr2GfAgBgD1aZB+WZjrpy32IVo8p+/JhzHPAEkXWBqwzMqG8s491qpvQ93gISCvaQQ
 PGdw==
X-Gm-Message-State: AOJu0Yxhbk4nnz8YpTyuk0KvbCATmdw/EVrRKxbOESYqiVTtUlVJgPKh
 kcs3/ZF4gOpE4YtBuVUaehBZKM+vlVyyqOc/jXtmCXyErSESzd28RkCWw0InWG179g==
X-Gm-Gg: ASbGncsXsUwUv8KKDAJg38M9FEDgmW3w5qopBMlzlkFdqFuJk6mB6bcuISEWEVdrXrm
 kMjMtIg3w3/cXR4GCp4ZD3ia/d/KfmkuTDKXonm0KUXSoFsO66ACBEL7iX48SoQvmL1sfg6DqIH
 Dx3J8VX5CgmAF2Ld9xSMG8V7NU/xo0W5g5obuo+GmDiPAd7iI6Z1s8dPk6/BKbJXTXBdjwEVQ89
 9ow30nQl1CvmXOWMuw7EJWu1Xfyc45U/xAF8cQa7xRY0xYw1hPX1Nfo00u6phJtMT1C69f8zvyj
 y2B28ZxFQyh+8XqdUNQ+AS2Y8KqTAX/YThNbXKUc8TGEVJIMZmTWmRZhKBE7uKiRgNLSwbuYPiA
 CdX2HSL8GnMr1GdzywD4PZHopP23zQYEts2rJ/RNAf3Fcok8SmP1lzIbOc89rfnBi65c+N+HKh9
 bIzL642XePLg==
X-Google-Smtp-Source: AGHT+IGyjr1sTunRgXY+NoX/KeP3inp5twravDOGXzdddki3M0jVtw4GlHZswojHUnXLpwhd84oTXw==
X-Received: by 2002:a05:600c:529b:b0:471:350:f7a4 with SMTP id
 5b1f17b1804b1-471178a400cmr72916065e9.17.1760923348440; 
 Sun, 19 Oct 2025 18:22:28 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427ea5a0f19sm12787642f8f.9.2025.10.19.18.22.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 18:22:28 -0700 (PDT)
Date: Mon, 20 Oct 2025 01:22:26 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aPWO0j120Kr0z6Pn@localhost>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-2-wegao@suse.com>
 <20251017143524.GA339521@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017143524.GA339521@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/3] lib: Add support option for .needs_cmds
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

T24gRnJpLCBPY3QgMTcsIDIwMjUgYXQgMDQ6MzU6MjRQTSArMDIwMCwgUGV0ciBWb3JlbCB3cm90
ZToKPiBIaSBXZWksCj4gCj4gPiArKysgYi9pbmNsdWRlL3RzdF90ZXN0LmgKPiA+IEBAIC01MjQs
NyArNTI0LDcgQEAgc3RydWN0IHRzdF9mcyB7Cj4gPiAgICoKPiA+ICAgKiBAdGFnczogQSB7fSB0
ZXJtaW5hdGVkIGFycmF5IG9mIHRlc3QgdGFncy4gU2VlIHN0cnVjdCB0c3RfdGFnIGZvciBkZXRh
aWxzLgo+ID4gICAqCj4gPiAtICogQG5lZWRzX2NtZHM6IEEgTlVMTCB0ZXJtaW5hdGVkIGFycmF5
IG9mIGNvbW1hbmRzIHJlcXVpcmVkIGZvciB0aGUgdGVzdCB0byBydW4uCj4gPiArICogQG5lZWRz
X2NtZHM6IEEgTlVMTCB0ZXJtaW5hdGVkIGFycmF5IG9mIHN0cnVjdCB0c3RfY21kIHJlcXVpcmVk
IGZvciB0aGUgdGVzdCB0byBydW4uCj4gPiAgICoKPiA+ICAgKiBAbmVlZHNfY2dyb3VwX3Zlcjog
SWYgc2V0IHRoZSB0ZXN0IHdpbGwgcnVuIG9ubHkgaWYgdGhlIHNwZWNpZmllZCBjZ3JvdXAKPiA+
ICAgKiAgICAgICAgICAgICAgICAgICAgdmVyc2lvbiBpcyBwcmVzZW50IG9uIHRoZSBzeXN0ZW0u
Cj4gPiBAQCAtNjE3LDcgKzYxNyw3IEBAIHN0cnVjdCB0c3RfZnMgewo+IAo+ID4gIAljb25zdCBz
dHJ1Y3QgdHN0X3RhZyAqdGFnczsKPiAKPiA+IC0JY29uc3QgY2hhciAqY29uc3QgKm5lZWRzX2Nt
ZHM7Cj4gPiArCXN0cnVjdCB0c3RfY21kICpuZWVkc19jbWRzOwo+IAo+IEFzIEkgd3JvdGUgaW4g
YWxsIHByZXZpb3VzIHZlcnNpb25zLCBjaGFuZ2luZyBzdHJ1Y3QgdXNlZCBpbiBzdHJ1Y3QgdHN0
X3Rlc3QKPiBhbG9uZSB3aXRob3V0IGNoYW5naW5nIHdpbGwgYnJlYWsgdGhpcyBwYXJ0aWN1bGFy
IGNvbW1pdC4KPiAKPiBTZWUgd2hlbiBJIGFwcGx5IGp1c3QgdGhpcyBjb21taXQuOgo+IGh0dHBz
Oi8vZ2l0aHViLmNvbS9wZXZpay9sdHAvYWN0aW9ucy9ydW5zLzE4NTk1ODkxNTg2Cj4gaHR0cHM6
Ly9naXRodWIuY29tL3BldmlrL2x0cC9jb21taXRzL3JlZnMvaGVhZHMvd2VpL25lZWRzX2NtZHMu
djQuZmlyc3QtY29tbWl0LWJyb2tlbi8KPiAKPiBDQyBsaWIvbmV3bGliX3Rlc3RzL3RzdF9leHBp
cmF0aW9uX3RpbWVyCj4gdHN0X25lZWRzX2NtZHMwMS5jOjE1OjIzOiBlcnJvcjogaW5pdGlhbGl6
YXRpb24gb2Yg4oCYc3RydWN0IHRzdF9jbWQgKuKAmSBmcm9tIGluY29tcGF0aWJsZSBwb2ludGVy
IHR5cGUg4oCYY29uc3QgY2hhciAqKuKAmSBbLVdpbmNvbXBhdGlibGUtcG9pbnRlci10eXBlc10K
PiAgICAxNSB8ICAgICAgICAgLm5lZWRzX2NtZHMgPSAoY29uc3QgY2hhciAqW10pIHsKPiAgICAg
ICB8ICAgICAgICAgICAgICAgICAgICAgICBeCj4gdHN0X25lZWRzX2NtZHMwMS5jOjE1OjIzOiBu
b3RlOiAobmVhciBpbml0aWFsaXphdGlvbiBmb3Ig4oCYdGVzdC5uZWVkc19jbWRz4oCZKQo+IAo+
IC4uLgo+IAo+IHF1b3RhY3RsMDEuYzoyMjY6MjM6IGVycm9yOiBpbml0aWFsaXphdGlvbiBvZiDi
gJhzdHJ1Y3QgdHN0X2NtZCAq4oCZIGZyb20gaW5jb21wYXRpYmxlIHBvaW50ZXIgdHlwZSDigJhj
b25zdCBjaGFyICogY29uc3Qq4oCZIFstV2luY29tcGF0aWJsZS1wb2ludGVyLXR5cGVzXQo+ICAg
MjI2IHwgICAgICAgICAubmVlZHNfY21kcyA9IChjb25zdCBjaGFyICpjb25zdCBbXSkgewo+ICAg
ICAgIHwgICAgICAgICAgICAgICAgICAgICAgIF4KPiAKPiBQbGVhc2UgeW91IG5lZWQgdG8gaGF2
ZSB0aGlzIGNvbW1pdCB0b2dldGhlciB3aXRoICJVcGRhdGUgdGVzdCBjYXNlcyB1c2UgbmV3Cj4g
bmVlZHNfY21kcyIgY29tbWl0IGludG8gc2luZ2xlIGNvbW1pdCAoc3F1YXNoIHRoZXNlIHR3byBp
bnRvIGEgc2luZ2xlIGNvbW1pdCkuCj4gCj4gT3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8KVGhh
bmtzIGZvciB5b3VyIHRpbWUgZG8gdmVyaWZ5IHRlc3QgY2FuIHJldmlldy4KVGhlIHJlYXNvbiBp
IHNwbGl0IHRoaXMgcGF0Y2ggdG8gc21hbGwgY29tbWl0cyBpcyBlYXN5IGZvciByZXZpZXcsIGlm
IHlvdQpuZWVkIGV2ZXJ5IGNvbW1pdHMgY2FuIHBhc3MgY29tcGlsZSBwaGFzZSB0aGVuIGkgaGF2
ZSB0byBjb21iaW5lIGFsbApjb21taXRzIGludG8gYSBzaW5nbGUgYmlnIG9uZSwgaXMgdGhhdCB5
b3VyIHJlcXVlc3Q/Cj4gCj4gS2luZCByZWdhcmRzLAo+IFBldHIKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
