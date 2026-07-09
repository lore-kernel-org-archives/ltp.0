Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD4D3C43458
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 10:33:42 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 653CC3E292E
	for <ltp@archiver.kernel.org>; Thu,  9 Jul 2026 12:33:41 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C47363E28CF
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:33:25 +0200 (CEST)
Received: from mail-qk2-x02.google.com (mail-qk2-x02.google.com
 [IPv6:2607:f8b0:4864:34::2])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 68AAB1400DB2
 for <ltp@lists.linux.it>; Thu,  9 Jul 2026 12:33:25 +0200 (CEST)
Received: by mail-qk2-x02.google.com with SMTP id
 af79cd13be357-92e5eef2abaso11545385a.1
 for <ltp@lists.linux.it>; Thu, 09 Jul 2026 03:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783593204; x=1784198004; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=S4XDW6S74ufLVcxqwTouss0BOGfFiBg9nq4AIaguCiw=;
 b=NZSCGGOmYm8KKI9mhthibdZfDp3fzg0eMTROGkPLDg5H3LSxt47tScmSxuHcRWpdrI
 78iHJf8BIL0jrLWpWZn1iijbY+1gQ2Kke5L1VVtwdr9O3j/L5rbwFSDXk06em4GjlA/Q
 e72QsCkHlX2Io47mJy7N8QqdMnHC2m+ODZcYpQWULe9mlSfwwaZwgElnAOZe/fJ1XJEl
 dAQ31b0j0BYAN4bK69eEj+DGTFG0Y3GLuXDNOjmJ1k2lMtGCaYSO175OHAK7sybXsS8r
 u33T7XhenOczE39UTcGLQ9cN8Zz27qQoKeGAdq3RGDMuc/vua2DZEXOY2e+kj6bvP9oq
 KD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783593204; x=1784198004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=S4XDW6S74ufLVcxqwTouss0BOGfFiBg9nq4AIaguCiw=;
 b=RDGnN8Q/HMXeflW8rB5yrfCxf0HUdB3K+bZIsQ0KL5jQXkBJSuq7+6BbGgtA8ifwrU
 2wmw6ICo46nh5eKJXXUu63SnmjWi1G09dweTHdIaJSy3cn9rRLaTKJRrIFW5qOV3MYzX
 PlKAr/hrhj3mcq/V8REuzSWW4VsCkAhzcjaif9qOElRr3nzY/H2cwHXGYq4XbmP2Ag9Z
 u8Kbb5yad5P2zRNpVPJkco8fMRFSbxS0GZEjvtIBMi/h8sageKqcSHwHtOfFDwO+Bmnk
 8qrLg0PELvlNXQV6cAYrDMwyCdMtc0ywrJ2qThbLg3niEDf87IgmBxv0+mKBvYHhTfpm
 BLGQ==
X-Gm-Message-State: AOJu0YygxV9W8hyFertnZ7bnzwfoZLlsNueHBzjit3ilCB6p/+dji8WA
 u/SJmAlE1RgBZl9Ri8J4uMg63eGtES/Ktp51EEMokBCoN9rWHehS99e5
X-Gm-Gg: AfdE7cmRwXqvRPMfhts5/ef8L9mJzqcGLtNXC59bd4PVskVqprfjmPHvRtNZHH24P/U
 kalfE/II4s5KCBO0BdIAQw2X2QKgQokcBLvQBDzUFza50nszel/6u7dyzmj3+fXHgs7Cnrz9TLS
 JT01IFCRzGfOSNDgK8lBika8zVcHTXSSYAnNe37ZyXJkEZL5eYzLSXspTn9vmtqSfhTcdWOQOQK
 4EGMFxqXuo8ipezyWsXY0A/CWs8lnHWIsjRIbIWcWCbQNEO06X9jJD3KEO3zNFVADLyO4EpysfD
 zwbl4fx8E/iJzVRK7EUfOpHSTBe5m7CITEnGQaHj3cHkmyMjrvLYhRwJmO4p03hxXn+VSxhzJUH
 TXUxV/JFu0jRtu5UtH3gsVTHi4THKkAbN0zNq3036BDjk+aJ7PHwcHhW73dVDzMi6QMlNBPeCDp
 zxYnzbyf/h2evjQkAtoEIjm8gCOuVrUZHBaotuNnZmfrBWkXQwIJ2azsancVWSRRagewFhOvYsE
 5NdCkbe9REEDUTtAt2s0zsjipUeKaQ=
X-Received: by 2002:a05:620a:6186:b0:927:59bf:46ca with SMTP id
 af79cd13be357-92ecf5777a1mr667687285a.40.1783593204105; 
 Thu, 09 Jul 2026 03:33:24 -0700 (PDT)
Received: from
 runnervm5mmn9.1joi1osonwlubklurnmqjjibde.cx.internal.cloudapp.net
 ([172.200.183.240]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-92e90cfa470sm1646124385a.44.2026.07.09.03.33.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Jul 2026 03:33:23 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: Runli <mingyu.he@shopee.com>
Date: Thu,  9 Jul 2026 10:33:23 +0000
Message-ID: <20260709103323.3962-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709074923.73372-1-mingyu.he@shopee.com>
References: <20260709074923.73372-1-mingyu.he@shopee.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] pty09: Cap RLIMIT_NOFILE-based slave PTY opens
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Runli,

On Thu, 09 Jul 2026 15:49:23 +0800, Runli wrote:
> pty09: Cap RLIMIT_NOFILE-based slave PTY opens

>  	max_pid_num = limit.rlim_cur - count;
> +	if (max_pid_num > MAX_SLAVE_OPENS)
> +		max_pid_num = MAX_SLAVE_OPENS;
>  
>  	tst_res(TINFO, "Available number of pids: %u", max_pid_num);

After the cap fires, `max_pid_num` holds 4096 -- the test's self-imposed
limit -- but the TINFO label still says "Available number", which implies
the system's available FD count.

On a system where RLIMIT_NOFILE - open_fds is, say, 1048000, the output
would read "Available number of pids: 4096", which could mislead anyone
comparing it against the system limit.

Consider printing the uncapped available count and a separate note when
the cap applies, e.g.:

  tst_res(TINFO, "Available number of pids: %u (capped at %d)",
          max_pid_num, MAX_SLAVE_OPENS);

or split the TINFO into two calls -- one for the real available count
(computed before the cap), one confirming the cap was applied.

Verdict - Needs revision

Pre-existing issues:

1. `count_avail_pid()` and the variable `max_pid_num` both say "pid"
   but the code tracks file-descriptor slots, not PIDs.

2. In run(): `tst_res(TPASS, "pty has been opened %d times", max_pid_num)`
   uses %d for an unsigned int argument.

3. In run(): `int slavefd[max_pid_num]` is a VLA. If max_pid_num == 0
   (all FD slots occupied) the zero-length VLA is undefined behaviour.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
