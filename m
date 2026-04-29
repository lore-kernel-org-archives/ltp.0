Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F984FF8875
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 10:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777456978; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=w0bEoYceBi9pf+xIx732eFLU9bY9agaW8LFRCbadlnQ=;
 b=oYQ5sn/NLK9DY9UQij57lLN9MsFy9yRYZqiaxx6ADfS7w4aSXoovfDuVkGhbKBLUIhYei
 vGecTDel2sQjuxiLGvA7FWLWRGPjfJ0loksgm2HTUXBIIe7uw1k5w2MwfjW0oLa+XOziYBz
 qI5y0nktE0Ls3EeIF4SHAZg0+0d9Ils=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C12C63E1A9F
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 12:02:58 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 104B53C2022
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:02:35 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 69AF6600A0F
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 12:02:35 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4890098abbaso97494655e9.0
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 03:02:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777456955; x=1778061755; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=FHNQBg2SU0SfUiZjQYeSC+RINiguA2i3U+DIMBH2da0=;
 b=DYyDeVj2wWNtEblpE0+GD9A7f8/0iCjmew/WVf2brrf0Up2Ov0gfQ8UGGTfsPkZB0r
 L/LchzTTVRTmxgpnifM/v127zOCiwsAurUyDgPUabbiY6YghadiivmSZ50Ee+bgCa3IG
 SwWZfIowg5zixFm6HG9X7plS95WRit9OjfQulyEA6Hb5lm/oYZ/hnKCyvu6YPM/iEKYM
 IIGrHiOLEWHusP+Ev69Zs8JZ5eCypz5poiIKBzjSWhh5Opu2XXbvYi8N+u/6Py7AKPZZ
 RHy6zSQJyMiOkbahrAxJNG9ukh/0Enwigh9ad5lObDzSlIta3zsasriZcEYffIFXeNcq
 9mOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777456955; x=1778061755;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FHNQBg2SU0SfUiZjQYeSC+RINiguA2i3U+DIMBH2da0=;
 b=DYtD5I9eppZr/KnjXSg/BIk/oKR56fDTtdIBUns3G+mN9wSAd/YQIpeNeSr3WxqPtp
 Fs61xJXbtmJH8bfa0lej4V+i9ZQFyuoV1037q3BkN806nSCI+/v3bWsHwTtX+QCtJAzE
 Hs+tStySLhNRoaNXqHVqjaVTuXC7OmPDAUIh7e18mr1SZwOIRYPnGVRDlve9i/CxQdah
 Nd50ZBZxBzhRbUG84z+laBXbGd4Mpz/91rT6J+nFHNizCQ3SAmyC80qc4hk6kmvv3dmu
 cpARlSHVHtcbacARTNL+cs5FiYWPy6j0gzcVSCvpu0qfsE9Ww1QyyhQSycRl5Bs6JnXf
 QarQ==
X-Gm-Message-State: AOJu0YxfdCQfmWDK0uYgXqxdAqwyfY3J4WV8LH4plW2L5iNfqfCt5Rmq
 AuNdb6Av+cWiz6dMMuWAKDp1ePqanbyvLfffOwDNmySY6ZdVG2TSD/Nijr9EGcIDgHHv3GChgAO
 OeTYsFxylrQ==
X-Gm-Gg: AeBDievrkafnZ9D169j6O1mstyy/jBlyPBPQurMzBEbQQlfpxO5oPV/Xp81rnULMXB0
 MWNBwKgANcbkFB2tOsOFqJ2UcsQdGc5tK6giEoAQ9qllGNMgmy/NG2XAG/BRqdIuv1xKXGcQmD9
 n417pdBl4wZFxL4h2e8Xf+wG4+Mv+TTFKpUkazCgqNLr908TsOL1GNOWHhcCLZUtD+F7Cz12LXU
 vH60+KjnnkCZe+U/VULdwZYN7e0dU4J9a1/uI3G8hJ/oOGMN6vB8jzBdAzuuYP31p4yH6L0E849
 w/YE7nQ4DXPQsIGE7Z6vSxLHEuW8WtOZ05tuautOA0ROn+mV0rjhOYnSCHO+W+8t/qqCmzhLioX
 UYwcTpkYUsIzEYqChxCwoI6T3WQKeY9wZ8bm57THwQzFm6VhetmCZ2w3sDwPydIR2bAhGdH2ln6
 +n5nIlYk0Ml5IEqrzOWNYA6nMnd9VaUGj6pnKlb4LS+fFVj9f6XqCRTd+v/5FW
X-Received: by 2002:a05:600c:3556:b0:489:284:44ab with SMTP id
 5b1f17b1804b1-48a7b51e0d4mr54293595e9.12.1777456954582; 
 Wed, 29 Apr 2026 03:02:34 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.1])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a7bc79ab4sm48542225e9.9.2026.04.29.03.02.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 03:02:34 -0700 (PDT)
Message-ID: <69f1d73a.050a0220.3c19ab.a437@mx.google.com>
To: "Wake Liu" <wakel@google.com>
In-Reply-To: <CAOcRiAEQnOGn7X5U51Jr_dYGCc6mRYwL_Vh68FNtkvRXXrCh7g@mail.gmail.com>
Date: Wed, 29 Apr 2026 10:02:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/userfaultfd: Handle ENOSYS in
 SAFE_USERFAULTFD
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
Cc: rbranco@suse.com, Wake Liu via ltp <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

>     What do you think about this? I would be happy to send a v2 patch
> addressing this.
> 

no everything makes more sense :-) the right way to handle this issue
is to use needs_kconfig as I explained in the first email.

Feel free to follow that pattern after trying it out. It should work.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
