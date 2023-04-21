Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBC6EC77B75
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 07:21:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1230C3CBEE3
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 09:21:29 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E9FF03CB332
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:21:19 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id F354D6008DC
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 09:21:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682061677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LxBPqG7ystQviq8aeBvVT5+ItkfSgFLETWUUw5PSIEA=;
 b=UdAtqShuqAjiwGygRjOJHUIt27pK0xCZmaAd20fxX2DhfIGR/Og0ClJi+lV1uFMD+cHjda
 +c/nZYL74E7cAsoR8hUL7PxRGibVPfRiJ2aMlEKJkfIHnodQyspUb0asZqcqXSjf2CbP0G
 WLUDdadhTI+bSwDbYVJJcI9ux1qXGGM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-cSvzYDdqOvqQDELNn9q12A-1; Fri, 21 Apr 2023 03:21:15 -0400
X-MC-Unique: cSvzYDdqOvqQDELNn9q12A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2fe3fb8e36bso814895f8f.0
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 00:21:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682061673; x=1684653673;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LxBPqG7ystQviq8aeBvVT5+ItkfSgFLETWUUw5PSIEA=;
 b=Lojc4q9w3LKnCsg2VTaAwELr+xY6RnBYhyoL6/ve3LGrjo7B6DaFELcqN6TdDsVKnt
 doRptNKaBPkChDMV88pvyv3FuBCzo5ZAWS1ujwUjVQjJwGoNHNsjnIqoqGO/Aocg9ONu
 7iMJArilPB6VwbEzCHgK6kWk5XtcRG1KjIJhkH0MMPIQUy2HzuMHWJ2FOPY2erMw/oj7
 h7xdE7xfA4mYnnzSfpoumJG7OiFsgBQwO3hKCc901NsxAsX1vT6K+QSE4xDMs/MbAC6p
 af59zkGApyJHBF9HfLf/DyREW7DQUIJ8y7KfXaKKZ3rNDLjFbrZWEiTKvuZ77lK7ZhK8
 LrJw==
X-Gm-Message-State: AAQBX9fEYxwaAQ4ZJK1xTZHc0SEG+GNjwX/c7+MUerzSpWqYPaOKLx8E
 0SXFbe4CkL4TSnKOUAfMAD0sD6Ak2IffJ/wdPXXydir7UFRoSEWRcoahGrUzQL9AelMuegXfFty
 1fcQKkZC+tzF98/ECQk9jrlzL/2LRKsg1EreVHVCP
X-Received: by 2002:adf:f149:0:b0:2ff:148d:7e4e with SMTP id
 y9-20020adff149000000b002ff148d7e4emr2878381wro.2.1682061673525; 
 Fri, 21 Apr 2023 00:21:13 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZOigD1frwTBM3ERIVTAbBKtq8ldmuhvG3HqARIGwcMW5p0wLJu+TG09ybb3BhKUZLu/ObfzvB1yqM/yB0c5ao=
X-Received: by 2002:adf:f149:0:b0:2ff:148d:7e4e with SMTP id
 y9-20020adff149000000b002ff148d7e4emr2878371wro.2.1682061673180; Fri, 21 Apr
 2023 00:21:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230420160910.809091-1-teo.coupriediaz@arm.com>
 <20230420160910.809091-2-teo.coupriediaz@arm.com>
In-Reply-To: <20230420160910.809091-2-teo.coupriediaz@arm.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 21 Apr 2023 15:21:01 +0800
Message-ID: <CAEemH2dCDPni4vtXhog3FcE8RkQ677NcUBAOR4BvGgyfSFwgtQ@mail.gmail.com>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v2 1/2] setpgid02: Use pid_max as PGID for EPERM
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

T24gRnJpLCBBcHIgMjEsIDIwMjMgYXQgMTI6MDnigK9BTSBUZW8gQ291cHJpZSBEaWF6IDx0ZW8u
Y291cHJpZWRpYXpAYXJtLmNvbT4Kd3JvdGU6Cgo+IEluIHNvbWUgc2ltcGxlIHN5c3RlbXMgKGxp
a2UgQnVzeWJveCksIHRoZSBsb2dpbiBzaGVsbCBtaWdodCBiZSBydW4KPiBhcyBpbml0IChQSUQg
MSkuCj4gVGhpcyBsZWFkcyB0byBhIGNhc2Ugd2hlcmUgTFRQIGlzIHJ1biBpbiB0aGUgc2FtZSBz
ZXNzaW9uIGFzIGluaXQsCj4gdGh1cyBzZXRwZ2lkIGlzIGFsbG93ZWQgdG8gdGhlIFBHSUQgb2Yg
aW5pdCB3aGljaCByZXN1bHRzIGluIGEgdGVzdCBmYWlsLgo+IEluZGVlZCwgdGhlIHRlc3QgcmV0
cmlldmVzIHRoZSBQR0lEIG9mIGluaXQgdG8gdHJ5IGFuZCBnZW5lcmF0ZSBFUEVSTS4KPgo+IElu
c3RlYWQgZ2V0IHRoZSBQR0lEIHdlIHVzZSB0byBnZW5lcmF0ZSBFUEVSTSBmcm9tIHRoZSBrZXJu
ZWwgcGlkX21heC4KPiBJdCBzaG91bGQgbm90IGJlIHVzZWQgYnkgYW55IHByb2Nlc3MsIGd1YXJh
bnRlZWluZyBhbiBpbnZhbGlkIFBHSUQKPiBhbmQgZ2VuZXJhdGluZyBhbiBFUEVSTSBlcnJvci4K
Pgo+IFNpZ25lZC1vZmYtYnk6IFRlbyBDb3VwcmllIERpYXogPHRlby5jb3VwcmllZGlhekBhcm0u
Y29tPgo+IC0tLQo+ICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldHBnaWQvc2V0cGdpZDAy
LmMgfCAxNCArKysrKysrLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCsp
LCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2Fs
bHMvc2V0cGdpZC9zZXRwZ2lkMDIuYwo+IGIvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRw
Z2lkL3NldHBnaWQwMi5jCj4gaW5kZXggNGI2M2FmZWU4Li5iMzgwZDdkZjQgMTAwNjQ0Cj4gLS0t
IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRwZ2lkL3NldHBnaWQwMi5jCj4gKysrIGIv
dGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9zZXRwZ2lkL3NldHBnaWQwMi5jCj4gQEAgLTEzLDE1
ICsxMywxNSBAQAo+ICAgKiAtIEVJTlZBTCB3aGVuIGdpdmVuIHBnaWQgaXMgbGVzcyB0aGFuIDAu
Cj4gICAqIC0gRVNSQ0ggd2hlbiBwaWQgaXMgbm90IHRoZSBjYWxsaW5nIHByb2Nlc3MgYW5kIG5v
dCBhIGNoaWxkIG9mCj4gICAqIHRoZSBjYWxsaW5nIHByb2Nlc3MuCj4gLSAqIC0gRVBFUk0gd2hl
biBhbiBhdHRlbXB0IHdhcyBtYWRlIHRvIG1vdmUgYSBwcm9jZXNzIGludG8gYSBwcm9jZXNzCj4g
LSAqIGdyb3VwIGluIGEgZGlmZmVyZW50IHNlc3Npb24uCj4gKyAqIC0gRVBFUk0gd2hlbiBhbiBh
dHRlbXB0IHdhcyBtYWRlIHRvIG1vdmUgYSBwcm9jZXNzIGludG8gYSBub25leGlzdGluZwo+ICsg
KiBwcm9jZXNzIGdyb3VwLgo+ICAgKi8KPgo+ICAjaW5jbHVkZSA8ZXJybm8uaD4KPiAgI2luY2x1
ZGUgPHVuaXN0ZC5oPgo+ICAjaW5jbHVkZSAidHN0X3Rlc3QuaCIKPgo+IC1zdGF0aWMgcGlkX3Qg
cGdpZCwgcGlkLCBwcGlkLCBpbml0X3BnaWQ7Cj4gK3N0YXRpYyBwaWRfdCBwZ2lkLCBwaWQsIHBw
aWQsIGludmFsX3BnaWQ7Cj4gIHN0YXRpYyBwaWRfdCBuZWdhdGl2ZV9waWQgPSAtMTsKPgo+ICBz
dGF0aWMgc3RydWN0IHRjYXNlIHsKPiBAQCAtMzEsNyArMzEsNyBAQCBzdGF0aWMgc3RydWN0IHRj
YXNlIHsKPiAgfSB0Y2FzZXNbXSA9IHsKPiAgICAgICAgIHsmcGlkLCAmbmVnYXRpdmVfcGlkLCBF
SU5WQUx9LAo+ICAgICAgICAgeyZwcGlkLCAmcGdpZCwgRVNSQ0h9LAo+IC0gICAgICAgeyZwaWQs
ICZpbml0X3BnaWQsIEVQRVJNfQo+ICsgICAgICAgeyZwaWQsICZpbnZhbF9wZ2lkLCBFUEVSTX0K
PiAgfTsKPgo+ICBzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+IEBAIC00MSwxMCArNDEsMTAgQEAg
c3RhdGljIHZvaWQgc2V0dXAodm9pZCkKPiAgICAgICAgIHBnaWQgPSBnZXRwZ3JwKCk7Cj4KPiAg
ICAgICAgIC8qCj4gLSAgICAgICAgKiBHZXR0aW5nIHBnaWQgb2YgaW5pdC9zeXN0ZW1kIHByb2Nl
c3MgdG8gdXNlIGl0IGFzIGEKPiAtICAgICAgICAqIHByb2Nlc3MgZ3JvdXAgZnJvbSBhIGRpZmZl
cmVudCBzZXNzaW9uIGZvciBFUEVSTSB0ZXN0Cj4gKyAgICAgICAgKiBwaWRfbWF4IHdvdWxkIG5v
dCBiZSBpbiB1c2UgYnkgYW5vdGhlciBwcm9jZXNzIGFuZCBndWFyYW50ZWVzCj4gdGhhdAo+ICsg
ICAgICAgICogaXQgY29ycmVzcG9uZHMgdG8gYW4gaW52YWxpZCBQR0lELCBnZW5lcmF0aW5nIEVQ
RVJNLgo+ICAgICAgICAgICovCj4gLSAgICAgICBpbml0X3BnaWQgPSBTQUZFX0dFVFBHSUQoMSk7
Cj4gKyAgICAgICBTQUZFX0ZJTEVfU0NBTkYoIi9wcm9jL3N5cy9rZXJuZWwvcGlkX21heCIsICIl
ZFxuIiwgJmludmFsX3BnaWQpOwo+CgoKSSBndWVzcyB0aGUgJ1xuJyBpcyBhIHR5cG8gYWRkZWQg
YnkgYWNjaWRlbnQsCmFmdGVyIHJlbW92aW5nIGl0IHRoZW46CgpSZXZpZXdlZC1ieTogTGkgV2Fu
ZyA8bGl3YW5nQHJlZGhhdC5jb20+CgoKCj4gIH0KPgo+ICBzdGF0aWMgdm9pZCBydW4odW5zaWdu
ZWQgaW50IG4pCj4gLS0KPiAyLjM0LjEKPgo+Cj4gLS0KPiBNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2Fu
ZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZv
L2x0cAo=
