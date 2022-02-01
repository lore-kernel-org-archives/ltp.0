Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 813BAC433EF
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 14:14:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 701843C9894
	for <ltp@archiver.kernel.org>; Tue,  1 Feb 2022 15:14:26 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C5D363C97E2
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 15:14:17 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 0481F200937
 for <ltp@lists.linux.it>; Tue,  1 Feb 2022 15:14:16 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 305F91F37F;
 Tue,  1 Feb 2022 14:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643724856; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrrhbMIPrIRP6F7xfM4+Jg2hSAsisgmbb6yLVyzY58k=;
 b=Tb9EeFfx1ocN6pMSXp2VeMXkKLdVE7IO3mvBheXXfSoUl5q+vzUQh9YE30EJ4Vc+VaZ8kr
 3fQ/qmgB2UROIVKr2lX3bZFeCj6WpZ6WrqR5a/OQbj8I9xCPcJRZTs483TZC/MwT8XuczX
 rLHn8NvPkm1A4LYCplMYQc15H4etqf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643724856;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rrrhbMIPrIRP6F7xfM4+Jg2hSAsisgmbb6yLVyzY58k=;
 b=u+hpLD+cogp4GpGLeCajt8ME6geEiIH2MhuoVC0JKOfECSNa74NA9sV2n0T98gULb5Dy3X
 SDuQWshYG3yq36DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 120AE13D7B;
 Tue,  1 Feb 2022 14:14:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 6/eWAjhA+WGMCQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 01 Feb 2022 14:14:16 +0000
Date: Tue, 1 Feb 2022 15:16:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <YflAqso2mcKddn4s@yuki>
References: <20220201122932.29272-1-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220201122932.29272-1-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] Add tst_dev_block_size utility
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
Pushed with a few fixes for the test, thanks.

Actually the LOOP_SET_BLOCK_SIZE ioctl() may fail with EAGAIN if there
are dirty blocks on the loop device and as a matter of the fact it did
fail for me in a few cases when I executed the test several times. I
guess that it all boils down to how the backing file is preallocated,
and there are several different options for that...

Anyways I fixed that part by adding the LTP retry wrapper around the
ioctl() which makes the test succeed repeatedly.

+ removed the mode for SAFE_OPEN() which is useless without O_CREAT
+ removed needs_tmpdir which is implied by needs_device

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
