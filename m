Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 364E2C28B28
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 09:20:14 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 969003CA344
	for <ltp@archiver.kernel.org>; Wed, 12 Mar 2025 10:20:12 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 446873CA344
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 10:19:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 55EFC600636
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 10:19:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741771191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=x1pmFz7UcO2vkM2oTkui8Ox2J8IOv/ojETGlWaYOHUk=;
 b=KRQVd9xTh1u8/5iSEOX3Z6B3h7y4b72UyTiWHwbiPvd+7EtO8dlrq2Eey/+22mSautBNNP
 G/nfZ0ApRduowatr9Oh2M7Hw3ZDU8E5hCrbFSeWgZ0X8gIAQB8+JhWr+CChtqY+1rAIVjM
 kxB0PeVlV3UAgXDduY3beQyY3Y650To=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-54-I4hAYj9ROLKGKm81E5Wl6A-1; Wed, 12 Mar 2025 05:19:50 -0400
X-MC-Unique: I4hAYj9ROLKGKm81E5Wl6A-1
X-Mimecast-MFC-AGG-ID: I4hAYj9ROLKGKm81E5Wl6A_1741771189
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2ff55176edcso11126332a91.1
 for <ltp@lists.linux.it>; Wed, 12 Mar 2025 02:19:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741771189; x=1742375989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=x1pmFz7UcO2vkM2oTkui8Ox2J8IOv/ojETGlWaYOHUk=;
 b=HvMG6JD9k4z758YLCjsFyID5B2B0cDo1eUh1b4NstAuhTnc7CyXwJPlbZkkgx55+b8
 hrMZCr8coWv4g3YT9ize226SmSJbk4G4bJkYnnW9Q3SACYO/ss9kHra7l+KkWQaZfufT
 96GQJ1Z58BQCIvQofqKeCyf0Fq88ZQkw6I4B9gBqjgK3L7hL9KvBTixdaPWWhXpWtP3C
 VQh/u4rdxoP5oe3CmkrpWcn1UzEUDl+m30sciUuHQatgElt9tXUTbDBUmvcDjNB+xAKS
 EYjCqlxWbOs/w1aZDSy6L/yhYasg7X/CXP8GSpLvgbeM8tFB3WNpEh89gHuvFGX+SJkf
 2btg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrmI7JlAXC5SYBpxe4H1u397j6oRALMe4NX1G0wBWj5sLrfa1XpfPlXb/Auc2EuRT1SYY=@lists.linux.it
X-Gm-Message-State: AOJu0Yw09XuRQ3NVAf5MkFKJRReinMHxc3NO6eUuSfWfPQ8l3SwnbFPg
 HKuIm+JB1S6nArVo8FoEwmHNyM+jEQkAnTzyGtpWUv2Ac0aCACsbkgT59s+eXNmZGKV2FooaANn
 bcPZm1Zq1mBIE3wRsZ5rxRTJaFGssKxuNbuqFXG/TD95NJxhhSgWODIJ3tp7n7zY+I758HuvaDd
 iWn1LPAUoc/cfU3DLKPGzY79g=
X-Gm-Gg: ASbGncts5XeZ+yQInQ4OU8VnFqLAn28kDlDLmWTBAcm2tzGTKow6jQN8m23PmLea7YP
 on5sgyCqE971MG6sewP3hMrVOnOPkLNVuibhhuakOFbjoQ7YZkgKG7RMVQSfRFAZVATxVp6xlLw
 ==
X-Received: by 2002:a17:90b:3812:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2ff7ce7277cmr28569346a91.6.1741771188849; 
 Wed, 12 Mar 2025 02:19:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvwwO8vc5OK/IrTFDtyGcU7iyI8GzFDcAxfSsLIwdaaOLQGsbBVGg+UfF7VSo91hm5D+rIiOMVzJf43DXxsxw=
X-Received: by 2002:a17:90b:3812:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-2ff7ce7277cmr28569315a91.6.1741771188425; Wed, 12 Mar 2025
 02:19:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250312050028.1784117-1-mcgrof@kernel.org>
 <20250312052155.GA11864@lst.de>
 <Z9Edl05uSrNfgasu@bombadil.infradead.org> <20250312054053.GA12234@lst.de>
 <Z9EfKXH6w8C0arzb@bombadil.infradead.org>
In-Reply-To: <Z9EfKXH6w8C0arzb@bombadil.infradead.org>
From: Li Wang <liwang@redhat.com>
Date: Wed, 12 Mar 2025 17:19:36 +0800
X-Gm-Features: AQ5f1JqgCkVKFRfIsciqkbFNuMVMGA8Cn4nEpqAWaKPOoSBJWMyPV48bUiUaPuw
Message-ID: <CAEemH2du_ULgnX19YnCiAJnCNzAURW0R17Tgxpdy9tg-XzisHQ@mail.gmail.com>
To: Luis Chamberlain <mcgrof@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: nOxQWM0_WmoDG2SjCH7IYpjCuPM1a97TCcZbyOp-c2w_1741771189
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] block: add BLK_FEAT_LBS to check for PAGE_SIZE
 limit
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
Cc: p.raghav@samsung.com, ritesh.list@gmail.com, brauner@kernel.org,
 lkp@intel.com, john.g.garry@oracle.com, da.gomez@samsung.com,
 djwong@kernel.org, david@fromorbit.com, oe-lkp@lists.linux.dev,
 willy@infradead.org, linux-block@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, oliver.sang@intel.com, hare@suse.de,
 gost.dev@samsung.com, kbusch@kernel.org, kernel@pankajraghav.com,
 Christoph Hellwig <hch@lst.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBNYXIgMTIsIDIwMjUgYXQgMTo0NOKAr1BNIEx1aXMgQ2hhbWJlcmxhaW4gPG1jZ3Jv
ZkBrZXJuZWwub3JnPiB3cm90ZToKCj4gT24gV2VkLCBNYXIgMTIsIDIwMjUgYXQgMDY6NDA6NTNB
TSArMDEwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6Cj4gPiBPbiBUdWUsIE1hciAxMSwgMjAy
NSBhdCAxMDozNzoyN1BNIC0wNzAwLCBMdWlzIENoYW1iZXJsYWluIHdyb3RlOgo+ID4gPiA+IElm
IHlvdSBuZWVkIGV4dHJhIHBlci1kcml2ZXIgdmFsaWRhdGF0aW9uLCBkbyBpdCBpbiB0aGUgZHJp
dmVyLgo+ID4gPgo+ID4gPiBBcmUgeW91IHN1Z2dlc3Rpbmcgd2UganVzdCBtb3ZlIGJhY2sgdGhl
IFBBR0VfU0laRSBjaGVjaywKPiA+Cj4gPiBQQUdFX1NJWkUgbm93IGlzIGEgY29uc3VtZXIgKGku
ZS4gZmlsZSBzeXN0ZW0pIGxpbWl0YXRpb24uICBIYXZpbmcKPiA+IGEgZmxhZyBpbiB0aGUgcHJv
dmlkZXIgKGRyaXZlcikgZG9lcyBub3QgbWFrZSBzZW5zZS4KPiA+Cj4gPiA+IG9yIHRvIGtlZXAK
PiA+ID4gdGhlIGNoZWNrcyBmb3IgdGhlIGJsb2NrIGRyaXZlciBsaW1pdHMgaW50byBlYWNoIGRy
aXZlcj8KPiA+Cj4gPiBNb3N0IGRyaXZlcnMgcHJvYmFibHkgZG9uJ3QgaGF2ZSBhIGxpbWl0IG90
aGVyIHRoYW4gdGhhbiB0aGF0IGltcGxpY2l0Cj4gPiBieSB0aGUgZmllbGQgd2lkdGggdXNlZCBm
b3IgcmVwb3J0aW5nLiAgU28gaW4gZ2VuZXJhbCB0aGUgZHJpdmVyIHNob3VsZAo+ID4gbm90IG5l
ZWQgYW55IGNoZWNrcy4gIFRoZSBvbmx5IGV4Y2VwdGlvbnMgbWlnaHQgYmUgZm9yIHZpcnR1YWwg
ZHJpdmVycwo+ID4gd2hlcmUgdGhlIHZhbHVlIGNvbWVzIGZyb20gdXNlcnNwYWNlLCBidXQgZXZl
biB0aGVuIGl0IGlzIGEgYml0IGRvdWJ0ZnVsLgo+Cj4gQWxyaWdodHksIHNvIHNpbGx5IHRlc3Rz
IGp1c3QgbmVlZCB0byBiZSB1cGRhdGVkLiBJZiBhIGhhbmcgaXMgcmVwb3J0ZWQsCj4gd2UgY2Fu
IGxvb2sgaW50byBpdCwgb3IganVzdCBhZGQgYmxvY2sgZHJpdmVyIGNoZWNrcyAvIGxpbWl0YXRp
b25zLgo+CgpXZWxsLCBkb2VzIHRoYXQgcGF0Y2ggZm9yIGlvY3RsX2xvb3AwNiBzdGlsbCBtYWtl
IHNlbnNlPwpPciBhbnkgb3RoZXIgd29ya2Fyb3VuZD8KaHR0cHM6Ly9saXN0cy5saW51eC5pdC9w
aXBlcm1haWwvbHRwLzIwMjUtTWFyY2gvMDQyNTk5Lmh0bWwKCi0tIApSZWdhcmRzLApMaSBXYW5n
CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8v
bHRwCg==
