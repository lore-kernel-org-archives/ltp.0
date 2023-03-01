Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2AFAC64ED6
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 13:46:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8A3673CDD55
	for <ltp@archiver.kernel.org>; Wed,  1 Mar 2023 14:46:29 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB6B23CCBA8
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 14:46:18 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5DE95600C38
 for <ltp@lists.linux.it>; Wed,  1 Mar 2023 14:46:18 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 62F3F1FE14;
 Wed,  1 Mar 2023 13:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1677678377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khx2LkYk6K5RWpbD92AKekwG0sMyuOQpbPEP72ewxrs=;
 b=TMknVpTdLkS+9T8Y3BfLmfzx6Kf3aTk5qH+lB1u80qf71q83qprULBTR/JDnCQA6rgugFb
 3nJKmwKMnFH7RPPmsK9iraLWJvOxzAq4BXoNWT2Wzap4txv5AAOln5y2e2s20v2biJcOrb
 L+KBDAQWUJ5V7LLcAwN7BjJBv7KI8iI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1677678377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=khx2LkYk6K5RWpbD92AKekwG0sMyuOQpbPEP72ewxrs=;
 b=Y6tR1KRG8zgW/tJq8zqNIxyeHm12QknbFwc1QYHHq3k57iCDC1IwK+ILVgif6mV1rvksVN
 3yUqOReBfLTB74CA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4B11713A3E;
 Wed,  1 Mar 2023 13:46:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id DeN4ESlX/2NdIAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 01 Mar 2023 13:46:17 +0000
Message-ID: <12a64a2b-a739-a9fb-c584-f0967fc126de@suse.cz>
Date: Wed, 1 Mar 2023 14:46:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Wei Gao <wegao@suse.com>, ltp@lists.linux.it
References: <20230228032254.13992-1-wegao@suse.com>
 <20230228032745.16595-1-wegao@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20230228032745.16595-1-wegao@suse.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] fsconfig03: New test CVE-2022-0185
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 28. 02. 23 4:27, Wei Gao via ltp wrote:
> +	for (size_t i = 0; i < 5000; i++) {
> +		/* use same logic in kernel legacy_parse_param function */
> +		const size_t len = i * (strlen(val) + 2) + (strlen(val) + 1) + 2;
> +
> +		if (!strcmp(tst_device->fs_type, "btrfs") && len <= (size_t)pagesize)
> +			TST_EXP_PASS_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0));
> +		else
> +			TST_EXP_FAIL_SILENT(fsconfig(fd, FSCONFIG_SET_STRING, "\x00", val, 0),
> +					    EINVAL);
> +	}

This special case for Btrfs is wrong. Btrfs is just the last major 
filesystem which does not implement its own fsconfig() handlers in the 
latest kernel release. But on older kernels, the same applies to other 
filesystems as well.

Any other filesystem that still uses legacy_parse_param() and has the 
CVE fix applied will fail this test with exactly 117 error messages on 
x86. That's how many iterations it takes to fill 4KB buffer with the 
test string.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
