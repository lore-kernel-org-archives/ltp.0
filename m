Return-Path: <SRS0=//k7=OH=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1306C433EF
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 11:16:49 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45EA960EE9
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 11:16:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 45EA960EE9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 52DDC3C8840
	for <ltp@archiver.kernel.org>; Fri, 17 Sep 2021 13:16:47 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 307573C1B0A
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 13:16:38 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 724D41A00F25
 for <ltp@lists.linux.it>; Fri, 17 Sep 2021 13:16:38 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AFA0A20274;
 Fri, 17 Sep 2021 11:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631877397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrucSyRNV+iSRIWXvYS4We+plHhQlXfFlzMWWLD/cVc=;
 b=aZBufhiykmFpUNRnDp01cRh2h0YxooLWtYtIvM2JtAUQ9DggVxS4DBQYAkuC78aRbBq2+4
 cYhrSOq+Fcw0cZWanmZFMV6WCD7F5c8YHS9X2RC8UDvUH0fKvZIptaGW7FG+rsmiZI/o9K
 YltUuaF/dv9A5v9jXtsuVrVhCtpSq9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631877397;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JrucSyRNV+iSRIWXvYS4We+plHhQlXfFlzMWWLD/cVc=;
 b=bQTAqY7JWqZzIqOS5JEEkvckCkFCyfQYhxihJRRpFtsvhBsxOptBLFFLYcScRfDFlGY6jz
 PBmAGpHZeGv7XfBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6ED1414063;
 Fri, 17 Sep 2021 11:16:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 3CsZGRV5RGF4HQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 17 Sep 2021 11:16:37 +0000
Date: Fri, 17 Sep 2021 13:16:35 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Alex Henrie <alexh@vpitech.com>
Message-ID: <YUR5E6eFMxieUbWA@pevik>
References: <20210914161503.97495-1-alexh@vpitech.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210914161503.97495-1-alexh@vpitech.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH ltp v3 1/2] IMA: Move check_policy_writable to
 ima_setup.sh and rename it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
Message-ID: <20210917111635.bOw9IYzJa_b7erp5-WtZ7vrrocddDj7-7W1CYk-bggM@z>

Hi Alex,

...
> --- a/testcases/kernel/security/integrity/ima/tests/ima_setup.sh

As it's now a generally used function I'll add a comment:

# Because we don't grep kernel config for CONFIG_IMA_WRITE_POLICY, we just try
# to write empty string (invalid), thus policy must be repeatedly checked.
# Because after first write to policy policy will be removed on systems without
# CONFIG_IMA_WRITE_POLICY.
> +require_policy_writable()
> +{
> +	local err="IMA policy already loaded and kernel not configured to enable multiple writes to it (need CONFIG_IMA_WRITE_POLICY=y)"
> +
> +	[ -f $IMA_POLICY ] || tst_brk TCONF "$err"
> +	# CONFIG_IMA_READ_POLICY
> +	echo "" 2> log > $IMA_POLICY
> +	grep -q "Device or resource busy" log && tst_brk TCONF "$err"
> +}
> +

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
