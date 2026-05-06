Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A675CD3436
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 12:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778071107; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=89mNVb/9MxzfY9oLmcctwnnIF7rT6wKXBrwCDD/vS+o=;
 b=Zz97aEAjdDRLhhco9k8ceHdJKiULE7U68JnihB0XSAYfH5nyvXd570i7w1IbZYvI4BG8P
 0o1xMNRXw+xty3Nm2WPcAjl2aqNy9xMo2OBIvNo6twnse6zk0Spykzh/D0vEPJAhxReDk/J
 sqfovKaP+5LV0LyOl+PNsLIJD0HHtNs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A5B23E6163
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 14:38:27 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9DE313E6157
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:38:05 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20::332])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9702E1A007F0
 for <ltp@lists.linux.it>; Wed,  6 May 2026 14:38:04 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-488ab2db91aso75178695e9.3
 for <ltp@lists.linux.it>; Wed, 06 May 2026 05:38:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778071084; x=1778675884; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=Tg5WMAXgKOdnSSFYxIRq/P/sK+hLP6KNky80AhVi0CM=;
 b=BdnEvGaqt6xB5FdsjMsbu6rrOQWVd1/wWDKERx1UMlB1/ddZ1R8pifiHNJh1typfoq
 rvzkjqzGBJjc8vBFkb9HASF3GaIJ4nuRmIhdg36hLRx+5p+aHiwQ7DE31Qkr2eH/EHrx
 76IgPmCITRuPW27Fk8F3WH+K+FAXG4+tK82b2UUjVfISS/xYbR6nBkuz5xa0ChzMFPqT
 hJ5YxIUcir6SuZFaXZC9Hi66bcjCNj/AGogQuYanLnnxZd3pgSiqj4ISxSof1bRWkyen
 /XU686dYy5xP3oTz+iP0tpYB663+wqnbBLfxrUYKGPApeBa9CQJFdz6mLdbc5ITeBBb6
 VBcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778071084; x=1778675884;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Tg5WMAXgKOdnSSFYxIRq/P/sK+hLP6KNky80AhVi0CM=;
 b=sX3oPBxv8YIcc5LubWQltD9yA7rki7BGX6ZmfqeUSF8zqLtXIJePsJrI6s1KYrjL2u
 hfbXO5QgFExBpxK11TpVQj8krVgMZqIq5sOGuFqSL4KKuS+gK2GPsm9nNtS3O/GtVbdE
 +M6HsIEPjG406fxwvGr7QEP1T4AvRxUm6vKKeWEEdL7h9oEfDs6jqafWbEpYc0zVAMEr
 clj68oNfXPMNph/X0NMN9BhXZgBSA36KsI/MWVf/WgAMnalBeXIwl2oBBsS7ElQLc2/g
 NhQdgSqCji32zRr0QZU9zqELZ2TDm2jA0eMg5912VwNEmUa//+OamgU3KTX2RKr3PGp/
 0+Mw==
X-Gm-Message-State: AOJu0Yyu6/179lut0w7O1hdCyWZNhwxZmvuR5ZfPdauDMuia9Rsxi6HS
 kExmPCV8SV6iIktuqT4ojAG4SZiJXirZa7tAgjEcII4iv8zrH+jjxD/che3ZeDf1M66k0/fVrjv
 6ydouk/SdJg==
X-Gm-Gg: AeBDies3/DBITJxw6Vggaghx+NdG02iRJKEBFDjNj6Q6xYgHRyfGOq8x4IjsXu6MUpQ
 kpo6SXxt85RzGzKEpZv0Qz7/5mHHw9PjoyELxg2d/amfuqH6DHGADQV0BARZ3dw9XboTn14p8sC
 C8397WRKm3ge5WsyFi/o0bfqUaTFRUEOqG9gxKJ4lqZWX2T1rZYXe0qSmm2pQw3/QEAbhBnPASH
 b6jp1Ai/HIqYFb0rpygfe0vHM+1BhJHjkyaKWE//PVKoYOxFzWTzXnYixAmAOa6ec4WBUeyPnf9
 kJDwZLIjH0Qt1GKputRuFIba/2rwC9ZAM9j4PIupWhJjuD7pJ+RHwbXsoXy0zettBDpbttAEjKM
 1qm7IlYgjp8asYVHidygsRRHWFSNdAZYG5qAjCLcjv8sgoWL62H9Mj6iDXm4oTXB35QhVTpqTGP
 OOy/bt1gdRbSo735fmuSzCtvYUsb9UkFfQlGZqxRC+dGi4ctFTz2ZCLgx45FEyqREmntIV5F1Ph
 Yg8ZZLDAu+3lx4S3738sWTzUGnx9Nkwpmri1PUmpVZg+Zk8svNPLcb126sWHlyOr4XtQg+c01gQ
 MaPVlat0kLnR
X-Received: by 2002:a05:600c:3b17:b0:489:e696:836f with SMTP id
 5b1f17b1804b1-48e51e15718mr52469055e9.10.1778071083809; 
 Wed, 06 May 2026 05:38:03 -0700 (PDT)
Received: from p200300ef2f4fc90024894b3dbba3ff7a.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb1a7sm90173365e9.9.2026.05.06.05.38.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 May 2026 05:38:03 -0700 (PDT)
Message-ID: <69fb362b.050a0220.144360.d768@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260505095451.26212-2-piotr.kubaj@intel.com>
Date: Wed, 06 May 2026 12:38:02 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v10] high_freq_hwp_cap_cppc.c: new test
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

> +		SAFE_PREAD(1, fd, &msr_highest_perf, sizeof(msr_highest_perf), MSR_HWP_CAPABILITIES);
> +		SAFE_CLOSE(fd);
> +		fd = -1;

This is not needed because it's done by SAFE_CLOSE() already.

> +		msr_highest_perf &= HIGHEST_PERF_MASK;
> +		tst_res(TDEBUG, "%s: %llu", path, msr_highest_perf);
> +
> +		if (msr_highest_perf != sysfs_highest_perf) {
> +			tst_res(TINFO, "cpu%d: sysfs=%llu MSR=%llu",
> +				i, sysfs_highest_perf, msr_highest_perf);
> +			status = false;

After this we should return, otherwise we keep cycling and next status
value might change again. I would just add here the TFAIL and return at
this point, so status variable goes away.

Unless, we want to track _all_ CPUs and then (at the end) print the
result. In this case, you need an array of int, assiging 1 in case of
error and 0 in case of success.
And the ending check, after the loop, will print the status of all
CPUs.

I'm not a driver expert, but I guess having an ending result printing
all results for all CPUs in case of mismatch is the best choice.

Kind regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
