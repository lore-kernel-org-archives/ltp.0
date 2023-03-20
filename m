Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A0FC6FD1D
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 11:16:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0D4E33CD355
	for <ltp@archiver.kernel.org>; Mon, 20 Mar 2023 12:16:36 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6687C3C4C12
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 12:16:25 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C11081A001FE
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 12:16:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679310981;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NbOBjkCeATfyIw6WJwpMzBoJ3tOups/kT4Y37y2sUuc=;
 b=dOrzYfqGVlBx39Yv7SLbrUz67UQSmILYiM+INIP+mgSr4VzquvIlSnBWBFCq7+fLrqq4Q8
 FeqMX8RIJmGekoDv9RFD4fjWrKpZcJcLtg+Byl379Js6I7MbWQ8K1VHzYPP8KrxU34fn3J
 5mEQH6cueoI8BXAQvlHz2NYUpS8kWro=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-152-2j6xZfPAOkCl5YinLqT_nw-1; Mon, 20 Mar 2023 07:16:20 -0400
X-MC-Unique: 2j6xZfPAOkCl5YinLqT_nw-1
Received: by mail-wr1-f71.google.com with SMTP id
 o5-20020adf8b85000000b002d58b4b7698so335620wra.19
 for <ltp@lists.linux.it>; Mon, 20 Mar 2023 04:16:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679310979;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NbOBjkCeATfyIw6WJwpMzBoJ3tOups/kT4Y37y2sUuc=;
 b=CfB7rGxSjTi2rl8VwPps6IsWwFbG5Vzi0ZM2S1E0qZQM63YyliyEh9fobfyB2o7tP4
 1GiIdFj1ufI+K1ZO320nP/Jm9m5uYr+661BDSExV3F+VGSGRC+GSW2QhQqdQ9o2h+EUq
 E3L5DMBzWMEcKYhFWQJCnehr8SLWLnxiRF5LRlONt4kFqjeWs8+Ptgh4sSkOwmRcv1Tc
 +FhHsM7LQcgU1BMwyW5Ys9raeR2h2d+3yIbLFVd5On/IabAE5tFXHJUsBoVCpGcqcoe7
 tfsaP6w4ucUHF4/BkSch7KDyLrm0iAb203HLJPGn0VGwnvpSd0oKEQtGgdceZ0U+DuJb
 iKSA==
X-Gm-Message-State: AO0yUKUmxv1MMA+52ipUFi+kOD0aG3hl/orUkfPTwY7Tn+pDOxnhkoh4
 R/SjYvBg23K3QRN7CToEHHFJBx9LgN55TFxEPvBk7r/RTDD2x4899Qt82zx4+uKnbcMQQeB4OOQ
 76JfVcEPs6lsd7ZMlwjUKHqOTjiw=
X-Received: by 2002:a1c:7717:0:b0:3ed:6afb:5272 with SMTP id
 t23-20020a1c7717000000b003ed6afb5272mr3239380wmi.8.1679310979096; 
 Mon, 20 Mar 2023 04:16:19 -0700 (PDT)
X-Google-Smtp-Source: AK7set/aU2Fb8d6AqucSeepUb5vG27R1zx0JiTpmsDIMoDRLY9QBqgTlirDx+yIY7Ms/Kx5kwDqvqrQ4Zr6tGJU+iRQ=
X-Received: by 2002:a1c:7717:0:b0:3ed:6afb:5272 with SMTP id
 t23-20020a1c7717000000b003ed6afb5272mr3239368wmi.8.1679310978772; Mon, 20 Mar
 2023 04:16:18 -0700 (PDT)
MIME-Version: 1.0
References: <20230314114037.25581-1-rpalethorpe@suse.com>
 <20230314175438.GB79562@pevik>
 <20230320080415.GA179863@pevik> <20230320082336.GA182681@pevik>
In-Reply-To: <20230320082336.GA182681@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 20 Mar 2023 19:16:07 +0800
Message-ID: <CAEemH2dHeOweGRaeQAx9DuE936=DMycqJNt_ymJ9GqSZ2ES8PQ@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] Add goals of patch review and tips
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBNYXIgMjAsIDIwMjMgYXQgNDoyM+KAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gSGkgYWxsLAo+Cj4gPiArIGFsc28gYWRkIFRlc3RlZDogbGluay10by1n
aXRodWItYWN0aW9ucy1ydW4gYmVsb3cgLS0tIGluIHBhdGNoIHdvdWxkCj4gaGVscAo+ID4gKGl0
J3MgdGhhbiBvYnZpb3VzIHRoYXQgbWFpbnRhaW5lciBkb2VzIG5vdCBoYXZlIHRvIGJvdGhlciB3
aXRoIGRvaW5nIGl0Cj4gb3IKPiA+IG5vdCBob3BlIHRoYXQgaXQgZmFpbHMgb24gQ2VudE9TIDcg
b2xkIGNvbXBpbGVyIG9yIHZlcnkgbmV3IEZlZG9yYQo+IGNvbXBpbGVyKS4KPgo+ID4gTWF5YmUg
YWxzbyBlbmNvdXJhZ2UgcGVvcGxlIHRvIGNyZWF0ZSBhY2NvdW50IGluIHRoZSBwYXRjaHdvcmsg
YW5kCj4gbWFpbnRhaW4KPiA+IHN0YXR1cyB0aGVpciBwYXRjaGVzIHdvdWxkIGhlbHAgKHNldCAi
U3VwZXJzZWRlZCIgaWYgdGhleSBzZW50IG5ldyBwYXRjaAo+IHZlcnNpb24sCj4KCkknbSBub3Qg
c3VyZSBpZiB0aGlzIGJyaW5ncyBhZHZhbnRhZ2VzIG1vcmUgdGhhbiBkaXNhZHZhbnRhZ2VzCk15
IGNvbmNlcm4gaXMgdGhhdCBwcm9iYWJseSBjYXVzZWQgdGhlIHdyb25nIG9wZXJhdGlvbiBpZiBt
b3JlCmdyZWVuIGhhbmRzIGNhbiB1cGRhdGUgdGhlIHBhdGNoIHN0YXR1cyBpbiB0aGUgcGF0Y2h3
b3JrLiBUaGF0CmVhc2lseSBsZXQgdXMgY29uZnVzZWQgYWJvdXQgd2hlcmUgdGhlIHBhdGNoIGhh
cyBnb25lOikuCgpVbmxlc3Mgd2UgaGF2ZSBhIHdheSB0byBncmFudCBsaW1pdGVkIHBlcm1pc3Np
b25zIHRvIGFjY291bnQuCgo+IG90aGVyIHN0YXR1c2VzIGxpa2UgIkFjY2VwdGVkIiBvciAiQ2hh
bmdlcyByZXF1ZXN0ZWQiIGFyZSBhbHNvIHNvbWV0aW1lcwo+ID4gZm9yZ290dGVuIGJ5IHRoZSBt
YWludGFpbmVyIHdobyBwb3N0IGNvbW1lbnRzIG9yIG1lcmdlIHRoZSBwYXRjaCkuCj4gRXhhbXBs
ZSB3aHkgaGVscGluZyB0byBtYWludGFpbiB0aGUgcGF0Y2hlcyBieSBzdWJtaXR0ZXIgd291bGQg
aGVscDoKPiBta25vZDAxOiBSZXdyaXRlIHRoZSB0ZXN0IHVzaW5nIG5ldyBMVFAgQVBJIFsxXSBm
b2xsb3dlZCBieSBbdjIsMS8xXQo+IG1rbm9kMDE6Cj4gUmV3cml0ZSB0aGUgdGVzdCB1c2luZyBu
ZXcgTFRQIEFQSSBbMl0uCj4KPiBMaSByZXZpZXdlZCB2MiwgYnV0IGxhdGVyIEN5cmlsIHB1c2hl
ZCB2MSAobWFudWFsbHkgdXBkYXRpbmcgcGF0Y2gpIHdpdGhvdXQKPiB1cGRhdGUgcGF0Y2h3b3Jr
LiAoTGkgcmV2aWV3IHdhcyBpZ25vcmVkLCBJIHRyaWVkIHRvIGFwcGx5IHYyIHRvIG1lcmdlIGl0
Cj4gYmVjYXVzZSBzdGF0dXMgd2FzIG5vdCB1cGRhdGVkLikKPgoKCkknZCBtYWtlIGEgY2xhcmlm
aWNhdGlvbiBmb3IgdGhhdCBta25vZDAxIHBhdGNoIHJldmlldywKdGhlIHJlYXNvbiB3aHkgQ3ly
aWwgbWVyZ2UgVjEgbWFudWFsbHkgaXMgdGhhdCBWMgppbnZvbHZlcyBuZXcgY2hhbmdlIChJIG5l
Z2xlY3RlZCkgaW4gbWtub2QwMiwgd2hpY2gKc2hvdWxkIGJlIHNlcGFyYXRlZCBpbiBhbm90aGVy
IHBhdGNoLgoKQ3lyaWwgZGlkIHRoZSByaWdodCB0aGluZyB0aGVyZS4gQnV0IGhlIGRpZG4ndCBl
eHBsYWluIHRoYXQuCgoKCj4KPiBLaW5kIHJlZ2FyZHMsCj4gUGV0cgo+Cj4gWzFdCj4gaHR0cHM6
Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2x0cC9wYXRjaC8yMDIzMDIyMjAzNDUwMS4x
MTgwMC0xLWFrdW1hckBzdXNlLmRlLwo+IFsyXQo+IGh0dHBzOi8vcGF0Y2h3b3JrLm96bGFicy5v
cmcvcHJvamVjdC9sdHAvcGF0Y2gvMjAyMzAyMjgxNTQyMDMuMjc4My0xLWFrdW1hckBzdXNlLmRl
Lwo+Cj4gPiBCb3RoIG9mIHRoZXNlIGFyZSBzbWFsbCBoZWxwcywgYnV0IHRoZXkgc3RpbGwgaGVs
cCBMVFAgbWFpbnRhaW5lcnMgdG8KPiBoYXZlIG1vcmUKPiA+IHRpbWUgZm9yIHRoZSByZXZpZXcg
b3IgZm9yIHdyaXRpbmcgb3duIHBhdGNoZXMuCj4KPiA+IEJ1dCBJIGNhbiBwb3N0IGEgZm9sbG93
LXVwIHBhdGNoIHdpdGggdGhlc2UgYWZ0ZXIgeW91ciBwYXRjaCBpcyBtZXJnZWQKPiBpZiB5b3UK
PiA+IGRvbid0IHdhbnQgdG8gZm9ybXVsYXRlIHRoZW0uCj4KPiA+IEtpbmQgcmVnYXJkcywKPiA+
IFBldHIKPgo+CgotLSAKUmVnYXJkcywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
