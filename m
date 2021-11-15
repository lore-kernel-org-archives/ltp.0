Return-Path: <SRS0=J9GY=QC=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BBB0C433F5
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 10:19:36 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A2B7C61B4D
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 10:19:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A2B7C61B4D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 088283C7FC2
	for <ltp@archiver.kernel.org>; Mon, 15 Nov 2021 11:19:33 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 173D63C7FC2
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 11:19:22 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A1B45140164E
 for <ltp@lists.linux.it>; Mon, 15 Nov 2021 11:19:21 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C1D051FD66;
 Mon, 15 Nov 2021 10:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1636971560; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbNNxkWkRG16C9jK/969rJDXKyJKelsvcNuFbFrAAck=;
 b=BLD6vOnmjLOCeNBW0a22AUmvSagU3hmGuH0Dnp1UjJsIb2MO/3xK2puS12iUNUS+rcjj1U
 8RZxWR3yKdbynjFxTCN5o6gi5aVr6paEbjpca1ZYrVCu4ZXFTxwnJIwf02b1f2QBma3RHD
 gNb7i+9q1S3CRY1h8eN5GgSCTABzAso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1636971560;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LbNNxkWkRG16C9jK/969rJDXKyJKelsvcNuFbFrAAck=;
 b=dvGpFydlVy5hgr1eU9utL5/NPi3DRDZSVysexxrEc9FHUJhBTGA3MIJjuDdimQwtXJEGME
 lyWDRJbt/1vRspAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id AE5AF13D58;
 Mon, 15 Nov 2021 10:19:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id HDsWKSg0kmFWIQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 15 Nov 2021 10:19:20 +0000
Date: Mon, 15 Nov 2021 11:20:24 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Richard Palethorpe <rpalethorpe@suse.de>
Message-ID: <YZI0aEoJt5c9bqTz@yuki>
References: <1636619544-2369-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <87a6i9ejdy.fsf@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <87a6i9ejdy.fsf@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx04: use stx_attributes_mask
 before test
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
> Note that even if you move setting the flags to the top. This will still
> result in all unset flags becoming TCONF instead of TFAIL.
> 
> IMO statx is broken on older kernels except for ext4. It can be fixed by
> backporting patches. One of the main use cases for LTP is to find
> missing backports.

That was my point as well.

I guess that the last time I've proposed to create a separate test that
just tests that these flags are set as expected for a all filesystems
and that test would have the patches that fixed that as a tags set. That
would make it clearer what is wrong and what should be backported.

Once we have that test implemented we can change this test as this patch
does.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
