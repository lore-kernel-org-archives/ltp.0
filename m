Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5259AC54F54
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 14:19:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785248387; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=85IkL/BEQC86u6xxqypGcxN/oj772LB7EWypljIwSKw=;
 b=nB+N1x4v4w70PIFWPSDRHf85S3fq66Kge4tyUhJG2Cw3J4+B3iqVgt/M/roUKBIbYPfPY
 CuFQArnBkK8TW3C72awfGG46zkPc13JIAh4nYVpEdr/xiXvSLaIMtV+SGJKYE4A7tolxbqz
 pN3c6M1XYHNmEoFDqGFi1EtIpjLR6Yk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52AD03E74A1
	for <ltp@archiver.kernel.org>; Tue, 28 Jul 2026 16:19:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A908A3D0E80
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 16:19:27 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E24F01A002EF
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 16:19:26 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-47f93b2fe4cso2807416f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Jul 2026 07:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785248366; x=1785853166; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zTvxpJZYIvN6Em48QVNjdQ3F3HXSon7aiIaxl/wkEwI=;
 b=ZNd38HEpzAhBReuJSdBhSfS2cnb79WYE0+xwVKEodxq7NQrwOZwu8Xd5fPxPdQoeJ1
 Vb0Huz7aYlk6GfmmT+G+Vy5Bbe7L9MLQIUX+iQICl+VxTDaut6/sl5acTmSpeCJqdGqg
 Xc1o85zsYsKcsBrrKr+IK/QgDoA/RrqdfvEX+N7Ic+LGKlYi5/zNpIuPwATkre6E6y1/
 nLK0kwfqU+NsJju6VXkwd93eArKCm6pTklykDt0ytdI9f8tQs3LK/zIxKFXieFezVXKw
 aH2WRYZpnvDn98Cg8PlnwI0HAQ54otEiNCwd064fwquEucDpzqvQUgPVT8q8oa1HS4Js
 UDzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785248366; x=1785853166;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=zTvxpJZYIvN6Em48QVNjdQ3F3HXSon7aiIaxl/wkEwI=;
 b=KR0liBCkgcntc8anYKms04Nd2JDUEucLVKeFO8wdCT+5k/E434StdN54U06sxNh6ag
 ufnJjdHAU5Yp8QUxRAd1N/aNd+qujJMb3LIq3MZDYt5hCG6lLVh/3IqngpkBijeclW37
 jHBRH3UH/dlzO3mlluDh4F2krccLjfarVoseAXWWUNTicCNEfiytYINJVFuyIxVOJ6Ha
 /uQw0NprMc2V1dsCQRWWls1l94KCydUhLDYBD11qMRdyp3480vRLisbhSW7H+VZ0LAk1
 REhXe8QPCRB3bzIcr4XeX2xLNhgdgp7A8blPt5Ra75dyUM27ZxS/mrht3R/nyUeDMJOG
 ZXZw==
X-Forwarded-Encrypted: i=1;
 AHgh+Roo4UgKxjfVCFuTbaHtQ/Z6CoKDxjAIrq3Vsn0+HXBbIHSJVQG/OOXiXJvxBqsCtrcvOU0=@lists.linux.it
X-Gm-Message-State: AOJu0YwT8qcJxH4yZaaD50EBibkeEtfWHIakPDCnzUL5PHCaj2FjmQ9/
 SJ3IZiua9oylxxm703WVD3EfDsfCA1mI+HAsMaMlNJ+cdlOVuWM1ujIECgr4E/rBDHE=
X-Gm-Gg: AR+sD130cPjBMtDStZhjIRb2G3MtdVWWAcZ7UO/aXFnrU4RnUISKWc97SutA5vLMTmY
 46XCuL/51mco0zj7cJKMOZA7sQNImB9rHHd1SSD0PaW+A0460uFGxlvglfN49P7TB1T1qMVwTVb
 dh7/xeY02zW6yprEHakXs2nsq2QDlFIA5wCmORy7Q5vCNwm45QvW0YIgiJR8CQSTgA9/ptUXaz6
 E/laTXmlJL88yBi5K/CS/ktFUz7mnJvZbNs7b4uLzfyju+jBSm5VEGYsxbs0cRqp6vMe+B8yY8u
 7muihzhcwFYMFJOzenFthXIA1/VM+UCIqIquyJo99HkVeEi3WxY3nGcVbVY6Wwg+lkZBL9m1BxN
 TMnL3aSgNzA9Hwm1Ajwvk0A6g7uIHYxcannf3NgrQvSVqCWkh97SzZ59eF95z1kq9tNce8WVpMz
 BOXfmLuzQcbYpb3E5fwRFwQpY/x//PbYUY
X-Received: by 2002:a05:600c:c4b8:b0:495:5858:8101 with SMTP id
 5b1f17b1804b1-496c642fe09mr32654875e9.15.1785248366088; 
 Tue, 28 Jul 2026 07:19:26 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496c44af22dsm74401765e9.1.2026.07.28.07.19.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 07:19:25 -0700 (PDT)
Message-ID: <6a68ba6d.6ab3636b.1b6ed.778e@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260728135858.GB1128467@pevik>
Date: Tue, 28 Jul 2026 14:19:24 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] lib: Avoid loop_info.lo_name buffer overflow
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

Hi Petr,

> I suppose strncpy() is recommended as safer alternative to strcpy(),
> right? Shouldn't we check for strlen(file) is not longer than
> sizeof(loopinfo.lo_name) -1 while we are at it?

we don't need to check for strlen(file) because strncpy() copy
min(strlen(loopinfo.lo_name), strlen(file)) chars at max.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
