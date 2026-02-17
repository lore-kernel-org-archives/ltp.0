Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4A4EE6817F
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 13:15:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1771334110; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=5iRY7Uv6bo4dyczIk7oen7kCNYiYsMTws0uuz8nKBf8=;
 b=PWUV3OavfOaP6U20pidQez2E0UW7qxlB0T6XRLg0Az/qM4zzcPIKTukEG9OpceATTs3DY
 cu6AH8+A8CBWPDYBQZpSiGTGnljgXsQB/CErLQSIDPgSCqCvrQOTfs+qaPOjB4X3IL3kCrN
 afe8YCOmxyYMAbFfmWzDG+sC8IpEPzs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 615B33D0635
	for <ltp@archiver.kernel.org>; Tue, 17 Feb 2026 14:15:10 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 30CBE3C092A
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 14:14:46 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 91B7C1A008A3
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 14:14:45 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4362507f0feso2772636f8f.0
 for <ltp@lists.linux.it>; Tue, 17 Feb 2026 05:14:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1771334085; x=1771938885; darn=lists.linux.it;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cVCHeij1lX8ennzLGOZVGrjfAFvHaYbKMlrUdo9CIV8=;
 b=cJwheHwz2pjrWSaRVhH2sNcAfNtTTvwn7yNK305QhUa41Eckm4l/quZKEj9PUkCUdF
 W2py2q49g6S/oiVMA0xvuQ1grbGiaWkwENogODAB+xF/5BV4zZoBmumL78IQKZcr6gx1
 QiecT4a8Bky3U0Cqiu//yoNdJDxvB9aUf+qkO6qEBetb8FQwPQgkmT3r6BbJ3v59yJQS
 hkH9gVPg0NioVZdTi4EVJg1b2WpzQWbPnBILxuRCgAqOmcV2EohlGhevl0CslqjmAF8H
 CcuqMsDzTxAHrLYTdJ3v37RAg6r6P9w6w+hyRCwgMODUnDD+GuQMT0XNavRprJui2n2Q
 fGeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771334085; x=1771938885;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cVCHeij1lX8ennzLGOZVGrjfAFvHaYbKMlrUdo9CIV8=;
 b=YUN9Zbc3pzjZQnOVomlgElYsRd+tY4hp7ZwIq/sW5ykMXl1bGHELUlPMlJfJ0FrPzI
 tTh9TBLiMAhq2AffcYu6KA34WwAvSgPgKQVQAhGl4yf9HyJURqQfLTa1q9UqYrZKdGu1
 0MP1S9zClJB5hjiK3UXEG6CeC2fu/HPmNoVp3rAucG5TKII+OYH35X4Moxwz0IArVUqY
 nOyAPsAA3vGc5XuBDctaQ7u6M5/hWPLLWp1+mujAU/YOpC/8fMjwirPKe6rFrNYbnoj1
 HdH+WqFDM7+aHFw+s1ZgWQ9YBW9saJbn99RA9TlAG7L0w1rzbGMmApqHSO89bqDjLOkT
 ePKw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXqMAd86hy179jvG8dFq1rQWK1XCGLjkOpbvV/x9oZIwMlSHPnzuTXIfLwB0E1f1+dg+08=@lists.linux.it
X-Gm-Message-State: AOJu0YwgTDWSe+8DVY9lNSTE1fjkGJ0PGK23M3gUMZMf1gzgvJMMBR7+
 r1VlkTvsGWtSXgLvxBcU+qp3COoNebNtwQQqLXjYqAzokV+BGSCDL1t37MN9JwK15UDLYwkLIMp
 3t06Sgic=
X-Gm-Gg: AZuq6aKyYJe6LNwsvvdk2InW0I+vXQgDA/Np2uX8VAdGPYI2OdMluFlOiRIs6E3B84/
 ZJ4VUb3vndg5sNL3/Rcq75oGOk+DT5e6LPzo9kjaMx5/CjfO/qiudTbbP96+rskestAylTI9LqA
 7sPPIqg+EPQZ7IpK6ZRPJlR+YbHjLoX4S5gT48ZEE9bRk/7afXVOG6ejl5EJWspi9UCXtvjvIC1
 akwEHJ5VpCORXdG6uC7x+iQYNSjvLEOvK4Ls7AWC7sL9tDDLD5ooQydSv2kubyFtKaHjldBwc4P
 FebZmrWjodIvTFDvSeKgCyDJVHA8rPTw2mabz/b9qWcK+/Zpt7VzxogiCn5G0YQaiyFzej8K2oM
 0EC2xC/+bnKzHiWapvcOtpoZGEtFj2nSJ9gkvh9Z/5Mmr6tEyJcCyhy7NZu8i/F9LpfSGz42dKK
 jUihsCDIFP12A3rlGj6ZYjnODbNQ0AtWYheJqc1JVGmLvQTRry7ZQA7h+TqTggcsnZ6zVwg6Kbh
 +5kzdka5ytHVWCfcjY=
X-Received: by 2002:a05:6000:288b:b0:437:72d8:7dd7 with SMTP id
 ffacd0b85a97d-43796af9f29mr23475940f8f.43.1771334084885; 
 Tue, 17 Feb 2026 05:14:44 -0800 (PST)
Received: from localhost
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43796ac7d91sm35086513f8f.26.2026.02.17.05.14.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 05:14:44 -0800 (PST)
Mime-Version: 1.0
Date: Tue, 17 Feb 2026 14:14:44 +0100
Message-Id: <DGH9J0DVED2K.RSTHJTJMSQBG@suse.com>
To: "Wei Gao" <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20260213023801.11713-1-wegao@suse.com>
 <20260213100329.12063-1-wegao@suse.com>
In-Reply-To: <20260213100329.12063-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] ioctl_pidfd02.c: fix clone3 EFAULT in 32-bit
 compat mode due to sign extension
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

Merged!
-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
