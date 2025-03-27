Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45D24C3600B
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1743076481; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-transfer-encoding :
 content-type : sender : from;
 bh=IQ0awEsvd/NxHL56sDG7VsztHTYY4J3ytnE6jgFwGlA=;
 b=hziLz0v+w8k2o0Qmj8t5R8IUwfI5z0ovKEFW9KPPE2rcGlBZtAe1DI99yxMWnCm7PFvko
 o+c/NtBRXoqFYDzZpDpp/60c0zohA9LhwnWaYhp4IRCkrKbl2RbBU0Lh3ID8QGaykIXZnYm
 3/wgmV3Vm6oWL+9Ah3HdGcTWw63As3Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D28153C9E88
	for <ltp@archiver.kernel.org>; Thu, 27 Mar 2025 12:54:41 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 70A4A3C726B
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:54:20 +0100 (CET)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BB9FB100044C
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 12:54:19 +0100 (CET)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-38a25d4b9d4so414641f8f.0
 for <ltp@lists.linux.it>; Thu, 27 Mar 2025 04:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1743076459; x=1743681259; darn=lists.linux.it;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=XJte5VXga7buSEWutuMvX6HtBnCpM9rR8Pptams0fHk=;
 b=aSVYOSw5D75+2mjwa8LhIIaFBaTfDNjAx57Y14DL5BRAk/QG8fSgSlJfKN4MhfQgEF
 PP8hXCcA9yz6sGe/RB155NdFh8kEPBdMuiUtXW/8d1ySlbpd9zt3UzFmonnfPyzkOZ+Y
 Ew89vjSmjpIFZd3rW9ekBy/NlThpWcOUe1kbGUJ2uVLYaDS4/nxiCpvpn/GsA9n+ha1x
 Sr2r2uy3CRP5+e3zQXIau2airw+musv898sD1R0A43yVNfLJrZuYuRRM4qmZCuFUd2Ma
 9N1uGxY0HqzWn08mXXe/17m2hAIcWvTDZVzBIDsZdr/qaYwL+gta++uXpSWVAm4US2ST
 HXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743076459; x=1743681259;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XJte5VXga7buSEWutuMvX6HtBnCpM9rR8Pptams0fHk=;
 b=cBXz81C+Ipm8qLAARtUFshyUazMlbvWfBG/UI4TIowobd7yAj5z8oZ9vch+K43xlRA
 UbfKuqSZRS40//vFZ66dMhsiGOiQ5Uzl11Kz7xk7Ckr3+s2jeaRSME5uFH2LCsHXJbUh
 XyM3VLrWEL8yhjZuuslexkbCluZyMQUW9IF5ygoCYfwnswGLIqpKYxXcx2UmHbxhaqDG
 2KA2w+adGpDQIaEnp3/VpMmm3ggHTjFjLyWumFAFJLXEfG+6VApvxAH/Sg5B3d67+4Ce
 20gwAp0v+jTMp5oFb7LB5dLdxgXF9WW2A43y13mPUqJ5OoOiYt7wDzP+YRavjUlNRBjL
 1Yfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUaywwAAS/7N8pfkeuIx8lhEw4DsSiWPMOVcK6BsZF3vZLIXRF5R63N4XawrSimTV9f328=@lists.linux.it
X-Gm-Message-State: AOJu0Yy3b3xIJfT6wVLk+reDojpWQ05aSxP40Ovfi422gwSkRrF636bp
 ENgEzlSWvSeFvWEewurkvd0mb6pC28VACn02/2QnrMo43Ed9iy+QA8b/BWJR3dg=
X-Gm-Gg: ASbGncuv6RL7OnNlNJokl1j1MXbXt0SqD0SfRpMvAbJF6nxzOHedAN7/+xSelpl6lfA
 lqd450cQfj83yqMdpJWm8P+ZGRH4IejNz37Id34HVERSYAnWeKHLHH6iWG2bravqh1bW5PBdBZ+
 yx9VZjbybP4yu25jylaniw7xqdu9PGIxX+MfYXXBvfrxE9rpxEyFotGMtNFe7zKvY3+40bT5hIp
 Fj4AKjM7fCjURcDeZL2wHAC+1hEPhWpCahwX6UlJRFUQav1EPiBRENiu+wKLDeCoklqYNDkcP0a
 JDjlPK+g93taNAcjSkkjk9qZbDJ5FzLfzK1e0Q7Xa6IIlLS3iW33vSmn2xBNTsqKyhHBJVRb938
 q4AXN1JgsBMnBWnF3A9uFKg7elbSCPbvr2Z9j3qyQ3KMSW4TBpWV729j+QoAA1gGXamKSi6mm8V
 h1hyZET3WJcjUw5QfRSw==
X-Google-Smtp-Source: AGHT+IGKFKtPYKbVWSloD4fZ10ZSPgYD3uN+xNt0Tbm+fBIRDO94kccAcWTIQqv72AMqSXY0/kTHlw==
X-Received: by 2002:a5d:6488:0:b0:391:2e0f:efec with SMTP id
 ffacd0b85a97d-39ad173f9c3mr2275079f8f.7.1743076459140; 
 Thu, 27 Mar 2025 04:54:19 -0700 (PDT)
Received: from ?IPV6:2003:ef:2f1a:ea00:b220:7501:321e:5c31?
 (p200300ef2f1aea00b2207501321e5c31.dip0.t-ipconnect.de.
 [2003:ef:2f1a:ea00:b220:7501:321e:5c31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3997f9efc9bsm19414662f8f.87.2025.03.27.04.54.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Mar 2025 04:54:18 -0700 (PDT)
Message-ID: <63364871-aec9-4ebe-9123-0c1b4a3cea9f@suse.com>
Date: Thu, 27 Mar 2025 12:54:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
References: <20250324234016.367228-1-pvorel@suse.cz>
 <20250324234016.367228-4-pvorel@suse.cz>
 <D8R0YF9GVL4S.276WLTALPPSQ5@suse.com>
Content-Language: en-US
In-Reply-To: <D8R0YF9GVL4S.276WLTALPPSQ5@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] Makefile: Update 'doc' target,
 add 'doc-clean'
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp <ltp-bounces+ricardo=marliere.net@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgUmljYXJkbywKCk9uIDMvMjcvMjUgMTI6NTAsIFJpY2FyZG8gQi4gTWFybGnvv73vv71yZSB2
aWEgbHRwIHdyb3RlOgo+IE9uIE1vbiBNYXIgMjQsIDIwMjUgYXQgODo0MCBQTSAtMDMsIFBldHIg
Vm9yZWwgd3JvdGU6Cj4+ICdkb2MnIHRhcmdldCBwcmV2aW91c2x5IHJ1biBkb2NwYXJzZSBkb2N1
bWVudGF0aW9uLiBQb2ludCBpdCB0byBkb2MvCj4+IGRpcmVjdG9yeSBzbyB0aGF0IGl0IGJ1aWxk
IHNwaGlueCBkb2NzLiBkb2MvIGRpciBoYXMgbWV0YWRhdGEvIGRpciBhcwo+PiBkZXBlbmRlbmN5
LCBubyBuZWVkIHRvIHNwZWNpZnkgaXQuIENhbGwgYWxzbyAnLnZlbnYnIHRhcmdldC4KPj4KPj4g
Tk9URTogaXQncyBzdGlsbCBwb3NzaWJsZSB0byBhdm9pZCB2aXJ0dWFsZW52IGJ5IGNhbGxpbmcg
J21ha2UgLUMgZG9jJwo+ICBGcm9tIHRoZSByb290IGRpciA/Cj4KPiAkIG1ha2UgLUMgZG9jCj4g
bWFrZTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvbW50L2V4dC9zcmMvbGludXgvbHRwL21haWwvZG9j
Jwo+IG1ha2UgLUMgL21udC9leHQvc3JjL2xpbnV4L2x0cC9tYWlsL21ldGFkYXRhCj4gbWFrZVsx
XTogRW50ZXJpbmcgZGlyZWN0b3J5ICcvbW50L2V4dC9zcmMvbGludXgvbHRwL21haWwvbWV0YWRh
dGEnCj4gL21udC9leHQvc3JjL2xpbnV4L2x0cC9tYWlsL21ldGFkYXRhL3BhcnNlLnNoID4gbHRw
Lmpzb24KPiBtYWtlWzFdOiBMZWF2aW5nIGRpcmVjdG9yeSAnL21udC9leHQvc3JjL2xpbnV4L2x0
cC9tYWlsL21ldGFkYXRhJwo+IGlmIFsgLWQgLnZlbnYgXTsgdGhlbiAuIC52ZW52L2Jpbi9hY3Rp
dmF0ZTsgZmk7IHNwaGlueC1idWlsZCAtYiBodG1sIC4gaHRtbAo+IC9iaW4vc2g6IGxpbmUgMTog
c3BoaW54LWJ1aWxkOiBjb21tYW5kIG5vdCBmb3VuZAo+IG1ha2U6ICoqKiBbTWFrZWZpbGU6MjQ6
IGFsbF0gRXJyb3IgMTI3Cj4gbWFrZTogTGVhdmluZyBkaXJlY3RvcnkgJy9tbnQvZXh0L3NyYy9s
aW51eC9sdHAvbWFpbC9kb2MnClllYWgsIHNwaGlueCBzaG91bGQgYmUgaW5jbHVkZWQgaW4gdGhl
IHJlcXVpcmVtZW50cy50eHQsIG90aGVyd2lzZSBpdCdzIApub3QgcG9zc2libGUgdG8gYWNjZXNz
IHRvIGl0IHZpYSB2aXJ0dWFsZW52LgoKQW5kcmVhCgoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBo
dHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
