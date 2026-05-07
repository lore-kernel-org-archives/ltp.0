Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F7D5CD3442
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778142939; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=ehQ0eXJ/hGQEVuHVyy3F/9MXgWqKjPzcPvrG22O1nTmhr0T7UQdOoYzc+TcCYoyGK12L4
 7wE7ISwzyWTOvRGA0ZzkN5z5+3HKYbXd3k1NWXD17kkAOCpVEuVIB1mLTTR3BSKZWkuiEzj
 ls7jmQKM1ZMYLNO+p1j50S0vpkiek5Q=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EBCB33E2C33
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:35:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 431753E6A32
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:34:58 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CE97810000C6
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:34:57 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so6968055e9.0
 for <ltp@lists.linux.it>; Thu, 07 May 2026 01:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778142897; x=1778747697; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=XtqtF+ksu67a2yMR5TL4YOEoPrtJCJHVGEMeZ2l+ykpBytOdijDK3Lm2DLvQRXWAO9
 IkeRmCEM4bHDfJqvxd37nx2f81XlSWbb5V4PUZzATMWzTUSQ0c1rva4vYEkKwy/iW69s
 64cjz4Sh8UjlytiZUofuVletO9jwKPZ+LNp/aRYe9CbDOuHx91Zet/++HE/G2VJS9dhU
 0WEEBLZft9j6JxDnJDd9t9P89fjEU1BkDZsssFFEy630BYqPRwHTuFf/UaXFADNv4ZXD
 0NOyc07kESGaOaENU/6vESP5O2YfIV8g7rC7HqUmioJuowNI/SveZ0+cNYZmfaTbGRtw
 BO2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142897; x=1778747697;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=JOhXiNpq15Va3vQE8xjDMTJ7YEZUv8XYeKgwv4sd92AQBLBuycweP7JiYfpXfjMHiy
 c4cFKaainy1qmsfieOGUwvZ86TN/hgV8ha310cUUqlStQMEBzPskyofetwTwfQgn0Krc
 lvc5pfOU7QaPaNXmOtQe7NxgBMlmK6gdlhHma9imuCNS2Hlm6DcaitNu6gDj0gATg1sX
 1w1/zplLjWcQQ2RZu3+ufshzbLylKZJMY2gXwt92/BLxjA36OpoFaPhMafZNWlZa26MK
 EzzImxcDo6KGmMGUbzpHXkIR5RfP5yCBrthVRwebZsvL2swyXMGIgOO8xFaNADOHBp87
 6caw==
X-Gm-Message-State: AOJu0Yyf/UcH74OvXQA0th6SvR8eXeSpAwB141f75aMeRICvYI6U7odc
 s9+tJHswS1+XBYxvH6trBqc3Dt0osSl3KDw17Tm/S3DQchliMRB4jCWP6lb/v5dqIw5OFPU5dei
 laDrirx+GWg==
X-Gm-Gg: AeBDiet5cA0qrMEu3PMGbHLVLDJx+9z08XFV9YVCjEWdOe02ZGZyXUwQWEWsO6Rt6yl
 jAsNyfc06RZV9ebV/rxuY0RyAP2HtHOpRrrF5D+HW3T/oU+OIUVTOdA88R2evx0JaN8wtuT/TqH
 1SFx96dngAjmsMunj8zDoTpO7v+meCMEZu0O+6xQnYmUELNnHcXEoNmDyd+ykTeoBVyihw+kd2x
 EBZZTbuD7hqtZrOiTosIMLS4sdnnDkzwUFA33nzY4gyREj4t02PDcwFRoyeHypqLdLXNlIDDu5i
 ONpJUAnRSZBPyoDAoTXWfMBeYg40xh09qG6IN4SldqSdzXqpnGIYI2zjfsL5JdAYpsWalpJMc1W
 vGXhpipDDtuApKQO1Xh3/+2e0/HR5vhXm0WTo0i/3xFtJC3G0TpV33So80I0UDoZBDgCB3NIny5
 67ui2w3EMTPnHfUjQKkCe4wxxZRz7p9VLpvXa8ycjy5GsRgEdyIYFv0MfT2/T6ryEUaL2iAT2fl
 wPLk1xOf4CPewomhO4v5+ghdYl5oWMup1KUxgi5eRZC6V3CMHZq0Wmw
X-Received: by 2002:a05:600d:10:b0:488:e7e4:8425 with SMTP id
 5b1f17b1804b1-48e51f4ea40mr94054285e9.23.1778142897026; 
 Thu, 07 May 2026 01:34:57 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e530b19besm36293665e9.7.2026.05.07.01.34.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 01:34:56 -0700 (PDT)
Message-ID: <69fc4eb0.050a0220.3cea67.2cc1@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260507075006.8690-1-chrubis@suse.cz>
Date: Thu, 07 May 2026 08:34:55 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/2] Fix proc parsing in newuname01
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
Cc: ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
