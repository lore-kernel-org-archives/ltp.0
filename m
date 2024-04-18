Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53442C4345F
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 05:33:09 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86BFB3CFBD0
	for <ltp@archiver.kernel.org>; Thu, 18 Apr 2024 07:33:07 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F35083CFBB7
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 07:32:43 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3027D1000C1B
 for <ltp@lists.linux.it>; Thu, 18 Apr 2024 07:32:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713418361;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FrHoyWC+47GduxXyulERZaN+W6U6P/kkz8X2PCNBIrI=;
 b=hAkoZJjri28t/SGvGNtYnkC9BPjq9sCi3uKNDXdTMwbV+SM+MdYIT8H4TjPMRNQ38FXmDL
 shVBFDWOTILvnSgTWamsVuTpLLg/fOqXbAYqVLzzwne6aNR2PRgW1deyWtskYYYJDROlwm
 1zSCU+ZyUyMXH1dgMq2b91Nv1zG1FPk=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-DiKSvv6FOgyB87liD9I5Gw-1; Thu, 18 Apr 2024 01:32:39 -0400
X-MC-Unique: DiKSvv6FOgyB87liD9I5Gw-1
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-2a2e6197371so681361a91.3
 for <ltp@lists.linux.it>; Wed, 17 Apr 2024 22:32:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713418358; x=1714023158;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FrHoyWC+47GduxXyulERZaN+W6U6P/kkz8X2PCNBIrI=;
 b=Z2FFiofI9HAzeuXOMoyO2jNILKI6jnmFXfGXwG+l1O2CW0saBTE1g6ClRSjNx8757K
 dcBSbcYfrM/ibWm39D7lYpyQntPvO1xs9HgcvFV9MMhVK87LgdIyPVAM45AfwZNCmqEX
 yC5juwD/whZcZazcTM40qmqH4CVKtU6MCI94ZO7Ux2zoevEZAVGbzuLSqlf2DzUkQd2H
 z8BJ1oZvDHUV9UfaBNxLDx1ZwLJRLBYGilhKLx+gebSQsbakS3+mCgxQYgccaRcLueUn
 XaKqEDO5Reh302oLT9bHPxw9QvSpvpwffyx5Zj3Y01iZuvdufXT/n+j7ROVMtvFcUSdJ
 YNLA==
X-Gm-Message-State: AOJu0YwZD7vfnBwvwAqNqn8USHkO9wf79DboS1wcoSFadboZv2qMKmr1
 S9DLgUSmCBBVZtBDVD6m+Yno+SFd5kNyfuknXkWO1t5CrORDz2K0HUpYBNZH808wwpzsPNCCcfx
 xxoDR3xLyW95USbLz7n2cxSpvqPMCva8aXjyYfY/gnCEERBu9hsSFIrK10c2k1sTMwkVZs3YZfL
 Z+YA1hwhEKh5Ol6FIcWawSWH6EdsTcKSMaXZXp
X-Received: by 2002:a17:90a:af93:b0:2ab:9c1d:f12a with SMTP id
 w19-20020a17090aaf9300b002ab9c1df12amr1626867pjq.20.1713418358056; 
 Wed, 17 Apr 2024 22:32:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF6AFYrnv+YfySpdBgHK3S4Bc90gXD4VGt+yL0pzPt4BuP5JeYiD+W5XZNY2G5icj+JSoHTrOCITzU1Q1v1Ras=
X-Received: by 2002:a17:90a:af93:b0:2ab:9c1d:f12a with SMTP id
 w19-20020a17090aaf9300b002ab9c1df12amr1626854pjq.20.1713418357708; Wed, 17
 Apr 2024 22:32:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240417123113.731780-1-pvorel@suse.cz>
 <20240417123113.731780-2-pvorel@suse.cz>
In-Reply-To: <20240417123113.731780-2-pvorel@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Thu, 18 Apr 2024 13:32:26 +0800
Message-ID: <CAEemH2dvLTfnG3u=-PCOS3O-8iChTr=jLL_Gg34Hrzw_88ffOw@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] libswap: Use tst_res_() instead of tst_res()
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

T24gV2VkLCBBcHIgMTcsIDIwMjQgYXQgODozMeKAr1BNIFBldHIgVm9yZWwgPHB2b3JlbEBzdXNl
LmN6PiB3cm90ZToKCj4gVGhhdCBhbGxvd3MgdG8gaWRlbnRpZnkgdGhlIGNhbGxlciBvZiB0aGUg
ZnVuY3Rpb24uIFRoYXQgaXMgdGhlIHJlYXNvbgo+IHdoeSB0c3RfYnJrXygpIHdhcyBhbHJlYWR5
IHVzZWQgaW5zdGVhZCBvZiB0c3RfYnJrKCkuCj4KPiBGaXhlczogZjk4N2ZmZmY1ICgibGlic3dh
cDogYWRkIHR3byBtZXRob2RzIHRvIGNyZWF0ZSBzd2FwZmlsZSIpCj4gU2lnbmVkLW9mZi1ieTog
UGV0ciBWb3JlbCA8cHZvcmVsQHN1c2UuY3o+Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdh
bmdAcmVkaGF0LmNvbT4KCi0tLQo+ICBsaWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jIHwgNiArKyst
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKPgo+
IGRpZmYgLS1naXQgYS9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5jIGIvbGlicy9saWJsdHBzd2Fw
L2xpYnN3YXAuYwo+IGluZGV4IGI0MjMzYmUwZC4uYWVkNzZkZmUyIDEwMDY0NAo+IC0tLSBhL2xp
YnMvbGlibHRwc3dhcC9saWJzd2FwLmMKPiArKysgYi9saWJzL2xpYmx0cHN3YXAvbGlic3dhcC5j
Cj4gQEAgLTE0OSwxOCArMTQ5LDE4IEBAIGludCBtYWtlX3N3YXBmaWxlKGNvbnN0IGNoYXIgKmZp
bGUsIGNvbnN0IGludCBsaW5lbm8sCj4gICAgICAgICBibGtfc2l6ZSA9IGZzX2luZm8uZl9ic2l6
ZTsKPgo+ICAgICAgICAgaWYgKG1ldGhvZCA9PSBTV0FQRklMRV9CWV9TSVpFKSB7Cj4gLSAgICAg
ICAgICAgICAgIHRzdF9yZXMoVElORk8sICJjcmVhdGUgYSBzd2FwZmlsZSBzaXplIG9mICV1IG1l
Z2FieXRlcwo+IChNQikiLCBudW0pOwo+ICsgICAgICAgICAgICAgICB0c3RfcmVzXyhmaWxlLCBs
aW5lbm8sIFRJTkZPLCAiY3JlYXRlIGEgc3dhcGZpbGUgc2l6ZSBvZgo+ICV1IG1lZ2FieXRlcyAo
TUIpIiwgbnVtKTsKPiAgICAgICAgICAgICAgICAgYmxvY2tzID0gbnVtICogMTAyNCAqIDEwMjQg
LyBibGtfc2l6ZTsKPiAgICAgICAgIH0gZWxzZSBpZiAobWV0aG9kID09IFNXQVBGSUxFX0JZX0JM
S1MpIHsKPiAgICAgICAgICAgICAgICAgYmxvY2tzID0gbnVtOwo+IC0gICAgICAgICAgICAgICB0
c3RfcmVzKFRJTkZPLCAiY3JlYXRlIGEgc3dhcGZpbGUgd2l0aCAldSBibG9jayBudW1iZXJzIiwK
PiBibG9ja3MpOwo+ICsgICAgICAgICAgICAgICB0c3RfcmVzXyhmaWxlLCBsaW5lbm8sIFRJTkZP
LCAiY3JlYXRlIGEgc3dhcGZpbGUgd2l0aCAldQo+IGJsb2NrIG51bWJlcnMiLCBibG9ja3MpOwo+
ICAgICAgICAgfSBlbHNlIHsKPiAgICAgICAgICAgICAgICAgdHN0X2Jya18oZmlsZSwgbGluZW5v
LCBUQlJPSywgIkludmFsaWQgbWV0aG9kLCBwbGVhc2Ugc2VlCj4gaW5jbHVkZS9saWJzd2FwLmgi
KTsKPiAgICAgICAgIH0KPgo+ICAgICAgICAgLyogVG8gZ3VhcmFudGVlIGF0IGxlYXN0IG9uZSBw
YWdlIGNhbiBiZSBzd2FwcGVkIG91dCAqLwo+ICAgICAgICAgaWYgKGJsa19zaXplICogYmxvY2tz
IDwgcGdfc2l6ZSkgewo+IC0gICAgICAgICAgICAgICB0c3RfcmVzKFRXQVJOLCAiU3dhcGZpbGUg
c2l6ZSBpcyBsZXNzIHRoYW4gdGhlIHN5c3RlbSBwYWdlCj4gc2l6ZS4gIgo+ICsgICAgICAgICAg
ICAgICB0c3RfcmVzXyhmaWxlLCBsaW5lbm8sIFRXQVJOLCAiU3dhcGZpbGUgc2l6ZSBpcyBsZXNz
IHRoYW4KPiB0aGUgc3lzdGVtIHBhZ2Ugc2l6ZS4gIgo+ICAgICAgICAgICAgICAgICAgICAgICAg
ICJVc2luZyBwYWdlIHNpemUgKCVsdSBieXRlcykgaW5zdGVhZCBvZiBibG9jayBzaXplCj4gKCVs
dSBieXRlcykuIiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAodW5zaWduZWQgbG9uZylwZ19z
aXplLCBibGtfc2l6ZSk7Cj4gICAgICAgICAgICAgICAgIGJsa19zaXplID0gcGdfc2l6ZTsKPiAt
LQo+IDIuNDMuMAo+Cj4KCi0tIApSZWdhcmRzLApMaSBXYW5nCgotLSAKTWFpbGluZyBsaXN0IGlu
Zm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
