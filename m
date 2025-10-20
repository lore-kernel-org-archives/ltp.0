Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A7CCCD195
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 01:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1760924489; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=8ifEhtYI/LjFaRKQz5nHFNNPC1cPrTnAWodTA2SJLjc=;
 b=ghrcGaOhHu5uBa7yyW8cr7R57JcuKbu+S1AGCTo/YpRp7QCcPsFZisV6bn59LAdVlyMUY
 eKUdf2sCEaZ3XNTA0bHoNMjs8QcHgJ4ZivbSzJQG3295vXVVTW6kccf6ZBqBkMpfQpBjUJ/
 ZIzWRB7lfDykTFmxS0UCVZA6zI2g1cM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E40DC3CEF0C
	for <ltp@archiver.kernel.org>; Mon, 20 Oct 2025 03:41:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48B703C9B2B
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 03:41:07 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6CE0A14004E9
 for <ltp@lists.linux.it>; Mon, 20 Oct 2025 03:41:06 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46b303f755aso39291125e9.1
 for <ltp@lists.linux.it>; Sun, 19 Oct 2025 18:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1760924466; x=1761529266; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ww1j7QE4cT7XlZptZYDkxH5tPrs5RC49gtGQuscueWw=;
 b=INveQlKJfsWRi6p99zIqnChoYznmezmyi2vgb/OunKzG+FyUST52mjLcLrsGXd9E2A
 u2Q+AYuRyyVnJ/E4Pe1dd6cwiinrjkv1tYWaLj0PMyPtEQFrvqv1XqZno85bzKmMJacA
 FOi2sdd58Vvzr2DE9LCN4MPXrgzwKQjm9ANltAYs5c3jpMiBLNhJ0NcCAzaXRWyKkeyu
 DARvwov8//4DspyE2ixKcsl14CyN36UMwoa91itUlHFjDw80qhPzYM9ypXkrT+LV2jwV
 yXrLzVdCEfe1uWR4KyIaIDV+yyeT4ziVRv7JVH1phmdx2qeLmDMYZGtZnLPbwOWHbI8g
 CBwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760924466; x=1761529266;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ww1j7QE4cT7XlZptZYDkxH5tPrs5RC49gtGQuscueWw=;
 b=WN4foJ1i6frnb5oMYlrVhaHpdWBeaQciTq4q/l0ZDEfc9lCfGc9kOKByChdpyTzzVd
 6IHmE26cP4zQC7aIb3ExZ7kwaBxgkTOSPobjO8N5SLr/nc6iwDKo7a6uYOK1zfiyoaeQ
 9z3+IFZthe5jKdg+M3RrrWcAfWAe+ZP7FdaEJ4LnxTLIfyur6N57in4tIYBAiAb97iDv
 3qN7FZGusy4K6Jloa59R+yGQIWawWFUwY7M4Z7gNkHFhM31MPgzCYsEAPI2w/n1zYmsb
 vjBw+Imt5VdepKZvsRlk1leusYzKBFHQ99BUVZAFioyauiI2YHEDScsaXO/E2gak3UjJ
 62/Q==
X-Gm-Message-State: AOJu0YxaNv63HiDMrT/+KWs3TVqVxlVhvqYUNxkACcFOK9Iz5jx9aUl3
 TzmUhYSnyay7oC9OeDsuFg17IwP+3D0KE8Aq9qWi33wiuxuVCStlGDwPa1220fhj32B81t1Qozp
 7SjI=
X-Gm-Gg: ASbGnct91RktEsqTwT1XghYXMfbCneHmy1CGi+ndUTeoNSnJN8wxLwguE3gBPPaIhC/
 SKWYVrKWeODnaXIy8ly3Oiv84B/3RbMhdg4jHDflZG67zwX1PY2VwnGrFbqy02wekSeP2KSuhdg
 HnFJGtflc5qcm8gyAQ6to3+lk85Dc9M5yfDuzAwPLLs+3IFO3RJjZzBjprDPzxl+FgYSsAVrXH5
 aeklYXBALvxfnO5XzOZrsvQ6Z7zzSVuvMVXEnHynCvCrS1UX8E6D+2Zjbk6+dqn1qeqgShFQDY+
 eEKBpECYqDhO3+6fXG1Af0ogWd3UH3pRRJy6Td7V44jDtYich0PksuE1J2Yey+ftPhrXshTMTiK
 yuOadttlPRYdmcWtyRW1zJvjuvECj27SOdBCX2A5LS5+R/b6mQJZox9d2dK2jurSunbZUbP+IFW
 s=
X-Google-Smtp-Source: AGHT+IFLAnOiDS18QZg1+UWD7++PJ55pAkQil8IgphgQa2yY5hf5u0nmN7Md7mZe6UhuDI299B0wjQ==
X-Received: by 2002:a05:600d:416b:b0:46e:1f92:49aa with SMTP id
 5b1f17b1804b1-4711787c0b3mr84437405e9.15.1760924465701; 
 Sun, 19 Oct 2025 18:41:05 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-427f00b97f8sm12550091f8f.36.2025.10.19.18.41.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Oct 2025 18:41:05 -0700 (PDT)
Date: Mon, 20 Oct 2025 01:41:04 +0000
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aPWTMFrZ1DDBsD8g@localhost>
References: <20251010064745.31361-1-wegao@suse.com>
 <20251017101011.3811-1-wegao@suse.com>
 <20251017101011.3811-4-wegao@suse.com>
 <20251017154135.GD339521@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251017154135.GD339521@pevik>
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] tst_run_shell.c: Add new function handle
 new needs_cmds
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Oct 17, 2025 at 05:41:35PM +0200, Petr Vorel wrote:
> Hi Wei,
> 
> >  testcases/lib/tst_run_shell.c | 61 ++++++++++++++++++++++++++++++++++-
> >  1 file changed, 60 insertions(+), 1 deletion(-)
> 
> Also here, any change you would add a test for a new feature (as a separate
> commit in e.g. testcases/lib/tests/shell_loader_cmd.sh).
Will added in separate commit in next patch.
> 
> Kind regards,
> Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
