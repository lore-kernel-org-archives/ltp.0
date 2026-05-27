Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45594CD5BD0
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 13:04:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AE8D73CB6D1
	for <ltp@archiver.kernel.org>; Wed, 27 May 2026 15:04:49 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E545A3C036C
 for <ltp@lists.linux.it>; Wed, 27 May 2026 15:04:29 +0200 (CEST)
Received: from mail-oa1-x42.google.com (mail-oa1-x42.google.com
 [IPv6:2001:4860:4864:20::42])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 71352600A09
 for <ltp@lists.linux.it>; Wed, 27 May 2026 15:04:29 +0200 (CEST)
Received: by mail-oa1-x42.google.com with SMTP id
 586e51a60fabf-43b4bf2e691so4542006fac.3
 for <ltp@lists.linux.it>; Wed, 27 May 2026 06:04:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779887068; x=1780491868; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LXOjbzu7At6Np7qZ61hua9HNyuhcQmhWfIH6rSqWHms=;
 b=Efq3FSFJ+LqAPdQ6Nt9h0c6FTNx315urTT0Ozqx+d94e+BW2YmlPvGcjb8fvjATYWZ
 QD1O05hZMYin0j41OYH9uGBwja1C1kWJaY4eTnfcUThYNbGIDMKGS8O4GUdJ+EMg6Faq
 iQJB1ROK2tenZNxGsHv2VYXea4ZOqbNi53AYxWOUlSRgK9VhXPENjtlMlaaWfvF0Wh4d
 MCX5H4EPOb8ED2y0ueh5psI1Tyrqu3fSvn+obWCvSLN8j0n+1mFSinW3ZGhzLUFiVMgL
 AnA+9pSP+2hUY/ljEBP2DTeI10h0HSg1Jaf3YAJyApPLYfOPO0GvBLe3Sq8GRoPalbuo
 2a1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779887068; x=1780491868;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LXOjbzu7At6Np7qZ61hua9HNyuhcQmhWfIH6rSqWHms=;
 b=DkSezzIa4Tqtxhvq0m9bzZ+v16t9eVwvrQ0Ab2t+WGFCgL7bayJEeLIgU+Ja2Vq2/K
 DL4FOXbp7Nj8r7z14gQeVmEgOGrXcSf6kQTen+3mubkXPjC2iPePJL1XS7rfXm14iXP5
 3/ep6FQRRHtmocDsIl6J0o6zSyjXfN51veXCvo/v9XarG3i6zL5XGym5c85cwGceqOji
 /HmmEl/38zKpaNMhIn5Y50Xus+awAMDlZWdnHRId7NyJlE3gNUcnUAgeMAq3bred4pQl
 KKINFsNc6c85H0zzj5mG87XHju/r5ISevCyPzzSecrgJtm937oX5FgBMi9tUf/7qaIUw
 GoTg==
X-Gm-Message-State: AOJu0YxhyCse8BQzflDCo0IGm0nbRRw/AnUU1TDYFQNOI8Y9gKVcCx1C
 75mugqKQsxyJX32DZ98IOfGpE2zEs+TVdXiZN6DnVjbm7dS7LZ8oVA+g
X-Gm-Gg: Acq92OGO22LlPz2I5DHtk+0GXT8N2ix6L/NhN3tHHz6t+R9KwkHRGugE/cytVw27RHR
 iVwV+H3CqrvCLLnFtS6jevL4i/3DHu1CAvh7mlsIkEJ/l2j1sW/PI8dJaiKSS1HAoR3CUhDHW1r
 Mpy4VcJsqdUAIB7lhyecMBsfH12yQ+Nw9f4XUGP8YpmnpxGqtecSkJYGBSY+QOZKK+gaqGx8FGo
 X9SZpb8KTMFz6v807XVlRWxWzdFIzGWOw+SreoGXBGk+f09SemgwP7SfLoBTCL+hbToBUpp1oGj
 rAhb/M3xNSHZuSzikz9SZk53tUr1HtsDJsF5vV5CH+zvqqcDilcuiBq0Uv9Bbyj45So5e+PTP+I
 k7Dr0LEZd9oOxQAWtG2aY/9NFpVMX4DHluLKpwcag021WjAQucBk2bMC5hwrHc37RhZFTr2E2eC
 1ql+tgmniWO6dqusNLQELvu0Q8Pqd0zBF39+1ZpsjleLbijEFDZL2c+IYLUqlSWfalP8kwyqky1
 CNo46h1NCOk8OQOw4v7iN6Z6IWkr5xydFfyS5M=
X-Received: by 2002:a05:6871:7a7:b0:3d9:2fe2:f5c8 with SMTP id
 586e51a60fabf-43b5b060604mr13295742fac.32.1779887067795; 
 Wed, 27 May 2026 06:04:27 -0700 (PDT)
Received: from
 runnervmg397c.evz1atmcliiexf3fmmiqzozgad.ex.internal.cloudapp.net
 ([64.236.201.54]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-914f87cd9fcsm464618785a.25.2026.05.27.06.04.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 06:04:27 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Martin Doucha <mdoucha@suse.cz>
Date: Wed, 27 May 2026 13:04:26 +0000
Message-ID: <20260527130426.4026-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260527114708.16896-1-mdoucha@suse.cz>
References: <20260527114708.16896-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] lapi/xfrm.h: Include system XFRM header and force kernel
 IPv6 definition
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

SGkgTWFydGluLAoKT24gV2VkLCAyNyBNYXkgMjAyNiwgTWFydGluIERvdWNoYSB3cm90ZToKPiBb
UEFUQ0ggMS82XSBsYXBpL3hmcm0uaDogSW5jbHVkZSBzeXN0ZW0gWEZSTSBoZWFkZXIgYW5kIGZv
cmNlIGtlcm5lbCBJUHY2IGRlZmluaXRpb24KClRoZSBjb21taXQgc3ViamVjdCBhbmQgdGhlIGlu
LWNvZGUgY29tbWVudCBjb250cmFkaWN0IHdoYXQgdGhlIGNvZGUgYWN0dWFsbHkKZG9lcy4gI2Rl
ZmluZSBfVUFQSV9JUFY2X0ggc2F0aXNmaWVzIHRoZSBpbmNsdWRlIGd1YXJkIG9mIGxpbnV4L2lw
djYuaCwKcHJldmVudGluZyB0aGF0IGhlYWRlciBmcm9tIGJlaW5nIHB1bGxlZCBpbiDigJQgaXQg
ZG9lcyBub3QgImZvcmNlIiBrZXJuZWwgSVB2NgpkZWZpbml0aW9ucy4gQm90aCB0aGUgc3ViamVj
dCBhbmQgY29tbWVudCBzaG91bGQgYmUgY29ycmVjdGVkLgoKPiArLyogRm9yY2UgdXNlIG9mIGtl
cm5lbCBJUHY2IGRlZmluaXRpb25zIHRvIGF2b2lkIHJlZGVmaW5pdGlvbiBlcnJvcnMgKi8KPiAr
I2RlZmluZSBfVUFQSV9JUFY2X0gKPiArI2luY2x1ZGUgPGxpbnV4L3hmcm0uaD4KCkFsc28gbmVl
ZHMgYSBjb21taXQgYm9keSBleHBsYWluaW5nIHdoYXQgc3BlY2lmaWMgcmVkZWZpbml0aW9uIGVy
cm9yIHRoaXMKZml4ZXMuIGxpbnV4L2lwdjYuaCBjb250YWlucyBzdHJ1Y3QgaXB2NmhkciBhbmQg
ZnJpZW5kczsgdGhlIHN0cnVjdCBpbjZfYWRkcgpyZWRlZmluaXRpb24gdGhhdCB0eXBpY2FsbHkg
Yml0ZXMgd2hlbiBtaXhpbmcgdXNlcnNwYWNlIGFuZCBrZXJuZWwgSVB2NiBoZWFkZXJzCmNvbWVz
IGZyb20gbGludXgvaW42LmggKGluY2x1ZGUgZ3VhcmQ6IF9VQVBJX0xJTlVYX0lONl9IKS4gUGxl
YXNlIGNvbmZpcm0KdGhhdCBibG9ja2luZyBsaW51eC9pcHY2LmggaXMgc3VmZmljaWVudCBhbmQg
dGhhdCB0aGUgcmVhbCBjb25mbGljdCBpcyBub3QKY29taW5nIGZyb20gbGludXgvaW42LmgsIGFu
ZCBkb2N1bWVudCB0aGUgcmVhc29uaW5nIGluIHRoZSBjb21taXQgbWVzc2FnZS4KClsuLi5dCgot
LS0gW1BBVENIIDUvNl0geGZybTAyOiBDb25maWd1cmUgeGZybSB1c2luZyBkaXJlY3QgbmV0bGlu
ayByZXF1ZXN0IC0tLQoKPiAtCXJldCA9IHRzdF9jbWQoeGZybV9jbWQsIE5VTEwsIE5VTEwsIFRT
VF9DTURfUEFTU19SRVRWQUwpOwo+IC0JaWYgKHJldCkKPiAtCQl0c3RfYnJrKFRCUk9LLCAiRmFp
bGVkIHRvIGluc3RhbGwgeGZybSBFU1AtaW4tVENQIHN0YXRlIik7Cj4gKwljdHggPSBORVRMSU5L
X0NSRUFURV9DT05URVhUKE5FVExJTktfWEZSTSk7CgpUaGUgcGF0Y2ggY29ycmVjdGx5IHJlbW92
ZXMgLm5lZWRzX2NtZHMgZnJvbSB4ZnJtMDEgYWZ0ZXIgZHJvcHBpbmcgdGhlIGlwKDgpCmNhbGws
IGJ1dCB0aGUgZXF1aXZhbGVudCByZW1vdmFsIGlzIG1pc3NpbmcgZnJvbSB4ZnJtMDI6CgoJLm5l
ZWRzX2NtZHMgPSAoc3RydWN0IHRzdF9jbWRbXSkgewoJCXsuY21kID0gImlwIn0sCgkJe30KCX0s
CgppcCg4KSBpcyBubyBsb25nZXIgaW52b2tlZDsgZHJvcCAubmVlZHNfY21kcyBoZXJlIHRvby4K
Ck5vIGxpbnV4LWdpdCB0YWcgZm9yIENWRS0yMDI2LTQ2MzAwLiBJZiBhIGtlcm5lbCBmaXggY29t
bWl0IGV4aXN0cywgYWRkIG9uZS4KCi0tLSBbUEFUQ0ggNi82XSB4ZnJtMDM6IENvbmZpZ3VyZSB4
ZnJtIHVzaW5nIGRpcmVjdCBuZXRsaW5rIHJlcXVlc3QgLS0tCgpTYW1lIHN0YWxlIC5uZWVkc19j
bWRzIGFzIHBhdGNoIDUvNiDigJQgeGZybTAzIHN0aWxsIHJlcXVpcmVzIGlwKDgpIGluIHRoZQp0
ZXN0IGRlc2NyaXB0b3IgZXZlbiB0aG91Z2ggaXQgaXMgbm8gbG9uZ2VyIGNhbGxlZC4KCi0tLQpO
b3RlOgoKVGhlIGFnZW50IGNhbiBzb21ldGltZXMgcHJvZHVjZSBmYWxzZSBwb3NpdGl2ZXMgYWx0
aG91Z2ggb2Z0ZW4gaXRzCmZpbmRpbmdzIGFyZSBnZW51aW5lLiBJZiB5b3UgZmluZCBpc3N1ZXMg
d2l0aCB0aGUgcmV2aWV3LCBwbGVhc2UKY29tbWVudCB0aGlzIGVtYWlsIG9yIGlnbm9yZSB0aGUg
c3VnZ2VzdGlvbnMuCgpSZWdhcmRzLApMVFAgQUkgUmV2aWV3ZXIKCi0tIApNYWlsaW5nIGxpc3Qg
aW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
