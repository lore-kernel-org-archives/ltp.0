Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9425CCF2C4
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 16:01:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792339299; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=0+AVkc7vPRflnq3qs6GE8CuATUqDFZcVv5hQMXqQKOg=;
 b=MeeWtCrOqcIxH7C6WiBXpwjKeNf4bNFabXhVzg34ieEqcXRrhtc9b69g0NaP5O0dc8Z4F
 8cHouq55SNkhyzH+FcmS2EUQYH/KsBHpxakZOTfatTo9AQJfLD6aRvxiCk7mLuNLfU68e5U
 wQ/BxadcOY2//SoYNvpHwIh5yhKv6Z0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7865C3E527B
	for <ltp@archiver.kernel.org>; Sun, 18 Oct 2026 18:01:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DA5093E1BD1
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 18:01:18 +0200 (CEST)
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com
 [IPv6:2a00:1450:4864:20::42e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id CD6791A00450
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 18:01:17 +0200 (CEST)
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-487049569b6so624131f8f.1
 for <ltp@lists.linux.it>; Sun, 18 Oct 2026 09:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792339277; x=1792944077; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TJpKGwIjxh0tnpWjQZrwtg8T04rYsUFASPfGPvO6LE4=;
 b=MV7qcIXaS+kyUcsRebfVwpWmksxHPg+gwxMRPpIN7VAvkoOQn4uZVC/2m8mP1MDNC9
 Hv4ZAipNXxtLB6y94wf7iYG0r0LoJ1+HqMUtx7vpY/3BhjA/l7nJnPO9ZLyDvQwazxOL
 6PUMqJgZ3l0SURo2b4pIxgt62sP7lo9xuL9KSY1TbJPDNEpH9eeqHKJeqQHNsPQPALg6
 mC+Lgff9Ve73oP9qLId37jiH5ZeNcX+GoD0FeP/Xy6ffy7cnraRAc4vbnMPDVYplwJkf
 8oPUOIlXGWsB3Edep9NRkcmgbT02Tyu0mfGwRzARr+KZyhfzHcIfevhuXeu8WKBTM1Qb
 vmMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792339277; x=1792944077;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=TJpKGwIjxh0tnpWjQZrwtg8T04rYsUFASPfGPvO6LE4=;
 b=wGpWJ7UT40QapO/4z3LaBgJqQY86Z+hp3o1488X4TRKo14D09q/VU1CvRVUxSD6bDt
 Nj4lHpq29p/daE9ZW7h+NHi4uCQ4MW9O0QZI5u0D64JxFQEpq4eZU0QwJebPwCvArbFr
 ZTYrzDQbA6AlXi460BYynQKmRzNXQvR9x3d19sqDf5Ap8JBFuETs/R5CgTD5GWunT7bS
 1wgVUWOBFlnaazphPgLaVhmKERRrQOk39zv/hB1ek/KAshmVUPtPZXpwthnXHiQwPn+r
 WBnMg8p2C7hx978oo/Yjj2ZID4LLBRnS5mMsX02ZO7pmxD7DrzWeEmd1P+9R3cpPc4dx
 OkIw==
X-Gm-Message-State: AFq9FYKZD6H4rVUeKouojSDSNS0cBnk/qLRwIPt1uwDxQURsa5njduph
 EAeoObqVonw9JNap/4J5Z4UegD9TvOSFEDqPH5PV3/ShqRwBoOEJpOEf2kK/inLh5b3IgheunQg
 KXqcEI28=
X-Gm-Gg: AYBFou13ZeZ9s91VLmPAcmAecW5LxZMpBWYCB04N2FNGCkGhwJ5p82mTSzVR2IVQnLS
 Wp1KMa9hwGUIwtcKEeh4i2s9ahas4U5b5KW6d+e4kfwCz8ryOJzGWh8mvcKZOzn47NR4uKhBAeO
 2wEqHBYlqWupI+v6VlrZWZzNuqxSeADVdNf9YEdCVP8X3X2sEn+3R9zDl16ZRdc69NfvrwlLSl7
 yRoTo+jJDJVBV7fROTYiZY7loLLa+u4OuLyC+55DoSimmQKOzwwNT0nfyHgaMmuA/yRYWJsBb1x
 XRZ1jG9ufe9cdKVNb5p9vFN6KkawXaXUU8uxB31Klh1nKwhtFcMiaHdyu+taXCWFew6HZT8Fhjn
 PXw7heIRT9y2BFToASHePJLHH3KFvOPsOhanZ7J8ktF3ugiRUgnH+AnMGORiYYiW7A4I9BjhWWZ
 qbb7WgUZtULZJ8CGBYM0rmZi6q69C/bIJeBlS1MT5MOErTq3VH3W/qgvIs0lXLSJX/HAwqnnSAS
 9Q83GrO
X-Received: by 2002:a05:6000:46dc:b0:48d:ee59:3a30 with SMTP id
 ffacd0b85a97d-48e07f9d2damr7156456f8f.22.1792339276950; 
 Sun, 18 Oct 2026 09:01:16 -0700 (PDT)
Received: from localhost ([176.114.240.8]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4c5813sm24760388f8f.17.2026.10.18.09.01.16
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 09:01:16 -0700 (PDT)
To: ltp@lists.linux.it
Date: Sun, 18 Oct 2026 18:01:13 +0200
Message-ID: <20261018160115.154430-1-avinesh.kumar@suse.com>
X-Mailer: git-send-email 2.56.0
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] openposix: mq_close/2-1: Fix failure on v7.3+
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
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Linux commit 1184f5e82009 ("mqueue: reject mq_notify with signo 0"),
merged in v7.3-rc1, makes mq_notify() with SIGEV_SIGNAL fail with EINVAL
if sigev_signo is 0. mq_close/2-1 passes signo 0 in the child's last
mq_notify() call, so it fails on v7.3+.

Patch 1 fixes that failure by using a valid signal number.

Patch 2 fixes the same problem for the child's first mq_notify() call.
It never sets sigev_signo, so it is rejected with EINVAL instead of
failing with EBUSY as intended. The test only checked that the call
failed, so it kept passing. The patch sets sigev_signo and requires
EBUSY.

Avinesh Kumar (2):
  openposix: mq_close/2-1: Use a valid signal number for mq_notify()
  openposix: mq_close/2-1: Initialize sigev_signo and check for EBUSY

 .../conformance/interfaces/mq_close/2-1.c              | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
