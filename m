Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28A2DC79F9F
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 12:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789041612; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=cgfY1AllV1JaRTVUAROBfE2lZGXWAGEcp9J70ED0ixQ=;
 b=Dd6RN6RFcP6B5bTpmGKyhSCAyLLOckqcYQg8BQ88hR2jijincPghG1LK0RUJ1A+1Ih166
 Ff+Xu8MdoValWTqX9+jxsZtPjmI9bP2Nm6n190zUiwg8WNSxPe4DQejcW86+c6gJiLrlhzW
 yFD3/OTuyr/HSzRsqTtUjIUhFpJszzs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D5C43E72E0
	for <ltp@archiver.kernel.org>; Thu, 10 Sep 2026 14:00:12 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 827F53E927D
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 13:58:32 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3A518600973
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 13:58:32 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-49a97714f5dso67002595e9.0
 for <ltp@lists.linux.it>; Thu, 10 Sep 2026 04:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789041511; x=1789646311; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=GQ+yflFmZY3VBu32icFwVd/q2Uq6QRVvrfTOSAu/g3k=;
 b=OGfgtIM7bfnrnbUW90bQSdK0n5Wr+xgGuiRrjYXEWZU7oWrMmYquUC5fpYCtn36Dfy
 BFnUzTd6dC6GFNAcukIwJnz2XwyPWs0Jh1nqTg/+J3lY2gsAo+5U3rVr/USvEB5HQAXa
 eE/RAP4CbGdCJ0kanqViLvuF0EeiwKx7SJj0ZxF3PGnTanYX2S9Hogvee+LaPRMRn+dY
 7s/cbGL4qI0Jbgv5F/7kkmTbH4aZYGKeuqWMefxcQFtNGmei2A/zYWsXAEiy8/QtHo73
 iJEfx2UeMEymGgmrNBYdjeQQb94L3k59m3tNqfWvMRpQL8UL0UsRCFPhlvwOqBZjSUQn
 +/3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789041511; x=1789646311;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GQ+yflFmZY3VBu32icFwVd/q2Uq6QRVvrfTOSAu/g3k=;
 b=nVzXZ4r18SSJMUajWASV+15/luIaN1RW3YV2tYk9ISG7u/LVGeCDJnDC3hCaWNDxrP
 ru9Vi4Pqb6Q9U4JSjn/q7GmqDvnIDcffcALzRsmLvgH0XCQRJvqHuitaYg2ThFdOR4Jb
 wSy88a1RHB6AY1aP92N82VzjQ8aMmG1d3O8LqwrCnHNi5KZyYTqnc06c5f3oWLSdkNfs
 POWyRcdgBfdu6ra6gcvbLsPiLlrbDHrTA0koVlhXOcCbAGb9+rVabousqE1iG+0d1TdP
 GVplP+jZZWMh8T5Amy0esGGDdQfcmH9An/xnAx/vI8U9AlHzobF+15QI35V/dBn99MNx
 7hPw==
X-Forwarded-Encrypted: i=1;
 AKwUvByDdXko2uagfkyfQgBQ1RkPujgKJLxF29d3PCgO7bJb/DHzL2kA2JGga1wH3Ri4+axTlNM=@lists.linux.it
X-Gm-Message-State: AFuF++mqBjCJXurlg1p9X8vWQtkRNDJSNeZcUWLSTuwg5LQ4mJD6k7u7
 UvoWZNL/8h5tLiZP+TyXsxovasWSVVvrCAglwyccu3gGCD9YnwZRFjknVp+ijG74NIo=
X-Gm-Gg: AYBFou1DBOUU6Ak+FQFYZSC2qX+pvzc8lrginwvei9qcJ0n7jXqSdKBo2hNzl5nf7zc
 DpT2nJnhdVSI6VvI+f4sRbKbk8mTaRyUnBasQcqIkr4f9lyqKI5shWuBgQ/KHwMcGAyAuVVdPEG
 OZZSSSKLEDkemOwR4pUQod5dxJnSzPUsrCow8VHv+l6e3stfTDsbiYo54C25kpebt9Jky10NlDQ
 GKP5IyZmZBstNHOi1OWwh5tDY1l1wph6RJYtoBruNYeKNcmIJMxu2mKVlj2O+7nzn+RlIOid1kp
 PBtLPlCKicvi9NaR0IEcH9tSOMDQ/myRfDRL+IFEDyZVz75NdtuLBIVjWV+2Awm6vctNGpj7IkO
 s7I+gi09XdDtftvq/7uYnnEbp43ISTyJUE+gEkedbFtAxElNJBuX+XpiEUKu4/hjTtrTZHw0t9a
 ikJZTSchV3LZjg9StCxlGyzD3XXBCWAoWyRQWsI9Dog93H4jcsveYYTkG/rMHLaYNBa7JR3uoAE
 1PiQcRMcbCNUTdwb0OAZg97rAC0/FN6PvOPBTruKn312iiC
X-Received: by 2002:a05:600c:c162:b0:49d:16dc:e721 with SMTP id
 5b1f17b1804b1-49d16dce7aamr214366385e9.24.1789041511542; 
 Thu, 10 Sep 2026 04:58:31 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d26c04ba2sm68027205e9.12.2026.09.10.04.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Sep 2026 04:58:31 -0700 (PDT)
Message-ID: <6aa29b67.1f1211b9.32d54.30d0@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <aqKJODHqRsBDsSi4@yuki.lan>
Date: Thu, 10 Sep 2026 11:58:30 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v8 1/5] sched_setattr01: Convert to new API
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

> Can we please split the passing test into a separate testcase?
> 
> Mixing possitive and negative tests into single source makes things
> more complex for no good reason...

Fixed and sent the new version

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
