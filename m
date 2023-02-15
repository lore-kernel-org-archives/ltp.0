Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48499C636D4
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 15:20:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8891C3CC3B0
	for <ltp@archiver.kernel.org>; Wed, 15 Feb 2023 16:20:15 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 051CF3CB4DB
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:20:04 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5426E1A00CB0
 for <ltp@lists.linux.it>; Wed, 15 Feb 2023 16:20:03 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 38F2020B80;
 Wed, 15 Feb 2023 15:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1676474403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGd1meu78vOKgXDLGE4oIP16E07SAWmNn0l28lTc5H8=;
 b=bbhUcH0ZZAU6paHJA3B9OBbshGoVz5cYlbqgXVD6hakIY0Tgn5tnpSS+9fgMGOtxHlXrN/
 1WFjrvM3XJbKRadx4ERpT4E3GhZrKYRCd8jA2hYHoGXqGOsF1a+vn8bYTrnDU/JGFBKjmw
 cBi8HkVoeemFHwJ2XhqpAukxE7m1w/0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1676474403;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SGd1meu78vOKgXDLGE4oIP16E07SAWmNn0l28lTc5H8=;
 b=qrycluIgZ8nN7wliheslCyXiH42Y4O3VMPOrGW+L0TE87IUrgTmA0tSOibmeZW+RSjA3Bm
 +yNNxOeKYQdUrTCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 26C33134BA;
 Wed, 15 Feb 2023 15:20:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2QvsCCP47GPgHwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 15 Feb 2023 15:20:03 +0000
Date: Wed, 15 Feb 2023 16:21:30 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Paulson Raja L <lpaulsonraja@gmail.com>
Message-ID: <Y+z4en9kAOOMgGk9@yuki>
References: <CA+O3cCQk5CEKTqdCkHnMmAwqWF8ePeGOOuHXKBMPqsqwvv7ihA@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CA+O3cCQk5CEKTqdCkHnMmAwqWF8ePeGOOuHXKBMPqsqwvv7ihA@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] RFC:[PATCH v1] Added testcase to test mmap with
 MAP_SHARED_VALIDATE flag
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
> +static void test_mmap(void)
> +{
> + mapped_address = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
> +      (1 << 7) | (1 << 9) | MAP_SHARED_VALIDATE, fd_file, 0);
> + if (mapped_address != MAP_FAILED)
> + tst_res(TFAIL | TERRNO, "mmap() is successful, but it should have
> failed.");
> + else if (errno == EOPNOTSUPP)
> + tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP.");
> + else
> + tst_res(TFAIL | TERRNO, "mmap() failed with unexpected error.");
> +}
> +
> +static struct tst_test test = {
> + .min_kver = "4.15",
> + .setup = setup,
> + .cleanup = cleanup,
> + .test_all = test_mmap,
> + .needs_tmpdir = 1,
> +};

First of all all the whitespaces are messed up and some of the lines are
wrapped, quite likely this was done by your email client. Please make
sure to send patches so that they do not get mangled like this.

See: https://www.kernel.org/doc/html/v4.17/process/email-clients.html

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
