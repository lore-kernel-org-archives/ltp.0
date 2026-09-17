Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78C8AC982CC
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 01:42:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789609344; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LcyVXv1uoNJFS9qiLj/IgcW+Ba515h46MHV47gZXCGY=;
 b=J97+RHwJiFwpAECZzr9G+0F81iwixZjm9wqcjmmJxa61ayEodmufMHcEV3JSzl3ZwAxn6
 fbEtej3CSZqTpo3kCP9+anb0XdiGv4u+z3zeevamz+N8b6ee7uRtI6SogwDVYeJuelspWXA
 fBEgx5B5sTN5DpA3leYNsWpxcOkRjH8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4514B3E97F3
	for <ltp@archiver.kernel.org>; Thu, 17 Sep 2026 03:42:24 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 169CE3C26DC
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 03:42:03 +0200 (CEST)
Received: from mail-wr2-x10.google.com (mail-wr2-x10.google.com
 [IPv6:2a00:1450:4864:30::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7A54E1A00251
 for <ltp@lists.linux.it>; Thu, 17 Sep 2026 03:42:02 +0200 (CEST)
Received: by mail-wr2-x10.google.com with SMTP id
 ffacd0b85a97d-482f6356256so76182f8f.1
 for <ltp@lists.linux.it>; Wed, 16 Sep 2026 18:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789609322; x=1790214122; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=39qj6wp8ZpB4RGUBll1Zt43w/Kh2NsW9a8zW5WhfgH4=;
 b=CoxpIIg0G8rcC78WIbq23yjWfsAABGdmYtUYvokpAjk58+NlXWwaOYyLgOXthd3ykE
 vspFUbsrLNMO/EJujT1lynD7mq+0xwcGeuq9zuXJCkOAtE2U2OJVFoPIp4yfKfQBvP2P
 yGB1WRzoNN8hIL17eduV1LZnb/oPLtR6IdEGbYrQIbEdI3PcV/S8Cowr3URCFFWlIDpr
 w8F2g6C02TjHZJfdiJhJO9hs6qXL8ybuDAunrSODPAqH3oT9GUNDjOdwRzDc3kD4XQgg
 PR0AidMqQXZtdnWKaVLTYqfA9/bodk/aQ7sUoUBrOZQHBb7OQepYPSI3fJCjwsOp9nF1
 cQBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789609322; x=1790214122;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=39qj6wp8ZpB4RGUBll1Zt43w/Kh2NsW9a8zW5WhfgH4=;
 b=ODz6wfmPj6N9ZmdZSURU9Stav2LCUe6qUzgFOSk03kP7ZeYwbSBKWK50JURwNwtHHi
 nKmRJSUADuOoMYUCG+Oc8Hd3lRVERz1I+tmZ+kg12Z2XUNGKeapp4qsB7X4N4wSjiAuP
 kj4eP7JZWSfA3SlH4riupxHG3T9mpgX5YHFqhf7sid1o/1Rem880pB6zq32mMQ0yujnM
 rYS0S7CM+/Hl2opqQC3OwJeFpAgVD2X6rZ6FueaZeezzPo1we2B7dekMsLK/2R3t6VTu
 V+XBFcNn3OdcLHcX3uXZG8GkZbh535rjAKI0aPiKpR18O7vmJ01Po2RazkjOSY5ahC8E
 2qZA==
X-Gm-Message-State: AFuF++lp4IgiMQrrCUo3uOu6IoMsxO9km9VSCd8qbDpf50NK/u5vtJux
 ZColD+SLHeTQsrn4PmgsyZqNJ/Fu19zP8iwrDHeGyMyeTQoej/SEnYw3u22DXLjMAA==
X-Gm-Gg: AYBFou1EHoBPNEEE46qJY8JpnBIQE6IUOOkParin1STExW65P6GkVxE++09Wtf4x2bs
 c2S9SBPKNGg2z72mWno49LcxILyxlJRRViLw9zEcMlBhgXH5mYyK8Q4USNXO/Fr0dTrly+Q6IiB
 O4dUSXqgsfhw89DkIqyl0pOTb8S0l0nheUcvs6Zn5FpLhI05pfhhq2/6PWcRghuI89aGgcJL1nd
 hC5AxRxUT2lZNO+3UyFIJIXpwBnzXQqtpCVAGGmEsZ4f4qFaXfXc970nBJI6V7mzHikTDwXK3R+
 lU0nZc2OcL9pBNQCqeuoeYkHsSMKVc+uuZ+vt9RIThC1qy7Yyj7AZ8DSxEsrIr6Wx1sRFv5XAtj
 cofwpYBHbjSE0PJ5G8e2cYrl77HC/JE4ttyB0DgHp3RpLEmw3ZdI0++OGVov1Q+C+dqycahd05W
 D9w1g0uPgsU+WWABBURHV9HrKd68YdYyWP4H5ymVtA+ALUds2yQR6QIBrNeBOoM44Iza3IdKwRU
 eFr/saP9GS+GEhsAMkbuglWVwzFIoOE6u3RbhotC6VSUxGysn/nHgtEeQta04Ed/ru5LjCy
X-Received: by 2002:a05:600c:1992:b0:49b:8f5e:51fb with SMTP id
 5b1f17b1804b1-49fbd1af43dmr20447975e9.3.1789609321679; 
 Wed, 16 Sep 2026 18:42:01 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd776e1dsm14003285e9.1.2026.09.16.18.42.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 18:42:01 -0700 (PDT)
Date: Thu, 17 Sep 2026 01:41:59 +0000
To: linuxtestproject.agent@gmail.com
Message-ID: <aqtFZxLAFU9x92ve@autotest-wegao.qe.prg2.suse.org>
References: <20260916072826.19834-1-wegao@suse.com>
 <20260916132835.15528-1-linuxtestproject.agent@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260916132835.15528-1-linuxtestproject.agent@gmail.com>
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

On Wed, Sep 16, 2026 at 01:28:35PM +0000, linuxtestproject.agent@gmail.com wrote:
> Hi Wei,
> 
> On Wed Sep 16 07:28:13 2026 +0000, Wei Gao wrote:
> > fsconfig04: Check FSCONFIG_SET_PATH
> 
> > +static struct tst_test test = {
> > +	.test_all = run,
> > +	.setup = setup,
> > +	.cleanup = cleanup,
> > +	.needs_root = 1,
> > +	.needs_device = 1,
> > +	.needs_cmds = (struct tst_cmd []) {
> > +		{.cmd = "tune2fs"},
> > +		{}
> > +	},
> > +	.filesystems = (struct tst_fs []) {
> > +		{.type = "ext3"},
> > +		{.type = "ext4"},
> > +		{}
> > +	},
> > +};
> 
> The test creates backing files "dev1_file" and "dev2_file" in setup(), but
> .needs_tmpdir = 1 is missing. Set .needs_tmpdir = 1 so these files are created
> in a temporary directory and cleaned up properly.
> 
> Verdict - Needs revision
.needs_tmpdir = 1 isn't required here because setting .needs_device = 1 already 
creates the temporary directory automatically in the LTP framework.
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
