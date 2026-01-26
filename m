Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9279BCF65E1
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 11:41:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 057F43C308D
	for <ltp@archiver.kernel.org>; Mon, 26 Jan 2026 12:41:22 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C57943C01B5
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 12:41:02 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D026F1400142
 for <ltp@lists.linux.it>; Mon, 26 Jan 2026 12:41:01 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 855833379E;
 Mon, 26 Jan 2026 11:40:55 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 64F80139E9;
 Mon, 26 Jan 2026 11:40:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id wRHHF8dSd2niYgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 Jan 2026 11:40:55 +0000
Date: Mon, 26 Jan 2026 12:42:10 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aXdTEreda0-s6WID@yuki.lan>
References: <20260126-fix_dio_sparse_slow-v2-1-5dbe1622f5c1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260126-fix_dio_sparse_slow-v2-1-5dbe1622f5c1@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 855833379E
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] io: fix really slow dio_sparse on certain
 systems
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> The reason why dio_sparse is happening to be slow on certain systems is
> that, if data buffering is slow, we run more buffered read() for one
> single dio write(). This slows down the whole test, because for each
> read() we always need to move data from kernel space to user space.

I guess it's not about slow buffering. What I suppose happens is that
every time the writer thread writes with O_DIRECT it invalidates the
page cache and we have to re-read everything from disk. Which measn that
the data are often removed from the cache between the reads and the
reader processes are often forced to re-read the data from the disk. If
there was no O_DIRECT reader thread the first child that happens to read
a file block would cause kernel to put it into the page cache and all
other children would just copy that data without a need to reach the
disk at all.

However the test should finish as fast as the writer finishes writing
the file. So slow readers shouldn't matter unless there is some serious
contention on the disk I/O. That's probably the reason you are aligning
the writer as well.

What is the difference in runtime between test before and after this
patch on the slow hardware?

The only thing I wonder about is that if we aren't dropping some
coverage along with speeding up the test. For the reading part I guess
it doesn't matter that much how big the blocks are (if we speed up the
test we finish faster and do less operations, but that is something we
can live with). If we align the writer it may write directly whole
blocks instead of reading a block, modifying it and writing it back.
Looking at the runtest files, we do have dio_sparse there with a
different write block sizes, so the default shouldn't matter that much,
so why do we bother changing it?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
