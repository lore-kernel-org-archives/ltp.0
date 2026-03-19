Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BED701090242
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 16:03:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E9D043E30C7
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 17:03:43 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9051E3CD3F0
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:03:25 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 1A1041001153
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 17:03:24 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id CCF3A5BD66;
 Thu, 19 Mar 2026 16:03:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773936203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dVlqWe/TtcAg6iHOEoKLhh4xlwD7sCliNo1+BUuVgr8=;
 b=FeQX+xW+lzXLgLoQOdvOsKCDe1Edor9XboponuJ/PyFvtiHg5M0yxnet/7mdPklp1QBHZJ
 p/6v9yYNlbqhquYXrFrjdtDMcjSMOZ1VE4/Z72XFIRROJ/mHgz/T44LrKoWYjiedYFUHr2
 dfhb85F0PTN3NG3S3p7E0lK8cnBEWZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773936203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dVlqWe/TtcAg6iHOEoKLhh4xlwD7sCliNo1+BUuVgr8=;
 b=hgyUI9A8BKTzA9uFDLQtsTzxQCUhsEmGfswQQpyrgwjoWOp1TCVE5zbPkS/cacjpUcm76p
 P2cJGVqeLdAcDFCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773936203; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dVlqWe/TtcAg6iHOEoKLhh4xlwD7sCliNo1+BUuVgr8=;
 b=FeQX+xW+lzXLgLoQOdvOsKCDe1Edor9XboponuJ/PyFvtiHg5M0yxnet/7mdPklp1QBHZJ
 p/6v9yYNlbqhquYXrFrjdtDMcjSMOZ1VE4/Z72XFIRROJ/mHgz/T44LrKoWYjiedYFUHr2
 dfhb85F0PTN3NG3S3p7E0lK8cnBEWZ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773936203;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=dVlqWe/TtcAg6iHOEoKLhh4xlwD7sCliNo1+BUuVgr8=;
 b=hgyUI9A8BKTzA9uFDLQtsTzxQCUhsEmGfswQQpyrgwjoWOp1TCVE5zbPkS/cacjpUcm76p
 P2cJGVqeLdAcDFCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B77604273B;
 Thu, 19 Mar 2026 16:03:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id pNfEK0sevGnAWwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Mar 2026 16:03:23 +0000
From: Cyril Hrubis <chrubis@suse.cz>
To: ltp@lists.linux.it
Date: Thu, 19 Mar 2026 17:03:16 +0100
Message-ID: <20260319160318.6867-1-chrubis@suse.cz>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/2] Cleanup of aiodio runtest files
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
Cc: Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The aiodio runtest files were added back in 2009 and since them not much
was changed there. Given that these test as far as I can tell, does not
find many bugs[1], we can reduce the runtime a bit.

This is a first patch that removes duplicate tests and limits the
maximal file size for the sparse tests. If we agree to do so, I will
look at the ltp-aiodio.part4 and try to parametrize the testruns with
different sizes and number of workers, as we do with the rest of the
files.

Also since we are touching these files, should we rename/split them as
well? E.g. ltp-aiodio.part1 should be problably called aio-cp. The part2
aio-sparse, etc.

[1] I did SUSE bugzilla serach and there are two filesystem bugs found
in 2019, one in 2018 and one in 2016. Also as far as I can tell in these
cases the bug didn't seem to be strictly related to AIO and were also
found by other tests.

Cyril Hrubis (2):
  runtest/ltp-aidio.part4: Remove dio_sparse
  runtest: ltp-aiodio.part2: Limit the maximal filesize

 runtest/ltp-aiodio.part2 | 16 ++++++++--------
 runtest/ltp-aiodio.part4 | 32 --------------------------------
 2 files changed, 8 insertions(+), 40 deletions(-)

-- 
2.52.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
