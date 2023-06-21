Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B3F5C0015E
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 09:43:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 57D743CCD2C
	for <ltp@archiver.kernel.org>; Wed, 21 Jun 2023 11:43:36 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A35173C9212
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:43:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2486F60026B
 for <ltp@lists.linux.it>; Wed, 21 Jun 2023 11:43:25 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E64AA21ABB;
 Wed, 21 Jun 2023 09:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1687340604;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CdX+p2vPUuR+Sv4jtbxvkmYtQntG8sTxWn7JlrmiHHA=;
 b=bWQyGnkexXUcCt5CoaWllydRFIh+cYZBzsqXZjqdxNYi9ap6pYohNTCz882lO6tMpYiRWd
 XNnTBcCevIumgUyPwIXrpLsRbQHYP5/jweVHLtJv9Za+yFhqGa0E6wqNFubA9Qc7TA/tB+
 PXdwOZyTA7MQnMRTeyeI2GMkIps+T8M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1687340604;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CdX+p2vPUuR+Sv4jtbxvkmYtQntG8sTxWn7JlrmiHHA=;
 b=61VvxLapdw4nUb3iSY0cdQtguyKhc6kLhWB3qdmMcU9iYEB4Q0hvReh7X30RdejZfDMzuU
 ycwcWRa2xSQUJQDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BE206133E6;
 Wed, 21 Jun 2023 09:43:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id NwZgLTzGkmSYdwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 21 Jun 2023 09:43:24 +0000
Date: Wed, 21 Jun 2023 11:43:23 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Rick Edgecombe <rick.p.edgecombe@intel.com>
Message-ID: <20230621094323.GB386889@pevik>
References: <20230531235725.389539-1-rick.p.edgecombe@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230531235725.389539-1-rick.p.edgecombe@intel.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] security/stack_clash: Add test for mmap()
 minding gap
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
Cc: Liam.Howlett@oracle.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Rick,

> diff --git a/testcases/cve/stack_clash.c b/testcases/cve/stack_clash.c
...

> +		/* This is not cleaned up. */
> +		SAFE_MMAP((void *)lastend, size, PROT_NONE,
> +			  MAP_ANON|MAP_PRIVATE|MAP_FIXED_NOREPLACE, -1, 0);
MAP_FIXED_NOREPLACE is undeclared on old CentOS 7 we still support,
thus it breaks the build.

Could you please include lapi/mmap.h instead of <sys/mman.h>
(it includes <sys/mman.h>).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
