Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 234AAC5DF82
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 07:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787212366; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=6KpUAH8iHhXPKR/95wJvVHYNeJ2KU6buSmJRSn9Sc2I=;
 b=UGZz6IvOq/K6sHOSNkYgxbnfVA8+sKg1lbeH6lZq9tiYI9d0M6w8F/jJmM7rrI9qNWpFY
 LYJyvTqCyZHSvi/brTzuU+tLjJz52sXBKdYZDmVemsMCZXcWkmulDRD7Ud1g9zkAUu2EF+E
 EiJCUg8jt+apB9WGGksi6oM5f61zwLo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B56163CEE75
	for <ltp@archiver.kernel.org>; Thu, 20 Aug 2026 09:52:46 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C7823CDBEC
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:52:26 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id AEE21600040
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 09:52:25 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4953de5be0aso15959475e9.0
 for <ltp@lists.linux.it>; Thu, 20 Aug 2026 00:52:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787212345; x=1787817145; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=maT8Q7f/gFpn7mLj/IpD7GYrFPpaE9tXyQNMe6CqB2o=;
 b=Tx1aUnswzi5EwsBwqdv8Z4U9G9uT9Q/04/xgTBc4HBwnYfogBkl+eH6rpadpl0gvRl
 7G4ciGT0EG+Kzsu14Rlel/uZihac3FvavJ2VpEAYnqmPKQ7DoPvWB/UXSEhU0v/QAY75
 JN4CZKkQ/MFjrxiz9//A9rq7Z2ZSgU0NJtNgOX4p09lIGBAfmSzH03aBodyG0eSTEeb4
 zSZ5cz/6eekwp6UmCDVaYPeTCpNmyrs9/G2atXffCuWG8nroh8SdWQOq+02VWZ0+WVCP
 gQ3cWU45oxxnPGlQrerc7Ag+ZKtt2hkXi7ozmJTAnUZm9Bl78X/n9qjeddhMydl+Rron
 T3iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787212345; x=1787817145;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=maT8Q7f/gFpn7mLj/IpD7GYrFPpaE9tXyQNMe6CqB2o=;
 b=nA3Rk+2Dq6+xp+dydIQJO7xJCjv7amFbzqWDi5vkpmzgJlV+c6GnhrwsifK7ZZoNO+
 NsY7SGN1X5N6V8Eo3u/yEKctWrxQja+uOuFYph1RQsakhXx2e9lITEIYrykc518ux8QH
 GPsnrg/hsSF44VkDupVMbpFqNOn/vnHewkZ0ODeijefvi6LZtJYTW7CmP02EJCVL9sDG
 vlkh/LqcZl+KwLEzX1/cq7wNVmmY/276Usc4LJRpoLOYTrNbkXozDESYpVhk7ngMIcdL
 jLqcVxHzZWsnkJRTisgGYH9nDXoN5sWXBZvO2/pKX9sONnanXrtGkdQR/nhLR3ww7b0u
 IKKg==
X-Gm-Message-State: AOJu0Yya7UD7fFRNRRc94s82luEnEHlvQ95ZtCNUIam5dmUeNyP4V9II
 mC+u/s2fABaNNpN7SqpctIU8e/uHFD/iLzreueRUl1xH6tHwZn+DNjevIa1kKrz5aslANQ/nmsF
 43xXQ97c=
X-Gm-Gg: AR+sD11qQeLNmqawvkDxok6+5S30zo7XmQLD5TXQ6dNhnhF9jCnk468y4FCy6CxFViX
 wFEv6be5ubgh9vfY3mR1Vi0CaPf5yyCt7YAq5Qi5NMYHFe6EKZATTB/44VEy6sikaivVEpE/Fu1
 3Ua3VVDClfqPkS9mCBKByTAotm8fjJT8UempNnN10iu5TGiC1nml9tzsyF+pabsVWFSA3O4/Inl
 MDnF2FvX5AAYMmD679ehvNOztN998dqJ2vvbPPEDJJIKjvW9PE0C01kMrXo6VLfbDqKVKn2mvwL
 uvRR+JFiB+/jfVeeiIrEl/6GCIKnBAp8QOf9n0lRS6Iei/ektw5Imx5VtUx0LBLGwpzLrwedFNl
 26Pb4Ibrs1ObhKILpTxK9RLbrdziq5LN1UBaGCPldkcTxYyTmBMwuNIWPPa2RfYwAMbohj5X5zM
 RxwL5mhNz3mA1paPtM1V2pnt7pO+toRdssrIrcfBQLvzQUioG/PdXLMUKTBSZ1mgprQXlk3I4=
X-Received: by 2002:a05:600c:1385:b0:495:5890:8f6c with SMTP id
 5b1f17b1804b1-499aa17dcd0mr155766195e9.7.1787212345042; 
 Thu, 20 Aug 2026 00:52:25 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11fd3asm114936995e9.8.2026.08.20.00.52.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 00:52:24 -0700 (PDT)
Message-ID: <6a86b238.80d8f3ad.1c3765.93d3@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260814063537.GE261864@pevik>
Date: Thu, 20 Aug 2026 07:52:23 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/4] tree: Use TST_EXP_PASS_OR_FAIL() and
 TST_EXP_FD_OR_FAIL()
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

> Therefore I suggest to merge with changes below (removed O_TRUNC and move fd =
> to the beginning).
> 
> > Kind regards,
> > Petr
> 
> +++ testcases/kernel/syscalls/landlock/landlock_tester.h
> @@ -254,13 +254,13 @@ static void _test_truncate(const int exp_err)
>  	tst_res(TINFO, "Test truncating file");
>  
>  	TST_EXP_PASS_OR_FAIL(truncate(FILE_TRUNCATE, 10), exp_err);
> -	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
> +	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY, PERM_MODE), exp_err);
>  	if (fd != -1) {
>  		TST_EXP_PASS_OR_FAIL(ftruncate(fd, 10), exp_err);
>  		SAFE_CLOSE(fd);
>  	}
>  
> -	TST_EXP_FD_OR_FAIL(fd = open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
> +	fd = TST_EXP_FD_OR_FAIL(open(FILE_TRUNCATE, O_WRONLY | O_TRUNC, PERM_MODE), exp_err);
>  	if (fd != -1)
>  		SAFE_CLOSE(TST_RET);
>  }

+1

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
