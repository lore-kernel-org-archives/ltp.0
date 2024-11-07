Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E72D5AE5A
	for <ltp@archiver.kernel.org>; Thu,  7 Nov 2024 04:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1730953287; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=ddF0Rh3WV3s0pGSdcIKtk8AhE/Lzn4ENsrW+FYkuq1E=;
 b=DdziMLkDGhCnAFHV002uUEXWrQXtF6XXkldmNQ3hwCQey0r3kuTlThYEP7TOqjRM7iTKb
 7XBGf70fdpjlYAaUF1EUbiSQ6mGO8FgAooYtsadEzF1b88GVwb0jzP59tyuL1XTlLl+hAzt
 qOnjT/Dw1+1DSbCp9RSHORhyEEM2hio=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CFE353D3E5A
	for <ltp@archiver.kernel.org>; Thu,  7 Nov 2024 05:21:27 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9074A3C0571
 for <ltp@lists.linux.it>; Thu,  7 Nov 2024 05:21:07 +0100 (CET)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 3B7BE209E3D
 for <ltp@lists.linux.it>; Thu,  7 Nov 2024 05:21:05 +0100 (CET)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-37d63a79bb6so317375f8f.0
 for <ltp@lists.linux.it>; Wed, 06 Nov 2024 20:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1730953264; x=1731558064; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uGWe2EipTYKQ92hKnd3RC18yuqjJauPuF1KOrls5zew=;
 b=fOxLRsSui/dKAEmhWBQ5wt3NzJIuMtAJn7nxspqC+VDO6YHPS6qcM6k+wf+M1DdDS+
 fT1l1KM9rx0GXftVIQJ6dOYR+efZmAFJtZ+I3RUGFH1DUqKmj3tjOvGhfl3zUyWuhiLH
 GxLiQG8QwNgjKWmh6IYZneGygRoWQlFA5wnIt3X2qAJkMEx6XmWmU8vkfB6j7QwuXiY2
 tXhYLYIfkD/QPQmeacpsPfhkUangWmyRox0qVJUeVmlcS5UjTA2kb9C0TNSKLac5eQ1/
 dEvSNdnddZ4DmgirXUvfayysk3De4beJolEI0Z41pGyeRu9hlJB0OrfllxVZpoaV/Ioh
 8QaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730953264; x=1731558064;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uGWe2EipTYKQ92hKnd3RC18yuqjJauPuF1KOrls5zew=;
 b=Jtr+Q7KcwUwvQgg0DJ2ftYZd35a1S+RCUur2uIY/H90Uw7NDkAViDHLMMxIM398Uhy
 UTJOQ+qRlHRzL8thM3Fzsi9Ew5mcKhUeBdXykX71hX2ygTzUV8D8wizE1gdxiTtkM+jW
 rrIicCCQn3gNLNlhLUhMNRKunCvmg4bSOqmuV3IiM8/miwCBsxPivPB6G3FibMKsLf/r
 LeSq8foPH9msw+nF/J2jNID2YYvLeHQ/6Ow9DcH5W6msa8P/XIsnq+pXKyVmgDRIdYrB
 akQAtBud6V9wBbLYisilTCy0tRUR7pUqmj/4pJ0yJbcqbkXBosQoIztqXyBupQQecoHp
 gPWw==
X-Gm-Message-State: AOJu0YwNEzD/MROAlOwRPsPnpixggz5BJvZx9CWI6+HPUfKwydtZ9C1B
 rle1AnEBcLDrqXORaEeEPk18QpF4Zna30V+auHswZXJHAvDp7ffYWAkg+fkZrQ==
X-Google-Smtp-Source: AGHT+IFc906G+yJf5ATxzvggP/FUQPHAPY43V9UUg+rQ/VKjErNoJ/rZ0mxxvD+33JQoZjjXRyugIg==
X-Received: by 2002:a05:6000:471c:b0:37e:f8a1:596e with SMTP id
 ffacd0b85a97d-381edac9b18mr504110f8f.11.1730953264591; 
 Wed, 06 Nov 2024 20:21:04 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a62bfb6sm2448555a91.43.2024.11.06.20.21.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2024 20:21:04 -0800 (PST)
Date: Wed, 6 Nov 2024 23:20:59 -0500
To: Petr Vorel <pvorel@suse.cz>, Cyril Hrubis <chrubis@suse.cz>
Message-ID: <ZyxAK7qa4GgYcrE7@wegao>
References: <20240926061936.21499-1-wegao@suse.com>
 <20240930135809.9300-1-wegao@suse.com>
 <20241105114427.GB1576432@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241105114427.GB1576432@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] cpuset02: Reimplementing the test6 of
 cpuset_memory_testset.sh as a separate C testcase
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

On Tue, Nov 05, 2024 at 12:44:27PM +0100, Petr Vorel wrote:
> Hi Wei,
> 
> This fails to build.
> https://github.com/pevik/ltp/actions/runs/11628250882
> 
> Kind regards,
> Petr

Hi Cyril / Petr

I have a question before my next patch.

The old cpuset_memory_testset.sh test is focus ONLY on cgroupv1 test, 
it setup cgroupv1 mnt point on /dev/cpuset, even on cgroupv2 support system.

If i add needs_cgroup_ver = TST_CG_V1 on current v4 patch, this test will be
skipped on system which support cgroupv2, since current cgroup framework will 
detect cgroupv2 mount point and skip test.

If i do not add needs_cgroup_ver = TST_CG_V1 then error will happen since cgroupv2
does not support cpuset.sched_load_balance anymore.

Finally i have to add new flag such as force_cgroup_ver = TST_CG_V1, so the test
case can continue create cgroupv1 mnt point to continue cgroupv1 test regardless 
detect cgroupv2 or not. What's your suggestion? Thanks.

Regards
Gao Wei

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
