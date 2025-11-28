Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297FFCFD376
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 07:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1764315488; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=cuOdWptmbqn9bMDShLpua/484W8aN5fQFSOCKvVyVm8=;
 b=pI3hcIOvipJFvNuBjNmZ0/nTfDtBtElZKroozvFSSCeA10wqp6rBz+XUunh9mTZBxf7xf
 xhAzDix8+444ctXJHA3C3lSX1h8tD/aAua35fp8QEMEUZh9yATfg2cvD4rylMgLMMjbeR5m
 5YIikRtYin9b74nfq35QYIdCa1vBNXM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F5B73CDF67
	for <ltp@archiver.kernel.org>; Fri, 28 Nov 2025 08:38:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EB5E13C79A8
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 08:37:47 +0100 (CET)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 913FE600A6D
 for <ltp@lists.linux.it>; Fri, 28 Nov 2025 08:37:46 +0100 (CET)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-42b3c965cc4so658269f8f.0
 for <ltp@lists.linux.it>; Thu, 27 Nov 2025 23:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1764315466; x=1764920266; darn=lists.linux.it;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Fzozka63dT3R8ap4lAix4Ma0ervC+gphBDnHcZXE2Rw=;
 b=drQqEmgurvOsYVOkuxdeuGKFxp/p0jjDBCJLrYZ+yrLpXMOjypZPqGpsewqsxNUZIY
 b5fcIxaGcnBGRIQ+FnptozhnV8Gq4JE0hmv29jnYOicbvRdsGpkEvyiQsYGJ8T0rgXUq
 RYgcYNKulImFYhxMxI8cSrFD+jST0lRc60Z8/B52QbYuyySGDl2rTJdfvjUnz1OmO+oz
 OWsY8c0S10QB7JPz9eNsRFEuVnUB2gcp8UiOtI+DZol8Dq3HbwEq/aLD2E8Vti4cuKQZ
 sBD0Yq5TdNgp5k2KW6/S+JQCv20dpha+38TvHY0OZtGE7csVQfrtURO7lTKGjPPLgCsD
 uLyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764315466; x=1764920266;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fzozka63dT3R8ap4lAix4Ma0ervC+gphBDnHcZXE2Rw=;
 b=e3/vbIOIX1y6jLVzGzzlZJYwlX5AEcIZUJxXzWwTDbcebuCnZrpDtzFfHxOVhSHGs0
 CiTrvb12XpREx+/TIqDabClgPDXkuYjSW6jfuxTZX4Bl+vZMQfbZWmD6vSI9h81j+S9j
 0x2nx8LG/1oX4BMxsm+BA83F0/4CvA/eCIFSi94vgVKXSlttSSG/ap44GahWI2ooMeve
 PUHcz8K16BSkIJL+JlU8Tx14g9S1aaYiWzmkOfkBnUJGQzt9UEtDYxAsjQBOKhiYaRME
 /D+TzcaUx5ikYHCeQqkrbSdb17JwwWxh3Wp5OVBBkP+f1XnHZhdSaHBa3FYO7ALVTejC
 UPUQ==
X-Gm-Message-State: AOJu0YypcfXqICd5kmgd+XlXjWYkSqKnu7zqJQn18547ZIC1jpaAAhiq
 SbG8Cc+KGk1sCa3drUgap3AQ4pBnRUgFx66bcH338vxviuvK68aJRMM4kMrK1VemZzuMQKWPlIm
 3jmg=
X-Gm-Gg: ASbGnct0ACpP2P8rx3CboeD1W4OWaj235KTwfzeUd75ZvXD4e4Yqdzc3d9aN9pvwg17
 hOwOTsamAzFCqQSStOZhcYb/KB8cboXZfoDXR8M1fNp6FPxegSkbOPUKHNn9y6HgZ/I9woC3UvU
 9AUXSDA0bUJnStqVwVK3ewrNGEN7V3fazrl6ZOj8nRRKwm+moXOoLqI/2kGr/sfM6cJlxoETUqj
 VihsDyN2eq7aNmRPr+jxoz5ilKw1qn/L9rZtNwDNBLxsS4juqUWHrG0ix9Xg+X9xZri48CX0VVQ
 Ur+cQg9Z/GinKbzAHPqxAhxZKTnusOk+DbVHFODDcGKKqB+vBxpbaAxqJ+ZapvwkA8MJLlkeYCh
 tDgtNj5lcdzusK35XbfJ/hupOcIMd3OT+HpEnLlO76zpmq5TQ2mKY22V0XDiVWNYKMjnOxAohFn
 n/bTj+ZZqrVSanYgpQ0gZ7+Spm5ywh
X-Google-Smtp-Source: AGHT+IHgoPuj+b06GRymOjmxbeDyw/gqgdfjjeIARUlDxnD+PMPx82uiPaBxSXAq47u6MXU4NWse4w==
X-Received: by 2002:a05:6000:1a87:b0:429:b8c7:1848 with SMTP id
 ffacd0b85a97d-42cc137b729mr31389706f8f.19.1764315465811; 
 Thu, 27 Nov 2025 23:37:45 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1ca1a396sm7832623f8f.22.2025.11.27.23.37.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 23:37:45 -0800 (PST)
Date: Fri, 28 Nov 2025 07:37:43 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aSlRR21MVU1tq-6T@autotest-wegao.qe.prg2.suse.org>
References: <20251127143959.9416-1-wegao@suse.com>
 <CAEemH2c648sBs9LJmQBGRi-OY6s6p-ju-nAzHLGL2uzoiJTiag@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2c648sBs9LJmQBGRi-OY6s6p-ju-nAzHLGL2uzoiJTiag@mail.gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] listmount04.c: Update case support
 mnt_id_req.mnt_ns_fd
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it, Andrei Vagin <avagin@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBOb3YgMjgsIDIwMjUgYXQgMTE6MjY6MDdBTSArMDgwMCwgTGkgV2FuZyB3cm90ZToK
PiBIaSBXZWksCj4gCj4gCj4gT24gVGh1LCBOb3YgMjcsIDIwMjUgYXQgOTo0MeKAr0FNIFdlaSBH
YW8gdmlhIGx0cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKPiAKPiA+IE5ldyBrZXJuZWwg
Y29tbWl0IGxlYWQgdGVzdCBjYXNlIGZhaWx1cmUgd2l0aCBmb2xsb3dpbmcgZXJyb3IgbWVzc2Fn
ZToKPiA+IGxpc3Rtb3VudDA0LmM6MTI4OiBURkFJTDogaW52YWxpZCBtbnRfaWRfcmVxLnNwYXJl
IGV4cGVjdGVkIEVJTlZBTDogRUJBREYKPiA+ICg5KQo+ID4KPiA+IERldGFpbCBvZiBuZXcga2Vy
bmVsIGNvbW1pdDoKPiA+IGNvbW1pdDogNzhmMGUzM2NkNmM5MzlhNTU1YWE4MGRiZWQyZmVjNmIz
MzNhNzY2MAo+ID4gZnMvbmFtZXNwYWNlOiBjb3JyZWN0bHkgaGFuZGxlIGVycm9ycyByZXR1cm5l
ZCBieSBncmFiX3JlcXVlc3RlZF9tbnRfbnMKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2Fv
IDx3ZWdhb0BzdXNlLmNvbT4KPiA+IC0tLQo+ID4gIGNvbmZpZ3VyZS5hYyAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgMSArCj4gPiAgLi4uL2tlcm5lbC9zeXNjYWxscy9saXN0
bW91bnQvbGlzdG1vdW50MDQuYyAgICB8IDE4ICsrKysrKysrKysrKy0tLS0tLQo+ID4gIDIgZmls
ZXMgY2hhbmdlZCwgMTMgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKPiA+Cj4gPiBkaWZm
IC0tZ2l0IGEvY29uZmlndXJlLmFjIGIvY29uZmlndXJlLmFjCj4gPiBpbmRleCAwNDgwZjQ2Y2Eu
LmZjZmY5MDc5OSAxMDA2NDQKPiA+IC0tLSBhL2NvbmZpZ3VyZS5hYwo+ID4gKysrIGIvY29uZmln
dXJlLmFjCj4gPiBAQCAtMjYzLDYgKzI2Myw3IEBAIEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3QgY2Fj
aGVzdGF0XSwsLFsjaW5jbHVkZQo+ID4gPHN5cy9tbWFuLmg+XSkKPiA+Cj4gPiAgIyBEZWZpbmVk
IGluIDxsaW51eC9tb3VudC5oPiwgYnV0IGluY2x1ZGUvbGFwaS9tb3VudC5oIGluY2x1ZGVzCj4g
PiA8c3lzL21vdW50Lmg+ICovCj4gPiAgQUNfQ0hFQ0tfVFlQRVMoW3N0cnVjdCBtbnRfaWRfcmVx
XSwsLFsjaW5jbHVkZSA8c3lzL21vdW50Lmg+XSkKPiA+ICtBQ19DSEVDS19NRU1CRVJTKFtzdHJ1
Y3QgbW50X2lkX3JlcS5tbnRfbnNfZmRdLCwsWyNpbmNsdWRlIDxzeXMvbW91bnQuaD5dKQo+ID4g
IEFDX0NIRUNLX1RZUEVTKFtzdHJ1Y3Qgc3RhdG1vdW50XSwsLFsjaW5jbHVkZSA8c3lzL21vdW50
Lmg+XSkKPiA+ICBBQ19DSEVDS19NRU1CRVJTKFtzdHJ1Y3Qgc3RhdG1vdW50Lm1udF9uc19pZF0s
LCxbI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ID4gICNpbmNsdWRlIDxsaW51eC9tb3VudC5oPl0pCj4g
PiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9saXN0bW91bnQvbGlzdG1v
dW50MDQuYwo+ID4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2xpc3Rtb3VudC9saXN0bW91
bnQwNC5jCj4gPiBpbmRleCBhNTJiYWQwNjQuLjNiZTNiZTRmMiAxMDA2NDQKPiA+IC0tLSBhL3Rl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGlzdG1vdW50L2xpc3Rtb3VudDA0LmMKPiA+ICsrKyBi
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbGlzdG1vdW50L2xpc3Rtb3VudDA0LmMKPiA+IEBA
IC0xOCw2ICsxOCw3IEBACj4gPiAgI2luY2x1ZGUgImxhcGkvbW91bnQuaCIKPiA+ICAjaW5jbHVk
ZSAibGFwaS9zeXNjYWxscy5oIgo+ID4KPiA+ICsjaWZkZWYgSEFWRV9TVFJVQ1RfTU5UX0lEX1JF
UV9NTlRfTlNfRkQKPiA+ICAjZGVmaW5lIE1OVF9TSVpFIDMyCj4gPgo+ID4gIHN0YXRpYyBzdHJ1
Y3QgbW50X2lkX3JlcSAqcmVxdWVzdDsKPiA+IEBAIC0yNiw3ICsyNyw3IEBAIHN0YXRpYyB1aW50
NjRfdCBtbnRfaWRzW01OVF9TSVpFXTsKPiA+ICBzdGF0aWMgc3RydWN0IHRjYXNlIHsKPiA+ICAg
ICAgICAgaW50IHJlcV91c2FnZTsKPiA+ICAgICAgICAgdWludDMyX3Qgc2l6ZTsKPiA+IC0gICAg
ICAgdWludDMyX3Qgc3BhcmU7Cj4gPiArICAgICAgIHVpbnQzMl90IG1udF9uc19mZDsKPiA+ICAg
ICAgICAgdWludDY0X3QgbW50X2lkOwo+ID4gICAgICAgICB1aW50NjRfdCBwYXJhbTsKPiA+ICAg
ICAgICAgdWludDY0X3QgKm1udF9pZHM7Cj4gPiBAQCAtNzMsMTIgKzc0LDEyIEBAIHN0YXRpYyBz
dHJ1Y3QgdGNhc2Ugewo+ID4gICAgICAgICB7Cj4gPiAgICAgICAgICAgICAgICAgLnJlcV91c2Fn
ZSA9IDEsCj4gPiAgICAgICAgICAgICAgICAgLnNpemUgPSBNTlRfSURfUkVRX1NJWkVfVkVSMCwK
PiA+IC0gICAgICAgICAgICAgICAuc3BhcmUgPSAtMSwKPiA+ICsgICAgICAgICAgICAgICAubW50
X25zX2ZkID0gLTEsCj4gPiAgICAgICAgICAgICAgICAgLm1udF9pZCA9IExTTVRfUk9PVCwKPiA+
ICAgICAgICAgICAgICAgICAubW50X2lkcyA9IG1udF9pZHMsCj4gPiAgICAgICAgICAgICAgICAg
Lm5yX21udF9pZHMgPSBNTlRfU0laRSwKPiA+IC0gICAgICAgICAgICAgICAuZXhwX2Vycm5vID0g
RUlOVkFMLAo+ID4gLSAgICAgICAgICAgICAgIC5tc2cgPSAiaW52YWxpZCBtbnRfaWRfcmVxLnNw
YXJlIiwKPiA+ICsgICAgICAgICAgICAgICAuZXhwX2Vycm5vID0gRUJBREYsCj4gPiArICAgICAg
ICAgICAgICAgLm1zZyA9ICJpbnZhbGlkIG1udF9pZF9yZXEubW50X25zX2ZkIGJhZCBmaWxlIGRl
c2NyaXB0b3IiLAo+ID4gICAgICAgICB9LAo+ID4gICAgICAgICB7Cj4gPiAgICAgICAgICAgICAg
ICAgLnJlcV91c2FnZSA9IDEsCj4gPiBAQCAtMTIyLDcgKzEyMyw3IEBAIHN0YXRpYyB2b2lkIHJ1
bih1bnNpZ25lZCBpbnQgbikKPiA+ICAgICAgICAgICAgICAgICByZXEtPm1udF9pZCA9IHRjLT5t
bnRfaWQ7Cj4gPiAgICAgICAgICAgICAgICAgcmVxLT5wYXJhbSA9IHRjLT5wYXJhbTsKPiA+ICAg
ICAgICAgICAgICAgICByZXEtPnNpemUgPSB0Yy0+c2l6ZTsKPiA+IC0gICAgICAgICAgICAgICBy
ZXEtPnNwYXJlID0gdGMtPnNwYXJlOwo+ID4gKyAgICAgICAgICAgICAgIHJlcS0+bW50X25zX2Zk
ID0gdGMtPm1udF9uc19mZDsKPiA+ICAgICAgICAgfQo+ID4KPiA+ICAgICAgICAgVFNUX0VYUF9G
QUlMKHRzdF9zeXNjYWxsKF9fTlJfbGlzdG1vdW50LCByZXEsIHRjLT5tbnRfaWRzLAo+ID4gQEAg
LTEzMyw5ICsxMzQsMTQgQEAgc3RhdGljIHZvaWQgcnVuKHVuc2lnbmVkIGludCBuKQo+ID4gIHN0
YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKPiA+ICAgICAgICAgLnRlc3QgPSBydW4sCj4g
PiAgICAgICAgIC50Y250ID0gQVJSQVlfU0laRSh0Y2FzZXMpLAo+ID4gLSAgICAgICAubWluX2t2
ZXIgPSAiNi44IiwKPiA+ICsgICAgICAgLm1pbl9rdmVyID0gIjYuMTgiLAo+ID4KPiAKPiBSZXZp
ZXdlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gCj4gVGhpcyBwYXRjaCBsb29r
cyBnb29kLCBJIGhhdmUgb25lIHF1ZXN0aW9uIGRvIHdlIG5lZWQgdG8gY292ZXIgdGhlICdzcGFy
ZScKPiBmaWVsZCB0ZXN0IGZvciBrZXJuZWxzIGJldHdlZW4gNi44IHRvIDYuMTg/CkkgdGhpbmsg
b25seSBrZWVwIHRyYWNraW5nIGxhdGVzdCBmZWF0dXJlJ3MgY2hhbmdlIGNhbiBtYWtlIG91ciBs
aWZlCmVhc3kgZm9yIHRoaXMgY2FzZSA6KQo+IAo+IAo+ICAgICAgICAgLmJ1ZnMgPSAoc3RydWN0
IHRzdF9idWZmZXJzIFtdKSB7Cj4gPiAgICAgICAgICAgICAgICAgeyAmcmVxdWVzdCwgLnNpemUg
PSBNTlRfSURfUkVRX1NJWkVfVkVSMCB9LAo+ID4gICAgICAgICAgICAgICAgIHt9LAo+ID4gICAg
ICAgICB9LAo+ID4gIH07Cj4gPiArCj4gPiArI2Vsc2UKPiA+ICsgICAgICAgVFNUX1RFU1RfVENP
TkYoCj4gPiArICAgICAgICAgICAgICAgIlRoaXMgc3lzdGVtIGRvZXMgbm90IHN1cHBvcnQgbW50
X2lkX3JlcS5tbnRfbnNfZmQuIik7Cj4gPiArI2VuZGlmIC8qIEhBVkVfU1RSVUNUX01OVF9JRF9S
RVFfTU5UX05TX0ZEICovCj4gPiAtLQo+ID4gMi41MS4wCj4gPgo+ID4KPiA+IC0tCj4gPiBNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPiA+Cj4g
Pgo+IAo+IC0tIAo+IFJlZ2FyZHMsCj4gTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
