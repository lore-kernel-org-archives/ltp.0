Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B157FEB64D9
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 02:51:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E26113CC63B
	for <ltp@archiver.kernel.org>; Tue, 20 Jun 2023 04:51:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6D4EA3CB27B
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 04:51:11 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0CBEE200204
 for <ltp@lists.linux.it>; Tue, 20 Jun 2023 04:51:10 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687229469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OyQoHrqr/7VEn9MfP+fkjUK049haAzZ0c7cDej49dK8=;
 b=IDP5gp/E/dQSFVhvtIXOrskLQlKki9zNuFEzkaSm4ai2TMbA9eFc0bhWZyKJTFRIKN0Qj1
 sR5LZjcohGO6UB1wWzJbPaH1hmhEnPCQHM/vIxwPsxLycrAQLgbeXoJkiqjTJFLY/xXxd6
 Vr9aHIHwfk3p1AAR5dH6wm9qXufBQV4=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-253-HAH8cGFGOwKj-8FIfosZdA-1; Mon, 19 Jun 2023 22:51:06 -0400
X-MC-Unique: HAH8cGFGOwKj-8FIfosZdA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2b46d6a2e75so14707531fa.1
 for <ltp@lists.linux.it>; Mon, 19 Jun 2023 19:51:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687229465; x=1689821465;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OyQoHrqr/7VEn9MfP+fkjUK049haAzZ0c7cDej49dK8=;
 b=Bjp2E7M0LcEhohKyttFHOQld0HuROyC9YZ9+TCzMwfC60aKjjTM+kAzvN9UTzdy+Yp
 QKHfAqsRGoxVh8jp6Jd59MyC809Fov44dBtDse8og4pdCbiGHxCfGv34vlVjMrDx2okU
 GH2hqQE76+YpwRciViEzn7C1GYTIludrAvtyiVgg/3m/xuHUQHvBDtRmdHEetpllmsyW
 2Kla5WNqeLwrKt/apIlQuRLPDTUZaDlddG0+UqTMqXxOUrgehQxt3o8E4LPuwFR6HWoR
 Z0JovC0/Vz5YY9sb6fmGgQ28+z0ppb6oFBstxNdQz4lYvh71glC8M35FVJ18AzFtp/yw
 MDLw==
X-Gm-Message-State: AC+VfDykh6WpQqkmI2kxbskWm7iX2sfuzeot+wF0yswVGMViH3VmWVn9
 HYQpstvjzykKT/4bwEpYI+glcMCwEj8u0hjuxwgeCzbh39Ox2RIovtvxnXaUVg6SmgXAoM/MizJ
 o4INeI4N7V9MngMPdKcd0ZKXrnm8=
X-Received: by 2002:a2e:95c2:0:b0:2b3:43e6:4335 with SMTP id
 y2-20020a2e95c2000000b002b343e64335mr6901398ljh.11.1687229465399; 
 Mon, 19 Jun 2023 19:51:05 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ48fpqKU7W96cKmPTSfs9uHPk3byLCs/YPvPJQPRM3o9mof8phAJpv3DWoAAs3A02OzTy/wZ70duzOpcwIJH2w=
X-Received: by 2002:a2e:95c2:0:b0:2b3:43e6:4335 with SMTP id
 y2-20020a2e95c2000000b002b343e64335mr6901392ljh.11.1687229464947; Mon, 19 Jun
 2023 19:51:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230619163255.234848-1-pvorel@suse.cz>
In-Reply-To: <20230619163255.234848-1-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Tue, 20 Jun 2023 10:50:53 +0800
Message-ID: <CAEemH2dQsp17RL1fFODhOCSvRJ8N0=2BUi5_JtxO4d_ofcBx4w@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] ci: Don't test doc generation on Debian
 oldstable
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

SGkgUGV0ciwKClRoYW5rcyBzbyBtdWNoIGZvciB0aGUgZGVidWdnaW5nIHdvcmsuCgpSZXZpZXdl
ZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgpPbiBUdWUsIEp1biAyMCwgMjAyMyBh
dCAxMjozNuKAr0FNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PiB3cm90ZToKCj4gSFRNTCBn
ZW5lcmF0aW9uIHdpdGggYXNjaWlkb2MgaXMgYnJva2VuIG9uIERlYmlhbiAxMSBidWxsc2V5ZQo+
ICh0aGUgbmV3IERlYmlhbiBvbGRzdGFibGUpOgo+Cj4gYTJ4OiBFUlJPUjogInhzbHRwcm9jIiAt
LXN0cmluZ3BhcmFtIHRvYy5zZWN0aW9uLmRlcHRoIDEgLS1zdHJpbmdwYXJhbQo+IGNhbGxvdXQu
Z3JhcGhpY3MgMCAtLXN0cmluZ3BhcmFtIG5hdmlnLmdyYXBoaWNzIDAgLS1zdHJpbmdwYXJhbQo+
IGFkbW9uLnRleHRsYWJlbCAxIC0tc3RyaW5ncGFyYW0gYWRtb24uZ3JhcGhpY3MgMCAtLXN0cmlu
Z3BhcmFtCj4gY2h1bmsuc2VjdGlvbi5kZXB0aCAwICAtLW91dHB1dCAiL19fdy9sdHAvbHRwL2Rv
Y3BhcnNlL21ldGFkYXRhLmh0bWwiCj4gIi9ldGMvYXNjaWlkb2MvZG9jYm9vay14c2wveGh0bWwu
eHNsIgo+ICIvX193L2x0cC9sdHAvZG9jcGFyc2UvbWV0YWRhdGEueG1sIiByZXR1cm5lZCBub24t
emVybyBleGl0IHN0YXR1cyA1Cj4KPiBGaXJzdCByZWFzb24gaXMgdGhhdCBkb2Nib29rMnggaXMg
bmVlZGVkIHRvIGdldCByZXF1aXJlZCBYU0wgKGJyb2tlbgo+IGRlcGVuZGVuY3ksIHdoaWNoIGlz
IGZpeGVkIG9uIG5ld2VyIERlYmlhbiB2ZXJzaW9ucykuCj4KPiBCdXQgZXZlbiB3aXRoIGl0IGJl
aW5nIGluc3RhbGxlZCwgaXQgc3RpbGwgZG9lcyBub3Qgd29yayBvbiBHaXRIdWIKPiBBY3Rpb25z
LCBkdWUgc29tZWhvdyBzcGVjaWFsIG5ldHdvcmssIGUuZy4gcGluZyA4LjguOC44IGRvZXMgbm90
IHdvcmsKPiAoZmlyZXdhbGw/KSwgY29kZSB3b3JraW5nIGluIGRpc3RybyBydW5uaW5nIHZpYSBw
b2RtYW4gbG9jYWxseSBmYWlscyBvbiBDSToKPgo+ICQgY2QgbWV0YWRhdGEgJiYgbWFrZQo+IGVy
cm9yIDogVW5rbm93biBJTyBlcnJvcgo+IHdhcm5pbmc6IGZhaWxlZCB0byBsb2FkIGV4dGVybmFs
IGVudGl0eSAiCj4gaHR0cDovL2RvY2Jvb2suc291cmNlZm9yZ2UubmV0L3JlbGVhc2UveHNsL2N1
cnJlbnQveGh0bWwvZG9jYm9vay54c2wiCj4gY29tcGlsYXRpb24gZXJyb3I6IGZpbGUgL2V0Yy9h
c2NpaWRvYy9kb2Nib29rLXhzbC94aHRtbC54c2wgbGluZSAxMgo+IGVsZW1lbnQgaW1wb3J0Cj4g
eHNsOmltcG9ydCA6IHVuYWJsZSB0byBsb2FkCj4gaHR0cDovL2RvY2Jvb2suc291cmNlZm9yZ2Uu
bmV0L3JlbGVhc2UveHNsL2N1cnJlbnQveGh0bWwvZG9jYm9vay54c2wKPgo+IEJlY2F1c2UgYXNj
aWlkb2MgaXMgdGVzdGVkIG9uIG90aGVyIGRpc3Ryb3MsIHNpbXBseSByZW1vdmUgdGhlIHRlc3Qu
Cj4KPiBSZXBvcnRlZC1ieTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+Cj4gU2lnbmVkLW9m
Zi1ieTogUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gLS0tCj4gIC5naXRodWIvd29ya2Zs
b3dzL2NpLnltbCB8IDMgKy0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMiBk
ZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS8uZ2l0aHViL3dvcmtmbG93cy9jaS55bWwgYi8u
Z2l0aHViL3dvcmtmbG93cy9jaS55bWwKPiBpbmRleCBkOGU1ZGNhODYuLmQ3ZTlmMmRkMCAxMDA2
NDQKPiAtLS0gYS8uZ2l0aHViL3dvcmtmbG93cy9jaS55bWwKPiArKysgYi8uZ2l0aHViL3dvcmtm
bG93cy9jaS55bWwKPiBAQCAtMSw0ICsxLDQgQEAKPiAtIyBDb3B5cmlnaHQgKGMpIDIwMjEgUGV0
ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4gKyMgQ29weXJpZ2h0IChjKSAyMDIxLTIwMjMgUGV0
ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KPiAgbmFtZTogIkNJOiBkb2NrZXIgYmFzZWQgYnVp
bGRzIgo+ICBvbjogW3B1c2gsIHB1bGxfcmVxdWVzdF0KPiBAQCAtNzksNyArNzksNiBAQCBqb2Jz
Ogo+ICAgICAgICAgICAgLSBjb250YWluZXI6ICJkZWJpYW46b2xkc3RhYmxlIgo+ICAgICAgICAg
ICAgICBlbnY6Cj4gICAgICAgICAgICAgICAgQ0M6IGNsYW5nCj4gLSAgICAgICAgICAgICAgTUVU
QURBVEE6IGFzY2lpZG9jLXBkZgo+Cj4gICAgICAgICAgICAtIGNvbnRhaW5lcjogIm9wZW5zdXNl
L2xlYXAiCj4gICAgICAgICAgICAgIGVudjoKPiAtLQo+IDIuNDAuMQo+Cj4KCi0tIApSZWdhcmRz
LApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQv
bGlzdGluZm8vbHRwCg==
