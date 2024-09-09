Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C74ECE57B
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 09:04:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E509C3C1015
	for <ltp@archiver.kernel.org>; Mon,  9 Sep 2024 11:04:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A77D83C05DE
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 11:04:00 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E6F191A00153
 for <ltp@lists.linux.it>; Mon,  9 Sep 2024 11:03:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725872638;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qD2J3iAQQcajQhkqdZUtOjUcOM+ZoBx4kOnCRxpQX6k=;
 b=eMOz0TvMOwIcqzOK0YRNxe5qWayrPd6PU6xPN3mOYyF1l+gKPw2EyGyOqzH8qbca9HBWS1
 tDlJ/1AcbY9+KwleZmVxLYiubjWoq52SK543DO4KcwFTlvZFfzGiYMaIRH7m270I9MoZAQ
 1eQiXEdkFZLKDAkI0FkYb5TRA4Bb2j8=
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com
 [209.85.210.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-wMgbx3yXNoy4VWlc22FmQw-1; Mon, 09 Sep 2024 05:03:56 -0400
X-MC-Unique: wMgbx3yXNoy4VWlc22FmQw-1
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-70cb2cd0cf4so3944430a34.3
 for <ltp@lists.linux.it>; Mon, 09 Sep 2024 02:03:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725872636; x=1726477436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qD2J3iAQQcajQhkqdZUtOjUcOM+ZoBx4kOnCRxpQX6k=;
 b=dENfi4bGbKnqQ6Lspp325Mxmk4AvO2vsNIhs3fH7bESQ/1g1OgytDLPlnBZJrasYjP
 HQ5pOELRYu6kh6rDmYFk3kRYTMFqn86yeA+s1RuYJARgHzLYHQalmGwaQBP2AlY065Dr
 rmX1r1dr7Iyty51Lfm79+RUHawv84FOc7gI9rtNX01IroVqT45RXHSbHsT/fm2OLVFx1
 pMkHIaiXaAsCQcUqhUSLRCuGO8g//bC1GNiV66FxQOu04RnxRdKYF/cWQwqyET0HhB3K
 KYYCgVEetILvJtbNPakp5YoQGidw6atccHX4jcUlQwoc3irmwjqCW5d2JwnW4sTNRIjK
 Rekg==
X-Gm-Message-State: AOJu0Yy1V1+bEyoBcU/XgOt6P9WFpiaqcSfTWUpUlOw1DF6uK8ywXD/K
 hwv8jboq+W/kH+4GiaQGmoAGe7XQOZj4FoGq+PyWMBdw4AfQCChnrOCHc5py+1MBTk4PIloO2AJ
 4ci8TA2F7D+CQST0vziV1TFr9xNtT5KP/T0pDKpf8j0GJQ7iLSLC5g5RL1eha0Zpi4LVi3eOJ4Z
 HuXGCSbMu+c6L1Q5fbECm74gA=
X-Received: by 2002:a05:6870:14d2:b0:261:648:ddc5 with SMTP id
 586e51a60fabf-27b82ed497bmr12792290fac.22.1725872636080; 
 Mon, 09 Sep 2024 02:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqAFW+S1IFU0ybf5kRcS2ZlZssV4RTl5WFRn135sbILAkLkDy+BKnmHzseE6PRJeHAYup977/M8wG3A9jxQpU=
X-Received: by 2002:a05:6870:14d2:b0:261:648:ddc5 with SMTP id
 586e51a60fabf-27b82ed497bmr12792268fac.22.1725872635691; Mon, 09 Sep 2024
 02:03:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240827120237.25805-1-chrubis@suse.cz>
 <20240827120237.25805-5-chrubis@suse.cz>
In-Reply-To: <20240827120237.25805-5-chrubis@suse.cz>
From: Li Wang <liwang@redhat.com>
Date: Mon, 9 Sep 2024 17:03:43 +0800
Message-ID: <CAEemH2fwPMSYO=5S9_C8uAApMMFba2sR8MbTGdx2Ei5QX4Otnw@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v3 4/4] testcaes/lib: Add shell loader
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

T24gVHVlLCBBdWcgMjcsIDIwMjQgYXQgODowNeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gVGhpcyBjb21taXQgaW1wbGVtZW50cyBhIHNoZWxsIGxvYWRlciBz
byB0aGF0IHdlIGRvbid0IGhhdmUgdG8gd3JpdGUgYSBDCj4gbG9hZGVyIGZvciBlYWNoIExUUCBz
aGVsbCB0ZXN0LiBUaGUgaWRlYSBpcyBzaW1wbGUsIHRoZSBsb2FkZXIgcGFyc2VzCj4gdGhlIHNo
ZWxsIHRlc3QgYW5kIHByZXBhcmVzIHRoZSB0c3RfdGVzdCBzdHJ1Y3R1cmUgYWNjb3JkaW5nbHks
IHRoZW4KPiBydW5zIHRoZSBhY3R1YWwgc2hlbGwgdGVzdC4KPgo+IFRoZSBmb3JtYXQgZm9yIHRo
ZSBtZXRhZGF0YSBpbiB0aGUgc2hlbGwgdGVzdCB3YXMgY2hvb3NlbiB0byBiZSBKU09OCj4gYmVj
YXVzZToKPgo+IC0gSSBkaWRuJ3Qgd2FudCB0byBpbnZlbnQgYW4gYWRob2MgZm9ybWF0IGFuZCBK
U09OIGlzIHBlcmZlY3QgZm9yCj4gICBzZXJpYWxpemluZyBkYXRhIHN0cnVjdHVyZXMKPiAtIFRo
ZSBtZXRhZGF0YSBwYXJzZXIgZm9yIHNoZWxsIHRlc3Qgd2lsbCBiZSB0cml2aWFsLCBpdCB3aWxs
IGp1c3QgcGljawo+ICAgdGhlIEpTT04gZnJvbSB0aGUgY29tbWVudCwgbm8gcGFyc2luZyB3aWxs
IGJlIHJlcXVpcmVkCj4KPiBTaWduZWQtb2ZmLWJ5OiBDeXJpbCBIcnViaXMgPGNocnViaXNAc3Vz
ZS5jej4KPiBSZXZpZXdlZC1ieTogUmljaGFyZCBQYWxldGhvcnBlIDxpb0ByaWNoaWVqcC5jb20+
Cj4KClJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KCgotLSAKUmVnYXJk
cywKTGkgV2FuZwoKLS0gCk1haWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0
L2xpc3RpbmZvL2x0cAo=
