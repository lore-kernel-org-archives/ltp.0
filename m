Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D55BC4452D
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 07:26:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784705186; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=/2nOZ4Wx/Jhpgaa4R0mDQmkk4eGylroQMDVctOZ7QSk=;
 b=M7cF3BMLXY5OICfuPokn8Ll9M1dfWQbaG+tt/UUcu/6xXEOH/uPEjCRptZEfmHRLzk4hl
 zgToGq5vGCDgpgsSf33dylc+uPjoS7XkcfNY5ubWUL/m+cFQBdBJq7DNKTi/X/zwq+YvPIo
 DrASb4mJ+kVBxJs/7Jej8umI8WWPxvw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D30613E1F85
	for <ltp@archiver.kernel.org>; Wed, 22 Jul 2026 09:26:26 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 736D83E1BFA
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 09:26:07 +0200 (CEST)
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id B34E7601241
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 09:26:06 +0200 (CEST)
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-47db714766aso3321952f8f.0
 for <ltp@lists.linux.it>; Wed, 22 Jul 2026 00:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784705166; x=1785309966; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Gq9SsnxtbgOOqCcpslfwZ2P+BMf0nwXSRdq67Nc3WaI=;
 b=gHgE/KTpfuSHlXi8rRhpitdN3IZKbCexoJ3iTAy/uCJdlNQCn60DQw01HU4IGn0Isv
 thzvEJiVuC1rDTVjBvsyllhc/fuCx+n0Kw+TSEKRCBZPZP0/ub2p/BBA0E+InzWFswoe
 jEOvCGCpenjgN58mFeQY1pD8/fW57qbXf4IbHtglLakpvIy5hsTkRTQbssvWyLt+GGbx
 vEtKjZVVp5x4N5kjP8UqkHw681aceNSag9fuKJ5ANNxQnKRxt02wiFYm41ufk3yQbY9W
 /OmCQRil61oIHWJCdjfmpT5ghtUrUQRJQS5OtHtzIE0SQ4UIUpYGzOgDkfHYSb9r4sfF
 ILLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784705166; x=1785309966;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Gq9SsnxtbgOOqCcpslfwZ2P+BMf0nwXSRdq67Nc3WaI=;
 b=I4E4UOPeKMXAztIcuOGVZnoRcu02nGeBKW1CnDAY1R/5xQtyRJsCDTl/ta6Wc+gqTD
 EajVx8nuswcd/wE03yZWLQonc8x60iABMq4rXsOKxqgIQ9rMptjDhO7EfHLJw3tFLtY+
 R8r/OEIgFJdbmAA7gHqaDL3lPWKUe/2X4QVfWqQRFVAwJa1cv2el9um2MrcT9F4QqZSI
 pT84c9wVLAoteGHPMJ70uNAy+TmguFoBwbaJrTZm88X2CRm/jZqLX2VGvLTX1o3FqPrC
 M24Qg1lfrGfTmXEkb6UJE5s6L7hEKQxg1wEevqhxTm2rEp45by9SAj6wwGYb8y06Tius
 7rRw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr3jpNAa208XvTlTDgDkAARSYEidTnMSxygj/34Wegc9mcMWu6+bJKV22nZR6M0yiCAsDU=@lists.linux.it
X-Gm-Message-State: AOJu0YxMQb4pABVM64aCCPX6hcbPuAheBB/pTyp3ESKehm1EaNJw6qtj
 oYDnCunfn03dWw7gn5sVtxUVkypUM+tamwEhQlOpye2iYhEkkIKy6xKJo97GcniM4rY=
X-Gm-Gg: AR+sD13EBfw11gdtlQXnwBivnVzH2J0sfT7cYYdVqCkeSSXsHqDRqjwZvFzycp9oWcP
 cnqWSrSq0Jkf4Q9jVMRjqaZ5Qa3R3T4Lr/0oQDFwaDlgOeZrVssf9HJDB38bFDPIuZBRyO2k7Vp
 uYlIpdgB8wfhTG8NFAU/pIhQuvqz2hbQ/aOkoh1pPLDo/JLaI3QOFL7l7JxgLXR+aKfygo6/Sq5
 wNwD87ApPznrVU7+S6A+scQCxcM6QpG2YMou0A2mntD/mLtcsymrV69yq6rCAyVurferZjF+F07
 uBLx8p6hgTvmpZkm5fvsZduJYv2jwIXPNk1i6XuAjC+I/TpW3UEzrMpjITX0nUJGmxHAfDxHUng
 XkXSEwSyV3OA0znMMFM8lMz2usbvmVFUjNolFptB/ywZXkGfWDE4f8PwKRIW/IKPcTsH+aZCy7b
 gSZv0Yc1BPZgUBC4sqAX+Z8rOlJQ==
X-Received: by 2002:a05:6000:986:b0:47f:70f2:ccf6 with SMTP id
 ffacd0b85a97d-47f840a359bmr3708239f8f.6.1784705166067; 
 Wed, 22 Jul 2026 00:26:06 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85c53052sm3451800f8f.18.2026.07.22.00.26.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 00:26:05 -0700 (PDT)
Message-ID: <6a60708d.ba2bb225.b4339.1916@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260722063259.GA821485@pevik>
Date: Wed, 22 Jul 2026 07:26:04 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] checkpatch: relax parenthesis style checks
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
Cc: Linux
 Test Project <ltp@lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

> Hi Andrea, Cyril,
> 
> I found both rules useful (more readable and more consistent code). Can we put
> it back? Over the years you will recognise on the code of single test that it
> was written/modified by several people with a different styles. And that makes
> it less readable.
> 
> * PARENTHESIS_ALIGNMENT check enforces space behind 'while' or 'if'.
> i.e. instead of:
> 	while(tst_fzsync_run_b(&fzsync_pair)) {
> have:
> 	while (tst_fzsync_run_b(&fzsync_pair)) {
> 
> cve-2014-0196.c mixes 'while()' and 'while ()'. Is it that hard to be
> consistent on it?

im not sure that rule is checking for spaces after the statements. that
rule is avoiding stuff like:

	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr,
																						sizeof(struct tst_landlock_ruleset_attr_abi1), 0);

because parenthesis should allign the attributes of the functions. that
is super ugly when functions have really long names. Instead, this would
make much more sense:


	ruleset_fd = SAFE_LANDLOCK_CREATE_RULESET(ruleset_attr,
							     sizeof(struct tst_landlock_ruleset_attr_abi1), 0);

> 
> * OPEN_ENDED_LINE asks for not ending line with '(' or '['.
> i.e. instead of this:
> 	ruleset_fd = TST_EXP_FD_SILENT(
> 								   tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));
> have this:
> 	ruleset_fd = TST_EXP_FD_SILENT(tst_syscall(__NR_landlock_create_ruleset, ruleset_attr,
> 						   sizeof(struct tst_landlock_ruleset_attr_abi1), 0));

you choose the right example, landlock testing suite has been updated to
match this rule and now it has stuff like:

	apply_landlock_fs_layer(ruleset_attr, sizeof(struct tst_landlock_ruleset_attr_abi1),
				path_beneath_attr, MNTPOINT, LANDLOCK_ACCESS_FS_IOCTL_DEV);

instead of

	apply_landlock_fs_layer(
				ruleset_attr,
				sizeof(struct tst_landlock_ruleset_attr_abi1),
				path_beneath_attr,
				MNTPOINT,
				LANDLOCK_ACCESS_FS_IOCTL_DEV
	);

that is more clear what are the functions attributes.

For the second one, maybe it's more like a personal preference, but the
first rule is actually generating a lot of weird code when functions and
attributes have long names, forcing to write long lines without staying
into the 80-100 chars.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
