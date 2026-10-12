Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FDA8CA9ED0
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 16:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1791822926; h=message-id :
 to : date : subject : list-id : list-unsubscribe : list-archive :
 list-post : list-help : list-subscribe : from : reply-to :
 mime-version : content-type : content-transfer-encoding : sender :
 from; bh=t88081pw85nGaxCiqIYUeHU6BFlDD5O79iYgtaT1hDo=;
 b=NCUwZJigj3n4FVVZIEz/paopoIAAIV6J9jP+fqHOhOkzZhB+uz8fMA5NHmNCLW3XHK4aM
 DPZhhuMOI44+N3E7oaa0n39FnCTpfp9z1PnFh540PLzFESMZielgXz/BDkYInKP2T6y+wgO
 1eDkJZbrDx/AibsvVTmVwIRxKXbFpd4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E98A33E2157
	for <ltp@archiver.kernel.org>; Mon, 12 Oct 2026 18:35:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5F8BD3E75A6
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:35:05 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E202F600663
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 18:35:04 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4956869750eso16218415e9.2
 for <ltp@lists.linux.it>; Mon, 12 Oct 2026 09:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1791822904; x=1792427704; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:to:message-id:subject
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HM9vwu4rMZlEFC94VTaAq+gLkn73JDbd1d1rMjPdEZc=;
 b=LZd1KkjfgbcNa9SMOItkeMMgjCnpwW7cBzaXWGs/WjXhpIUwGhssb+u+mgAVb1Fyvs
 ql+H29cIbiemth8rwI3ThsW1az33weecnARI8zIzHA0S/4n8k2ZeomludxX+LAYQh3ds
 4Xf+c2noPEfZoTUHqiYzhWVX6nY8v9pMFIvg5nkHzUsE0MPDct/FR18Juj9sAXErkpZB
 r4et0RvBfdowCmFgFzcCT6Gvm42TobqZY6kXXFD/0gbrAFZcw2YrEZE1RT8v6YkL+53M
 G/g0D4QufCHhkUiNeZOradlTbzZTuTCR+MK4eipGPmo1S9LVsBRMqiGpnW1yXMmJdtZ6
 YThQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791822904; x=1792427704;
 h=date:content-transfer-encoding:content-type:to:message-id:subject
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HM9vwu4rMZlEFC94VTaAq+gLkn73JDbd1d1rMjPdEZc=;
 b=h6M8l3TFhQPTtu3MkCbn0Ytkuon5qsPRgPVtUwCUNzIl3uJA+C4v5FmPReq2q6cvsp
 qp3JrtX9wGl/3EfnUNQ2KFrmHJ8S6hBFcGUJYKSmRT95eAjNUUquEBLaFLi7F/Ba289t
 COBP4PSg4ZjHWvXRTuYoQQ5OjLhlIqQH5KZ0Af1C5z6IxX+fZjp2is3HZkEbZq5uWsZp
 SpzEELPu0OpMWA7jfQ1p16J0nCZYXOj9eFKpUYDL+QWJ7qGUhHDwfmrrKJRe+Vp68xFu
 +Pcp3SBEIalNqAY3PiSCBnanCj+BY6J4qp0VIWp4ul6B8GxOOeSaWKn2aDmWY9mmPN4/
 /eQg==
X-Gm-Message-State: AFq9FYKqMKZThw79zaux7azaUDpBCE9DCuCB7xrR3hbMn54kXOXt1czs
 eva8FPf4ut+X9qDZpcGh+/q3wDVssxs1RVJceQJqAHtTi6zAX8g/14dasjHCm2zmGKwnaWxpiHS
 YCRu0hPjps7XD
X-Gm-Gg: AYBFou2qRtTU1f36tSKbVsxJb3nrVWCxh/DBMZq4PB+mL/oPtqaq5yMN2pcfO8KqEeh
 VjHAv3cny1ZZw3a5gt2l2xMQitS/6A6WA7UxYe7r2/xX+m8XTuR+QR5YoaaRxIyjgB/TCESbTWQ
 roYZJahZ5RqjWQ6VFhwAqcEoRYs2EMD4HegqDS6EcfEluhV+La7h262R5MsLk+JCawb/yXaEQg6
 odOE8ZBf1jx7R0sBJroL4L7veloa3reVrbIwmx1P/JkZkXBMvEsUA/zkM8ntcuMjV0/7H7zh5Yw
 TGOtSLt8t+i3a6G3ZbUVYPyePNK141qx4ASala47ZvAoW7cDVZ7b9z6RioiCR42+OdaMted8ZBB
 pOTZZwC0DMu0CbK7HeoncdTxbvb1an92yJmp8hRE83XGSFBj45pbEorS+J30vR9pElc8S3/d7PA
 wc/P/pth5TAnPfn+LuiFFKSJgMHWgKkxFL4ImXF4j65PbfLHZNGS1b2/pRMxw/snRQzk/ftrZmx
 0E78mC8S2RRQ8Ag8Mn6zP+S1C1QxBlv81L2uH1BVVifrzwzvj2Mqiorv3XRUdNtTX+JcYaTMC4b
 3JNEAQcafY45
X-Received: by 2002:a05:600c:4ecb:b0:49f:f099:6fb1 with SMTP id
 5b1f17b1804b1-4a18e4adcd0mr197157015e9.15.1791822904215; 
 Mon, 12 Oct 2026 09:35:04 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf2caf4sm327712545e9.10.2026.10.12.09.35.03
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 09:35:03 -0700 (PDT)
Message-ID: <DEOxbeuZFcHpiFjVfFNUWk1P6sFdwJrbbB3T@localhost.localdomain>
To: "LTP List" <ltp@lists.linux.it>
Date: Mon, 12 Oct 2026 16:35:03 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] After release meeting
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello everyone,

what about scheduling a new LTP meeting after the release?
When's your first available date?

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
