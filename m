Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFE4C43458
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 11:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1783943333; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=l5Evm3VfZq3dgSbrd/Kv2XU3IGP+814dwIai170U50E=;
 b=AU2+t1DP9stvoUHFDf0nXyaisL/Ho8LBT4bWwLzJOn+D70rogmZkdhPA/xODLqxq5C2aQ
 /2Nej4y6uoy7ANTV3QLAROh7G4/N6Dj/9ItNFu1TG80YWud1WCDRKij0D9yG2qUavZxRbc0
 7oCv1RQ9D4+TBVYxx/VJwza1OK58sQI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EF6CD3E7FA9
	for <ltp@archiver.kernel.org>; Mon, 13 Jul 2026 13:48:52 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C61FD3E295D
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:48:32 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C12C46002ED
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 13:48:31 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-471eeac43bfso2983361f8f.3
 for <ltp@lists.linux.it>; Mon, 13 Jul 2026 04:48:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1783943311; x=1784548111; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Cg52w3afRr91emQM9+ul4egt02iUgVyInd+IkwU18FI=;
 b=KVxJUNCkhNyedgTtBRnNHzzqUm5tY7oms9RzRQviXvpcTV6VkSUDo0UGLPf5VmKQL3
 NSkdCct6ZI+t9kLv8C/LVmsPtLrZPmk0jwET8/HOkTl0oroRu2gbEo69iWbYRzlBNkup
 89hbeHKXwFOsO/yfCXcrlm7+9ySaNxrUOqTTkzbLAdA3uQP5IKOVEJKUtjyori+Sp1vf
 KvrcIldGUDLql3tt3RH3jrqnkNbi1CXbx9W1YZrmrWs7djMDteRDUn1rJhHqtvRQhBbH
 Rpkc5N0eMOAIP22JoUQM94a1URl+Pr1pJ7Dh+CeDM/sfZWNDh0l/WuuO6di7/Xu23p2K
 b3lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783943311; x=1784548111;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Cg52w3afRr91emQM9+ul4egt02iUgVyInd+IkwU18FI=;
 b=nImc3TvvRtNfM5M87kyNk7aX91ln8862aBRACVt2X71bpdLVxAw9cOafmJdMsIElFr
 mXDgbaVzdMB1Ckne1AhPmbj+kkDR5YQwmwZu3qMjfSP7poV7cnBUJCs40Po0e07QP1Od
 dv5o6D51c4avsU6rRNGJFWrqsvwgqqR/3HUkZTlX0vnWvIDcfG6FS8dZpolJu1Xm/YY0
 vRxWstTsOr7sm3Gr7XFua2BRaJI4s8Su6eYTCiz7LQIjJdj0b/m9aDo0EQjHuxmNM/KJ
 Wf8Bnc7yA2QyJumLu33K6s8ka2TNlQivR8GHvf2qhAMk+xYQCdEhgZqY79tOspXEjozu
 yg2A==
X-Forwarded-Encrypted: i=1;
 AHgh+RpoZWxJxXg2KfYUKDbLnERTxxchoOvRYP4vov9z86vqeEjE9Mt5WCCyphTxC6sQm8JCgpY=@lists.linux.it
X-Gm-Message-State: AOJu0YzaCvIpWxA0Mtx1IIve/Haog2we9baNiBSTkvfSrFX/nI5mREUd
 IapjFbe1gbV0LyjMrZfbJWlGhPCRn9weVLKV2eOa1CAJ6HGfzLgX7CSHPbvSC5yJMR8=
X-Gm-Gg: AfdE7ckTgi6GR047dNJY4qzRdkNZDCLfzRB2WvBqk+Iuf+Ijul2B3fpbzumGdSkoXie
 Kmpv1O6YZ1xBdXa4diyew5qDcU3XRS7n5lVbGlnNT7iMGymvKTK6ue3J0DJ1ZurCoB5W05B86o2
 y+tEvPTuY3HACMCXLxIFeCTRd6dkyYdU+qcSM+QQjzy5UxFbrW59KOTo+idQhnr61W3fazjwXS8
 +N1BQCAI4SXSR67EILIT8NVF62sseZD04ZXRXjdncOaJPZFwOlNYkHRfVYTIs3lr5F7TLfId0Vh
 8eSfuWMdQL6xsNIKN9r7EkvXPezOtg/JVGtU08iDmSEePlge3nK4pP5B0J0HnKqnAzjUIqgBnoa
 5EzcmeNoDjZfVoLPaFHoSxzs4gyGfaM26GNOTwboNaliSKvWFiGX7wgPSvzqWjmTp6UsYdwYrfK
 pETHLJWsTMArBpqwczKQloKlYZIgFx9S1i
X-Received: by 2002:a05:6000:2c05:b0:475:f0c2:75a7 with SMTP id
 ffacd0b85a97d-47f2dd08aedmr11336415f8f.56.1783943310976; 
 Mon, 13 Jul 2026 04:48:30 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9e4d6e4csm80057080f8f.10.2026.07.13.04.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:48:30 -0700 (PDT)
Message-ID: <6a54d08e.ebbd881c.1eb8f6.3e6e@mx.google.com>
To: linuxtestproject.agent@gmail.com
In-Reply-To: <20260707163648.4043-1-linuxtestproject.agent@gmail.com>
Date: Mon, 13 Jul 2026 11:48:29 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] power_management: rewrite runpwtests04.sh in C
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

Hi Jinseok,

> 
> open() is a tested subject here -- its return code drives the
> TCONF/TFAIL decision. Bare syscalls that are the subject of the
> test must be wrapped in TEST(), not called directly. The same
> applies to read() and write() below.

This is a false positive.

> 
> > +	ret = read(fd, buf, sizeof(buf));
> > +
> > +	if (ret < 0)
> > +		tst_res(TFAIL | TERRNO, "%s read() failed", path);
> > +	else if (ret == 0)
> > +		tst_res(TFAIL, "%s read() returned 0", path);
> > +	else
> > +		tst_res(TPASS, "%s read() successfully", path);
> 
> read() is the primary subject of this test and must be wrapped in
> TEST() so that TST_RET and TST_ERR are populated.

This is false positive.

> 
> > +	if (tcases[i].is_writable) {
> > +		if (write(fd, "invalid_governor", 16) < 0) {
> 
> Same for write().

This is false poitive.

> 
> > +static struct tst_test test = {
> > +	.cleanup = cleanup,
> > +	.needs_root = 1,
> 
> The doc comment only mentions readability. It does not explain why
> root is required. Ground Rule 4 requires the reason to appear in
> the /*\ ... */ block. Root is needed here for writing to
> current_governor and for the save_restore of that path; please
> document that.
> 
> > + * Verify that selected cpuidle sysfs files are readable.
> 
> The test also verifies that writing an invalid governor name to
> current_governor is rejected with EINVAL. The description should
> cover both aspects.
> 
> Verdict - Needs revision

The rest is correct.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
