Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50012CE7AFB
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 10:10:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 92A233C265D
	for <ltp@archiver.kernel.org>; Fri,  6 Sep 2024 12:10:33 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AB5FE3C0352
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 12:10:17 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E37AB7DD557
 for <ltp@lists.linux.it>; Fri,  6 Sep 2024 12:10:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725617415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AlA7MjIkh9/ELhebAguswbqnhqw803YihHnjZzhhIC8=;
 b=BtlUppxoIU6hZXmQlS42PkqPkwxaw27A8XoLu1KPUmgQhG2h0sd5LCx8t+3D27WSyVQs4b
 7CvfokzFiZ0ed05HvWR3sIJ7a3oYQ2kbseULVUkWtwi+AqIGRhPihdOZndBfz5l+45XidE
 MFv5O1aNXhWxQIVVdD+uvOcgB4V6ElI=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-207-Mn-kwhOFOBuqs6jh19i4WQ-1; Fri, 06 Sep 2024 06:10:13 -0400
X-MC-Unique: Mn-kwhOFOBuqs6jh19i4WQ-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-277ed55b94dso1638337fac.2
 for <ltp@lists.linux.it>; Fri, 06 Sep 2024 03:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725617412; x=1726222212;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AlA7MjIkh9/ELhebAguswbqnhqw803YihHnjZzhhIC8=;
 b=dGuui5SxUSoe3i4A7FP2A6tBHduSr4P70+Xsk8GA/+Jp2GnBND339frGCLAzLVN96w
 RZ5a+TCC0UqzP5XRhe0fWBlcHbi/zHMjYDmVUsUzbP3Jg2EPI+JVxTw+q/iezVK70bjd
 DVLWY5S4qT+vak6gn1tCm0E2oUUz+euiDAs8sRbkmMBiMqs30+qp6ywhZ6d01WAO0/v1
 wBBGIYDw1Mmx1Uc8H642BNpusBdChPamh0O1n5g5wiLGmMp4dWNLtHVJ3eI4P3kkLdhI
 Ja0icPO1JFXqf3VGv88VAlNguP6AJT86vr+Co7TW7p6f4GbSMkyju/F4NrrnghF7sATh
 3Tpw==
X-Gm-Message-State: AOJu0YwfzcRpJOJhqRDM3bk0Rnj9UDZy2B3+ZdFqXSeSZ5pnrILr8A7I
 FbHWqWehffNEupFX3XnMmMCf63ZheO7CDwTBdVdNNBRpWweIuNW2U3UfW0fcAzBulFStRA5OzPn
 MCAoiqnbwuJUBKmP88ehbL17xVTRjlT59U2xwycEmwQpQKpHGRTGFvnfvdfAMbFwO4ZTHG4WOt3
 vjbGRMeAqsbB8eZbtfpw5ZL9M=
X-Received: by 2002:a05:6870:a1a1:b0:270:5f17:b34 with SMTP id
 586e51a60fabf-277900b31a5mr28411140fac.11.1725617412491; 
 Fri, 06 Sep 2024 03:10:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEiCh1MUiSBjju8BVLJGkIi9jvkVccAeIOP3ywwZfohReyis2jxVI74SkNYj0CUD+ZLW2F2CkP6cHExvys2/zU=
X-Received: by 2002:a05:6870:a1a1:b0:270:5f17:b34 with SMTP id
 586e51a60fabf-277900b31a5mr28411122fac.11.1725617412087; Fri, 06 Sep 2024
 03:10:12 -0700 (PDT)
MIME-Version: 1.0
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-3-chrubis@suse.cz>
 <CAEemH2eQQfhTfVo5xrBHFjzuf4dn=VqK2M=9Y3+hy+r8yzMtAA@mail.gmail.com>
 <ZtrRCVxNKuu5ZdHN@yuki.lan>
In-Reply-To: <ZtrRCVxNKuu5ZdHN@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Fri, 6 Sep 2024 18:09:59 +0800
Message-ID: <CAEemH2eHa10SCrdVrPPTWZfQFpyDZ1poFEC=BL1raQECgpjf7g@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 2/4] Add support for mixing C and shell code
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

T24gRnJpLCBTZXAgNiwgMjAyNCBhdCA1OjU04oCvUE0gQ3lyaWwgSHJ1YmlzIDxjaHJ1YmlzQHN1
c2UuY3o+IHdyb3RlOgoKPiBIaSEKPiA+IHRzdF90ZXN0LmM6MTg2MDogVElORk86IExUUCB2ZXJz
aW9uOiAyMDI0MDUyNAo+ID4gdHN0X3Rlc3QuYzoxODY0OiBUSU5GTzogVGVzdGVkIGtlcm5lbDog
Ni44LjAtMTAxMC1yYXNwaSAjMTEtVWJ1bnR1IFNNUAo+ID4gUFJFRU1QVF9EWU5BTUlDIFRodSBB
dWcgIDggMjM6MjI6NDEgVVRDIDIwMjQgYWFyY2g2NAo+ID4gdHN0X3Rlc3QuYzoxNzAzOiBUSU5G
TzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKPiA+IHNoZWxsX3Rlc3QwMS5jOjExOiBU
SU5GTzogQyB0ZXN0IGV4aXRzIG5vdwo+ID4gVXNhZ2U6IHRzdF9yZXNfIGZpbGVuYW1lIGxpbmVu
byBbVFBBU1N8VEZBSUx8VENPTkZ8VElORk98VERFQlVHXSAnQSBzaG9ydAo+ID4gZGVzY3JpcHRp
b24nCj4gPiB0c3RfdGVzdC5jOjE1MzU6IFRCUk9LOiBUZXN0IGhhdmVuJ3QgcmVwb3J0ZWQgcmVz
dWx0cyEKPiA+Cj4gPiBTdW1tYXJ5Ogo+ID4gcGFzc2VkICAgMAo+ID4gZmFpbGVkICAgMAo+ID4g
YnJva2VuICAgMQo+ID4gc2tpcHBlZCAgMAo+ID4gd2FybmluZ3MgMAo+ID4KPiA+Cj4gPiBIZXJl
IEkgZ290IHRlc3QgZmFpbHVyZXMgb24gbXkgUlBpNCAoYmFzaC01LjIuMjEpIHRoYXQgdGhlICRM
SU5FT04gY2FuJ3QKPiA+IGJlIHBhcnNlZCBjb3JyZWN0bHkuCj4KPiBBcmUgeW91IHN1cmUgdGhh
dCB0aGlzIGlzIGR1ZSB0byBiYXNoPyBNeSBndWVzcyBpcyB0aGF0IG9uIFJQaSB0aGUKPiBkZWZh
dWx0IHNoZWxsIGlzIGRhc2ggYmVjYXVzZSBpdCdzIGRlYmlhbiBiYXNlZC4KPgoKRG91YmxlIGNo
ZWNrZWQgdGhhdCBpcyBpbmRlZWQgYmFzaC4KCmxpd2FuZ0ByYXNwaTQ6fi9sdHAvdGVzdGNhc2Vz
L2xpYiQgZWNobyAkMAotYmFzaAoKbGl3YW5nQHJhc3BpNDp+L2x0cC90ZXN0Y2FzZXMvbGliJCBl
Y2hvICRTSEVMTAovYmluL2Jhc2gKCmxpd2FuZ0ByYXNwaTQ6fi9sdHAvdGVzdGNhc2VzL2xpYiQg
cHMgLXAgJCQKICAgIFBJRCBUVFkgICAgICAgICAgVElNRSBDTUQKIDE3NDk5NyBwdHMvMCAgICAw
MDowMDowNCBiYXNoCgpJIGV2ZW4gbWFudWFsbHkgY29kZWQgdGhlICEjL2Jpbi9iYXNoIGluIGV2
ZXJ5IHRlc3QgZmlsZSwgdGhlIHRlc3Qgc3RpbGwKZmFpbGVkLgoKJCBiYXNoIHJ1bl90ZXN0cy5z
aAp0c3RfdGVzdC5jOjE4NjA6IFRJTkZPOiBMVFAgdmVyc2lvbjogMjAyNDA1MjQKdHN0X3Rlc3Qu
YzoxODY0OiBUSU5GTzogVGVzdGVkIGtlcm5lbDogNi44LjAtMTAxMC1yYXNwaSAjMTEtVWJ1bnR1
IFNNUApQUkVFTVBUX0RZTkFNSUMgVGh1IEF1ZyAgOCAyMzoyMjo0MSBVVEMgMjAyNCBhYXJjaDY0
CnRzdF90ZXN0LmM6MTcwMzogVElORk86IFRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCnNo
ZWxsX3Rlc3QwMS5jOjExOiBUSU5GTzogQyB0ZXN0IGV4aXRzIG5vdwovaG9tZS9saXdhbmcvbHRw
L3Rlc3RjYXNlcy9saWIvdGVzdHMvL3NoZWxsX3Rlc3RfcGFzcy5zaDogbGluZSA1OiB0c3RfcmVz
Ogpjb21tYW5kIG5vdCBmb3VuZAovYmluL2Jhc2gKdHN0X3Rlc3QuYzoxNTM1OiBUQlJPSzogVGVz
dCBoYXZlbid0IHJlcG9ydGVkIHJlc3VsdHMhCgpTdW1tYXJ5OgpwYXNzZWQgICAwCmZhaWxlZCAg
IDAKYnJva2VuICAgMQpza2lwcGVkICAwCndhcm5pbmdzIDAKCgoKPgo+IEkgd2lsbCB0cnkgdG8g
cmVwcm9kdWNlLgo+Cj4gPiBUaGUgcmVhc29uIHByb2JhYmx5IGlzIHNvbWUgc2hlbGxzIG9yIHNw
ZWNpZmljIHZlcnNpb25zIG1pZ2h0IG5vdCBoYW5kbGUKPiA+ICRMSU5FTk8gY29ycmVjdGx5IHdp
dGhpbiBhbGlhc2VzLCBlc3BlY2lhbGx5IHdoZW4gdGhlIGxpbmUgbnVtYmVyIG5lZWRzCj4gPiB0
byBiZSBkeW5hbWljYWxseSBkZXRlcm1pbmVkLgo+ID4KPiA+IFNvIEkgc3VnZ2VzdCB1c2luZyBh
IGZ1bmN0aW9uIGluc3RlYWQgb2YgdGhlIGFsaWFzLgo+ID4KPiA+Cj4gPiAtLS0gYS90ZXN0Y2Fz
ZXMvbGliL3RzdF9lbnYuc2gKPiA+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0X2Vudi5zaAo+ID4g
QEAgLTIxLDUgKzIxLDEyIEBAIHRzdF9icmtfKCkKPiA+ICAgICAgICAgZXNhYwo+ID4gIH0KPiA+
Cj4gPiAtYWxpYXMgdHN0X3Jlcz0idHN0X3Jlc18gJHRzdF9zY3JpcHRfbmFtZSBcJExJTkVOTyIK
PiA+IC1hbGlhcyB0c3RfYnJrPSJ0c3RfYnJrXyAkdHN0X3NjcmlwdF9uYW1lIFwkTElORU5PIgo+
ID4gK3RzdF9yZXMoKQo+ID4gK3sKPiA+ICsgICAgdHN0X3Jlc18gIiR0c3Rfc2NyaXB0X25hbWUi
ICIkTElORU5PIiAiJEAiCj4gPiArfQo+ID4gKwo+ID4gK3RzdF9icmsoKQo+ID4gK3sKPiA+ICsg
ICAgdHN0X2Jya18gIiR0c3Rfc2NyaXB0X25hbWUiICIkTElORU5PIiAiJEAiCj4gPiArfQo+Cj4g
VGhhdCBhY3R1YWxseSBkb2VzIG5vdCB3b3JrIGJlY2F1c2UgdW5saWtlIHRoZSBhbGlhcyB0aGUg
JExJTkVOTyBpcwo+IGV4cGFuZGVkIGluIHRoZSB3cm9uZyBwbGFjZSBhbmQgdGhlIGxpbmUgaXMg
aW5jb3JyZWN0Lgo+Cj4gVGhlIHdob2xlIHJlYXNvbiBmb3IgdGhpcyB0byBiZSBhbGlhcyBpcyB0
aGF0IGl0J3MgZXhwYW5kZWQgb24gdGhlCj4gY29ycmVjdCBsaW5lIGluIHRoZSB0ZXN0IHNvdXJj
ZS4KPgo+IC0tCj4gQ3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPgoKLS0gClJlZ2Fy
ZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5p
dC9saXN0aW5mby9sdHAK
