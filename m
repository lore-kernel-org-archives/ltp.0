Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E15CCD4F2C
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1781251563; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=x1yoruXSLien5hhzUqJlpfT+5fuuULPlmSi3IKT/lh0=;
 b=Pe4UQHTYCO1hsXFT6l9KeG0T7F6INFQIFVXapp5Lq31hTw/eLy885X/G519zT+aFO6C8E
 GjAa10pwipf0Rnvm9Ni8e+zd6Vo93l6LWYe1n8XUnru4Y/RQ2c+GjVPyVBKwXP5OjW+kqsh
 /vjgXA18lgnr5CroCRP0CPC700MWYNQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4151C3E56B7
	for <ltp@archiver.kernel.org>; Fri, 12 Jun 2026 10:06:03 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DE61D3DD463
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:05:43 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5B21060076E
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 10:05:43 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-45fd45e596cso345076f8f.1
 for <ltp@lists.linux.it>; Fri, 12 Jun 2026 01:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1781251543; x=1781856343; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ogBgDxagCWnfRrEfCQu1/UNNG5X024adIaM9rGP2fYs=;
 b=Lo8sedaMo4QAqf49QnMVanmYS2/3HrJSU3s8dpNEAFs9vyD0O5SJey6zr2rMOijnz+
 mxhQSaQMrJzWkiHfx0wdjlvbMNRNGCdUpZJDvX+YNcS2NiLirnzmLcIpAYzrCwdBe5UB
 VUbjNOBSLys9XsKPFXPteTgpAtUOHvF/qGohOBQ4uEHjq+nEEVWw0W4kfF6s6v616KtC
 weF6x4yVJ+HC33FOlbmBBpqMcNsQRKHwE7FQyygYB+2t2g4fPr5Xp9c3VGH5srtMu1Q8
 lpwRKYjSFUDta3P5ojzHTyHBSdsfMAk1nDVK7VUh6+yu1MeolMZ/eke2O8sz+lSdZeAB
 1ybA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781251543; x=1781856343;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ogBgDxagCWnfRrEfCQu1/UNNG5X024adIaM9rGP2fYs=;
 b=N9rR8lmEbhkmnYAqXzpxTfzsNZ76x7xrMIfxyzxoT9pYHwNY2EzH2qvIqafkzFmCum
 06UDMp+BGSUPkJI5hm/PH/NZvcVQNRdleq8GH9thA91KSo2OkqJp1Xgpr3eS5KdGFdn9
 FqMHDnVXemhIQidb0gr9DtVl8svV/hbD1mfZNkyuBrUJX4v+AH7QM+K5Ju8GIHcs7mp3
 a4Av0rf720qk5MN72UJ3SEqphqmkWSWnDMmR5tZ8kOTf2EBmAK1sHt/81FTFtpbQpeIJ
 l9S1QIURl6dfgxzoFF34xMlbPb1eudlmMAUp+gxz6+d1as4oFTJS0nOGkYH+UmtjTqG5
 OoHw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8QpKQEKYcxEnBHsoUwygL13/3ka9vcM8bLd/NagnO3stM0lIEw3vyjyePVQRCSO86uA4s=@lists.linux.it
X-Gm-Message-State: AOJu0YyEOO5cLk92cGwMwe4y7AcQOr+Z2maYDn76zZe6oF3b7YY9nL9R
 E9jY5XF8W2j/w9T8nA92MRhb4ZLHiAGWWbMZM7RPnCCplL8ONk0vSq6bSHEgARKHag8=
X-Gm-Gg: Acq92OEhpKPvuWQz4l+YQX0e3fOtR4kDrI0S6sw/0sN/WFXhG/EiP9Yz6hbqQkQeRvz
 IM6FXtSGseKql4zmcUfYzmOzhfHsoHc/sdMshIvS6TduE+Jfx27CfjavEwRRWaOhodGuBVvsYXo
 veLFU5zX5Hq22iz/90LhXLh257BUnMGsndWutoZCBkgSgjRpub/EQ27LTZKcQJruzQ4UnjiXNIO
 SklA7avbLD+GpqqyhVYQAyb+uuwPG+1t4rwx0+vjDf2mGvBKbw3vqK62T2mTcUnPuQA19CRLUrV
 QgjqaHF1dzxWb9uuDOTPrnL2c+fwe0aIS2Jq6JKwsUH/B+n3TrusmuVp44PqKG9IZvSvu4kmObH
 h8Lwerl3n3bFEP2vyq+5bAKnrYEPtHAZU+gfeYelHuVPLysTcwSfpUfTau9U/CaRTtsf+m6t1IR
 NHzcB+Xwu7gNfxsMXhi6p2LHzX22v2c5KnI9MxFyDlBgXrf3eX5vJP0+Q8RmEP1syrHVDOgftxP
 ALEB7W6CW+ShmbzZyI2hYj3y9ZYnDa0plI=
X-Received: by 2002:a05:6000:46da:b0:460:1a57:dd7c with SMTP id
 ffacd0b85a97d-4606db9743cmr1602877f8f.23.1781251542517; 
 Fri, 12 Jun 2026 01:05:42 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f13eb00c11aebd17f9598f1.dip0.t-ipconnect.de.
 [2003:ef:2f13:eb00:c11a:ebd1:7f95:98f1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b1092sm3494458f8f.17.2026.06.12.01.05.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 Jun 2026 01:05:42 -0700 (PDT)
Message-ID: <6a2bbdd6.e130e254.a31cb.0826@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aik2VjAKb_EUYNsv@yuki.lan>
Date: Fri, 12 Jun 2026 08:05:41 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 2/2] doc: Complete struct tst_test table and
 shell API docs
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
Cc: Linux Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +``TST_CHECKPOINT_WAKE_AND_WAIT``
> > +    Wake one waiter and then wait (argument: checkpoint id).
> 
> This is the old shell API that is eventually going away.
> 
> The API that is going to stay is the JSON comment in the test.

Should I completely ignore this file then? For me it's ok.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
