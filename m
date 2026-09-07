Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AF9C79F89
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 07:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788766204; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=Xuxf/ZdzpYgMrBQXnLCtjc/b6bDGvv6MXSBXi+b1zfQ=;
 b=D6Or2DvuT4sUN+EzXynY/FFQGYQohNfwt+/4pWuu0lA/afoLnROaSNm28xbThb6DCo9Br
 NYVh0v3N5Bphkp4LJYycGL6CHgH1iiCyne2eA/a1yq6Sybm7ipD8yxyES3RZIsw2pKHS1NN
 /i0GsaKfs6BIk1aumjMwNa8a5qjsmvM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B9B933E5355
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9FEBB3C6135
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 09:29:44 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E4F99600626
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 09:29:43 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-48441a2ba1bso2243279f8f.1
 for <ltp@lists.linux.it>; Mon, 07 Sep 2026 00:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788766183; x=1789370983; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jdjbWAbGQfJQsSHYvyC+UxtadA9VHlbCfN2p02o8qFA=;
 b=CmuBvmV7I2Oobijrd3VHl3Q91auRvpYEiTRYrmN/JJXn7hWQbmBPEOCQDi/5q0uh3J
 k3ajPYLCQsz+iqkYGnfqS8Jr0odsZAEawj2X5v5n6qafXsxbr64KR/bppzf2yJP/mPqe
 TKIcb84JU7JC7DmR0YX9SL0urwDrsyZfBAg4Q2YbYuek9g7obqCwyY6VThWjYZZKZWKH
 Fbh4sxycVs0O1MgvoxPO4OcHHPnUjfVkY6kdS9ptm62LFa+4SABteFmjM0G99ewZKl/m
 qWPjeFXNyDKGUylppo0uIB6R9+36/njaJ28V4A2BxXgTllXwZvO9JDlqUE18UHEBardx
 ycuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788766183; x=1789370983;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jdjbWAbGQfJQsSHYvyC+UxtadA9VHlbCfN2p02o8qFA=;
 b=DBr2epRki4hSV+TaS2MR8YwTZ7QdJ8Lwt1Is4HxffdljfUPKmcCH+SWBZf9wcm7osM
 Wj8F5JTCcNmzvs91pXYDml13jvc55hwsqKjG4z9ayOVbWlrY7OTlHIlntKo2uuMuhHUm
 V/HQyu4qhqieyW/+Jpvc8AOMxNs4lvZh6gAGOf9MqwJxPSXtoWbcPNx4YzdkjPK/M7a8
 XMQFXsJnUMyP99aGm5aXE0dO/0+1G5Ej8HQF87pyeeSaXV1QPBYqMPfkBE0rDb6NWtq0
 RyRxdlloT+7KW5iFyW7MRBULsPAmlgvIBFx70qeyfaZM0RgTriiXV/I9HN9P/Zz2OyBN
 KsMQ==
X-Gm-Message-State: AFuF++kQWOF13ygPbiHPAerBGEw7Ecg6itb9N5Szi0xM5PRDf1Lwsa3n
 qPE61CcBXEwUvFuC8XClo1wJQmInBaQKb6Lby7mXeitHEI0ViErzu7NftKo7W74xxw==
X-Gm-Gg: AYBFou1ukwP/w5zKRDThphSHYqskqqfrczh8sGYevYJZJUd7uqulQplZI/HiTbdNE0f
 gP2B7lMFZfLOPgEEFaMenxuXWrSU3zJ6egujawoEzQVfEdX7AkyJC4jCEcex1XRMSpELYsiHbh8
 +uawaTiWT7KZ7VjpDbAxiKPNxc7JKnkMvUsQ5cbom3BNJrS+JOyfPlinyUjoDljTgss/YDs11YJ
 5G45EuBWW0CPwsoV4hKTJbaLxzlW7pI0G90uvxJmdKPBjvYxImdPE8HmsCPEsihe/3S0P4htxZ2
 TR7UFHOgQC+x1qcFQemZaTb7VRPcIWZkFHcnhC5tlALUb24I0raEFgAHKGLyFE4n78fkkkoeldZ
 eZxjjKOy+B01KkM9PWjRNQto24oj7SYSPbq3MHjan/c3yIUplNbzco7JpU30aABZSTtmKYl4YCt
 atM59F1I8jGeDExBdQJ46X6JitxfoFRVKASbY/P9csjmeS9fxah6r/Ee9fkw7R46ZA5FL8P2uFf
 pF1YJYuyj+Z0FkiaEtAcVqk3S5w49GOXzA/MMV4LdBES/Q2j4bxv8xfxLY/Kg==
X-Received: by 2002:a05:6000:2c11:b0:485:8c16:a349 with SMTP id
 ffacd0b85a97d-4858c16a7e9mr19662749f8f.33.1788766183320; 
 Mon, 07 Sep 2026 00:29:43 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4858e239862sm21398268f8f.9.2026.09.07.00.29.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 00:29:42 -0700 (PDT)
Date: Mon, 7 Sep 2026 07:29:41 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ap5n5QV5xneoAFYm@autotest-wegao.qe.prg2.suse.org>
References: <20260903095255.4925-2-wegao@suse.com>
 <6a9a867b.de81f790.219d91.7092@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a9a867b.de81f790.219d91.7092@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v11 1/2] lib: Extend tst_assert_ulong() with enum
 flags
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

On Fri, Sep 04, 2026 at 08:51:06AM +0000, Andrea Cervesato wrote:
> H Wei,
> 
> I was re-checking the whole patch-set and it looks a bit overengineered
> from my point of view. A few points below.
> 
> > +enum tst_assert_flags {
> > +	TST_ASSERT_SATURATED_INT = 1,
> > +	TST_ASSERT_TRUNC_32BIT   = 2,
> > +};
> 
> Adding new flags for the whole LTP core library trying to fix a single
> test is not a good idea in general. Also, TST_ASSERT_TRUNC_32BIT is
> probably not needed.

But this is follow Cyril's suggestion:
https://lore.kernel.org/ltp/aJm5SBOaRoe1e0PB@yuki.lan/

> 
> > +	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val_64);
> 
> This is the real fix. Read below.
> 
> > +
> > +	if (flags & TST_ASSERT_SATURATED_INT) {
> > +		if (sys_val_64 > (unsigned long long)INT_MAX)
> > +			expected_val = (unsigned long)INT_MAX;
> > +		else
> > +			expected_val = (unsigned long)sys_val_64;
> > +	} else if (flags & TST_ASSERT_TRUNC_32BIT) {
> 
> In 32bit compat mode `unsigned long` becomes 32bit, so we can simply do:
> 
> void tst_assert_ulong(const char *file, const int lineno, const char *path, unsigned long val)
> {
> 	unsigned long long sys_val;
> 
> 	safe_file_scanf(file, lineno, NULL, path, "%llu", &sys_val);
> 
> 	if (val == (unsigned long)sys_val) {
> 		tst_res_(file, lineno, TPASS, "%s = %lu", path, val);
> 		return;
> 	}
> 
> 	tst_res_(file, lineno, TFAIL, "%s != %lu got %lu",
> 		path, val, (unsigned long)sys_val);
> }
> 
> And then, inside the test:
> 
> 	if (tst_is_compat_mode() && info.shmmax == INT_MAX)
> 		tst_res(TPASS, "shmmax clamped to INT_MAX in compat mode");
> 	else
> 		TST_ASSERT_ULONG(PATH_KERN_SHMMAX, info.shmmax);
> 
> 	TST_ASSERT_ULONG(PATH_KERN_SHMMNI, info.shmmni);
> 	TST_ASSERT_ULONG(PATH_KERN_SHMALL, info.shmall);
> 
> 
> Please verify if this is working anyway. We can probably fix the
> whole patch-set with a couple of lines instead of defining
> redundant flags and specific code for a single test.
> 
> Regards,
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
