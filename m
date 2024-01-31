Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F7C0C47258
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 15:15:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AED3C3CF952
	for <ltp@archiver.kernel.org>; Wed, 31 Jan 2024 16:15:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C74523CB492
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:15:01 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0A880600FFA
 for <ltp@lists.linux.it>; Wed, 31 Jan 2024 16:15:00 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5B8A21FF9;
 Wed, 31 Jan 2024 15:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706714099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
 b=jWuPLTo1tn1PT+igogqktc66cl6+dlGY0U/xLc57rxZIHCC83dN2c0H1GZa8XBWYyqP/E0
 F9kAbAOiHXs07cv/7IldwsFiM1gY8a2ZDmwI0kRgKVyyAZ7AF91ymx84z4PIzMJW3YIvbN
 6hBPFBtg2Rv76kDtxQ5mtbPdi2Do7WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706714099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
 b=Gp390m5cK/lO56fp9uc0lQ1zGL9EVhzZxc96bbAY2URzxNdg5ISX+um0yxlWlJrzTxLn3n
 gLYO1GBMpUeuvQCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706714099; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
 b=jWuPLTo1tn1PT+igogqktc66cl6+dlGY0U/xLc57rxZIHCC83dN2c0H1GZa8XBWYyqP/E0
 F9kAbAOiHXs07cv/7IldwsFiM1gY8a2ZDmwI0kRgKVyyAZ7AF91ymx84z4PIzMJW3YIvbN
 6hBPFBtg2Rv76kDtxQ5mtbPdi2Do7WM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706714099;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=ZEiUTRZkh8inO5+YNVbj+n37qKraFO4+vyQgGitviAA=;
 b=Gp390m5cK/lO56fp9uc0lQ1zGL9EVhzZxc96bbAY2URzxNdg5ISX+um0yxlWlJrzTxLn3n
 gLYO1GBMpUeuvQCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 7774F132FA;
 Wed, 31 Jan 2024 15:14:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id 6QFcG/NjumWJeQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Wed, 31 Jan 2024 15:14:59 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Wed, 31 Jan 2024 16:14:42 +0100
Message-ID: <20240131151446.936281-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Spamd-Bar: +++
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=jWuPLTo1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Gp390m5c
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [3.49 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 R_MISSING_CHARSET(2.50)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; BROKEN_CONTENT_TYPE(1.50)[];
 RCPT_COUNT_FIVE(0.00)[5]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 MID_CONTAINS_FROM(1.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[43.18%]
X-Rspamd-Queue-Id: C5B8A21FF9
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 0/4] nfsstat: Test also on NFSv4*
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
Cc: linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Petr Vorel (4):
  runtest/net.nfs: Rename test names
  nfsstat01.sh: Validate parsing /proc/net/rpc/nfs{,d}
  nfsstat01.sh: Add support for NFSv4*
  nfsstat01.sh: Run on all NFS versions, TCP and UDP

 runtest/net.nfs                              | 197 ++++++++++---------
 testcases/network/nfs/nfsstat01/nfsstat01.sh |  47 +++--
 2 files changed, 135 insertions(+), 109 deletions(-)

-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
