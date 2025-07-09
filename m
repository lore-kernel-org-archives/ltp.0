Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78A3BC8303C
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 03:26:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752031577; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=uLUQ0Brb5hDMlRRq1vwDnMJkRE7pwsRx79fLBKxsEl4=;
 b=jFrhkIDfWGGkWJZ3tPm22v3+BzLnz7hAP5Q9ul5Xa22c//1qT4s4yuUlC8vamT0k1auwq
 iKgNw/X4dMmFKCu+t6AWRUf1ASsF3H3ZLwjFeBDho0ZYlc8yfBTvAleAFm0fizc3nAu3UeA
 QEl5tyOSagvEE2NmWV/prputQdlBVnI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DF4FC3CA5E4
	for <ltp@archiver.kernel.org>; Wed,  9 Jul 2025 05:26:17 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D211F3C627B
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 05:25:56 +0200 (CEST)
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com
 [IPv6:2a00:1450:4864:20::42f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 035C11400DFD
 for <ltp@lists.linux.it>; Wed,  9 Jul 2025 05:25:55 +0200 (CEST)
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3a510432236so3329443f8f.0
 for <ltp@lists.linux.it>; Tue, 08 Jul 2025 20:25:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752031555; x=1752636355; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=o/OaxmyVzarGgKRre60kTK6gK5oZytKOvQUEgcKw10E=;
 b=Vm8k5nGH2ncdUxpkJI28I7D/AyANoZ/R4CHhCdNwiBaow4w5esM9J0Vch9TU9AT3a1
 G7kK3ZlCnfogipy52PwQCB35PQRVL2WWw/ztoUN3ew1K+xPDkhV6ERQGkOa7XhcWHrUR
 zZuQkB48yT3vB4QfqGRuJ5QF4sPnOsI/qUf1pnktpuC+b/L/z3ftHkBxL04S2JFV/51j
 g8ibPOAUUGYvh2R+5zgEDqwd8CA+RPl9b9R6eoscn6x9aITYeaNoA+0vK0K5M6V4Uwf+
 jUlpWF+k9uWh6m5ugUzOUixKzvy8SbPPtzRZ0kIp7OTZkfM6BTHYF8qqTvqhjPgajkLn
 ruoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752031555; x=1752636355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o/OaxmyVzarGgKRre60kTK6gK5oZytKOvQUEgcKw10E=;
 b=D7w20gPy5Brcnh5l924u8mgBnG73XayRixu26X3s2xpEt3oGq1GHsGJU5OstY7gSll
 ZenY1S3Ar7R5zF9qBuMzUZkTjSbI2Rl5hWe4oSAPFDtoZMQNqNw5gmlqP2M7PUrVoQBm
 hKo47iK2B2hQrUhNCrzd0mhbq7CHmuuKivQt0amhWxcBSZDy6MANEsxpnKs4tCMpY0oR
 hjFGiX1npWhmTsTT4MYMtCWx3Z21Xf/YFJaq5HRP2KYpGuwyr2H42wr1YZGJNQmq31bY
 ZOcQSkN9vpB8qqNIUV2ROnPEsONQvjd9OdtNaLDXeGPyCc7/I8/Dq/2Ot6h/yz36GGgQ
 kb1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUoVMihI/5ohLpY0WV3MaBVMx4yXFBTmKjp9dKwgYrmxVOaNHsxEFXlvBsZuq8frnbvDEg=@lists.linux.it
X-Gm-Message-State: AOJu0Yy86UPbF63I6S9UJIjmTziKi2YSIXkNwTXS6YBLa5bUL6kdvsan
 S92NcYwQ2W6qGXMBSFRTpyTfN+83jpuiVD5IOoaj/EWhM4MV7V4iG2YvIJJzkFQcrA==
X-Gm-Gg: ASbGncuqntduhfdEmyKiYzQzwCZAiukSEEzNdHFlNVufQmMqTgCJyR+tCa6CqfIZF1l
 z1FXdA9p5OdorypaCxzd2uZ10nRrgRAiWZZZOscuvIgLrp9LXM6KUhC2ddM5clb0zlm9eDwEy5+
 GS7wtUGBz93TuvONtmJi3rhewvPr3KVfLvd8MqAuPq3z93svdDNlni2w0ycuxXyP1O6Oa8OO5yy
 uTFHsC+yCRWux+Clt7rE9zr6VJrCKTB6IIX06/RYjc37wkPT/CNM47E7tkvRppdhWJBPIpAnNVa
 FcG9E0LuT+6MVy3Y10+pOiEelhBLiNVXq9GRLWmUL2Hrv4PVFp7STMR8xKiWHA==
X-Google-Smtp-Source: AGHT+IELahsA+TXt/WlfRHwvimNebavZ+QcwkkbyB7wc8V/BsJG1E2KYnuVbsaaftsNPGr1j8OY9xQ==
X-Received: by 2002:a5d:64ee:0:b0:3a4:efc0:c90b with SMTP id
 ffacd0b85a97d-3b5e4509a5amr383551f8f.15.1752031555379; 
 Tue, 08 Jul 2025 20:25:55 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23dc3090346sm74979735ad.168.2025.07.08.20.25.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Jul 2025 20:25:54 -0700 (PDT)
Date: Wed, 9 Jul 2025 11:25:16 -0400
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aG6J3NWjIWD2mqLt@MiWiFi-CR6608-srv>
References: <20250703-xattr_bug_repr-v2-1-154e9afe2463@suse.com>
 <aGwjGgbvy4Ik2Sy5@MiWiFi-CR6608-srv> <aGuXdYP1fkikZzgN@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aGuXdYP1fkikZzgN@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] Add listxattr04 reproducer
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

On Mon, Jul 07, 2025 at 11:46:29AM +0200, Cyril Hrubis wrote:
> Hi!
> > > +		tst_res(TFAIL, "listxattr() failed to read attributes length: ERANGE");
> > > +		return;
> > Why ERANGE is Checked Separately?
> > Such as tst_res(TFAIL | TERRNO, "listxattr() error") will also report
> > errno.
> 
> Because with ERANGE we reproduced the bug and return TFAIL while with
> any other errno we report TBROK.
> 
> > > +	}
> > > +
> > > +	tst_res(TPASS, "listxattr() correctly read attributes length");
> > > +}
> > > +
> > > +static void run(void)
> > > +{
> > > +	int size;
> > > +
> > > +	size = listxattr(TEST_FILE, NULL, 0);
> > > +	if (size == -1)
> > > +		tst_brk(TBROK | TERRNO, "listxattr() error");
> > > +
> > > +	verify_xattr(size);
> > > +}
> > > +
> > > +static int selinux_enabled(void)
> > > +{
> > > +	uint32_t lsm_num;
> > > +	uint64_t ids[32];
> > > +	uint32_t page_size;
> > > +	int available = 0;
> > > +
> > > +	page_size = SAFE_SYSCONF(_SC_PAGESIZE);
> > > +
> > > +	lsm_num = lsm_list_modules(ids, &page_size, 0);
> > > +	if (!lsm_num)
> > > +		return 0;
> > > +
> > > +	for (uint32_t i = 0; i < lsm_num; i++) {
> > > +		if (ids[i] == LSM_ID_SELINUX) {
> > > +			available = 1;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	return available;
> > > +}
> > > +
> > > +static void setup(void)
> > > +{
> > > +	int res;
> > > +
> > > +	if (!selinux_enabled())
> > Mabye we can use is_selinux_enabled instead of self build function?
> 
> That mean that we have to compile the test again one more library. I
> would rather add tst_selinux_enabled() into the test library. We already
> have tst_selinux_enforcing() there anyways. That should be as easy as
> reading another file in /sys/fs/selinux/.
Got it. Also agree with using an easy way to check selinux status.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
