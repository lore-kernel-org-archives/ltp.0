Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A5F9C433EF
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 10:56:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B0A263C8095
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 11:56:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 06A0E3C8010
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:55:49 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 548A41A0098D
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 11:55:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 938191F3A0;
 Fri, 10 Dec 2021 10:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639133748; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDk8cCoyr03VU+auwRq3FMElh2j+T4gccuVXmU3rEyg=;
 b=GtpX0KfL9BHjdEBnPKUq815GI0CE1GkkdYZrJyZeELwUSYunK5/5YrY9pTwUDqM3KbJnUs
 MkNYi8dF/z1fAxBWol9X1VdhEDTWKNYbkWF5Ahr3NAPPlyOeC5afqr/CP1NBNrC/83JDiD
 5xDVhShAxdAzroAJYn0Tznqrd8j78ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639133748;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDk8cCoyr03VU+auwRq3FMElh2j+T4gccuVXmU3rEyg=;
 b=iFnrplPfEIoXoaGGjhQtD3qOKgWanZHPDaIVxc1O5M5kgqIN3QQ7nv/vxCvFTg7HbOEr4d
 sRUyL4dzHfV7dYDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7E8E413D57;
 Fri, 10 Dec 2021 10:55:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id sWmCHTQys2E+XQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Dec 2021 10:55:48 +0000
Date: Fri, 10 Dec 2021 11:57:08 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: "daisl.fnst@fujitsu.com" <daisl.fnst@fujitsu.com>
Message-ID: <YbMyhM7/wqbGCdgk@yuki>
References: <1638825434-10768-1-git-send-email-daisl.fnst@fujitsu.com>
 <Ya9my0FdHXLqvkJr@yuki>
 <338aba97-dd1d-9a9e-e6a0-dcd60cf8ebc9@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <338aba97-dd1d-9a9e-e6a0-dcd60cf8ebc9@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/write06: Add new test
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> What I want to test is the following description of open(2) man-pages:
> 
> O_APPEND
>  ?????? ?? The file is opened in append mode.?? Before each write(2), the 
> file offset is positioned at the end of the file, as if with lseek(2).?? 
> The modification of the file offset and the write operation are 
> performed as a single atomic step.

Ah, now it makes much more sense.

I think part of the problem is that the code is actually confusing. I do
not like the l_seek() function at all, it's confusing at best because it
does several different things at the same time. So it would be much
better to write the offset check as:

	off = SAFE_LSEEK(fd, 1K, SEEK_SET)
	if (off != 1K)
		tst_brk(TBROK, "Failed to seek to 1K");

	SAFE_WRITE(1, fd, write_buf[1], K1);

	off = SAFE_LSEEK(fd, 0, SEEK_CUR);
	if (off != K3)
		tst_res(TFAIL, "Wrong offset after write %zu expected %u", off, K3)
	else
		tst_res(TPASS, "Offset is correct after write %zu", off);

	SAFE_FSTAT(fd, &statbuf);
	if (statbuf.st_size != K3) {
		tst_res(TFAIL, "Wrong file size after append %zu expected %u",
			statubuf.st_size, K3);
	} else {
		tst_res(TPASS, "Correct file size after append %u", K3);
	}


This makes it much clearer what happens here and the TPASS message
actually says what has passed...

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
