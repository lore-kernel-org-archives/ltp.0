Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBD6FCA0FE6
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 12:14:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B79153CE03A
	for <ltp@archiver.kernel.org>; Fri,  1 Sep 2023 14:13:57 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D039A3CBB99
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:13:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A165C1001598
 for <ltp@lists.linux.it>; Fri,  1 Sep 2023 14:13:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id EDE4A21862;
 Fri,  1 Sep 2023 12:13:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1693570424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdZLmcyvGUooiMn2rzOdiX0llyewRwRuNt2EDMwp8VU=;
 b=z+IAiUoLMsL4w28J3hFhsqvgxyXvgYnmOVqdlMcAaqgPLh91bjfmHTwNKL1x54hb01coqa
 6M5mB+kQICx0obe4SXVnphlF1Ij6ynI9cC2kspxNvtDFjVyrXONj4f2PX7g9YxFNOqZGQT
 1MtEovu52Vk6hE9XnuFf3dEFrr1n7xY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1693570424;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HdZLmcyvGUooiMn2rzOdiX0llyewRwRuNt2EDMwp8VU=;
 b=M95kuimR9FsDkCT9knuGmKUWzrDZvYX7i2vJS2GF8wr+qO+WjuJYUHj9DKhT3OsoSNhPUm
 lhBMMLbGeYBer6Dw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5EB7B1358B;
 Fri,  1 Sep 2023 12:13:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wQvcC3jV8WTbGwAAMHmgww
 (envelope-from <akumar@suse.de>); Fri, 01 Sep 2023 12:13:44 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 01 Sep 2023 17:43:41 +0530
Message-ID: <2556714.ltBL1Nq8q0@localhost>
Organization: SUSE
In-Reply-To: <ZO3CghC11RzXJjuq@rei>
References: <20230818112023.18159-1-akumar@suse.de>
 <20230818112023.18159-4-akumar@suse.de> <ZO3CghC11RzXJjuq@rei>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 4/4] syscalls/mmap04: Rewrite the test using new
 LTP API
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

Hi Cyril,

On Tuesday, August 29, 2023 3:33:46 PM IST Cyril Hrubis wrote:
> Hi!
> This is nearly identical to the mmap02.c and the same comments apply
> here.
> 
> Also the test does not check the PROT_EXEC part at all. If we wanted to
> properly test PROT_EXEC we would have to copy a function code to the
> file first then execute it, something that mprotect04 does, but since
> that flag is already tested in mprotect04 it does not make that much
> sense to have it here as well.

Yes, I agree this test does not cover PROT_EXEC scenario. So, if this case is 
covered in mprotect04, do you recommend dropping this test altogether from 
here?

--
Regards,
Avinesh



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
