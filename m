Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FFF4ED7B8B
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 09:19:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA0453C4F29
	for <ltp@archiver.kernel.org>; Tue, 14 Apr 2026 11:19:11 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E5C253CEF96
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 11:18:53 +0200 (CEST)
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com
 [IPv6:2607:f8b0:4864:20::72b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A980B1400BE7
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 11:18:52 +0200 (CEST)
Received: by mail-qk1-x72b.google.com with SMTP id
 af79cd13be357-8cfc3ca1922so503612585a.1
 for <ltp@lists.linux.it>; Tue, 14 Apr 2026 02:18:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776158331; cv=none;
 d=google.com; s=arc-20240605;
 b=J7qGwUQ5bedhL0oDidrySzGT9RKU/MqJClMFvsohbIQNtLUXWRJo9IHplGEb6xZkqT
 79vO8Ci79lqJWci1jsNkyRO7rnU44vXAC4m7RKua22rmkp71sxmImrQfBULvp04urtxZ
 lqNxQz95vxmVovLH/aMQy+/Qd1emfCAlOb41/Kq/3lF9RyeU7ArdeCtzxXg6sUtRw1xx
 5TpMQsXb8Jp678mWhFLhhjlRUYoyyMXaUAA7GM7UP/OzrFkJkPVLGqrBOHFFOMpzPMHL
 9cbGK5KSOoiRvZUAD0X636Be5Ih/jZC9FkPKfMEQrmNvBk6Gh++d13cfI/RyS45u4Svn
 aHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=79jXtn8j5GoDbWLCxyLcfZHhJ9NIvGFts67JW9kU9nY=;
 fh=Q3HcMqzsMHxLWjwvmRLIQOf1pJe3Pqj7A2dMy5TaL1I=;
 b=SVPnBQ+UvJytdgae8H+mMEvN1pPA1lAHPi8mjK/LiE5nvNsEjnGCqBizSH92DgSyk9
 5euXJCW50ALUCWovehrtUGSopnKRzDfXPLMFDyiXmAVn0cxBW49wNbh+V8+MFIVbSF2T
 uBzzVSWAO27jYY70Oa/4zkms9c9ObGFTQYg4nj2TqKrGSg6Nb1BONtF25I3ZDEkPx0rV
 JJFmos/AK1Hnm3C+/KhXvYoZWNT9I23bAguOiT2hZFzEbfdXZSiYMqnsNO4RFboOHWal
 soShjNBpYDzVy0laYjs0r1j8CX5ll0k1n4EIPMtzMXJiHuurq8SpThiCWNi0hSZSrIUc
 ryTw==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776158331; x=1776763131; darn=lists.linux.it;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=79jXtn8j5GoDbWLCxyLcfZHhJ9NIvGFts67JW9kU9nY=;
 b=iqZxKEh8tbN58pmiCC4QuNFPZtnVWfUdYu3rqgc/RB8rlVBA8wl+SVc55L1vVrXhzw
 u5zQidPlkhMIB/lfwHOHr3VR7zMsYNCx6xrXkZLGDE2HPssPaRd8JKdi4PhYTmeQp+Bz
 39D65O/IGTghp0ZlABFvFYa1dT+yuff5Z5QSyV5kAi5ymodyERpaP/L2hlMRt7oFhACa
 2gFaeBy6OqEPNmrreSbOSSTfb6fG7oj+K1h9+cA9EWguVCTwyFvmBixqxa2QhvtCz9Wm
 75nLlTmIubQ1tyV4kNjgRhZRoustg/bAODZyfQW+6aIEJ/vYK2l8t2UReSoI5pQTrxhR
 RaMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776158331; x=1776763131;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=79jXtn8j5GoDbWLCxyLcfZHhJ9NIvGFts67JW9kU9nY=;
 b=iWdbAbfCiKmucN0gTztb0kOfYZ1c8/D01XkMilTo8bNAYAE84UetPWIYdmH5OVSdyk
 q+3QtrHTpkqzYJAdUfgq5+yYquv0mvlxBs+p2ZmwfFX6/3xTDcvp3P4SYoFpOgUYLS6z
 XL3TcUEmuYshs5OFcbXVP+nzv9P/mZdWSfL7wquvJNRSd07t2uYGMhoUU/EhyNRYZtkV
 hKsNE7u6FBerbSORaNLqI88mFQbQFKvSFrwxKDBCruFvYA2FourZnKOfi3drMHymTuDE
 HLqspJO9fTd3USmuFAp+NOJljlViv5/2vFZ42W130+aIqroi3GkZ2QBtQd4nBcJs3haL
 Peiw==
X-Gm-Message-State: AOJu0Yyb0Vq7MkjZ3A4MFm8WMaqQqqEWLKsXvgGgIKpnpVL8b9qhMoa+
 0bls8NsDkW/1o4DK0TTmK4rPwI9tgddbcLTWj1Rd0NeZ+JOMNxy3bkLEpoQMgW0txs/YkQFVBxE
 +1g1JAtVQuE529zS6sf23VDKMqXKHcA==
X-Gm-Gg: AeBDiesW76sVsrMuKzLn+b7FpkKZUQx9TzxANYaU7bA6N/WsuZsMt0Q2HpWBGlRS6H1
 UIYtBlpGLzlOW+2zrly78VhVT4C5tjXyU+qrVd5FNqciWg9TdQ0iAzKQ4HHBQscKrkUVL5PomRO
 JA9e1EwYnxPqpAxzZCuD9TS8AMqUZOqP67YipYNzoRS+YBHLSyHdIt+Epnqh3Z5cK+rgrJeZquU
 TM8/EXtmsaijQi9YbphZJdUSnjtRIicEiDpbbyEOWtNrY3HHCO3eqFTmwftnh7jo+uYRHv8Jo4F
 shV+7A==
X-Received: by 2002:ad4:576a:0:b0:899:fdeb:6ace with SMTP id
 6a1803df08f44-8ac746551e5mr292662436d6.23.1776158331279; Tue, 14 Apr 2026
 02:18:51 -0700 (PDT)
MIME-Version: 1.0
References: <CANgNiRz+BdnL-yYw3BqcKo+o2tSmPEV-wiaCftxse8rqEA+3fw@mail.gmail.com>
 <69ddfe4a.050a0220.161dad.4224@mx.google.com>
In-Reply-To: <69ddfe4a.050a0220.161dad.4224@mx.google.com>
From: Li Wang <wangli.ahau@gmail.com>
Date: Tue, 14 Apr 2026 17:18:39 +0800
X-Gm-Features: AQROBzC2K11k3htKESZDslxT82R4mZLLBd80ls4kMsfW6NlY2RtUdIy0onFxcOs
Message-ID: <CANgNiRx+m6syogcmXoyCueS1HepMABxLx4m47VOVhgj+kFwuBg@mail.gmail.com>
To: Andrea Cervesato <andrea.cervesato@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] AI review agent
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
Cc: LTP Mailing List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> It's a good idea, feel free to send a PR on https://github.com/acerv/ltp-agent

PR opened: https://github.com/acerv/ltp-agent/pull/2/


-- 
Regards,
Li Wang

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
