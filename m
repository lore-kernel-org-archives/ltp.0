Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC244C36010
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 18:37:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D69D3CB3BE
	for <ltp@archiver.kernel.org>; Tue,  8 Apr 2025 20:37:21 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C03323CB379
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:37:04 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B91C21000D0B
 for <ltp@lists.linux.it>; Tue,  8 Apr 2025 20:37:03 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E93FD2116E;
 Tue,  8 Apr 2025 18:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744137422; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UbDizKsrqaHg/wLg7WkwAnMvZAQjreVLQWJbHJ7sCE=;
 b=cUlE6LlCxS94Vq5k7UyvN4XeEGNQh4omEUFq6DfnO8+ueg8mBHIDvDnhLxwZbq4iYGKFV3
 7fTgzvPXUEuOObyHg3fLyVAPF0l2l6HMYldfwzRqs87wU4eFNGy/yYGKzvyDQ3oCH3IZWa
 0l+55BZf4g705TEloPFOfLxZrdd9GRw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744137422;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UbDizKsrqaHg/wLg7WkwAnMvZAQjreVLQWJbHJ7sCE=;
 b=gsPjeGpE8IvVUplmlDggQij4ppF1R06PGTYJ7iCY8xCdaRsB44CKOfSXGyFF+I/DYBZdQe
 YfGmIJXacq0aC4DA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1744137421; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UbDizKsrqaHg/wLg7WkwAnMvZAQjreVLQWJbHJ7sCE=;
 b=WEN4iKBuq2Xv5eqf9+wWZJeyo0c4PgiBrhxH5OubT7Q1A2H0wybkQzTH37/Ga83hp2Nhbm
 XXjzMXtWiwRyqDmEN62KO5bgEgLPRI+uJtxlMZY1RqqSI0X0efqvsBIUi6Bh8VvAgayev4
 TrODAFknzLl3nBKiW+MDXoAYSSQyp/o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1744137421;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3UbDizKsrqaHg/wLg7WkwAnMvZAQjreVLQWJbHJ7sCE=;
 b=36reuFKiY9NQUcDawxg7lKL5mEROgbi8mPZKtrmNdR4xZCFMdyO9KAznnYRxJNqk62omcT
 2M18X2ppiGWhWBBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CD53A13691;
 Tue,  8 Apr 2025 18:37:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id rzkHMc1s9WenDwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 08 Apr 2025 18:37:01 +0000
Date: Tue, 8 Apr 2025 20:37:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z_Vs5oeKp1KJo0fx@yuki.lan>
References: <20250403101912.459507-1-pvorel@suse.cz>
 <20250403101912.459507-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250403101912.459507-2-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/2] runtest/ipc: Enable named pipes on
 non-blocking IO
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
> Tests were disabled from the start (edab67b3a0 in 2001) due EAGAIN.
> Tests are working now even on very old SLE12-SP3 based 4.4 kernel,
> therefore enable them.

My guess is that it much more depends on number of CPUs. It's more
likely that reader/write would starve on single CPU system.

But I've spend quite a bit of time reading the tlibio.c code (after I've
cleaned up the messy ifdefs) and the test (by default) passes method =
0. Which means that for write we do:

                while (1) {
                        if (((ret = write(fd, buffer, size)) == -1)
                            && errno != EAGAIN && errno != EINTR) {
                                sprintf(Errormsg,
                                        "%s/%d write(%d, buf, %d) ret:-1, errno=%d %s",
                                        __FILE__, __LINE__, fd, size, errno,
                                        strerror(errno));
                                return -errno;
                        }

                        if (ret != -1) {
                                if (ret != size) {
                                        sprintf(Errormsg,
                                                "%s/%d write(%d, buf, %d) returned=%d",
                                                __FILE__, __LINE__,
                                                fd, size, ret);
                                        size -= ret;
                                        buffer += ret;
                                        totally_written += ret;
                                } else {
                                        if (Debug_level > 1)
                                                printf
                                                    ("DEBUG %s/%d: write completed without error (ret %d)\n",
                                                     __FILE__, __LINE__, ret);

                                        return totally_written + ret;
                                }
                        }
                        wait4sync_io(fd, 0);
                }


And wait4sync_io() does select() to wait for the file descriptor to
became ready for reading. The corresponding part that reads look
similar. So it at least looks like the code properly handles the EAGAIN
case in the tlibio.c library and that it should be safe to enable the
non-blocking case.

Acked-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
