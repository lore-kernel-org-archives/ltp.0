Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F3EC77B79
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 07:58:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42E283CC439
	for <ltp@archiver.kernel.org>; Thu, 13 Apr 2023 09:58:24 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 572543C0041
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 09:58:10 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 44B731000952
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 09:58:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681372687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VZrTqC8VzVxpPnwEG1SyoVHAt8oakg4YXVmtFMSjdyk=;
 b=X7As0Nd11q4ZaJ6QCowlRfUORtmoEGrao4Vk9htr86T3iKmxciJgqNac0Bo0dTIkTZ6P3z
 ATl9tOx/8YP3W3uAJsTa518Wy1qXQlT19SS8fC7xqyffCYZVYDved7YQsKoJjjnoiBmLpu
 ucz+iPZzfSOT6NT7U9iOa6koXC5NuPA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-360-9eILOcY0OF66GEkVPNVaZg-1; Thu, 13 Apr 2023 03:58:06 -0400
X-MC-Unique: 9eILOcY0OF66GEkVPNVaZg-1
Received: by mail-wm1-f70.google.com with SMTP id
 d8-20020a05600c3ac800b003edf7d484d4so4435165wms.0
 for <ltp@lists.linux.it>; Thu, 13 Apr 2023 00:58:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681372685; x=1683964685;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VZrTqC8VzVxpPnwEG1SyoVHAt8oakg4YXVmtFMSjdyk=;
 b=LLAhFmldBPED9XdXptEHFTZLqcnDQxSN2V4oqUb6ri8bWB2YlPPtYIY6yL70SD8NTT
 7gQOaO/unJ9lgglS1uCLE8M4BtwcWaDYt0WPqk/PyAK+peAVZ3mEzKgMOF0Ez/GP3lPu
 ITDmZNE5Pjw5rCeXhsSWp3gs1iGB3N2bKwQL2kETmb8AaXCshcNro+HcruuqbtiJX+TG
 JTp9B91/mpu3mVzl5NfspZyutGdqlFPxmKC57Uc7esicZjyc1zJtzWeb97FVotS8V+P7
 0xVs2gq1ZkmfE3hTST/laWhsFpJCExwbm6tNhvGyGBHff6JkhTxJeL3c/inUV1XN/ILn
 mFeA==
X-Gm-Message-State: AAQBX9doB9cS0wYqKJPIZvS95KFLL82clI2GoDAMmRDy1NxzM5WYEcz+
 PrdmKB1+jiveZ5NZbbPrGijqLqprzlkPwB5aa0S/UQ9hzVcfHZsHohQZiB0d8rzk3uxObzlmBcG
 pt+1cmm9fAvJ+S9c0lRa9tccnW6c=
X-Received: by 2002:a5d:6602:0:b0:2f6:39cd:d899 with SMTP id
 n2-20020a5d6602000000b002f639cdd899mr53578wru.7.1681372684941; 
 Thu, 13 Apr 2023 00:58:04 -0700 (PDT)
X-Google-Smtp-Source: AKy350aUkKb2amypNVvGWZNKe/yzNYLGdB5TTRcjSKEjRDBbO0jiA69EeKyTThDLf44A6qddaUbzhCEQYdSQr3qmSXE=
X-Received: by 2002:a5d:6602:0:b0:2f6:39cd:d899 with SMTP id
 n2-20020a5d6602000000b002f639cdd899mr53575wru.7.1681372684616; Thu, 13 Apr
 2023 00:58:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230412073953.1983857-1-pvorel@suse.cz>
In-Reply-To: <20230412073953.1983857-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 13 Apr 2023 15:57:53 +0800
Message-ID: <CAEemH2eGHMkUCZXJRmPBXM=qqVFA37eyEecNb8cn6j_F3dSO2g@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] tst_test.sh: Remove possible double/trailing
 slashes from TMPDIR
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

T24gV2VkLCBBcHIgMTIsIDIwMjMgYXQgMzo0MOKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gTkZTIHRlc3RzIGhhdmUgcHJvYmxlbSB3aGVuIFRNUERJUiBwYXRoIGNv
bnRhaW5zIGRvdWJsZSBzbGFzaGVzLAo+IGJlY2F1c2UgdGhleSBncmVwIGV4cG9ydGZzIG91dHB1
dCB3aGljaCBpcyBub3JtYWxpemVkLgo+CgpJJ20gb2sgdG8gcmVtb3ZlIHJlZHVuZGFudCBzbGFz
aGVzLCBJIGp1c3Qgd29uZGVyaW5nIHdoZXJlCmlzIHRoZSBzZWNvbmQgc2xhc2ggY29tZXMgZnJv
bT8KSXMgdGhhdCBhZGRlZCBieSBhY2NpZGVudCB3aGVuIGVudiB2YXJpYWJsZSBkZWZpbml0aW9u
PwoKPgo+IFByb2JsZW0gaXMgZWl0aGVyIHRyYWlsaW5nIHNsYXNoOgo+Cj4gJCBUTVBESVI9L3Zh
ci90bXAvIG5mczAxLnNoIC10IHRjcAo+IC4uLgo+IG5mczAxIDEgVElORk86IE1vdW50aW5nIE5G
UzogbW91bnQgLXYgLXQgbmZzIC1vIHByb3RvPXRjcCx2ZXJzPTMgMTAuMC4wLjI6L3Zhci90bXAv
L0xUUF9uZnMwMS5zSXFtNExMUzR1LzMvdGNwCj4gL3Zhci90bXAvL0xUUF9uZnMwMS5zSXFtNExM
UzR1LzMvMAo+IG5mczAxIDEgVElORk86IHN0YXJ0aW5nICduZnMwMV9vcGVuX2ZpbGVzIDEwMDAn
Cj4gbmZzMDEgMSBUUEFTUzogdGVzdCBmaW5pc2hlZCBzdWNjZXNzZnVsbHkKPiBuZnMwMSAyIFRJ
TkZPOiBDbGVhbmluZyB1cCB0ZXN0Y2FzZQo+IG5mczAxIDIgVElORk86IHJlbW90ZV9kaXI6ICcv
dmFyL3RtcC8vTFRQX25mczAxLnNJcW00TExTNHUvMy90Y3AnCj4gZXhwb3J0ZnM6IENvdWxkIG5v
dCBmaW5kICcqOi92YXIvdG1wLy9MVFBfbmZzMDEuc0lxbTRMTFM0dS8zL3RjcCcgdG8KPiB1bmV4
cG9ydC4KPiBybTogY2Fubm90IHJlbW92ZSAnL3Zhci90bXAvL0xUUF9uZnMwMS5zSXFtNExMUzR1
LzMvMCc6IERldmljZSBvciByZXNvdXJjZQo+IGJ1c3kKPiBybTogY2Fubm90IHJlbW92ZSAnL3Zh
ci90bXAvL0xUUF9uZnMwMS5zSXFtNExMUzR1LzMvMCc6IElzIGEgZGlyZWN0b3J5Cj4KPiBvciBk
b3VibGUgKG9yIG1vcmUpIHNsYXNoZXMgKGFueXdoZXJlIGluICRUTVBESVIpOgo+Cj4gJCBUTVBE
SVI9L3Zhci8vdG1wIG5mczAxLnNoIC10IHRjcAo+IG5mczAxIDEgVElORk86IE1vdW50aW5nIE5G
UzogbW91bnQgLXYgLXQgbmZzIC1vIHByb3RvPXRjcCx2ZXJzPTMgMTAuMC4wLjI6L3Zhci8vdG1w
L0xUUF9uZnMwMS5xTmpTc29wVmJZLzMvdGNwCj4gL3Zhci8vdG1wL0xUUF9uZnMwMS5xTmpTc29w
VmJZLzMvMAo+IG5mczAxIDEgVElORk86IHN0YXJ0aW5nICduZnMwMV9vcGVuX2ZpbGVzIDEwMDAn
Cj4gbmZzMDEgMSBUUEFTUzogdGVzdCBmaW5pc2hlZCBzdWNjZXNzZnVsbHkKPiBuZnMwMSAyIFRJ
TkZPOiBDbGVhbmluZyB1cCB0ZXN0Y2FzZQo+IG5mczAxIDIgVElORk86IHJlbW90ZV9kaXI6ICcv
dmFyLy90bXAvTFRQX25mczAxLnFOalNzb3BWYlkvMy90Y3AnCj4gZXhwb3J0ZnM6IENvdWxkIG5v
dCBmaW5kICcqOi92YXIvL3RtcC9MVFBfbmZzMDEucU5qU3NvcFZiWS8zL3RjcCcgdG8KPiB1bmV4
cG9ydC4KPiBybTogY2Fubm90IHJlbW92ZSAnL3Zhci8vdG1wL0xUUF9uZnMwMS5xTmpTc29wVmJZ
LzMvMCc6IERldmljZSBvciByZXNvdXJjZQo+IGJ1c3kKPiBybTogY2Fubm90IHJlbW92ZSAnL3Zh
ci8vdG1wL0xUUF9uZnMwMS5xTmpTc29wVmJZLzMvMCc6IElzIGEgZGlyZWN0b3J5Cj4KPiBXaGls
ZSB0aGlzIGNvdWxkIGJlIGhhbmRsZWQgaW4gbmZzX2xpYi5zaCwgaXQncyBiZXR0ZXIgdG8gc2F2
ZSBpdCBmb3IKPiBhbGwgdGVzdHMuIEl0J3MgZWFzaWVyIHRvIG1vZGlmeSAkVFNUX1RNUERJUiwg
YmVjYXVzZSB0aGUgcHJvYmxlbQo+IG5hcnJvd3MgZG93biB0byBkb3VibGUgc2xhc2guCj4KPiBT
aWduZWQtb2ZmLWJ5OiBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4KPiAtLS0KPiAgdGVzdGNh
c2VzL2xpYi90c3RfdGVzdC5zaCB8IDIgKysKPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9u
cygrKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9saWIvdHN0X3Rlc3Quc2ggYi90ZXN0Y2Fz
ZXMvbGliL3RzdF90ZXN0LnNoCj4gaW5kZXggYzgxN2VlYzc3Li40MmY2MGFiNTggMTAwNjQ0Cj4g
LS0tIGEvdGVzdGNhc2VzL2xpYi90c3RfdGVzdC5zaAo+ICsrKyBiL3Rlc3RjYXNlcy9saWIvdHN0
X3Rlc3Quc2gKPiBAQCAtNzIyLDYgKzcyMiw4IEBAIHRzdF9ydW4oKQo+ICAgICAgICAgICAgICAg
ICBmaQo+Cj4gICAgICAgICAgICAgICAgIFRTVF9UTVBESVI9JChta3RlbXAgLWQgIiRUTVBESVIv
TFRQXyRUU1RfSUQuWFhYWFhYWFhYWCIpCj4gKyAgICAgICAgICAgICAgICMgcmVtb3ZlIHBvc3Np
YmxlIHRyYWlsaW5nIHNsYXNoIG9yIGRvdWJsZSBzbGFzaGVzIGZyb20KPiBUTVBESVIKPiArICAg
ICAgICAgICAgICAgVFNUX1RNUERJUj0kKGVjaG8gIiRUU1RfVE1QRElSIiB8IHNlZCAnc34vXCt+
L35nJykKPgo+ICAgICAgICAgICAgICAgICBjaG1vZCA3NzcgIiRUU1RfVE1QRElSIgo+Cj4gLS0K
PiAyLjQwLjAKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
