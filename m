Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44F48D6D229
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 13:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1766065897; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=ACyCPrGRfZGHdFxJlhaL3sJ2INEyZOpcx+BWZKr2nfw=;
 b=U0njuR9ADXDqevl4dsxcMDYaF709KloiVeZVvwCRFQq77lnaBJ6/3P8CmjxY066M6FNNA
 KExa8CyOHNoyJ928WnKfff2gc9VbsrtV9wT2zWDu6r4uxe+sAs96y4/9R0oIvYkuEcwgacM
 lNmUZryBhvRDc7WOK6VC+5HKP7Q4NMo=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DFB873CFD2B
	for <ltp@archiver.kernel.org>; Thu, 18 Dec 2025 14:51:37 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 292423CBEC7
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:51:15 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id AD0F9200AF5
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 14:51:10 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso5298945e9.2
 for <ltp@lists.linux.it>; Thu, 18 Dec 2025 05:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1766065870; x=1766670670; darn=lists.linux.it;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JcFrMBhCZV7jcfP5rIA7r+dtWAn2LPs/cjQVZfeS/SM=;
 b=bOppzEaigrjO9bmiywP6UzDQX1eoACzWNbqpCcEUzlAo2G4jxChBaUVv9D8VlxUQM1
 5ETFn1hHeQyDP5lUB63XbCqglmHjRRDH5o8JCljYbfwqs6UYg041o5HFGog3+SHPdISV
 8pKBNWK4Qp84e0Lapeitw0/fp6OFqiwV9076vR/UcdKbYgd74OhbyxYT2xvRpq4VUDTb
 TaV8IX9CnGA3ypSJwwq+CF79jBA5AUK/KXIOmS3eqMmOjVBZ4mUk4Tx9TWoJfO6rx+d2
 D4Z3f0jGD4IZ3yDGxk96TRIia+x+kL7fzyxVXK3GJZCvajOnPtvraQLGlVf/XC9EA82Z
 9nuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766065870; x=1766670670;
 h=in-reply-to:references:from:subject:to:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JcFrMBhCZV7jcfP5rIA7r+dtWAn2LPs/cjQVZfeS/SM=;
 b=xEGE5uOgFf3rF1gsZEwSw1+jPS9C9hJxKpdgATvIhKOIUOs8Cgcsk5lDO0HYJIP0xF
 QMjxhnq4wozIJVTA3wQdNRtVGuM7FMh1UAYDfP//ZUxzLHuqOA1owh7WF6GluflZqkpz
 lOKSTmLxh+yylc/ihY2iuVMrO5pMt6BWoA4cz82+iTZv4wHM+nkZ7sq4RcL9rgfSkGOF
 gx3HUIQHhfxTMlgTBy98cq4XGazMUF+cWiaMgKSmDNo2DYEuN3UBlTfEvi+etVqM3TuL
 IMN9I098b8o5oQTBbRmO0/uVeLS3Ss0zu50HQ4DyXowGndL2JHfnpZHqOoaSd9PSHuPm
 vdLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6m+fisddbQMXYM9ex1sQw8QfWNdPTBj4/w4HqZ7JUuMu/TjhWfGAC7x466jgc9riSXWE=@lists.linux.it
X-Gm-Message-State: AOJu0YxMsFqutvRznQ7BlCufFWBRRsHmAoczWKEmV9o+XrTrlrbOSN01
 WUEhxRbRj4tK+aUcS3j+0n8ztH4gVVHghl2lipmHkFZPthLXkCiFEQDqakxX8NdllAQ=
X-Gm-Gg: AY/fxX5oJ95mUw6CQDuPgm/9PP0TaXtnCjeQgdp6HlHZA3o9x0obrCNCP77yXoK/y49
 dgzzxWgiEnRSG+T86oy5fRiCzsu0XdMRHDS2EAB8a9+/PLVRRP98u/VwkKTSuPftWfa180cK7m4
 cc5OHqW+jHnPFPtx8Q8ovnmDahwyZ7mi8pL5yfFC5+kVgJh5V0GWPPfBRQ6XcyIWm7T1Ul2bnvS
 3iWbJh1QNm8g+cMZkiJCm04G2+oXi11GXEw4DEkKzV9tDWeWlIGL/EM+4Z7NjiXdG2aB24jhKyy
 jgmYgT8msvGY12HYE+kUjW9kPjOUnorwCsoTh0VuIkDkHMnBikAPkwpm4LRcBfZs/53/Md5NzRS
 12kgW5LyCu2QMKZjmrg4l1F6HMjHENKD6qvCMkgYS2wkOQ864VDHBdIrPZ2V0lYwiSb751C8Vcy
 VjDaG66mqB6rf5kFg=
X-Google-Smtp-Source: AGHT+IHObDEeE0WFYu9fdKvRpUWNjrSphHUKICiPVqMK3EQVIVtiJqwSX9nuy+IymoF/R8uzoEgsIQ==
X-Received: by 2002:a05:600c:3f08:b0:477:9c73:2680 with SMTP id
 5b1f17b1804b1-47bdd99afdcmr53557405e9.23.1766065869959; 
 Thu, 18 Dec 2025 05:51:09 -0800 (PST)
Received: from localhost ([153.19.102.214]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47be3aa99a3sm13832525e9.12.2025.12.18.05.51.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Dec 2025 05:51:09 -0800 (PST)
Mime-Version: 1.0
Date: Thu, 18 Dec 2025 14:51:08 +0100
Message-Id: <DF1E3NQXVKFA.7KDKO769A2NQ@suse.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.com>, "Wei Gao"
 <wegao@suse.com>, <ltp@lists.linux.it>
X-Mailer: aerc 0.18.2
References: <20251101012320.24972-1-wegao@suse.com>
 <20251113015242.799-1-wegao@suse.com> <20251113015242.799-4-wegao@suse.com>
 <DF1E2E0JRGSY.3LQ2W7TCBWDLU@suse.com>
In-Reply-To: <DF1E2E0JRGSY.3LQ2W7TCBWDLU@suse.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/3] ci: Add e2fsprogs package for CI test
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

Please ignore the following message, I missed the patch-series while
doing `git am`.

On Thu Dec 18, 2025 at 2:49 PM CET, Andrea Cervesato wrote:
> Hi!
>
> The commit message talks about tune2fs/dumpe2fs, but I couldn't find
> tests using them.
>
> Am I missing something?


-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
