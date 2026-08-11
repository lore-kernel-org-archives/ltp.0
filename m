Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6116EC5AC67
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 07:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1786434290; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=+3Ko/xZ49Tqj4Y1k7mDNFkmZaJlh84ox5Y0b0hzeDhQ=;
 b=jnQwcmt4xfDULU29PnHzWX+doPd01XoKuOMjEbpdDXwCZVohWcaWF26OJJ4H7jvlOi5Ez
 JZ7qmT0d1wg6DD8VijIe5C4eHft/Mj91OwSQFkW5y3kwCl2EdccLE3wbvbgQSTHgToKU1r8
 eS3ZWUjHkfFpKH1t+YzuDEbEE065hyQ=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 95D6C3D066D
	for <ltp@archiver.kernel.org>; Tue, 11 Aug 2026 09:44:50 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3687E3CBD18
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:44:28 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 784B21000490
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 09:44:28 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so25786855e9.3
 for <ltp@lists.linux.it>; Tue, 11 Aug 2026 00:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1786434268; x=1787039068; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=5m/EwxSMD/iGKZtI1C78PeepX1Ky+dZeguXcmF/Abwg=;
 b=ZVo1HZpH0c5V1O5FwUXNVgYPf6auLdJouhZua+Mw2Gi0LWX5kV7R0DFZhmLgcLb8Z6
 BHzfpQ/AtsARyLVXN02houWeXN6vpPsexXnZQiKILIvKSIZ8t/gai2Givv3dR7kJ9gdg
 dCxkfaliwjPknds1a8AyyjCiBB9mNhaW2HkkTpfwzIrCy+ACyDwJSEz3mS1tSfqMeB1h
 zEbGTQbZVU80It9U9MYvtvVdocaKmTsM+ZGDY0bqcUXIWRsyKmdli6rNfHl9IRkssl74
 udxpS9hZrr8Vn+ZMcmzyCW8xZXi1ENEPszSjRwQjwZDnGLw4VgJWTki5Y0ef1g77r7Fj
 8CHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786434268; x=1787039068;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5m/EwxSMD/iGKZtI1C78PeepX1Ky+dZeguXcmF/Abwg=;
 b=ppRO3uGmImlV9P2kcX/9gU+VHnJL7U3k0vhqATLcuRb7TIHJtgTvR/BZ8IqL3QSljI
 Via6BONuXUK8QAZBhKeEqj7YnHShOPSWfACNXO6ktUGpmIPjDCHIV4cg942l3Wn3SAxM
 Se/grigViwNW3iG+hSdAlhF8UDei90FJsVBMWECEtju3j928oOiBJYdDaOzji8uk2hih
 /IcpS5FRBac57M429gU0IKb0Wimt4oYevwV0+5WbTFlXNgTTU8KWnLJMGmSBRJPB0IcG
 wlAyWSk3Qw2SosobLktUvsijnE5NjANCCtpZlA/mCCahklIS3mMi5K+VptJxXeGiR9ZY
 taIQ==
X-Gm-Message-State: AOJu0Yza7HVAQyliCYAEit0aAr7zcrjmcMbRldwfPVXvGrUbPEsk7ReW
 Ff42Uv8oxidEChBOfjB//2+L225HN5dXg5VEbVl7X8nCdaalPY6JYzPavDbe7h+Lg9T8PTF/h+b
 dCTgY9Ls=
X-Gm-Gg: AR+sD12po2EnJe2ihbU4jEVPIZj/hcV/gWCHiHhFbVwU0ZmH5dMKjPAcaRd9507fF2O
 jozAvHA+5VXaXUw1IeydhqDxldt6QNOBzSE/r/GLXPmQbpu8SyKjp0H09oBvIUcsIySJMo+EWD1
 JA8WeY91xHlrsMOZmFbAjRYulcaAlfMUpwi4bdqi8v3KvY2/o77fPtg8AfvTCvEOvAayuQLehqj
 DCba6aMYT5cNo8TshNfmErcS6D+kPnT3NIJ3XXIZq9NUg+3IUmOUd9zNVlu9w2OTGByzlx2j72M
 jV6+CkoCWB7JpNW2xya6uMqg8xiDJt7GlLbrWJzCIhCJHxbCKUCzcHRheL4zTVKB86nbdiKtt4s
 GciRot6ubozP104gyCzXuKM3pKbj0+syRSvyeA4tfrqNMk7hT/Xx5AK8sMOA34Bb4JNQKs9vsS4
 j4vAu7oCh5N3+DEL/JBEEM2sCpKw4lkYPDhlzlxQkkRfVxGzMNLhVc4+bPUCrBTlCxX0dbcNJVm
 JI=
X-Received: by 2002:a05:600c:6088:b0:496:ca1f:a428 with SMTP id
 5b1f17b1804b1-49978475c11mr24316115e9.19.1786434267825; 
 Tue, 11 Aug 2026 00:44:27 -0700 (PDT)
Received: from 192.168.1.121 ([151.62.122.237])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4814a14ed5esm2007237f8f.0.2026.08.11.00.44.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2026 00:44:27 -0700 (PDT)
Message-ID: <6a7ad2db.a148a86f.110d56.d1c6@mx.google.com>
To: "Wei Gao via ltp" <ltp@lists.linux.it>
In-Reply-To: <anKp5GokntftzFa3@autotest-wegao.qe.prg2.suse.org>
Date: Tue, 11 Aug 2026 07:44:26 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it, linuxtestproject.agent@gmail.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> > > +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> > > +	if (TST_RET == -1) {
> > > +		if (TST_ERR == EOPNOTSUPP)
> > > +			tst_brk(TCONF, "fsconfig(FSCONFIG_SET_PATH) not supported");
> > > +		else
> > > +			tst_brk(TFAIL | TTERRNO, "fsconfig(FSCONFIG_SET_PATH) failed");
> > > +	}
> > 
> > Could this test be gated with .min_kver = "7.2"?
> > 
> > Before Linux 7.2, ext4 declared journal_path as a string parameter, so
> > FSCONFIG_SET_PATH is rejected with EINVAL rather than EOPNOTSUPP. Since
> > fsopen_supported_by_kernel() only gates fsopen at Linux 5.2, those kernels
> > reach the else branch and report TFAIL instead of TCONF.
> If fsconfig parameter is correct, return EINVAL should be an kernel bug.
> Current logic is correct.
> I guess AI mix wtih some old code with new API. But how to fix AI's rule is a
> question.

yeah, agent is wrong.

> > 
> > > +	SAFE_SSCANF(dev2, "/dev/%s", loop_name);
> > > +
> > > +	snprintf(path, sizeof(path), "/sys/block/%s/dev", loop_name);
> > > +	SAFE_FILE_SCANF(path, "%u:%u", &major, &minor);
> > 
> > Could the device number be obtained from stat(dev2).st_rdev instead?

what about this?

> > 
> > tst_find_free_loopdev() also supports /dev/loop/N and /dev/block/loopN.
> > Those paths produce loop/N or block/loopN here, causing the test to read a
> > nonexistent sysfs path and terminate with TBROK.
> > 
> > > +	SAFE_MKFS(dev0, tst_device->fs_type, mkfs_opts_set_journal_dev1, NULL);
> > > +}
> > > +
> > > +static void run(void)
> > > +{
> > > +	...
> > > +	TEST(fsconfig(fd, FSCONFIG_SET_PATH, "journal_path", dev2, 0));
> > 
> > Could each iteration reset dev0 to dev1 or alternate the source and target
> > journal devices?
> > 
> > The first iteration persists dev2 in dev0's superblock. Every subsequent
> > -i iteration requests dev2 again, so it no longer exercises a dynamic
> > journal-device change.

and this?

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
