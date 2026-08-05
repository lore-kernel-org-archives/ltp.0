Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2D60C2A09B
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 03:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785899516; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LKvVcYXup2YU/XBYaWxhPrHVh5c0QVVWyeiH0Nm2pEY=;
 b=advdePty3943Uj8ddzVEZDwu1lZqLXFheW28iMqaSG6iJ9zu/eTs7LnIMBMEZeKIZM3TK
 2Lk2iU3BhPTuK35xOmSxf2XqhNsADnTydQpwOaMUfIQxd4OCsD11RaA9XRGKklSpuCaG2Fm
 Snf8oY9b/uR4TVRHlD9685HkZ5kp65k=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 140B83E94A5
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 05:11:56 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 320513E1460
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 05:11:36 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 489A11A00362
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 05:11:35 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49558ce01afso2810125e9.1
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 20:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785899494; x=1786504294; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/d1AHNvNEkw4vkD0o0uchpAfO6H6tqVuRAimU56gjRw=;
 b=ICGSkiVI1BOOn+GdGyRRmhmt7MyO1c4s/dQMMxrdZ/Fn2Q1VcsG1VbC9w7vx4PqVzL
 aKTJzSRn7oaMWSghEYJNU5wvKthFfEMJ6jKkhq0ZuN+t2qEBMtIlrwaGfTsJJiYyvq31
 3mesWYfAmVP5STLqjJi6wUyyY5DK4RQPMzCqNgxGVxhoswk2uWvzpo44znGuHB4jz37i
 vYrdmplAmcepa6+DM3aCE+pfxU7x/Fl2CL7JBhAhGpw2EpioWSIullMbCJoQQl9wYmuk
 IFYq8kXmUhdPD6jOrol2qc0VotAMOQ/WPkHsLJBnJmq6zLyuJT69Na563CM1VmLKjJOv
 YwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785899494; x=1786504294;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/d1AHNvNEkw4vkD0o0uchpAfO6H6tqVuRAimU56gjRw=;
 b=jxnbr7kmVeknddZtYCMSBGvWjzglZgW7CT9XGu2kuOhpyD6nneg0ithsXWZji9JxJ4
 /00/FCLrqX8tTuxVII1XkGQSrN/zTBJw7MRqrxwgLA1q7U8td4fETBmQmriBXPGypYQm
 vKMNmP7OzfV39b3oB1ehVvUwHOUtRbmXCQuvkoQK1Tjx+PEUK17Tr4Kk4pTFqRQLc7Kd
 cIAmCmPi7NyUP1j1Royb0nwVvide7gZJwqfJ7us+ee+jWnUlrMb8cXu3/2DAGvMx4oZc
 Gf77u1B6ZzEnVSaVBJ8IkG48gdNCRawpMupqAoD2v0KPSRi7ghZx4yrC8Sq9JIv2/TLK
 Sfbw==
X-Gm-Message-State: AOJu0YyXT+fAYadmZP/jyTcsmLKDxNkF2r1ciQbmakUFm4VNjicH8iRz
 0++UtAe6wjk3CVo7ciO0yg1s/bK/Pt+R8/SwMA2+E2nzwELZcXUWlpE223q9nuL8ag==
X-Gm-Gg: AR+sD134eS/2pcjlzM39/gBs6XBikrLO/zaQLGG7bpMoOfu9S8PMS2EFDl3JGBRqfuy
 xfhdX9N9pfmrTHmy8fVMXTbeyTyPOrE1Owy5F2ztbiISAsjKAinO62+Xq/zeR3uUPaYbGubm8fz
 2n3pYobC0ooya0q8Nd5SY50SlbaeyvfGd3SgWUOTMluH36V84bI9C1JFe0rAxRdsfhl6ldbZzBh
 6GmH0Y8JtUxOWs+PDz8BqM39PWlpWpEH2i4RLtU0Pjwb9HPdEPANFa3hmaE+cPKumKDfMj/Q2jU
 /vwlxbiMu76C2RzAyyoZC8CN70AVp+svZybL1TgtQB8bUfU1ggetHGyIciEhaZH1oe09+ZY2VMu
 PSFjGz3uPBnDQoylXYzv+s/6J/mKXvLQ1meN1xEHP73wz8Oh8HcaoGgju+xqFtMBqAU1URRm+fQ
 OQ1NSGOuomJS1FDm66CNX1F94UPkAbcO3g1l5RvwYuCWnUrMOvFv88+2wy6m2YcXJuP3+jPwD0L
 8RSLg==
X-Received: by 2002:a05:600c:d5:b0:493:cfe8:5b36 with SMTP id
 5b1f17b1804b1-4994e7457c6mr26000275e9.8.1785899494512; 
 Tue, 04 Aug 2026 20:11:34 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fcb0c5sm124707985e9.4.2026.08.04.20.11.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 20:11:34 -0700 (PDT)
Date: Wed, 5 Aug 2026 03:11:32 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <anKp5GokntftzFa3@autotest-wegao.qe.prg2.suse.org>
References: <20260804010439.15195-1-wegao@suse.com>
 <20260804041751.8871-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260804041751.8871-1-linuxtestproject.agent@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] fsconfig04: Check FSCONFIG_SET_PATH
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

On Tue, Aug 04, 2026 at 04:17:51AM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On Aug 4, 2026, Wei Gao wrote:
> > fsconfig04: Check FSCONFIG_SET_PATH
> 
> > +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> > +	if (TST_RET == -1) {
> > +		if (TST_ERR == EOPNOTSUPP)
> > +			tst_brk(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
> > +		else
> > +			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
> > +	}
> 
> Could this test be gated with .min_kver = "7.2"?
> 
> Before Linux 7.2, ext4 declared journal_path as a string parameter, so
> FSCONFIG_SET_PATH is rejected with EINVAL rather than EOPNOTSUPP. Since
> fsopen_supported_by_kernel() only gates fsopen at Linux 5.2, those kernels
> reach the else branch and report TFAIL instead of TCONF.
If fsconfig parameter is correct, return EINVAL should be an kernel bug.
Current logic is correct.
I guess AI mix wtih some old code with new API. But how to fix AI's rule is a
question.
> 
> > +	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
> > +
> > +	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
> > +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
> 
> Could the device number be obtained from stat(dev2).st_rdev instead?
> 
> tst_find_free_loopdev() also supports /dev/loop/N and /dev/block/loopN.
> Those paths produce loop/N or block/loopN here, causing the test to read a
> nonexistent sysfs path and terminate with TBROK.
> 
> > +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> > +}
> > +
> > +static void run(void)
> > +{
> > +	...
> > +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> 
> Could each iteration reset dev0 to dev1 or alternate the source and target
> journal devices?
> 
> The first iteration persists dev2 in dev0's superblock. Every subsequent
> -i iteration requests dev2 again, so it no longer exercises a dynamic
> journal-device change.
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

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
