Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 258BDEB64DD
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 10:17:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A0FF03CD0D3
	for <ltp@archiver.kernel.org>; Wed,  9 Aug 2023 12:17:05 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 45D133C8B63
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 12:16:54 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 44809600281
 for <ltp@lists.linux.it>; Wed,  9 Aug 2023 12:16:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691576210;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mnwW/XuR2zi69K6x5nuKwBsTaKQeWXtic1b2RMo7fr8=;
 b=P9Dxr5oI/HceuMjDy8AqL9yPcxglNS285TQX645XF7np8zO8wjhvECQMm5PPl3bVPY1+jz
 Wv2NKWdsOLz668MdbX/AEH+fdSRqW9rj29sGFsPBVRdnfo2NQCEYlMJ47C8JZt2f0druFj
 8YyLYZ/WdJxfUwYvxPKtUUXx4BrFtE4=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-rAhkoSCFP6C1Lp48zfcubw-1; Wed, 09 Aug 2023 06:16:48 -0400
X-MC-Unique: rAhkoSCFP6C1Lp48zfcubw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2ba37b5519fso36618711fa.2
 for <ltp@lists.linux.it>; Wed, 09 Aug 2023 03:16:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691576206; x=1692181006;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mnwW/XuR2zi69K6x5nuKwBsTaKQeWXtic1b2RMo7fr8=;
 b=Q/cYsj8H9uAX7sQOOwmDx6UrI0MQBcZxbECoU3N/YP+65sBz4tPzWRJC7xxsgHeNmC
 FrA7RCV4aMmkclZM4lVb26Zi3oKgiI84tL5wIlbLQbn9ef9wT2+IH2MtNDG2DeOV1OD5
 f6rMOnj8hmS2yP0Q6E8r/K89O4osfSjCV0UP5MhEMMtCCCZQrKwyiIm0gcXxAkZTerFA
 8uDFPT3bY16zjbgqgpftjlggAg4pgw9NAX2a9qHzTK/vD9be6rUmZsesb+0o1D/ZFNfR
 43tBGtO91ouEQqm5nQIBFcZRgr3AeSmT8jkSFiWvDXxf0YfQUFLBcr70dTna8hyWXopI
 bqXA==
X-Gm-Message-State: AOJu0Yw0/vh0h3OsjgdMgoagmJqLp/WNwNHFKFRCb9L5XBKg0VyKPcO6
 eGd0Bst/4ThQoRuWfgAKUeN125vOMXvTPwsD76yflgBTpuLrrU+AexYNTB84XYOD/iSiJrh4se5
 bfE6KtiXeAxgJ7bJ+hKlffi1CgPhlYSMEVZP6SpVy
X-Received: by 2002:a2e:a1d0:0:b0:2b9:da28:c508 with SMTP id
 c16-20020a2ea1d0000000b002b9da28c508mr1422438ljm.31.1691576206492; 
 Wed, 09 Aug 2023 03:16:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFkIw3ApPqofWVsZHOxIRBmNuQGhJa9Bq5/iaFCBMp6tZj95bY33zhK1mi0dcupkZJJJu6V8bUnOEl8/tExpXc=
X-Received: by 2002:a2e:a1d0:0:b0:2b9:da28:c508 with SMTP id
 c16-20020a2ea1d0000000b002b9da28c508mr1422418ljm.31.1691576206041; Wed, 09
 Aug 2023 03:16:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230808153549.22777-1-akumar@suse.de>
In-Reply-To: <20230808153549.22777-1-akumar@suse.de>
From: Li Wang <liwang@redhat.com>
Date: Wed, 9 Aug 2023 18:16:33 +0800
Message-ID: <CAEemH2dWNJjtbsWn7mf8aghjzMjuWq+XqZWUHw0nx0Vu-Uf7qA@mail.gmail.com>
To: Avinesh Kumar <akumar@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/2] sbrk01: Refactor the test using new LTP API
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

SGkgQXZpbmVzaCwKCk9uIFR1ZSwgQXVnIDgsIDIwMjMgYXQgMTE6MzbigK9QTSBBdmluZXNoIEt1
bWFyIDxha3VtYXJAc3VzZS5kZT4gd3JvdGU6Cgo+IFNpZ25lZC1vZmYtYnk6IEF2aW5lc2ggS3Vt
YXIgPGFrdW1hckBzdXNlLmRlPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Ni
cmsvc2JyazAxLmMgfCAxMjEgKysrKystLS0tLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFu
Z2VkLCAyNiBpbnNlcnRpb25zKCspLCA5NSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS90
ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3Nicmsvc2JyazAxLmMKPiBiL3Rlc3RjYXNlcy9rZXJu
ZWwvc3lzY2FsbHMvc2Jyay9zYnJrMDEuYwo+IGluZGV4IGNlMjZiMTUwMy4uMTA5YjFkMTI1IDEw
MDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2Jyay9zYnJrMDEuYwo+ICsr
KyBiL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2Jyay9zYnJrMDEuYwo+IEBAIC0xLDExMSAr
MSw0MiBAQAo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMAo+ICAvKgo+ICAg
KiBDb3B5cmlnaHQgKGMpIDIwMDAgU2lsaWNvbiBHcmFwaGljcywgSW5jLiAgQWxsIFJpZ2h0cyBS
ZXNlcnZlZC4KPiAtICogIEFVVEhPUiAgICAgICAgICAgICA6IFdpbGxpYW0gUm9za2UKPiAtICog
IENPLVBJTE9UICAgICAgICAgICA6IERhdmUgRmVubmVyCj4gLSAqCj4gLSAqIFRoaXMgcHJvZ3Jh
bSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuIHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3IgbW9kaWZ5
IGl0Cj4gLSAqIHVuZGVyIHRoZSB0ZXJtcyBvZiB2ZXJzaW9uIDIgb2YgdGhlIEdOVSBHZW5lcmFs
IFB1YmxpYyBMaWNlbnNlIGFzCj4gLSAqIHB1Ymxpc2hlZCBieSB0aGUgRnJlZSBTb2Z0d2FyZSBG
b3VuZGF0aW9uLgo+IC0gKgo+IC0gKiBUaGlzIHByb2dyYW0gaXMgZGlzdHJpYnV0ZWQgaW4gdGhl
IGhvcGUgdGhhdCBpdCB3b3VsZCBiZSB1c2VmdWwsIGJ1dAo+IC0gKiBXSVRIT1VUIEFOWSBXQVJS
QU5UWTsgd2l0aG91dCBldmVuIHRoZSBpbXBsaWVkIHdhcnJhbnR5IG9mCj4gLSAqIE1FUkNIQU5U
QUJJTElUWSBvciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVIgUFVSUE9TRS4KPiAtICoKPiAtICog
RnVydGhlciwgdGhpcyBzb2Z0d2FyZSBpcyBkaXN0cmlidXRlZCB3aXRob3V0IGFueSB3YXJyYW50
eSB0aGF0IGl0IGlzCj4gLSAqIGZyZWUgb2YgdGhlIHJpZ2h0ZnVsIGNsYWltIG9mIGFueSB0aGly
ZCBwZXJzb24gcmVnYXJkaW5nIGluZnJpbmdlbWVudAo+IC0gKiBvciB0aGUgbGlrZS4gIEFueSBs
aWNlbnNlIHByb3ZpZGVkIGhlcmVpbiwgd2hldGhlciBpbXBsaWVkIG9yCj4gLSAqIG90aGVyd2lz
ZSwgYXBwbGllcyBvbmx5IHRvIHRoaXMgc29mdHdhcmUgZmlsZS4gIFBhdGVudCBsaWNlbnNlcywg
aWYKPiAtICogYW55LCBwcm92aWRlZCBoZXJlaW4gZG8gbm90IGFwcGx5IHRvIGNvbWJpbmF0aW9u
cyBvZiB0aGlzIHByb2dyYW0gd2l0aAo+IC0gKiBvdGhlciBzb2Z0d2FyZSwgb3IgYW55IG90aGVy
IHByb2R1Y3Qgd2hhdHNvZXZlci4KPiAtICoKPiAtICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVk
IGEgY29weSBvZiB0aGUgR05VIEdlbmVyYWwgUHVibGljIExpY2Vuc2UgYWxvbmcKPiAtICogd2l0
aCB0aGlzIHByb2dyYW07IGlmIG5vdCwgd3JpdGUgdGhlIEZyZWUgU29mdHdhcmUgRm91bmRhdGlv
biwgSW5jLiwKPiAtICogNTEgRnJhbmtsaW4gU3RyZWV0LCBGaWZ0aCBGbG9vciwgQm9zdG9uLCBN
QSAwMjExMC0xMzAxIFVTQS4KPiAtICoKPiAtICogQ29udGFjdCBpbmZvcm1hdGlvbjogU2lsaWNv
biBHcmFwaGljcywgSW5jLiwgMTYwMCBBbXBoaXRoZWF0cmUgUGt3eSwKPiAtICogTW91bnRhaW4g
VmlldywgQ0EgIDk0MDQzLCBvcjoKPiAtICoKPiAtICogaHR0cDovL3d3dy5zZ2kuY29tCj4gLSAq
Cj4gLSAqIEZvciBmdXJ0aGVyIGluZm9ybWF0aW9uIHJlZ2FyZGluZyB0aGlzIG5vdGljZSwgc2Vl
Ogo+IC0gKgo+IC0gKiBodHRwOi8vb3NzLnNnaS5jb20vcHJvamVjdHMvR2VuSW5mby9Ob3RpY2VF
eHBsYW4vCj4gLSAqCj4gLSAqLwo+IC0vKgo+IC0gKiBERVNDUklQVElPTgo+IC0gKiAgICAgMS4p
IHRlc3Qgc2Jyayg4MTkyKSBzaG91bGQgcmV0dXJuIHN1Y2Nlc3NmdWxseS4KPiAtICogICAgIDIu
KSB0ZXN0IHNicmsoLTgxOTIpIHNob3VsZCByZXR1cm4gc3VjY2Vzc2Z1bGx5Lgo+ICsgKiAgQVVU
SE9SIDogV2lsbGlhbSBSb3NrZSwgQ08tUElMT1QgOiBEYXZlIEZlbm5lcgo+ICsgKiBDb3B5cmln
aHQgKGMpIDIwMjMgU1VTRSBMTEMgQXZpbmVzaCBLdW1hciA8YXZpbmVzaC5rdW1hckBzdXNlLmNv
bT4KPiAgICovCj4KPiAtI2luY2x1ZGUgPHVuaXN0ZC5oPgo+IC0jaW5jbHVkZSA8ZXJybm8uaD4K
PiAtI2luY2x1ZGUgPHN0cmluZy5oPgo+IC0jaW5jbHVkZSA8c2lnbmFsLmg+Cj4gLSNpbmNsdWRl
IDxzeXMvdHlwZXMuaD4KPiAtCj4gLSNpbmNsdWRlICJ0ZXN0LmgiCj4gKy8qXAo+ICsgKiBbRGVz
Y3JpcHRpb25dCj4gKyAqCj4gKyAqIFZlcmlmeSB0aGF0IHNicmsoKSBzdWNjZXNzZnVsbHkgaW5j
cmVtZW50cyBvciBkZWNyZW1lbnRzIHRoZSBwcm9ncmFtJ3MKPiArICogZGF0YSBicmVhay4KPiAr
ICovCj4KPiAtY2hhciAqVENJRCA9ICJzYnJrMDEiOwo+ICsjaW5jbHVkZSAidHN0X3Rlc3QuaCIK
Pgo+IC1zdGF0aWMgc3RydWN0IHRlc3RfY2FzZV90IHsKPiArc3RhdGljIHN0cnVjdCB0Y2FzZSB7
Cj4gICAgICAgICBsb25nIGluY3JlbWVudDsKPiAtfSB0ZXN0X2Nhc2VzW10gPSB7Cj4gK30gdGNh
c2VzW10gPSB7Cj4gKyAgICAgICB7MH0sCj4gICAgICAgICB7ODE5Mn0sCj4gLSAgICAgICB7LTgx
OTJ9LAo+ICsgICAgICAgey04MTkyfQo+ICB9Owo+Cj4gLXN0YXRpYyB2b2lkIHNldHVwKHZvaWQp
Owo+IC1zdGF0aWMgdm9pZCBzYnJrX3ZlcmlmeShjb25zdCBzdHJ1Y3QgdGVzdF9jYXNlX3QgKik7
Cj4gLXN0YXRpYyB2b2lkIGNsZWFudXAodm9pZCk7Cj4gLQo+IC1pbnQgVFNUX1RPVEFMID0gQVJS
QVlfU0laRSh0ZXN0X2Nhc2VzKTsKPiAtCj4gLWludCBtYWluKGludCBhYywgY2hhciAqKmF2KQo+
IC17Cj4gLSAgICAgICBpbnQgbGM7Cj4gLSAgICAgICBpbnQgaTsKPiAtCj4gLSAgICAgICB0c3Rf
cGFyc2Vfb3B0cyhhYywgYXYsIE5VTEwsIE5VTEwpOwo+IC0KPiAtICAgICAgIHNldHVwKCk7Cj4g
LQo+IC0gICAgICAgZm9yIChsYyA9IDA7IFRFU1RfTE9PUElORyhsYyk7IGxjKyspIHsKPiAtCj4g
LSAgICAgICAgICAgICAgIHRzdF9jb3VudCA9IDA7Cj4gLQo+IC0gICAgICAgICAgICAgICBmb3Ig
KGkgPSAwOyBpIDwgVFNUX1RPVEFMOyBpKyspCj4gLSAgICAgICAgICAgICAgICAgICAgICAgc2Jy
a192ZXJpZnkoJnRlc3RfY2FzZXNbaV0pOwo+IC0gICAgICAgfQo+IC0KPiAtICAgICAgIGNsZWFu
dXAoKTsKPiAtICAgICAgIHRzdF9leGl0KCk7Cj4gLQo+IC19Cj4gLQo+IC1zdGF0aWMgdm9pZCBz
ZXR1cCh2b2lkKQo+IC17Cj4gLSAgICAgICB0c3Rfc2lnKE5PRk9SSywgREVGX0hBTkRMRVIsIGNs
ZWFudXApOwo+IC0KPiAtICAgICAgIFRFU1RfUEFVU0U7Cj4gLX0KPiAtCj4gLXN0YXRpYyB2b2lk
IHNicmtfdmVyaWZ5KGNvbnN0IHN0cnVjdCB0ZXN0X2Nhc2VfdCAqdGVzdCkKPiArc3RhdGljIHZv
aWQgcnVuKHVuc2lnbmVkIGludCBpKQo+ICB7Cj4gICAgICAgICB2b2lkICp0cmV0Owo+ICsgICAg
ICAgc3RydWN0IHRjYXNlICp0YyA9ICZ0Y2FzZXNbaV07Cj4KPiAtICAgICAgIHRyZXQgPSBzYnJr
KHRlc3QtPmluY3JlbWVudCk7Cj4gLSAgICAgICBURVNUX0VSUk5PID0gZXJybm87Cj4gKyAgICAg
ICB0cmV0ID0gc2Jyayh0Yy0+aW5jcmVtZW50KTsKPiArICAgICAgIFRTVF9FUlIgPSBlcnJubzsK
CgpDYW4gd2UgbWFrZSB1c2Ugb2YgdGhlIExUUCB0ZXN0IG1hY3JvIFRFU1RQVFIoKT8KSXQgaGFz
IGFscmVhZHkgZ2l2ZW4gVFNUX1JFVF9QUlQgYW5kIFRTVF9FUlIgaW5zaWRlIHRoYXQuCgpTZWU6
Cmh0dHBzOi8vZ2l0aHViLmNvbS9saW51eC10ZXN0LXByb2plY3QvbHRwL2Jsb2IvbWFzdGVyL2lu
Y2x1ZGUvdHN0X3Rlc3RfbWFjcm9zLmgjTDMwCgoKCj4KPiAtICAgICAgIGlmICh0cmV0ID09ICh2
b2lkICopLTEpIHsKPiAtICAgICAgICAgICAgICAgdHN0X3Jlc20oVEZBSUwgfCBUVEVSUk5PLCAi
c2JyayAtIEluY3JlYXNlIGJ5ICVsZCBieXRlcwo+IGZhaWxlZCIsCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgIHRlc3QtPmluY3JlbWVudCk7Cj4gLSAgICAgICB9IGVsc2Ugewo+IC0gICAgICAg
ICAgICAgICB0c3RfcmVzbShUUEFTUywgInNicmsgLSBJbmNyZWFzZSBieSAlbGQgYnl0ZXMgcmV0
dXJuZWQgJXAiLAo+IC0gICAgICAgICAgICAgICAgICAgICAgICB0ZXN0LT5pbmNyZW1lbnQsIHRy
ZXQpOwo+IC0gICAgICAgfQo+ICsgICAgICAgaWYgKHRyZXQgPT0gKHZvaWQgKikgLTEpCj4gKyAg
ICAgICAgICAgICAgIHRzdF9yZXMoVEZBSUwgfCBUVEVSUk5PLCAic2JyayglbGQpIGZhaWxlZCIs
Cj4gdGMtPmluY3JlbWVudCk7Cj4gKyAgICAgICBlbHNlCj4gKyAgICAgICAgICAgICAgIHRzdF9y
ZXMoVFBBU1MsICJzYnJrKCVsZCkgcmV0dXJuZWQgJXAiLCB0Yy0+aW5jcmVtZW50LAo+IHRyZXQp
Owo+ICB9Cj4KPiAtc3RhdGljIHZvaWQgY2xlYW51cCh2b2lkKQo+IC17Cj4gLX0KPiArc3RhdGlj
IHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+ICsgICAgICAgLnRlc3QgPSBydW4sCj4gKyAgICAg
ICAudGNudCA9IEFSUkFZX1NJWkUodGNhc2VzKQo+ICt9Owo+IC0tCj4gMi40MS4wCj4KPgo+IC0t
Cj4gTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRw
Cj4KPgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6
Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
