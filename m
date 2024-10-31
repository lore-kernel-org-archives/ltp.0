Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA37E68948
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 02:34:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B213B3CBA07
	for <ltp@archiver.kernel.org>; Thu, 31 Oct 2024 03:34:19 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2E143CB8D0
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 03:34:03 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D23D663AA6B
 for <ltp@lists.linux.it>; Thu, 31 Oct 2024 03:34:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730342040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XqJW1sA2AU/GCHMiILXx9RQlm8g2lklKHnewKV4Vvbc=;
 b=Jo1SJpCYorG5W7WY1TJcyEOKIiTSVVouhKuBLO15Eryvtpe+i3vg6sNq30Hz0D0tzysaJV
 8KTTLBc9aZkbge/x7gCf35UztOvNflWcLmzrnWJiUTy5pCj2gGDUzITPsawfQdHp5lbHX5
 DKAYqF8bRkn0iMt839xrgBevra20Kso=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-28-PwdXjQeOOD6VyQ2Ht6Lpnw-1; Wed, 30 Oct 2024 22:33:57 -0400
X-MC-Unique: PwdXjQeOOD6VyQ2Ht6Lpnw-1
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-71e71425193so530880b3a.1
 for <ltp@lists.linux.it>; Wed, 30 Oct 2024 19:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730342036; x=1730946836;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=XqJW1sA2AU/GCHMiILXx9RQlm8g2lklKHnewKV4Vvbc=;
 b=mEf+QGHXLOF+OEXJySvcqd5CsurlpGqX7gCmQiHNG6F5JJC4tC3C/MzWyvSMJ2i5dt
 U4PWfyBfJfqvQpxBWk4m4eHG5LvGwsZTORHHsKAKxkrXLuvWgQb+FJlofkzg0D/abk+X
 +qKlalLDHTy2UG1ayqWYGiUAY3R0JSu1DDkuRf+WPSyrzoI127FZSjou/z4XjnRhru6y
 LgoY3+siIiMGKAgoc57h3TvjkLO+L3rAP+wHtHCbO6gOksTps4RaI1QWpT8wDqHUoIpc
 rRvndWpK1MYAlVKU57TW21swAyz006GLlEj6tVIsCJ7G5PM0wpJNxRVy7Wm2MoVqJs38
 LeVA==
X-Gm-Message-State: AOJu0YxhAvZdlOrW3npC7noauTHA3v9J32OrS6FjhFY/S8L9se62QeFi
 wYb3S3n9bhj9G94TjHgTq1J6o00E9QzozPeGR2QjEnJ5/2lqR52hKe1M44Tvdsi+u1pz7+hntZq
 cfHimWbyJpV+BgeP6fiU7hFAIf74UzJ45d54YQUHoxNyLG8lFccW5C4SAPBM/nK5YH5icE0Ko5Q
 9uqfykSgGDopFufL9yPI/Rh0U=
X-Received: by 2002:a05:6a20:8914:b0:1d9:c615:d1e6 with SMTP id
 adf61e73a8af0-1d9c6160e4amr13207319637.0.1730342035886; 
 Wed, 30 Oct 2024 19:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFVXFwHeAKwTJeEAfZ+LvZ/dP/bQm+CdNZixUp0RO4tbss9NF2ZVnoA3OBY0APxnfPfVQcF6qlOCqobW11EzIE=
X-Received: by 2002:a05:6a20:8914:b0:1d9:c615:d1e6 with SMTP id
 adf61e73a8af0-1d9c6160e4amr13207307637.0.1730342035585; Wed, 30 Oct 2024
 19:33:55 -0700 (PDT)
MIME-Version: 1.0
References: <20241030084558.195297-1-liwang@redhat.com>
 <ZyIjHUuNFviz47gx@yuki.lan> <ZyIjZGIpFlFqLm42@yuki.lan>
In-Reply-To: <ZyIjZGIpFlFqLm42@yuki.lan>
From: Li Wang <liwang@redhat.com>
Date: Thu, 31 Oct 2024 10:33:43 +0800
Message-ID: <CAEemH2fjg5wPPEfDMVej6DkEPgiweivhsoy4JHt0d2RghKxq8Q@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH] lib: Print failure hints only once to reduce log
 duplication
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

T24gV2VkLCBPY3QgMzAsIDIwMjQgYXQgODoxNeKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKCj4gSGkhCj4gPiA+IFRoZSBMVFAgdGVzdCBjdXJyZW50bHkgcHJpbnRz
IGZhaWx1cmUgaGludHMgbXVsdGlwbGUgdGltZXMgaWYgYSB0ZXN0Cj4gPiA+IGVuY291bnRlcnMg
c2V2ZXJhbCBURkFJTCBvciBUQlJPSyByZXN1bHRzLiBUaGlzIGxlYWRzIHRvIHVubmVjZXNzYXJp
bHkKPiA+ID4gdmVyYm9zZSBhbmQgZHVwbGljYXRlZCBsb2dzLgo+ID4gPgo+ID4gPiBUaGlzIHBh
dGNoIG1vZGlmaWVzIHRoZSBgcHJpbnRfZmFpbHVyZV9oaW50cygpYCBmdW5jdGlvbiB0byBlbnN1
cmUgdGhhdAo+ID4gPiBmYWlsdXJlIGhpbnRzIGFyZSBwcmludGVkIG9ubHkgb25jZSBwZXIgdGVz
dCBydW4uIEJ5IHNldHRpbmcKPiBgc2hvd19mYWlsdXJlX2hpbnRzYAo+ID4gPiB0byAwIGFmdGVy
IHRoZSBmaXJzdCBwcmludCwgc3Vic2VxdWVudCBjYWxscyB0byBgcHJpbnRfZmFpbHVyZV9oaW50
cygpYAo+ID4gPiB3aWxsIG5vdCBwcm9kdWNlIHJlZHVuZGFudCBvdXRwdXQuCj4gPgo+ID4gSG1t
LCB3ZSBkbyBjYWxsIHByaW50X2ZhaWx1cmVfaGludHMoKSBmcm9tIGRvX2V4aXQoKSB0aGF0IGNh
bGxzIGV4aXQoKQo+ID4gYXQgdGhlIGVuZCBvZiB0aGUgZnVuY3Rpb24uIFdlIHNob3VsZG4ndCBw
cmludCB0aGUgaGludHMgdHdpY2UsIHdoYXQgZG8KPiA+IEkgbWlzcz8KPgo+IEFoLCByaWdodCwg
d2UgaGF2ZSB0d28gaWYgKCkgY29uZGl0aW9ucyB0aGF0IGNhbGwgdGhlIGZ1bmN0aW9uIGluIHRo
ZXJlLAo+IHNvIHllcywgd2UgbWF5IHByaW50IGl0IHR3aWNlLgo+Cj4gUmV2aWV3ZWQtYnk6IEN5
cmlsIEhydWJpcyA8Y2hydWJpc0BzdXNlLmN6Pgo+CgpQdXNoZWQsIHRoYW5rIHlvdSBib3RoLgoK
LS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
