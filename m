Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70FAFC87FCB
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 20:05:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1754337951; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ML4yIi1sNyY3CIw/5mnE1nluGBGTjvQemW+30govpUE=;
 b=RNNJtCRqI0duaVuGF8UuXBQcuitJQPqLiaSREwHaMon+iRv222XmZgEdErJwdJBLj6t1e
 j7WZRAdYLLdTfYcHlURHhmD0uffHG6qtu8wNSyVJOVURngAbUWMh15WNYn0M/g67OKguaaz
 icVKUYFCs2D6zRhSoKu0vmbPSU3EoU0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACF103CCFEB
	for <ltp@archiver.kernel.org>; Mon,  4 Aug 2025 22:05:51 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 850F93CCDE8
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 22:05:30 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 51B4310007DC
 for <ltp@lists.linux.it>; Mon,  4 Aug 2025 22:05:29 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-459d62184c9so10517905e9.1
 for <ltp@lists.linux.it>; Mon, 04 Aug 2025 13:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1754337928; x=1754942728; darn=lists.linux.it;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YmPG0FKm2eAyzDHde4Egrl0xCMz2N9w7HJrELY6R1t0=;
 b=ZQKhtCgTOQbDYRqT4yrIFh6ER59N0b+JF1zQMFDwjMAVmdERVB+abJ7+JNdIaCBBYT
 yE1lOUqE0PkZOADoIKjcFyd9siHJDbYmg9o87FM+ziJ6xaFEZ5qFy9FnFT8WXCgCPk2l
 isxiEhCM7OaduPZERVv0ENdM2vYV9JTDVeUbGoWbDNOPs6uFDaF/e3p22xVytYqtZQ/3
 M1ijPzED/g5X3E7/3WWMf68Q1FzTACQyNLo5+h1Bo0Q8U3sGRM/iD+MSnYHoccTTtOXv
 533UP6BQdPNSKyXTyK4NKxOT4UjwbnXumH/A/Vi4OGpIr4fngBK4gVF5ThmaNRA6orq9
 Luug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754337928; x=1754942728;
 h=in-reply-to:references:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YmPG0FKm2eAyzDHde4Egrl0xCMz2N9w7HJrELY6R1t0=;
 b=AXjAdYRNL4b1prYYCtNfMv+B9eYzLkdz9o627vddnp2Nkm2sgcj39vJyw3njxh8pUg
 eBLcBNmOxtrLPkWGzEoHS//aFGfEmuWI1bmmvqQKpRyewhHXC+b/yXOXWy16G3/GpuAo
 /HLMqdF7xq4OofjjbY/QGPWM5oXSqopTGfZJSmvGuDXmu4l9Q8AU/QMt5EtG3j6FdVT6
 EGV0W4utJVTZdxLfALKrVYImC3WzY/QtD0vRB7szKXb3aTgW9YlGYHxM6MvAOSRdIOPq
 1y6dekH25J/Gk5Gok+NN2bgqDww67vS1dIb1bwpTYh68lawbpKifgH2RKLxdJUT4A9FU
 YU/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUE0Chd9r79jP4AUQYa6OHn2o/f7aokaeJRDsoyUj1GAzRrrcgG19SJ69ToIgvfOPF1hbU=@lists.linux.it
X-Gm-Message-State: AOJu0YxnLrgZL0GZ0mTp4PbaMjfQkYZL0oVAHlG9Kp/RsjwJOUo3Lxtm
 hgoS/U2x+RQjYczkQIcgef9j8KbQVt9Uqwlffr/VXw474A06kkbwSaBDjXPOq4ttGO4=
X-Gm-Gg: ASbGncuMILWCRi84bEIg46hM15FigQCr6L/lAmcooDm4SrvH02KWvk3jXa2b+PbGSur
 hhgry+Bojrc6gs5zNp0iv/Y97z2IdcDM4FP/ukYdN+f+AJ3uc9qDzXmpkEZYfNGzXJILL6/w7mt
 UDM9yfjgPs2SQSSjf6nLpSEKPwLvEA1BCO2gHMFBsiJAm1fde6picrQt8FUJssm/Qw76Vi/4YU6
 zC7s6WxgoNw6JOwIVla4/L5vPttzbocT+Wdrf8mkULgpRoXci2FfU4Us5R9meq1imSQuZUGJN+1
 tMc8a4nIWrfyNTUNTRTptzc3uTcdOsMQidA4SqaPxzvO7fZRucD9QNeDYJPbue0gsrC41V7yZWR
 uGGa9D8rLzg==
X-Google-Smtp-Source: AGHT+IH0Tm5gj2pfB1FVxEPIxds22Zf0DAyL9qwR/YYyJRPBbokvT/sTG6pJsqWLZ4dzh0YZml/s8g==
X-Received: by 2002:a05:6000:228a:b0:3b7:9233:ebb with SMTP id
 ffacd0b85a97d-3b8d946a592mr6970538f8f.6.1754337928474; 
 Mon, 04 Aug 2025 13:05:28 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-53936b15df5sm2998456e0c.3.2025.08.04.13.05.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Aug 2025 13:05:28 -0700 (PDT)
Mime-Version: 1.0
Date: Mon, 04 Aug 2025 17:05:22 -0300
Message-Id: <DBTWW3QOSI3I.2LBV7VWPR4C0B@suse.com>
To: "Petr Vorel" <pvorel@suse.cz>, <ltp@lists.linux.it>
X-Mailer: aerc 0.20.1-80-g1fe8ed687c05-dirty
References: <20250804184850.313101-1-pvorel@suse.cz>
In-Reply-To: <20250804184850.313101-1-pvorel@suse.cz>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] rpc_test.sh: Check for rpcbind remote calls
 support
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: rbm@suse.com
Cc: libtirpc-devel@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 Steve Dickson <steved@redhat.com>,
 =?utf-8?b?UmljYXJkbyBCIC4gTWFybGnDqHJl?= <rbm@suse.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uIEF1ZyA0LCAyMDI1IGF0IDM6NDggUE0gLTAzLCBQZXRyIFZvcmVsIHdyb3RlOgo+IGNs
aWVudCBiaW5hcmllcyBycGNfcG1hcF9ybXRjYWxsIGFuZCB0aXJwY19ycGNiX3JtdGNhbGwgcmVx
dWlyZSBycGNiaW5kCj4gY29tcGlsZWQgd2l0aCByZW1vdGUgY2FsbHMuICBycGNiaW5kIGhhcyBk
aXNhYmxlZCByZW1vdGUgY2FsbHMgYnkKPiBkZWZhdWx0IGluIDEuMi41LiBCdXQgdGhpcyB3YXMg
bm90IGRldGVjdGFibGUgdW50aWwgMS4yLjgsIHdoaWNoIGJyb3VnaHQKPiB0aGlzIGluZm8gaW4g
LXYgZmxhZy4KPgo+IERldGVjdCB0aGUgc3VwcG9ydCBhbmQgc2tpcCBvbiB0aGVzZSAyIGZ1bmN0
aW9ucyB3aGVuIGRpc2FibGVkLgo+Cj4gU2lnbmVkLW9mZi1ieTogUGV0ciBWb3JlbCA8cHZvcmVs
QHN1c2UuY3o+Cj4gLS0tCj4gSGksCj4KPiBCVFcgaXQnZCBiZSBuaWNlIHRvIGludmVzdGlnYXRl
IHdoeSB0aGUgYnJvYWRjYXN0IGZ1bmN0aW9ucyBmYWlsLAo+IGVuYWJsaW5nIHJlbW90ZSBjYWxs
cyBkb2VzIG5vdCBoZWxwLCB0ZXN0aW5nIG9uOgo+IC4vY29uZmlndXJlIC0tZW5hYmxlLWxpYndy
YXAgLS1lbmFibGUtd2FybXN0YXJ0cyAtLWVuYWJsZS1kZWJ1ZyAtLXdpdGgtc3RhdGVkaXI9L3J1
bi9ycGNiaW5kIC0td2l0aC1ycGN1c2VyPXJwYyAtLXdpdGgtc3lzdGVtZHN5c3RlbXVuaXRkaXI9
L3Vzci9saWIvc3lzdGVtZC9zeXN0ZW0gJy0td2l0aC1uc3MtbW9kdWxlcz1maWxlcyB1c3JmaWxl
cycgLS1lbmFibGUtcm10Y2FsbHMKCkJ1dCBkaWQgeW91IHN0YXJ0IHRoZSBkYWVtb24gd2l0aCBg
LXJgPyBlLmcuCgojIC9zYmluL3JwY2JpbmQgLWYgLXcgLXIgJgoKPgo+IEtpbmQgcmVnYXJkcywK
PiBQZXRyCj4KPiAjIFBBVEg9Ii9vcHQvbHRwL3Rlc3RjYXNlcy9iaW46JFBBVEgiIC4vcnBjX3Rl
c3Quc2ggLXMgcnBjX3N2Y18xIC1jIHJwY19jbG50X2Jyb2FkY2FzdAo+IHJwY190ZXN0LnNoIC1z
IHJwY19zdmNfMSAtYyBycGNfY2xudF9icm9hZGNhc3QKPiBycGNfdGVzdCAxIFRJTkZPOiBSdW5u
aW5nOiBycGNfdGVzdC5zaCAtcyBycGNfc3ZjXzEgLWMgcnBjX2NsbnRfYnJvYWRjYXN0Cj4gcnBj
X3Rlc3QgMSBUSU5GTzogVGVzdGVkIGtlcm5lbDogTGludXggdHMgNi4xMy42LTEtZGVmYXVsdCAj
MSBTTVAgUFJFRU1QVF9EWU5BTUlDIE1vbiBNYXIgMTAgMDg6NDk6MjQgVVRDIDIwMjUgKDQ5NWQ4
MmEpIHg4Nl82NCB4ODZfNjQgeDg2XzY0IEdOVS9MaW51eAo+IHJwY190ZXN0IDEgVElORk86IGlu
aXRpYWxpemUgJ2xob3N0JyAnbHRwX25zX3ZldGgyJyBpbnRlcmZhY2UKPiBycGNfdGVzdCAxIFRJ
TkZPOiBhZGQgbG9jYWwgYWRkciAxMC4wLjAuMi8yNAo+IHJwY190ZXN0IDEgVElORk86IGFkZCBs
b2NhbCBhZGRyIGZkMDA6MToxOjE6OjIvNjQKPiBycGNfdGVzdCAxIFRJTkZPOiBpbml0aWFsaXpl
ICdyaG9zdCcgJ2x0cF9uc192ZXRoMScgaW50ZXJmYWNlCj4gcnBjX3Rlc3QgMSBUSU5GTzogYWRk
IHJlbW90ZSBhZGRyIDEwLjAuMC4xLzI0Cj4gcnBjX3Rlc3QgMSBUSU5GTzogYWRkIHJlbW90ZSBh
ZGRyIGZkMDA6MToxOjE6OjEvNjQKPiBycGNfdGVzdCAxIFRJTkZPOiBOZXR3b3JrIGNvbmZpZyAo
bG9jYWwgLS0gcmVtb3RlKToKPiBycGNfdGVzdCAxIFRJTkZPOiBsdHBfbnNfdmV0aDIgLS0gbHRw
X25zX3ZldGgxCj4gcnBjX3Rlc3QgMSBUSU5GTzogMTAuMC4wLjIvMjQgLS0gMTAuMC4wLjEvMjQK
PiBycGNfdGVzdCAxIFRJTkZPOiBmZDAwOjE6MToxOjoyLzY0IC0tIGZkMDA6MToxOjE6OjEvNjQK
PiBycGNfdGVzdCAxIFRJTkZPOiB0aW1lb3V0IHBlciBydW4gaXMgMGggNW0gMHMKPiBycGNfdGVz
dCAxIFRJTkZPOiBjaGVjayByZWdpc3RlcmVkIFJQQyB3aXRoIHJwY2luZm8KPiBycGNfdGVzdCAx
IFRJTkZPOiByZWdpc3RlcmVkIFJQQzoKPiAgICBwcm9ncmFtIHZlcnMgcHJvdG8gICBwb3J0ICBz
ZXJ2aWNlCj4gICAgIDEwMDAwMCAgICA0ICAgdGNwICAgIDExMSAgcG9ydG1hcHBlcgo+ICAgICAx
MDAwMDAgICAgMyAgIHRjcCAgICAxMTEgIHBvcnRtYXBwZXIKPiAgICAgMTAwMDAwICAgIDIgICB0
Y3AgICAgMTExICBwb3J0bWFwcGVyCj4gICAgIDEwMDAwMCAgICA0ICAgdWRwICAgIDExMSAgcG9y
dG1hcHBlcgo+ICAgICAxMDAwMDAgICAgMyAgIHVkcCAgICAxMTEgIHBvcnRtYXBwZXIKPiAgICAg
MTAwMDAwICAgIDIgICB1ZHAgICAgMTExICBwb3J0bWFwcGVyCj4gICAgIDEwMDAwNSAgICAxICAg
dWRwICAyMDA0OCAgbW91bnRkCj4gICAgIDEwMDAyNCAgICAxICAgdWRwICAzNjIzNSAgc3RhdHVz
Cj4gICAgIDEwMDAwNSAgICAxICAgdGNwICAyMDA0OCAgbW91bnRkCj4gICAgIDEwMDAyNCAgICAx
ICAgdGNwICA2MDc0MyAgc3RhdHVzCj4gICAgIDEwMDAwNSAgICAyICAgdWRwICAyMDA0OCAgbW91
bnRkCj4gICAgIDEwMDAwNSAgICAyICAgdGNwICAyMDA0OCAgbW91bnRkCj4gICAgIDEwMDAwNSAg
ICAzICAgdWRwICAyMDA0OCAgbW91bnRkCj4gICAgIDEwMDAwNSAgICAzICAgdGNwICAyMDA0OCAg
bW91bnRkCj4gICAgIDEwMDAwMyAgICAzICAgdGNwICAgMjA0OSAgbmZzCj4gICAgIDEwMDAwMyAg
ICA0ICAgdGNwICAgMjA0OSAgbmZzCj4gICAgIDEwMDIyNyAgICAzICAgdGNwICAgMjA0OSAgbmZz
X2FjbAo+ICAgICAxMDAwMjEgICAgMSAgIHVkcCAgNDA5MzkgIG5sb2NrbWdyCj4gICAgIDEwMDAy
MSAgICAzICAgdWRwICA0MDkzOSAgbmxvY2ttZ3IKPiAgICAgMTAwMDIxICAgIDQgICB1ZHAgIDQw
OTM5ICBubG9ja21ncgo+ICAgICAxMDAwMjEgICAgMSAgIHRjcCAgMzgwNDcgIG5sb2NrbWdyCj4g
ICAgIDEwMDAyMSAgICAzICAgdGNwICAzODA0NyAgbmxvY2ttZ3IKPiAgICAgMTAwMDIxICAgIDQg
ICB0Y3AgIDM4MDQ3ICBubG9ja21ncgo+IHJwY190ZXN0IDEgVElORk86IHVzaW5nIGxpYnRpcnBj
OiB5ZXMKPiBycGNfdGVzdCAxIFRGQUlMOiBycGNfY2xudF9icm9hZGNhc3QgMTAuMC4wLjIgNTM2
ODc1MDAwIGZhaWxlZCB1bmV4cGVjdGVkbHkKPiBSUEM6IFRpbWVkIG91dAo+IDEKPiBycGNfdGVz
dCAyIFRJTkZPOiBTRUxpbnV4IGVuYWJsZWQgaW4gZW5mb3JjaW5nIG1vZGUsIHRoaXMgbWF5IGFm
ZmVjdCB0ZXN0IHJlc3VsdHMKPiBycGNfdGVzdCAyIFRJTkZPOiBpdCBjYW4gYmUgZGlzYWJsZWQg
d2l0aCBUU1RfRElTQUJMRV9TRUxJTlVYPTEgKHJlcXVpcmVzIHN1cGVyL3Jvb3QpCj4gcnBjX3Rl
c3QgMiBUSU5GTzogbG9hZGVkIFNFTGludXggcHJvZmlsZXM6IG5vbmUKPgo+Cj4KPiAgdGVzdGNh
c2VzL25ldHdvcmsvcnBjL3JwYy10aXJwYy9ycGNfdGVzdC5zaCB8IDUgKysrKysKPiAgMSBmaWxl
IGNoYW5nZWQsIDUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9uZXR3
b3JrL3JwYy9ycGMtdGlycGMvcnBjX3Rlc3Quc2ggYi90ZXN0Y2FzZXMvbmV0d29yay9ycGMvcnBj
LXRpcnBjL3JwY190ZXN0LnNoCj4gaW5kZXggY2FkYWU1NTIwMy4uMWE4Y2Y0NjM5OSAxMDA3NTUK
PiAtLS0gYS90ZXN0Y2FzZXMvbmV0d29yay9ycGMvcnBjLXRpcnBjL3JwY190ZXN0LnNoCj4gKysr
IGIvdGVzdGNhc2VzL25ldHdvcmsvcnBjL3JwYy10aXJwYy9ycGNfdGVzdC5zaAo+IEBAIC01Myw2
ICs1MywxMSBAQCBzZXR1cCgpCj4gIAkJZmkKPiAgCWZpCj4gIAo+ICsJaWYgWyAiJENMSUVOVCIg
PSAncnBjX3BtYXBfcm10Y2FsbCcgLW8gIiRDTElFTlQiID0gJ3RpcnBjX3JwY2Jfcm10Y2FsbCcg
XSAmJiBcCj4gKwkJcnBjYmluZCAtdiAyPi9kZXYvbnVsbCAmJiBycGNiaW5kIC12IDI+JjEgfCBn
cmVwIC1xICdyZW1vdGUgY2FsbHM6IG5vJzsgdGhlbgo+ICsJCXRzdF9icmsgVENPTkYgInNraXAg
ZHVlIHJwY2JpbmQgY29tcGlsZWQgd2l0aG91dCByZW1vdGUgY2FsbHMiCj4gKwlmaQo+ICsKClJl
dmlld2VkLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJtQHN1c2UuY29tPgoKVGhhbmtzIQoK
PiAgCVsgLW4gIiRDTElFTlQiIF0gfHwgdHN0X2JyayBUQlJPSyAiY2xpZW50IHByb2dyYW0gbm90
IHNldCIKPiAgCXRzdF9jaGVja19jbWRzICRDTElFTlQgJFNFUlZFUiB8fCB0c3RfYnJrIFRDT05G
ICJMVFAgY29tcGlsZWQgd2l0aG91dCBUSS1SUEMgc3VwcG9ydD8iCj4gIAoKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
