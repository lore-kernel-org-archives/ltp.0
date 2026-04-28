Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A403FF8868
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 11:53:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777377203; h=message-id :
 to : cc : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : mime-version : content-type : content-transfer-encoding :
 sender : from; bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=bw6K6jhbKbRk9Shl3/8S+uknq+R2ocnHh+QEF38uuUzRh6ubuBv/WU4Yb8EXLgAnHwKdt
 mQ3H+X811CB9adRGRQ8nVI+fMah387PH1K6h3v2fdD+hLGarndJvBIX1NuqNzLUkWnmMF+B
 V7JmLLwq21sBJE4m9YP2Xnxcw1xoFf4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 05DC43E49F3
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:53:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 39A453E2D7C
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:53:00 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B4DF11000975
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:52:59 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-43d7e23defbso6625056f8f.0
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777377179; x=1777981979; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ZPo3URXCssa2GL5B3r4/SSUvvYY+b+AoTfGuOSE6KqD2wA02RD8mo/vVcry77sda5R
 KUrD1NhrqBicrmBI7+q4tbgV1duHpb3w2zz4gNdwAX+EWOp8PGV5LmbUEEz6kIIbOQQ0
 8t6rGRtO0grYKZ5tT4XZU8ykMHVCXm1ZMetLjOMmDCCtr9B5ILIDXbgMnTT0jezdSC6Z
 //rcAAKO8hqEJrDqtOB0hfxL4vbaf0Mqk+dHeXI6L0GDIPe3Wlyj4qw4Ji63rEoB8mN1
 048wqTKdOoEFHYTMl3zdMuRR3Igk14r0ePYOJGspNr9bIsp3UWxHgFLqcKuzrvBO7Qlc
 xKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777377179; x=1777981979;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=FEVAB5Xi/87JP9TXN0+AHz022DcGMG6bBwjJeiU0K5azSWNaejFJHvMUztykB5Z5/R
 bo3ay1JDQ3Rwxb+iMvdLd5IQ89aj0nVpaFd1zos8RcMx7QX588SU5USNOCLzRGLzjaLJ
 3+hMLzVfSDEQoOS8AGlpPDPxESrGxF8Rt8BLmQXvB2vJepCYWgvqDqZTQyzaO2TdO5Ip
 BaLeOq69dNoua2tWXGyoRiB1KhjS+0ECCOzuYvcMOh2UJYtrXWkLQOjnXF00JX+lWQGk
 A5kWHfBQjqPOlMyURxDXMtAlcjWptXzt8OWkqWhAxi81MAEbDYZgOUvH9OYSbeyqezve
 vUBA==
X-Gm-Message-State: AOJu0YwhbkSOa4q2RFpPje21XLNRuUNpKXPrnxPcG610cN1rgpfuFEAz
 CP8adZVxjrCVvIK7NY7srDPYFUeLZBPG/VPLG6WVAkdo6KqPybskbeWCbzqyDNAEYnGXa67oZYN
 zPAEc9zfOcOII
X-Gm-Gg: AeBDievoBeBktqiDsCkZZnBZo7YgGtkBCHhe2mSISMFw7HpLaktvxQlgTVvyVAGlFgp
 LcVBE8gafEtLCD2yiE07OYXVYePmMjc47M3/57RJXiYPGTdJBkO6dWPSOYqPOSSpwh5iofOjXMq
 Au5tMqS2y3xztn06tBzTWt08qPdctpGSmN1gSaZcJqN/oQ/cwU8g9NeqtdpHSVBd+X5aO8tEYYY
 G59Y9QvQIIOcpO7a51SRuiPxfc976OCihGFqrmg62BQ3q8twxYcQDAWg0XE9QKMsi59tEmQnbmQ
 ahr+mvRlQcE4XABisDsdeyrmpYz//9ZCCGCzwqjgqkPplC2p7VO12S5wEMR3qHqsjJgHPzi8FRa
 JU6ATxCj44Ea+Cv+mVbTD2yMgTpOr+ZWZbgCdQ5ZQj7E78NVyUXyMmNHl5lZzzJGlx7j9qTEVKn
 Yu9L/x7awywS5u5kfRDmiqYvyBsPmqrRdqeKcVMWU9rQZ1RO5JaUnwpXZPhdTNeekIprqLVmnYu
 k262cXXP0LM+f91waFCIVAaPKQYHyHN1ekAlx58NUpzkA==
X-Received: by 2002:a05:6000:3105:b0:43d:242:b9bb with SMTP id
 ffacd0b85a97d-44648b510d4mr5023608f8f.18.1777377178767; 
 Tue, 28 Apr 2026 04:52:58 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4463f5b4fa2sm5765839f8f.19.2026.04.28.04.52.58
 for <ltp@lists.linux.it>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:52:58 -0700 (PDT)
Message-ID: <69f09f9a.050a0220.321275.199a@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
Cc: ltp@lists.linux.it
In-Reply-To: <20260427115941.31945-1-wegao@suse.com>
Date: Tue, 28 Apr 2026 11:52:57 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mmapstress06: TCONF on systems without swap
 space
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
