Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF1AC624D4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 07:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788420157; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=4EXlp7rneXWFCQgCdLpf5YVAj0pe+N935BzrPCLs6Is=;
 b=kOA5Z2hfagpqAvYEZX4GDt/IVnWA4cO70EsWu1zZ+a8rKVxP0FFK3kVlLT2fyWk9MrPhF
 ZrKYYnCH+RjtBrtO7jETlkV7DriahILQMUaRel3bxnmGYixh4qac/JPRpzxk1++R/PYzPYh
 iKx0+WCdvA9GXrcjP13siVPB2TlssLg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 65BA53E97D4
	for <ltp@archiver.kernel.org>; Thu,  3 Sep 2026 09:22:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 677653E97DE
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:22:12 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id ABD086006E2
 for <ltp@lists.linux.it>; Thu,  3 Sep 2026 09:22:11 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-49b0eab380eso6798955e9.0
 for <ltp@lists.linux.it>; Thu, 03 Sep 2026 00:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788420131; x=1789024931; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RDRuFk40qsTniqGzTes4sJyDUYQ7KVUoePHq5oKAHR4=;
 b=V3LCtpjw6hkN2kQb8qtMykjx9cnsxUwuEJ0814zcZk8yB04mHMlvqlmRfHBDaehR55
 nOWa+IFrElVvQzlXUs2oQc8FuHSlGxWkwd3z27ABFaCUO4YEUslbiJwMOhyV89mxDSjP
 35GZETqQSfXvGyyGqnIZPTi3XLK78hftL4rON9L8qERomfWQZQCm6WyS1eJPd2Sj7R/a
 q7znr2DrMqi41QpDTYdvGVOFQX1W1CVGK1duNd8E/gthbJ4I6EX8puRmN2zUrKgrx62N
 kD4uUPhEVybZIkRFZtq5FKd4V8zchu2QiCrpJL9UTyjsB4X1vwEXwh/gTxd88aU4PU1D
 h/qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788420131; x=1789024931;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=RDRuFk40qsTniqGzTes4sJyDUYQ7KVUoePHq5oKAHR4=;
 b=WIf3ZTF5r5obc2o93oHXYiwv0Ie/ovNbJuCUfz6lxx/e4R9wY3nAhRejI444wKGJgI
 mrEfrCRpIoIi4LDGRAPYhAniDFfA7Ic6qzgtrX2GlqqUM2DKp1G6e59c1lz9n2mubyhG
 GC8yFG6okRMrWK+Kb3EfLACWSL71/wzCG7XUrU1u/KHRv/e6trYlGrjEVghT5HlpXKOV
 wHwCUqkPVlxS3sGqXwuND2BwS9mwTFCb2jr7jjrLynoxAQyeJg0VDU9ZZowUg1qbZrdP
 bs2y68hUR54a9Xq07OMuLGDuJHpfb73Ei9gMfGor+OTTM7F4EUfhv1RBqKv3o6AlqJEj
 YoKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBywDmh0P/Qh/5+E6zjK20KHY7x553D+aVnattGGbHVo54iUqnAXawdiwiNQhlCRZCj90N8=@lists.linux.it
X-Gm-Message-State: AFuF++k37rdKNDRkg+a+qApcLOUi/vB9MOgKDpsdj0s0evurqDgulf2v
 2YVOkTUo4RCqUZFlxTi479LC5rCozA4+tM+iIouiiydGU3rJr6DXAqhZmexE8v6JGDpjG3rUerE
 s5nFUQt5f/E68
X-Gm-Gg: AYBFou2TlWmxCw1p6b0TGbjQiKRhHmiRfiTblg7/3xecZvWSb9W9in46rfO3NFgsXWt
 +JtwyX82nQIkzOcY4PIKt1X98R3LRsr1t4lEY1KC6RvlDk3+oQV+CzOGoQZRs2wYAfoI9HAIMB+
 cG7nIenAix1lyy/9YtQ15/GNbXPZdhu2H+OqpntC+YQM9vnP5Cpiw/0HYrbjm8JXLkRboJAalHY
 W91vjOuW9oLEUxqkUBiuJBn6q2W6qo+eTdNjHpKxtlqJ+AF6OZ3rsyKEiyuPX+w1kvGi1AJn7jX
 h3yB0biiItTtheePRHfbyNAORLcD6DPaU5eGPp3lmNUeM4h/PcWRTsMF6OEk1sPQjEV+K2+/oAh
 t4fj/+c2DLF8cKudQvBXIK1TTt+39ktLTkoBWeDh9/I/wQlXLQ0Kzz3EnlaQFnr3oiFUx500c/g
 8ow6o94we8F7o+GvupH79OLnefVXED+8X1cbJJICgLDhc4MjCqjuDxXE6+gw0M0hRWlC5m+aE+3
 IIKgCZMwiyA
X-Received: by 2002:a05:600c:46c6:b0:49c:799a:177b with SMTP id
 5b1f17b1804b1-49cf1576df1mr16734815e9.2.1788420130332; 
 Thu, 03 Sep 2026 00:22:10 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5dec54sm58161315e9.12.2026.09.03.00.22.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2026 00:22:10 -0700 (PDT)
Message-ID: <6a992022.1f1211b9.2158ca.51d3@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260902174400.9226-1-linuxtestproject.agent@gmail.com>
Date: Thu, 03 Sep 2026 07:22:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] coredump01: New core_pattern specifiers test
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

> Hi Andrea,
> 
> On September 2, 2026, Andrea Cervesato wrote:
> > coredump01: New core_pattern specifiers test
> 
> > 	if (tst_get_path(HELPER, helper_path, sizeof(helper_path)))
> > 		tst_brk(TCONF, "'%s' not found in $PATH", HELPER);
> 
> `tst_get_path()` can return a relative path such as
> `./coredump01_helper`, but a piped core_pattern helper is resolved from
> the root directory. Canonicalize `helper_path` to an absolute path before
> writing it to core_pattern, otherwise the helper may not start and the
> test reports a false failure.
> 
> Verdict - Needs revision
> 
> ---
> Note:
> 
> The agent can sometimes produce false positives although often its
> findings are genuine. If you find issues with the review, please
> comment this email or ignore the suggestions.
> 
> Regards,
> LTP AI Reviewer
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

This is valid. I sent a new version

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
