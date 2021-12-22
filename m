Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8A6C433EF
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 19:18:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 027FB3C9293
	for <ltp@archiver.kernel.org>; Wed, 22 Dec 2021 20:18:09 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E1D73C08F2
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:15:43 +0100 (CET)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com
 [IPv6:2607:f8b0:4864:20::1034])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 02CC46010A9
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 20:15:43 +0100 (CET)
Received: by mail-pj1-x1034.google.com with SMTP id
 n15-20020a17090a160f00b001a75089daa3so6759294pja.1
 for <ltp@lists.linux.it>; Wed, 22 Dec 2021 11:15:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:from:mime-version:date:subject:message-id
 :to; bh=+k+LTi04QmYCFhmjn6H9x4rxeuQWQNuCN3uMOR1vHhY=;
 b=nQGR3Jxll542UXZG8NGPfQS/PXbPio2Gzv7UfKEpuQAL0cN4SL7q1GLqqOq123tFDK
 KUrHhXMFgyyz+7aFIWZ+UaVnLzZ2y3paNSw+HWI2q6i/CBVGbDZZg8vcyhrJnHbJiyj6
 cUF+jZ8Rf8GMjMDwfrT/k4DD+DthvJrLm4E9EJTfX2kq2JuMFrcEeY4yQgx6NA9cGbEa
 xJ+qXFHd8HvV1z9oBjOjDjk+k5CdCI7jQe8SdoFuJs+5IyUeOZEefUbUEDCytQbbbXbb
 kJ7pZ1z50erYa11G0WbkFEzuG4F3C5UmbzgQg/mGDvWaaDlfCeTQC/39jTWXODX/It5d
 yFjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version:date
 :subject:message-id:to;
 bh=+k+LTi04QmYCFhmjn6H9x4rxeuQWQNuCN3uMOR1vHhY=;
 b=wdFJN4W9cX5N67HSw0aVvpzof5CJVR59wkWjCS68T6Uh0EvaXuosd43PU8YFO6IyxT
 XDOVfPlDUiuAtRwy99Mu4xUjXvNjX58sSKN6oFh8mlTgRAXREq7RMK3D4haHvmnn4X4z
 LBHemueZk9/2Lwk9lcbekbJqMMNY70dM2J1wQfnx863QeoNvuZqAETyEUBCcw1EeQXYP
 IcAXnapkERbliFMWxj6yevogyw2MjmGKaerd8x8tx/44cwTtim576aW+QLBWWBuUuFuo
 T7PIMSx1NjLv1aWcRkfdRraEQhbUy+riXZioVSWLxBFWxymebs1luUaEAwn38iglskBI
 +8ZQ==
X-Gm-Message-State: AOAM5336ibwCt71XPLPuxjvQYFpmxYQBBZMXlQgtnJjtnvBu27RReJet
 JXExCfBq7bvuW8m3ob3KsfRxXFp3HF8=
X-Google-Smtp-Source: ABdhPJy/ziuLkpGciLca58kxIMok7hBoQ70eFRsNDhHu5XBhSDRvXDgxHSs7KUK1KFEgZqMdR8/9vg==
X-Received: by 2002:a17:902:b189:b0:143:8079:3d3b with SMTP id
 s9-20020a170902b18900b0014380793d3bmr3928772plr.71.1640200541259; 
 Wed, 22 Dec 2021 11:15:41 -0800 (PST)
Received: from smtpclient.apple (c-76-115-88-232.hsd1.or.comcast.net.
 [76.115.88.232])
 by smtp.gmail.com with ESMTPSA id u71sm2789775pgd.68.2021.12.22.11.15.40
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Dec 2021 11:15:41 -0800 (PST)
From: Brent Yardley <brent.yardley@gmail.com>
Mime-Version: 1.0 (1.0)
Date: Wed, 22 Dec 2021 11:15:40 -0800
Message-Id: <DFDF839E-90B4-4020-B78D-88FC174B6B6D@gmail.com>
To: ltp@lists.linux.it
X-Mailer: iPhone Mail (19B74)
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Wed, 22 Dec 2021 20:18:00 +0100
Subject: [LTP] Disktest Removed from LTP?
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGVsbG8sCgpJIHdhcyBqdXN0IHRvbGQgdGhhdCBkaXNrdGVzdCwgdGhlIHRvb2wgdGhhdCBJIHdy
b3RlIGZvciB0ZXN0aW5nIGRpc2sgc3Vic3lzdGVtcywgaGFzIGJlZW4gcmVtb3ZlZCBmcm9tIHRo
ZSBMVFAuIEkgd2FzIG5vdCBhc2tlZCBhYm91dCB0aGlzIGFuZCB3YXMgc3VycHJpc2VkIHRvIHNl
ZSB0aGF0IGl0IGlzIGNvbnNpZGVyZWQgbm90IG1haW50YWluZWQuIEkga25vdyB0aGF0IEnigJl2
ZSBub3QgYWRkZWQgYW55dGhpbmcgbmV3IHRvIGl0IGZvciBtYW55IHllYXIsIGJ1dCBJIGtub3cg
dGhhdCBpdCBpcyB1c2VkIGFzIEkgZ2V0IHF1ZXN0aW9ucyBhYm91dCBpdCBmcm9tIHRpbWUgdG8g
dGltZS4KCkNhbiBJIGFzayBzb21lb25lIGFib3V0IHRoaXMgb3IgY2FuIEkgYmUgZGlyZWN0ZWQg
dG8gc29tZW9uZSB0byBiZXR0ZXIgdW5kZXJzdGFuZCB3aHkgaXQgaXMgY29uc2lkZXJlZCBub3Qg
dXNlZD8KClRoYW5rcywKLSBCcmVudAoKVGhhbmtzLAotIEJyZW50CgotLSAKTWFpbGluZyBsaXN0
IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
