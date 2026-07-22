Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1AB1C44533
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 07:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784705843; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=EC6KOr3NFfXPV58IUBxnbYhwzpfzeOoGruIqIwAo8C0=;
 b=VeoZIe6Wj+6WQvHYGv/CQmvqZRWMAIYNYptYR5fZ4A2X6T7GsAKaJFNOBvrrlfD701Qy+
 EjcUqGZTnjNkRTUwBlbWO4RTh209d2mRhKsnNDSlUsV8Ssp9lOHpfySTNhg37JOsQJjFp8Z
 d4n++duaiIRnbhn6xqWx0CfDEh1lcAo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 226F03E26B4
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 09:37:23 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEA833E1EB0
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 09:37:02 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6B49F1000411
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 09:37:01 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso44411025e9.0
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 00:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784705821; x=1785310621; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gSL3ApcalK46wskr5Gdlr8JMRtPExaHy20ygHFs1H90=;
 b=KjVHel35Py46Keif4gVO2RRUvEb+mEv8paxCLM/jH8kw/kJ2vjHtqHMghmoCw+j3Qv
 IVwsaCBbxyE4ex5OeBD0aJ8tjBUtZmqRf3aWZRZ6ZwbsKmg0VQjVw04ePwH6+2hqReK+
 rp4qTZRgJCxafgh3yParqQORnKgM0ja5nHVzLLe0IxgfQOnBye0RXaYYcH5e/1/FRp2l
 hAQIYXTBlnv5Et9jMDycMC/aBqI6d4slgKKjrXxrEwtp7ySI3TjrjBREAo+KW2cuaJR6
 Ol86Qvh0lL2ObIw9sQpaljSvkudVaaPzzfVl2tMOEmFTr9L6P5/6p60mPVomi33qogdL
 C+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705821; x=1785310621;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=gSL3ApcalK46wskr5Gdlr8JMRtPExaHy20ygHFs1H90=;
 b=i1PuVMolG4/F4T3V9aIyXCJMKQcjsQDrwrVOOhnZY0Ma3R8yGFEZCZ8+lZYUBPwDf5
 POKxwLrG8B3tDa66qbXgjdqUv0JLgwmKd1YQh1IH09cxdOaRibr1rLWCv03mff67yHvn
 8BH0u1eTOwWfFuoedUvEbpmoXF+pe+BNNxSZQfR9PD8yh3ajWNkPAWnOyxW7VjlBskyo
 tMiQ24FMe0JnkW3EvNefHBgYZTtFE5tAxemXRkDF/Z6pj1/Gg+7TJ5gWVOmwOA9G6U6t
 pFTuBnoq6200rip8DXvEJUWWIRA/nsSz/5tOicX01EQEjwVUkj/TsGn6hZMZOXaSpJFx
 4IqQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrMuNWVhtZ2w2IgXU1EYDJ6ArVJu5jfmFtNbtRO/OF2HcI4XOyB+EY4JYv+UerxgEpHMdM=@lists.linux.it
X-Gm-Message-State: AOJu0YzguP+zcNK253GR3hh5rmAqRS7rUuf1k6+TacQbanuoRSRylRTy
 UHgpPcXyrVx81KG3TB+EB3SvktpeR1/4QZRSjg8CTzxKL23wPq0x6PDeKu1c+6XUHUM=
X-Gm-Gg: AR+sD10ED0+QNi+ZXQkWmNxh9I+8t54Yvm4ecx66EuW0ezarUeLRLT1nIfhoOtCC7Og
 j8uV5MAEbomlur3k9aob+jx/rHShdwqWvbMvogJqDVQ/upfp/L+bcri8EHRBq/f0d+G5yI8vn/c
 b5kgiTcbkeqS1/v1kgAu/PSOTYKdYFgiSSDeQUd7MycU7VuDkStAAsJ8YKixXP9wxweLuPs3jMe
 R5IpDAXWc5Iai9vWogA/fcmsCz3ZD8xgqz9YXEzWRrR5MQyTMSznb/LV3BBraOoKDmN6nuhRB2M
 HW0S/sHgGEnzxi9ETV8xgkbsnSnNeYQ/VqBhpfXF2Ao29ZUluW6eK+Qjhs79Sx207UWzM793Jdc
 hJ1G2ufEe4AjzpaigD34MPYFLsCGBqXpXF03MJF4htvOH9jlwHPlohj7c/2DFrgnp8Lt95LCvi/
 XT1YXYJluyjgW5SmIz4tWJSiHKAA==
X-Received: by 2002:a05:600c:524a:b0:495:5a0e:6d8c with SMTP id
 5b1f17b1804b1-4955a0e6fa1mr167893585e9.27.1784705820721; 
 Wed, 22 Jul 2026 00:37:00 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-495686a8600sm100881845e9.6.2026.07.22.00.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:37:00 -0700 (PDT)
Message-ID: <6a60731c.9e856a68.1de8b6.5ec6@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260721192815.8592-1-linuxtestproject.agent@gmail.com>
Date: Wed, 22 Jul 2026 07:36:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Add test for CVE 2026-53362
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

Hi Martin,

> This high-level description block opens with a plain `/*` instead of
> `/*\`. setsockopt10.c (and the rest of the test suite) uses `/*\` for
> this block, since it gets exported into the RST-based test catalog.
> 
> As written, this stays a regular comment and will not show up in the
> generated documentation. Could this be changed to `/*\`?

This is correct.

> 
> > +	/* Splice input pipe buffer page into socket */
> > +	memset(buf, 0, TEST_MSGSIZE);
> > +	buf[TEST_MSGSIZE - 6] = 1;
> > +	SAFE_WRITE(SAFE_WRITE_ALL, pipefds[1][1], buf, TEST_MSGSIZE);
> > +	splice(pipefds[1][0], NULL, sockfd, NULL, TEST_MSGSIZE, SPLICE_F_MORE);
> > +	tee(pipefds[0][0], pipefds[1][1], PATTERN_SIZE, 0);
> > +	splice(pipefds[1][0], NULL, sockfd, NULL, PATTERN_SIZE, SPLICE_F_MORE);
> 
> The file already includes "lapi/splice.h", which provides
> `SAFE_SPLICE()`. Both splice() calls here use the bare syscall
> instead, so their return value is discarded. If either call fails or
> returns short, the reproduction sequence silently doesn't happen and
> the iteration would just report TPASS without having exercised
> anything. Would SAFE_SPLICE() be preferable here?

mmmh is this the case where splice() is supposed to fail but triggering
the CVE into the kernel? if so, we probably need to add a short comment
so we know that SAFE_SPLICE() is not a good choice.

> 
> > +	for (i = 0; i < PIPE_COUNT; i++) {
> > +		SAFE_CLOSE(pipefds[i][0]);
> > +		SAFE_CLOSE(pipefds[i][1]);
> > +	}
> 
> pipefds[][] (and sockfd, closed a few lines above) are not reset to -1
> after being closed here; only setup() initializes them to -1, once.
> cleanup() decides whether a descriptor needs closing with a `>= 0`
> check.
> 
> Since leak_pipe() runs in a loop (up to 64 times), if SAFE_PIPE() or
> SAFE_SOCKET() at the start of a later iteration fails (pipe(2)/
> socket(2) can fail with EMFILE/ENFILE/ENOMEM) before refreshing a
> given slot, cleanup() would see the stale, already-closed descriptor
> number from the previous iteration as still open and try to close it
> again. Would it make sense to reset the relevant slot to -1 right
> after each close?

Again, I updated the agent but it's still asking for this. Please ignore
it, I will need to update the agent in a proper way. There's probably
some logic flaw in the rules at the moment.

Thanks,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
