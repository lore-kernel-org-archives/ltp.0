Return-Path: <SRS0=690a=OE=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D4F8C433EF
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 11:59:30 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A4FC610D1
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 11:59:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5A4FC610D1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 535A03C89CE
	for <ltp@archiver.kernel.org>; Tue, 14 Sep 2021 13:59:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 142993C1D7E
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 13:59:17 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 10E841A01232
 for <ltp@lists.linux.it>; Tue, 14 Sep 2021 13:59:16 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 075A921F76;
 Tue, 14 Sep 2021 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631620756; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kPUcY5x7iHK7McWV2hWTyIf6gwruCKWbl/OzBrwdH2Y=;
 b=Bj/12vnD+SLaUIulGDygRTyFYLUBZVzkMqFUUqhgzxq03OtlG0SRHnVL/K60dM1DSQBBBs
 R8XLwU68/kn7V/7O3s2vBAEtTOhR/wpQ04w2sNAE/P4sYQ8qE2rblL5LIJpOqL24irjhdl
 TCIBkoH7oP9KBnLgoxQK5n5roOayYWw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631620756;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kPUcY5x7iHK7McWV2hWTyIf6gwruCKWbl/OzBrwdH2Y=;
 b=GnX2KIa38VBNfZh6MN0K9LSOPCVBX+ka6d6LpgSPzFQ0TwZtBox8TFPnSRufBemdw5ixsV
 GhCbapCNk1jY96AA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E339C13342;
 Tue, 14 Sep 2021 11:59:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id iDaBN5OOQGEnGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 14 Sep 2021 11:59:15 +0000
Date: Tue, 14 Sep 2021 13:59:36 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YUCOqP9ObE+CxQCQ@yuki>
References: <20210913144454.22992-1-mdoucha@suse.cz>
 <20210913144454.22992-2-mdoucha@suse.cz>
 <3a764f27-b453-0aab-4938-7b7b34496885@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3a764f27-b453-0aab-4938-7b7b34496885@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/4] syscalls/setresuid01: Convert to new API
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
Message-ID: <20210914115936.BdjXPAnPZkP0c1thb2S8sD6_kPSyjCtUp9YhB58YcGk@z>

Hi!
> Oops, I've accidentally copy-pasted the wrong SPDX header to all three
> setresuid tests. Patch 1 is correct as is but patches 2-4 should have
> GPL-2.0-or-later instead. Please update it before merge.

I've fixed that and also removed useless comments from the test
structure in setresgid03.c and pushed the patchset, thanks!

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
