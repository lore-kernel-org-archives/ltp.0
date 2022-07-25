Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF9FC43334
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 12:56:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24EB23C9725
	for <ltp@archiver.kernel.org>; Mon, 25 Jul 2022 14:56:03 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 868C43C941D
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 14:55:53 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id EE3EB60083F
 for <ltp@lists.linux.it>; Mon, 25 Jul 2022 14:55:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B7282201C3;
 Mon, 25 Jul 2022 12:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1658753751;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q67mzK+UcyKxLEgfmnXkms6J6RYtpUOuFouTekm0wVU=;
 b=pGMffqe0uWZVLoj0o/GTDZ0jqrdIXSHMezhGzQWrqq4bM+s7mCsoZ09qo2w/DZdOdyryuo
 ofaQYYNza7D6i7oaJcNC5EvGt6VliTGZIQhwXnH+KOmAjUaYGzfiESbcF6FA4ehhz4Qkbm
 5XNgJb0ZAj1A2cmeS+MJNJya01464Ts=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1658753751;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=q67mzK+UcyKxLEgfmnXkms6J6RYtpUOuFouTekm0wVU=;
 b=vxXWZrsHnDKsCwPpN6tGXJlxNjAsoZ1vDcMqt+m1LpG+8MVZj7IHbSnfl3qkhE7hS+oiCf
 P9DUhGDXaUZnEuAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 581D713ABB;
 Mon, 25 Jul 2022 12:55:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QVgZE9eS3mL3bAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 25 Jul 2022 12:55:51 +0000
Date: Mon, 25 Jul 2022 14:55:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Matthew Bobrowski <repnop@google.com>
Message-ID: <Yt6S1dkYcBN8msnR@pevik>
References: <20220719095853.3373732-1-amir73il@gmail.com>
 <20220719095853.3373732-3-amir73il@gmail.com>
 <Ytc3AHNkLoAT6TfZ@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Ytc3AHNkLoAT6TfZ@google.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] syscalls/fanotify14: Add test cases for
 events not allowed on non-dir
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>
Tested-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
