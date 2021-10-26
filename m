Return-Path: <SRS0=ntep=PO=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27613C433F5
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:41:01 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4224760E8F
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 14:41:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4224760E8F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 184BD3C6806
	for <ltp@archiver.kernel.org>; Tue, 26 Oct 2021 16:40:58 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CBB93C679A
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:40:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id BFAAE2011AD
 for <ltp@lists.linux.it>; Tue, 26 Oct 2021 16:40:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E8AB31F770;
 Tue, 26 Oct 2021 14:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1635259246; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wX7vNbp9zKE7/q+Vt2tX8XOEUiU9UUe0c6Ad+wSHVKQ=;
 b=zxDkUIZ2NRTeCkc77zX9t2FVosSgxFKkz96zX0J1FF0lu+vvTx8LnLqdgLV2uafmJQOJd0
 8q/bc7ph6uSegeB4WJHaboiyDzk3DyLQcA6bDT4HItaN+4XFtLEE1zYaOdc1StAoKNy6+P
 XP+79yaro8S/r0XEqNygbn0XGnFTAnA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1635259246;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wX7vNbp9zKE7/q+Vt2tX8XOEUiU9UUe0c6Ad+wSHVKQ=;
 b=eWzRHGDkDc3uIQ27JEJ7k77HHkUnaOmm7UTI6z2xbpEFerRXCxEAcNOZACXnczZsJddl3v
 D8YINfa4wQZZqzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D07B113AE2;
 Tue, 26 Oct 2021 14:40:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 9+5oMm4TeGFKHAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 26 Oct 2021 14:40:46 +0000
Date: Tue, 26 Oct 2021 16:41:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YXgToPshvc9WiQ9q@yuki>
References: <1634562996-6045-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1634562996-6045-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 11/11] syscalls/quotactl09: Test error when
 quota info hidden in filesystem
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Generally looks good, same minor comments as for the rest of the
patchset apply here as well:

- for the description comment
- no need to include "lapi/quotactl.h"
- there are some trailing whitespaces (have you run make check before submitting?)
- does geteuid() in setup return anything else than 0?

Also I wonder if we should include the fmtv0 in the variant list, but as
far as I can tell it only matters for the tests that attempt to set the
limits, right?

I guess that we can define the test variants as:

static struct quotactl_variant {
	int use_fd;
	int32_t fmt_id;
	const char *fmt_name;
} variants[] = {
	{.use_fd = 0, .fmt_id = QFMT_VFS_V1, .fmt_name = "fmtv1"},
	{.use_fd = 1, .fmt_id = QFMT_VFS_V1, .fmt_name = "fmtv1"},
	{.use_fd = 0, .fmt_id = QFMT_VFS_V0, .fmt_name = "fmtv0"},
	{.use_fd = 1, .fmt_id = QFMT_VFS_V0, .fmt_name = "fmtv0"},
};

And then set .variants = 2 for all the tests that does not touch the
limits and for these tests that manipulate the limits set .variants = 4

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
