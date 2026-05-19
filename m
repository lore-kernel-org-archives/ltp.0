Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A4D3CD4F3C
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 15:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1779204629; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=XfIhaiHYFymkfbkqKPGf00f1LlGhzZx1xV1kDjh3YzBKTIHrAg/7AmvyQ6K/tnnQiGZBI
 cvEPNvFos7LVJ8KTFgWXSlt7Q8r7IsILItLagMyVe1BGJOtz7uxN1Xlnh968FkC9Km5ZQiW
 A/HM+cGbk8uk1C+8aw41mK2AZXA2JiI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1736D3C70FA
	for <ltp@archiver.kernel.org>; Tue, 19 May 2026 17:30:29 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7C2813C6FDC
 for <ltp@lists.linux.it>; Tue, 19 May 2026 17:30:04 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 2087210009E4
 for <ltp@lists.linux.it>; Tue, 19 May 2026 17:30:04 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-48896199cbaso30361665e9.1
 for <ltp@lists.linux.it>; Tue, 19 May 2026 08:30:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1779204603; x=1779809403; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=Wfo8tnK7HOm4zGffT4LBmbiAuQzjNaIanQaQlo1A9FS9o4+fUZ0pwMRuYCEh68GT6p
 9iMfcyHlHQdKNjTRCDUjsF0MNO9yDMTkd5zgip13waIdt2Rh4dy2tL3PBFmzjBg2+3An
 1D+zy/yeyR4RD+fBsAjy0kuqaMYUnHoLKGyN2eg2X0K1sLyDpLAqQESv+Cix9kW2A46l
 3ljD+c+P3Uni60kJLGwDpe1yrLwi0HJ1ZKxY6NwMzceU2ZY8Nf3iYO+ZbBs7Ey0bPSps
 7eJkNakrWhdi325T5zvf6Pawg4xF2rkfKPHAQZZTNE/qFwci6VK+E5U44H4URP+8p8RQ
 w0ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779204603; x=1779809403;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=WF0wTq455kjG67i2PC46+WLKfOGZNPa6QACdPn0FM4PTo2RX796Nmb1plorO1czvq0
 Pbw5S86+Vb7Y6/khDmuzq4cn/6uiV9e7w6JATJZJM3uftdXfFvetJ5N1OH58dY3j8gK8
 4r+lsvDUh0ThKkgKIRj5T+RRUMer5bNiU3ci6gk+1UGUVkGW7oMqmcrLDNBlzCxBhebX
 ilNuxv67XNt8y83mDcNjGjbsZDV2MjR//qPmrFhcwy4kqbWpJ2jP+1t4Xo8Q+d0/1IZ/
 3y9hHqC5msYNyy6sTXuXaQMesRMESoCBZhm7coAV9KSQ9troVZKb6PsoCC9ORTbLrRrF
 47yQ==
X-Gm-Message-State: AOJu0YzxO9XMwYRcBpRVIats2YPoWPHSLGE5RLD24ZetzU9EudN3r0AF
 7bljIFJpd7occksOUV4joVWGNdn5kex95HfKBD2qwpRzbuPufwOIjqTufppzL26ze498aLiqw0P
 JPLGWawY=
X-Gm-Gg: Acq92OG9xcgFSZ+6PqMAAxx9S+yRHASpKNv8A12SJSftdu9j3kdD2gie+ClKI1/v73c
 /x4rIVABFW2peZ6GKjDaf5+Q2Umm8qAQGx/Utgkc42hd0mXWoCBAevchMS2nehxxnjiaxHVfbeH
 MfoUPhvksoSqxl9qokw7VvquYgz1w21jg1QSD7u7XuQqdAakMeKIX/rXd2d32d6b/PkikwTHWmp
 fIkHUsqWQMfYqh2KRgxcOdLxn+aXENebY7yY5lm9q7AHbTq9LRUoBiP5IqSly3atoMIQmkZR9q4
 r/levALPTGLK8xbzXwQuKfju0Ubt7ginr2Pr6pHF/5aS2JC7MUOQR10GWNTs6FI/3g2LfgyMMOY
 3Y5rnF/FNg2JILMzYEvr3TStjEoEHK7ZiWzf0uRMxNeNFRqZnUdZE+gB5Pe9d1/h4hdR8XRnMUZ
 nJIVm5RuJOJRkellI0y5m6zjVWP1BN6Hgo6jBXzaOeb28d3W17FRcDd0tDPNyPjA==
X-Received: by 2002:a05:600c:8b0d:b0:48f:e230:2a26 with SMTP id
 5b1f17b1804b1-48fe6631679mr322490415e9.33.1779204603223; 
 Tue, 19 May 2026 08:30:03 -0700 (PDT)
Received: from localhost.localdomain (wl.mlade.cb.wlnet.cz. [193.165.72.195])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48febe582d0sm133192105e9.18.2026.05.19.08.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 May 2026 08:30:02 -0700 (PDT)
Message-ID: <6a0c81fa.01f20405.13968a.5199@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260429062650.3191021-1-wakel@google.com>
Date: Tue, 19 May 2026 15:30:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] syscalls/file_attr01: Dynamically expect
 EOPNOTSUPP on tmpfs without xattr
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
Cc: wakel@google.com, ltp@lists.linux.it
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
