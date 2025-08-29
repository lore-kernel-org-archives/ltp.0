Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E730CA0FF0
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 20:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1756501192; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=WGJYK7lsda8DdBWr5p7KKs2pumCSAH12JwtFd8TqC2g=;
 b=EfLZ8XghzftK9hn6iUX6wn1NJjfUzHiiNAcupg7K3t/YaC4Dz9qHIRUixP+xtFAxbf77M
 5TgW2lT8yaCcS4gX902sXpThFs+yaR9rDRMwHJ1HwpJJLnQnGhMcGvn3cTLis/NdT0ot11U
 6KvupdzhCpGTxSMZkszuTWgOyQZKNPI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2987A3CBC18
	for <ltp@archiver.kernel.org>; Fri, 29 Aug 2025 22:59:52 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A63373CBC18
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 22:59:31 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 055E6100049E
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 22:59:30 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3b9edf4cf6cso1961892f8f.3
 for <ltp@lists.linux.it>; Fri, 29 Aug 2025 13:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1756501170; x=1757105970; darn=lists.linux.it;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Wl+t6WcmJrmf+7hWKcHkmBKd/kbKXPYB0XohojyeG8c=;
 b=HMeVZYZmrdn2Mo5muelwWZ4MVmIzRoKjd+WJ5jFjNm+nZ3P5LM4CRv67YpGy6pM5ro
 wY1LOufIrMfUPslsOnOmzPW+++gs4hA21s5rmJmO6uqs7HI16kNQfoA0VohSQ9DWQ3+m
 9ZA5ZkqzuWdjePEA+z8Pt0x1tCR5lfk4CueiQGmqVlzLqmP09wB+zMQE3opteA3BRGcS
 8tT6z7MbWd1o0mpkpwcXDo+bCRFY8sO7vjFGE7EZRg7YO4tWsnwXTve7H9s2olHA4NE5
 U1ImlxdMH1tf5J4YhCcbjop1E9ZOeME1bBVkWF7t+qTCMyN3b76Efcht89/wj9vo/gb6
 vyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756501170; x=1757105970;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Wl+t6WcmJrmf+7hWKcHkmBKd/kbKXPYB0XohojyeG8c=;
 b=dSVuu9kkCgPO2JZWyVYd73W4trEAysOZ6PGYfsgotnupWWnGaxtyps5sjdrgav92fO
 KpbOxECvQUhWOVVytpt4BkpHlfRMU8jRona+DxrLxAGl/qlSwen+4ePZVfG8rKir9QRq
 y/HARuiYGux4JeOUty+kCESzK7xtGgbkfQhWCgr+XbQMRedlNML2AM/TseSm93QLkgn5
 kZ3U4GaD9/t0JjfZm5IGxg497uxn2U9qI40/gj8PlSbaZvIKZGWvPJfnLugJpnc4/rEA
 xEuS4YuYbV/EKvZrcGQ3GY+buvT9QMb9W+OxVhNQLFUu1iVBcRLui56/hBjOxVUBYmsW
 3vOQ==
X-Gm-Message-State: AOJu0YzavL2TUJ11tW5Jo1fuwhJgBsWZRpExEQqV9+5sRle03AIempvm
 Zj5qIXjuW3LcLMX8a/uNytW9GJm1T96X4ISdL1yFMFfRFo/XOlHOj4/+7z0YYE3AvCsaF010W3t
 4SweDHwM=
X-Gm-Gg: ASbGncuOfGcEW6tREV5dglk1mNGsrf9zor503SBsZ85dUzcYSGe920o4GYtsVO3Qcof
 2qg3R3aIFTL4cxM8p22OpjJMENA+XZYVmwEEIQ93kUFbl4YBaGZAUypJGmAf7rGEQN3vSXfIltT
 oFFAM1c72aFPUsWNJR29uGfvT0JmoITXHCmOydt7IVGveCE5Jh9uG5PzuDvBdYTa0PPfeCcWGu3
 4mVP10TZ+XFb6lnUnmW2jDoskYIVg+UWy0k7Se+LcAq/PMWiyC0tqWbXdYv7DyUfhKQMdplFMf5
 ag1pCmjT6LdGjfaFRVtJgbenr9dwKG3Ce+jIUpEchAEVm7Q9UiLGgDH1zVPUNavf+NEmjFIHpwY
 sR5Mj+Y91ZA==
X-Google-Smtp-Source: AGHT+IEfS6K7lKEMgSVwIwZWbqzQDH4RZAhAh0v1yRm1SzbUnXJVtazWQPCr9zAprR9cHjq8v0fSaw==
X-Received: by 2002:a05:6000:2c06:b0:3d1:c805:827 with SMTP id
 ffacd0b85a97d-3d1dc5a2113mr11214f8f.5.1756501170324; 
 Fri, 29 Aug 2025 13:59:30 -0700 (PDT)
Received: from localhost ([177.94.120.255]) by smtp.gmail.com with ESMTPSA id
 3f1490d57ef6-e9847dc25c6sm1047689276.27.2025.08.29.13.59.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Aug 2025 13:59:29 -0700 (PDT)
Mime-Version: 1.0
Date: Fri, 29 Aug 2025 17:59:24 -0300
Message-Id: <DCF7P37L0GXM.2SKTK442GUA50@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>,
 =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
X-Mailer: aerc 0.20.1-125-gabe5bb884bbc-dirty
References: <20250828-conversions-lchown-v4-0-60dd9a0145f3@suse.com>
 <20250828-conversions-lchown-v4-2-60dd9a0145f3@suse.com>
 <aLA9ZbNA8erKn7Qh@yuki.lan>
In-Reply-To: <aLA9ZbNA8erKn7Qh@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 2/4] syscalls: lchown01: Convert to new API
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
From: =?utf-8?q?Ricardo_B=2E_Marli=C3=A8re_via_ltp?= <ltp@lists.linux.it>
Reply-To: =?utf-8?b?UmljYXJkbyBCLiBNYXJsacOocmU=?= <rbm@suse.com>
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu Aug 28, 2025 at 8:28 AM -03, Cyril Hrubis wrote:
> Hi!
>> -struct test_case_t {
>> +static struct test_case_t {
>>  	char *desc;
>>  	uid_t user_id;
>>  	gid_t group_id;
>> +} test_cases[] = {
>> +	{ "Change Owner/Group ids", 700, 701 },
>> +	{ "Change Owner id only", 702, 0 },
>> +	{ "Change Owner/Group ids", 703, 701 },
>> +	{ "Change Group id only", 0, 704 },
>> +	{ "Change Group/Group ids", 703, 705 },
>> +	{ "Change none", 0, 0 },
>>  };
>>  
>> -static struct test_case_t test_cases[] = {
>> -	{"Change Owner/Group ids", 700, 701},
>> -	{"Change Owner id only", 702, -1},
>> -	{"Change Owner/Group ids", 703, 701},
>> -	{"Change Group id only", -1, 704},
>> -	{"Change Group/Group ids", 703, 705},
>> -	{"Change none", -1, -1},
>> -	{NULL, 0, 0}
>> -};
>
> This actually changes what the test does. To cite manual page:
>
> "If the owner or group is specified as -1, then that ID is not changed."
>
> The -1 values there were correct, all we need to do in case we have -1
> in there is to lstat() the file before lchonw() and use that value for
> the check.
>
>
>> -	cleanup();
>> -	tst_exit();
>> +	struct test_case_t *tc = &test_cases[i];
>> +	uid_t user_id = tc->user_id;
>> +	gid_t group_id = tc->group_id;
>> +
>> +	tst_res(TINFO, "%s", tc->desc);
>> +	SAFE_LCHOWN(SFILE, user_id, group_id);
>> +	SAFE_LSTAT(SFILE, &stat_buf);
>> +	TST_EXP_EQ_LI(stat_buf.st_uid, user_id);
>> +	TST_EXP_EQ_LI(stat_buf.st_gid, group_id);
>
> So this would look like:
>
> 	uid_t usr_id = tc->user_id;
> 	gid_t grp_id = tc->group_id;
>
> 	SAFE_LSTAT(SFILE, &stat_buf);
>
> 	uid_t cmp_usr_id = usr_id == -1 ? stat_buf.st_uid : usr_id;
> 	uid_t cmp_grp_id = grp_id == -1 ? stat_buf.st_gid : grp_id;
>
> 	SAFE_LCHOWN(SFILE, user_id, group_id);
> 	SAFE_LSTAT(SFILE, &stat_buf);
> 	TST_EXP_EQ_LI(stat_buf.st_uid, cmp_user_id);
> 	TST_EXP_EQ_LI(stat_buf.st_gid, cmp_group_id);
>
> And this is exactly what the code was done before.

Thanks for the explanation!

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
