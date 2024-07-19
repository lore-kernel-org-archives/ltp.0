Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6705AC3DA59
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 17:44:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2DFF23D1B47
	for <ltp@archiver.kernel.org>; Fri, 19 Jul 2024 19:44:02 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A08893D0099
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 19:43:46 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 1A3BA207A0E
 for <ltp@lists.linux.it>; Fri, 19 Jul 2024 19:43:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D19A71F7A5;
 Fri, 19 Jul 2024 17:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721411022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
 b=W9gxKBromI/sNsrKIOevP2RIcbkC+BCV1at+g2SUEg543FAXNyzS+atZV0v9A+c9GFghPm
 RhMLb5gPDGoWSw6zxnhWMptQX4D81Aw13IMWI33kXHMRtJn04fMTrChOK0mCPav711Fqcy
 OM7wFyhX33jHrWNNKjtGkg9F9Ey6Gbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721411022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
 b=DVDsbkGyUEW9DxctpXXrcSxh/3o9uwW4tcwZzPoPvfBvN9PwuDrOhpt1E3T1xaCc+GonZQ
 DnIz4j3tolsM9PCA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1721411022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
 b=W9gxKBromI/sNsrKIOevP2RIcbkC+BCV1at+g2SUEg543FAXNyzS+atZV0v9A+c9GFghPm
 RhMLb5gPDGoWSw6zxnhWMptQX4D81Aw13IMWI33kXHMRtJn04fMTrChOK0mCPav711Fqcy
 OM7wFyhX33jHrWNNKjtGkg9F9Ey6Gbs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1721411022;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=KVsBhDaO8D1jYNs6pDclEnNjXeKtbtSCS2VYT4HR+Uo=;
 b=DVDsbkGyUEW9DxctpXXrcSxh/3o9uwW4tcwZzPoPvfBvN9PwuDrOhpt1E3T1xaCc+GonZQ
 DnIz4j3tolsM9PCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 05F2B13808;
 Fri, 19 Jul 2024 17:43:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yOZaO82lmmaiJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Fri, 19 Jul 2024 17:43:41 +0000
Date: Fri, 19 Jul 2024 19:43:25 +0200
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240719174325.GA775414@pevik>
MIME-Version: 1.0
Content-Disposition: inline
X-Spamd-Result: default: False [0.70 / 50.00]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 MIME_GOOD(-0.10)[text/plain]; RCVD_TLS_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[13];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FREEMAIL_CC(0.00)[vger.kernel.org,kernel.dk,suse.cz,suse.com,gmail.com,suse.de];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [RFC] Slow down of LTP tests aiodio_sparse.c and dio_sparse.c
 in kernel 6.6
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
Cc: Jens Axboe <axboe@kernel.dk>, linux-xfs@vger.kernel.org,
 Jan Kara <jack@suse.cz>, fstests@vger.kernel.org, linux-block@vger.kernel.org,
 Filipe Manana <fdmanana@suse.com>, David Sterba <dsterba@suse.com>,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

LTP AIO DIO tests aiodio_sparse.c [1] and dio_sparse.c [2] (using [3]) slowed
down on kernel 6.6 on Btrfs and XFS, when run with default parameters. These
tests create 100 MB sparse file and write zeros (using libaio or O_DIRECT) while
16 other processes reads the buffer and check only zero is there.

Runtime of this particular setup (i.e. 100 MB file) on Btrfs and XFS on the
same system slowed down 9x (6.5: ~1 min 6.6: ~9 min). Ext4 is not affected.
(Non default parameter creates much smaller file, thus the change is not that
obvious).

Because the slowdown has been here for few kernel releases I suppose nobody
complained and the test is somehow artificial (nobody uses this in a real world).
But still it'd be good to double check the problem. I can bisect a particular
commit.

Because 2 filesystems affected, could be "Improve asynchronous iomap DIO
performance" [4] block layer change somehow related?

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/io/ltp-aiodio/aiodio_sparse.c
[2] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/io/ltp-aiodio/dio_sparse.c
[3] https://github.com/linux-test-project/ltp/tree/master/testcases/kernel/io/ltp-aiodio/common.h
[4] https://kernelnewbies.org/Linux_6.6#Block_layer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
