Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99701062878
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 12:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773233040; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=CUYC5CiYUmzRQFohUPHzzBmlDKDcwvDXMQrPZEmMtDk=;
 b=jD0dFUYHtkigQTnY5X6c4qLN8SWFqoVM4ty6ejAUMlG9Qx8uYvJ/bzvehnilJe/nX8Prw
 VojH/CntESpyfMWym8OVFMPiXKoutwGQ80UOtCdhTuwWo0fhugl4DADq9/5Wg3YWTU0/743
 H5mBlvy3XVSXqsRIYMYKOi4+o0tRr3s=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7C32F3E491E
	for <ltp@archiver.kernel.org>; Wed, 11 Mar 2026 13:44:00 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DCB563CCFDE
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 13:43:37 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8950B6002E2
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 13:43:37 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4853fd7b59aso20057795e9.2
 for <ltp@lists.linux.it>; Wed, 11 Mar 2026 05:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773233017; x=1773837817; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YjZJUUJq9p882loKiUHliBtVVr/OJoVNZy50yN/X3Jw=;
 b=CTHA3ce78stit4Xmm1joFb7M3Atz9gwiICfQh2WjsRSLvx9NF2zsoBudNJGLdMk5MH
 bEpWHt04O5Lt/gMKnp5XwRIZtvO2abjLU0Zk7PHVe2jPbHRZ+zsS1fRB/xvUqA2cMjoD
 oRYKxeoutAeCSGL4HEZNXo+TtlIbpJl52wAuZxN42GbuNyczEG9zWV2jHpG4qwIRZuB+
 DbQhN4waux1Cy3UsRrb/jprgc0z8imaJ522ruGL9goaw4WJOi0dBaBt8vYcEHaDfWH6Z
 wsW6ZvKSrpeylVY4G6ueFmZT+urDMTVQDoU+P6x1fLEVNw27VH76pmKO3N/jRVs7Wl9f
 Cv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773233017; x=1773837817;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YjZJUUJq9p882loKiUHliBtVVr/OJoVNZy50yN/X3Jw=;
 b=B/nAnLE6UIly9Wg2/MVmbI97Ocu61VlKyCa6sdX5Izz1zxnTK3rucdn/iDxO8Cigfj
 uqlb6iiKmAOlgd+Qq+R2dnaAUUoJgeZJetVMVa7oJeFogzrQYIPVFwCq22UGSshD7N2X
 O2nvP3PjQ2Hl6Lb+bnM9uybxF59vjHi7CGJtLoDMq6ZjqshpvhmawptWtX3oZclEv35K
 /TQyb0xHpG/45F3MP8BjQbPIQzjrYcwYS+MdAxbDDJ0cqNuChzWcN/pEr1qIF3Kd2D0Y
 /2QgCieXbIrUg56cyRQy1CNio2m5i1ExsTpclwbWDiOxZF6t+/S3wzQPKPierdGTyP19
 TICg==
X-Gm-Message-State: AOJu0Yx4BXav7blXkkiGKoq8/QY/JPn8YmdTa/AH5Hct5zRPnSVN2xFK
 Zbc4wMYoD2mLaixQGfe45MR62+f8Uc4mYhLx7KlvTpRXIWPAVmQ1geA84yv6Av214lcjEFUkEkk
 BobX9
X-Gm-Gg: ATEYQzx5gdcSwrJVAVBDC16dv92nHBySB6r00ehHAq4vpeX6Uk7zqZEDNRltjv9bI17
 njIlL5AwFau4E3wOHr/9ye5TYm3WudkfXxP7EkAjE08Ru13EJvcWCuGBQwn2X9qE8I76U6eRtdf
 QIYVhApJ2KnQBvGcicm5620x6iuusSFyST4Q7g/pUbBMYHMDqUjPOdOrj2D/QQue7LeuKmC/coM
 Ypr0IotPkopEkK7OG/2NHcC7y4mJ5A506mYyGWzjgBEFcBRWSFVs9S+XhwQiHr/hNmkNPaoq2W7
 AzW++LYttDgbWPr9HQAEQwhIfq5K6kWlklFaNuA1z1n6guB8aAcshsz1adykvvTeHU525Mki2/O
 HG1xrp/lrxkCBIZwSjEu7TW5O34ka3OpWjX8Gzlxwg2ge0gO0XFuYyqGJceuAcqmT7zwHxlrL25
 V22ptG2cFlO3fVbDR/n5691A8rq8d9VQi+U1DdF5Fc
X-Received: by 2002:a05:600c:45c3:b0:485:345b:ccb7 with SMTP id
 5b1f17b1804b1-4854b13b52dmr41381345e9.34.1773233016580; 
 Wed, 11 Mar 2026 05:43:36 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.24])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-485419c2930sm253707865e9.0.2026.03.11.05.43.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 05:43:36 -0700 (PDT)
Message-ID: <69b16378.050a0220.e24c3.cee0@mx.google.com>
To: ltp@lists.linux.it
In-Reply-To: <69b16303.050a0220.27d4f3.6151@mx.google.com>
Date: Wed, 11 Mar 2026 12:43:35 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] After release meeting
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
Cc: Cyril Hrubis <notifications@github.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> What about Tuesday the 17th at 9:00 UTC (10:00 CET and 18:00 Beijing time) ?
> @Li Is it too late for you or we can make it?

Sorry I just realize I have a meeting in that hour. Can we go for Monday the 16th at 9:00 UTC?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
