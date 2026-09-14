Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A463BC88E5C
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 02:14:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789352050; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=LYsNKEzXjpj4HPqUcyq7dYyU6gR+lRVf6FCaeDrA9Pw=;
 b=IzmQarp5UFeRDhwKSnnMVGd5qGPz+bzmv8DyaV9gEuXpvDBdOd/iupjHIcwHcRB9xr7+3
 5Gvj++3UATavudNozJWAm9IbMAdfzNzWBDCo+OuAvbFDafK8CurVjhJscHogOaMhDKIMLdb
 uEygOwcndRCgxDP2zOvUN5xaUhFrkv8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4F4003E20E9
	for <ltp@archiver.kernel.org>; Mon, 14 Sep 2026 04:14:10 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5236B3CD382
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 04:13:47 +0200 (CEST)
Received: from Atcsqr.andestech.com (atcsqr.andestech.com [220.128.198.184])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5AD9F200927
 for <ltp@lists.linux.it>; Mon, 14 Sep 2026 04:13:40 +0200 (CEST)
Received: from mail.andestech.com (atcpcs54.andestech.com [10.0.1.154])
 by Atcsqr.andestech.com with ESMTPS id 68E2DXOM007487
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 10:13:33 +0800 (+08)
 (envelope-from cyyang772@andestech.com)
Received: from ATCPCS34.andestech.com (10.0.1.134) by atcpcs54.andestech.com
 (10.0.1.154) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.43; Mon, 14 Sep
 2026 10:13:33 +0800
Received: from swlinux02.andestech.com (10.0.15.183) by ATCPCS34.andestech.com
 (10.0.1.134) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Sep
 2026 10:13:33 +0800
Date: Mon, 14 Sep 2026 10:13:27 +0800
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aqdYRyvoyE8X_mM1@swlinux02.andestech.com>
References: <20260908023121.1895897-1-cyyang772@andestech.com>
 <ap_nx7AZvluXzW-i@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ap_nx7AZvluXzW-i@yuki.lan>
User-Agent: Mutt/2.4.1+37 (70449fe) (2026-08-09)
X-Originating-IP: [10.0.15.183]
X-ClientProxiedBy: ATCPCS33.andestech.com (10.0.1.100) To
 ATCPCS34.andestech.com (10.0.1.134)
X-DKIM-Results: atcpcs54.andestech.com; dkim=none;
X-DNSRBL: 
X-MAIL: Atcsqr.andestech.com 68E2DXOM007487
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap21: Check for free space before mapping the
 file
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
From: Victor Cheng-Yen Yang via ltp <ltp@lists.linux.it>
Reply-To: Victor Cheng-Yen Yang <cyyang772@andestech.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Depending on the page size this is either 4MB or 64MB, I would say that
> if you run LTP on a machine with less than 4MB of free space many tests
> would fail.

I agree with you. In our test environment, we did provide mmap21 with
sufficient space. mmap21 was the victim because certain shell test did
not clean up properly and filled up the disk.

> Maybe it would make sense to print a warning from the test library for
> any tests that has needs_tmpdir == 1 and the free space at the test
> temporary directory is less than a few megabytes.

I'll work on this in the near future. Printing warning messages from the
test library is indeed an elegant way. Thanks for your idea!


Best Regards,
Victor

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
