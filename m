Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F38F7606A319
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 06:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=TrAItubm;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cxcM7sij
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792650073; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=K40yTYJakcBy18DtnVqmQ9hbodVrTaf+POuJFsSrTew=;
 b=TrAItubmyBjMdylX9stA6maBQQzRh4yvJY5LabYqqOk1TGWJIMkc+P133ZZXxG/QmHimq
 7gUwhvk5V7K29nRUvJ+IYaGsj0DF0zNu1wBtUOnw8IOpr884ahmMU/0GoPR0Jz22993qNrG
 8fwhq8UkKWthaPMkseiTPNih5AG3/Co=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 347BA3CFE46
	for <ltp@archiver.kernel.org>; Thu, 22 Oct 2026 08:21:13 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2C5503CFDCE
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 08:20:53 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D97E02009DF
 for <ltp@lists.linux.it>; Thu, 22 Oct 2026 08:20:52 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4a1b07c3c5fso13079085e9.1
 for <ltp@lists.linux.it>; Wed, 21 Oct 2026 23:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792650052; x=1793254852; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=l/V6gDylsTD5NNC+wNb3joi7fitmY2bjhueVo0WNp/4=;
 b=cxcM7sijZGuxcvJYEeF4UFtj3NpEqcK9TgfC122Y6wHKUPYFeNW7lePtgUwGySVzVX
 k6VgNWoD9yoBmKC8KtflzJqSvywgss50+P8suO7bfsX16HlmKqTT/UkirtUAD+EqgspL
 WaCncgzZJXqBNXyAvqh3yrvlCxTcrLHjbXNrLCZsa5lzyhfW3FBsd5AO0SH9FPTBe1AR
 cVTN8Xf5OxNUoCVuiisiw3jGsqMtyVH1N64sl/3OUSLcrTDF4BZRxRLCC49h8QKD3l13
 So6u2iHx/9VS41IRIbIYq+YK4R6VUxfTHluccjv1odRejtEB7aDYCox1fPpD0/whvtqf
 EADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792650052; x=1793254852;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=l/V6gDylsTD5NNC+wNb3joi7fitmY2bjhueVo0WNp/4=;
 b=FAhG+dA5XR1vATWaXDmNFHFHm+GH1aSGOxQirZV6SNus+AybTcNp4wMEW5yPiFKjMM
 sI/v6hy6mD+dT1fbEa0d4iCxPsTShFjAeZ0YcTyrMGVhLMvFq2NUUT8QHc+gn635iuwh
 Udek1TbxCCc+daEhZ8w1Y/ZDK4lTQHpVqfrUBRY/tHLJAZG5a/59/BElBzxOGug4Skdv
 7ZrO+Exbpw30UxiPnkW1KS8nxvzdCrajBarUG4lpqnAUoGDlvLCW+Fui75/YSDKowfGg
 517cczZH1Z5pfzGk0KRClgXGwMi7cAdO94p/DeESTgsEm+J5BWJoWPhSBnWUyeMtkJPe
 Ljaw==
X-Gm-Message-State: AFq9FYJmjLh+jOQ0v6AXFbOQTz2cUGKSaRch1TH/49XCOjjlyk/v8BLF
 3DMhu05P+H8M0hTC9xN65IW7cQ2S5N3S3xqNMIDmfRgW4mJVF6jmuf7ZkIwFaiC00U68WksIiKB
 qPr0=
X-Gm-Gg: AYBFou1cof0ogicSBS5p0psP0yaYFusWTlay5h3gypVgXtCi7NYEtZGgIoveyEgcsRQ
 THFKiTh1DOjrSvUnz5+JAMhrrJ5Pxeu6NtySsQmCFLoJA0DnHgr3laDXu/GvcjHm+864ZcEXFUj
 ue2BVsljDWXnaONEkdv8AkUAFXqTbfzVn0tp+OnTJyzfLW7eRKadeE/PyO6qGX9qUh9AetIzYBl
 bH4TEZE7Dalmk0mznC3FHMY1DckDbalXmX3lU9p9MQ6kcId2+Ht2EAHVlJ6bBmpF8RS0aJfRsEU
 y+dpWhoa+RRelzjBLoZFmyxGwSYI7SaINTubZhNCT6MUM4K7qYEXZRHfC9YqksLDYfffS6z99I8
 F5SYIwEdc+MUGw7C8kZPeJOGQyMaaBEiizezQ11DYHXXSygiW46RoVdponURVwtXTdx5CgOebAR
 GRE0i4t7ZDKmmZyY+yfLJa8Eu0swEFhu9PFPy96MVNy8R+brv4922GORT7ZLWnx84lCOTZ8Unot
 pl1NEqgPfCKsiyatfH6aFjVCAm/e+CBS96Ae9nR6UW3cIEDZFH4dnvTGUZYJidVgJ3W2exk9Zd6
 ABvvhHSkui2WS3OY3A4W/R2VZt883+AtNaGnQPM/u6Y+/Q6u2jTK/g==
X-Received: by 2002:a05:600c:4685:b0:4a2:a1b:dc6f with SMTP id
 5b1f17b1804b1-4a20a1bdcc7mr6432385e9.4.1792650052271; 
 Wed, 21 Oct 2026 23:20:52 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25835f46sm10183860f8f.38.2026.10.21.23.20.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 23:20:52 -0700 (PDT)
Date: Thu, 22 Oct 2026 06:20:50 +0000
To: ltp@lists.linux.it, Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Message-ID: <atmrQp-ahBUw6x-W@autotest-wegao.qe.prg2.suse.org>
References: <20260929022340.524-1-wegao@suse.com>
 <20260930035332.3360-1-wegao@suse.com>
 <20260930035332.3360-2-wegao@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260930035332.3360-2-wegao@suse.com>
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] memcontrol: Add bind_to_current_cpu()
 helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Sep 30, 2026 at 03:53:14AM +0000, Wei Gao wrote:
> Add bind_to_current_cpu() to memcontrol_common.h to allow memcg tests
> to bind the test process to a single CPU.
> 
> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  .../controllers/memcg/memcontrol_common.h     | 27 +++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/testcases/kernel/controllers/memcg/memcontrol_common.h b/testcases/kernel/controllers/memcg/memcontrol_common.h
> index 495f924a0..0f5021c0d 100644
> --- a/testcases/kernel/controllers/memcg/memcontrol_common.h
> +++ b/testcases/kernel/controllers/memcg/memcontrol_common.h
> @@ -52,4 +52,31 @@ static inline void alloc_anon(const size_t size)
>  	free(buf);
>  }
>  
> +static inline void bind_to_current_cpu(void)
> +{
> +	int cpu = sched_getcpu();
> +	size_t mask_size;
> +	cpu_set_t *mask;
> +
> +	if (cpu < 0)
> +		tst_brk(TBROK | TERRNO, "sched_getcpu() failed");
> +
> +	tst_res(TINFO, "Binding test process to CPU %d", cpu);
> +
> +	mask = CPU_ALLOC(cpu + 1);
> +	if (!mask)
> +		tst_brk(TBROK | TERRNO, "CPU_ALLOC() failed");
> +
> +	mask_size = CPU_ALLOC_SIZE(cpu + 1);
> +	CPU_ZERO_S(mask_size, mask);
> +	CPU_SET_S(cpu, mask_size, mask);
> +
> +	if (sched_setaffinity(0, mask_size, mask) < 0) {
> +		CPU_FREE(mask);
> +		tst_brk(TBROK | TERRNO, "sched_setaffinity() failed");
> +	}
> +
> +	CPU_FREE(mask);
> +}
> +
>  #endif /* MEMCONTROL_COMMON_H__ */
> -- 
> 2.55.0
> 
Hi Michal

Could you help check this patch? I already change to pinning to the
single CPU for all arch.

Thanks
Wei Gao

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
