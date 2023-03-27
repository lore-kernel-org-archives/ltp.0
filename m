Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93EFFC761AF
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 10:51:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 662303CCB4D
	for <ltp@archiver.kernel.org>; Mon, 27 Mar 2023 12:51:25 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C7BE43CA4EA
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:51:14 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id B2420600769
 for <ltp@lists.linux.it>; Mon, 27 Mar 2023 12:51:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6F9D31FDB9;
 Mon, 27 Mar 2023 10:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679914272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3PQmsIfjkqRHkM4t421XxDmfxZ3n9RKAhMKSJzDkRc=;
 b=wRYomrS/l0LHlMy4YgP0EZs/qFOXT/ElAcN2o2I9k1fgNBza2auOnpLkWtoTnMRUjGfaQZ
 Rh6A/cqnLxqcNshODkJ4J5MrIJcPUFTA8sAh+0imxbocDgbWxESFIK2q/6usA6f6eOJjfZ
 v9JEIErFUgbr4o8I/ULgMa73JxMCbxQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679914272;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e3PQmsIfjkqRHkM4t421XxDmfxZ3n9RKAhMKSJzDkRc=;
 b=XdQ9ZBFDzxTfv+DsgknS/cTVGDiDqK5kTYo0dGwPmI1ZfRTFRjvQ9D8gqk+V1nEtqmZwof
 h3nRDXtovFCcNmDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4FDB013329;
 Mon, 27 Mar 2023 10:51:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZoTeESB1IWSSFAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 27 Mar 2023 10:51:12 +0000
Date: Mon, 27 Mar 2023 12:51:10 +0200
From: Petr Vorel <pvorel@suse.cz>
To: paulson <lpaulsonraja@gmail.com>
Message-ID: <20230327105110.GA667966@pevik>
References: <20230323121330.92244-1-paulson@zilogic.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323121330.92244-1-paulson@zilogic.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Added test for mmap() with MAP_SHARED_VALIDATE.
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> +static void test_mmap(void)
> +{
> +	mapped_address = mmap(NULL, TEST_FILE_SIZE, PROT_READ | PROT_WRITE,
> +			      (1 << 7) | MAP_SHARED_VALIDATE, fd_file, 0);
> +	if (mapped_address != MAP_FAILED)
> +		tst_res(TFAIL | TERRNO, "mmap() is successful, but it should have failed.");
> +	else if (errno == EOPNOTSUPP)
> +		tst_res(TPASS, "mmap() failed with errno set to EOPNOTSUPP.");
> +	else
> +		tst_res(TFAIL | TERRNO, "mmap() failed with unexpected error.");
> +}

FYI we have various helpers in include/tst_test_macros.h, e.g. TST_EXP_FAIL()
for expected failures where return is just classical syscalls result
(0 for pass, -1 for error) or TST_EXP_FD() for file descriptors.

But these cannot be used here, because mmap returns pointer to void.
We might want to write helpers which use TEST_VOID() instead of TEST(),
after tests for mmap() are rewritten to new API, they could use it.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
