Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE056C79FAD
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 03:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788924069; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=3DBcdte1KxLuNjnaTDr5BB3iCFYu7NWJedDR3LdoR70=;
 b=K6kV3Y/eHGpDZQS09+NjPQoUllw6a5Um6Qep7dySq2yhtbwsj4qyg18wGPSVfOvp7VDHd
 Q9lnBZZWxY2Pl5/JPg2NaFkyub4UG0RZkVDpZIjDTssG2WONV5VR/Z3NlK/5SCvlu39uaF0
 XHkqnCEFLML+qxcH3MwAcYWj/eaFwfA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9B90A3E94D5
	for <ltp@archiver.kernel.org>; Wed,  9 Sep 2026 05:21:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8D1173C99F4
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 05:20:48 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 388B3201179
 for <ltp@lists.linux.it>; Wed,  9 Sep 2026 05:20:48 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4995b0343c1so74762585e9.3
 for <ltp@lists.linux.it>; Tue, 08 Sep 2026 20:20:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788924047; x=1789528847; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V5Klc3Hrp2odKuK/8h3APzbjtFPbNqr3bUXEMTUzQnY=;
 b=XT5zygwykH95XouWT1BHDp72G4620FDZmrv1QgYY0MRf6/FxGdcWVf4Md/kIZAMIxq
 mbnZ9tEneAVTkR83cupbqdTaSndSxFMFfDicEKSTF2eik4q02JMH45NmQKp3fi6FtJZC
 JQE4tY95LCwVIIfq5h25JkNBhD0r+ZTvw6lcybimF7dG1pY4uJ95Yupf/tF7S1bkSRr/
 aTM+9VnrJLJKW9lbBRHVA9vUy68JDxqGthMdxwMQjQKZcwL5Cak2dmyc4ABjhuBsZH/0
 xaGkI9v/L68LzfopIS38dZS68ZI6GI4hxEK2a6aLAbecYb22wlaqbt8bI6BQgqIBidiC
 rPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788924047; x=1789528847;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V5Klc3Hrp2odKuK/8h3APzbjtFPbNqr3bUXEMTUzQnY=;
 b=AUClaMZ93KIr7eblbDCYFc8RvQtu31gITql5GYK0Y7HHPhzov2ISI4aqO5G+L4WECY
 IBRsrh1WB3E2RYmbTrKTB7qQpORATyOkv/COGsEHNQjpdVMWeiINY0vUuDomA90iRzLo
 U+m9792P2CZKkZ4FNN+VCOLi7IMylL/THVMBDRh3sRn6b6NdLsed3CNYm6Cdp35k2tsR
 grs/l8R41WNeVwzxC7q9tTQcvfMc7tCFGddb1CkRvgc7IgNXEfc6lWq7AthFg3qQETFo
 E5bAfql61g2W4hW1OLc3CMko+bYMVpJYdD8VSCjwuh1XQiJNxC5Gvh7w9R3XfIjUqbAR
 pPrA==
X-Gm-Message-State: AFuF++lNb9OWCD/Z3LizbCymcH54/PTXOv4Fj9ABfq9f3YU1AXrvWqnc
 7nOUDqHTOK1FwHnoKtL2RcRl7whATRXHI+Iibbprz9Lu2c+6fPyd0wUAQtecXdHNHA==
X-Gm-Gg: AYBFou30pkxVTuXcswJxuqHnQxg1wpNNluoLHCCT/7zErVMGaHDPhaKnsMb85brKAgJ
 ZvmUrvmH2PUaxknZ1FDDSQyL8i9jjUm/5GyUefEnOdFgYN8X1kKq4JC0B5Gx/iO73PcnGncktWA
 Iujf7yEyrazmk0O5F3L1Pm/zIXrAJizGswSJXYqiu+Jl4i8CS+xnVV865MSmEPIMN1qLu00B91P
 4iB+VsnLiFv1xwSd2Kd2rpqhDuOBb0V2cJRQAYZ41kTM29iueXiUbO723YKiSjUaAEhVhhPa8Kn
 PcxHkNDT3ci0/W8xuLw1t2GEcQwiEa09fKTptOUgG2XbW8k9o5v/YiByaergy6+M7r5lQVlBwYe
 q4/h8ezgo1XR5nfWq8cSgydgdBYDZyiZDvO/zVnVXBHpzSplmSl8RSyjeG1CZ6b47VNgeNVYwgv
 ptny8EEvWP7LOj3QSW60EF9JRpYJGTggKdwCan0BhAWkUJSdDte0N1kwjZ+l3fPuSQzRx5EJsGX
 ELjiiA7X919p8YS0qaeTp7mgjK0Pdxq6tRsIF3rjgb7r3Zbv7d8iMnpQWaVb9Dx9KS8TtAutaVT
 EzWvNfk=
X-Received: by 2002:a05:600c:3e06:b0:49d:99:1d98 with SMTP id
 5b1f17b1804b1-49d00991db1mr258767105e9.9.1788924047671; 
 Tue, 08 Sep 2026 20:20:47 -0700 (PDT)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49d03543064sm345431195e9.13.2026.09.08.20.20.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 20:20:47 -0700 (PDT)
Date: Wed, 9 Sep 2026 03:20:45 +0000
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <aqDQjTh4Tbk4YRxX@autotest-wegao.qe.prg2.suse.org>
References: <20260813052853.22152-1-wegao@suse.com>
 <6a9abeef.14e24f9c.2590a.fec3@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a9abeef.14e24f9c.2590a.fec3@mx.google.com>
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v13] fsconfig04: Check FSCONFIG_SET_PATH
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

On Fri, Sep 04, 2026 at 12:51:58PM +0000, Andrea Cervesato wrote:
> Hi Wei,
> 
> > +#define MNTPOINT	"mntpoint"
> 
> this is never used

This used in following code:

static struct tst_test test = {
        .test_all = run,
        .setup = setup,
        .cleanup = cleanup,
        .needs_root = 1,
        .needs_device = 1,
        .mntpoint = MNTPOINT, <<<<<<<
> 
> > +#define LOOP_DEV_SIZE 10
> > +#define UUID "d73c9e5e-97e4-4a9c-b17e-75a931b02660"
> > +
> > +static int fd = -1;
> > +static char dev0[PATH_MAX];
> 
> the static dev0 buffer and strcpy() are redundant since tst_device->dev is
> already available
> 
> > +static char dev1[PATH_MAX];
> > +static char dev2[PATH_MAX];
> > +
> > +static char device_option_dev1[PATH_MAX + 16];
> > +static char device_option_dev2[PATH_MAX + 16];
> > +static const char *const mkfs_opts_journal_dev1[] = {"-F", "-J", device_option_dev1, NULL};
> > +static const char *const mkfs_opts_journal_dev2[] = {"-F", "-J", device_option_dev2, NULL};
> > +static const char *const mkfs_opts_set_UUID[] = {"-F", "-U", UUID, "-O", "journal_dev", NULL};
> 
> these static buffers and option arrays can be replaced with a small helper
> function that formats -J device=%s locally, eliminating global mutable
> state and setup() string formatting.
> 
> > +	if (found)
> > +		tst_res(TPASS, "Device found in journal");
> > +	else
> > +		tst_res(TFAIL, "Device not found in journal");
> 
> the manual if/else result reporting can also be simplified with
> TST_EXP_EXPR(found, ...)
> 
> > +
> > +	pclose(tune2fs);
> > +	SAFE_CLOSE(fd);
> 
> SAFE_CLOSE(fd) can be called immediately after FSCONFIG_CMD_CREATE,
> freeing the kernel filesystem context before invoking tune2fs
> 
> --
> Andrea Cervesato
> SUSE QE Automation Engineer Linux
> andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
