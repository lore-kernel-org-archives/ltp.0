Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1830C46CD2
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 12:53:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58DDC3CE8A3
	for <ltp@archiver.kernel.org>; Tue,  2 Jan 2024 13:53:06 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 80FAE3CBA4F
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 13:52:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 6E8FC20023C
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 13:52:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2418421CDB
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 12:52:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704199974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qCaujLANwwJ9OLv8dcYibO00C+C5mqL2dWunRBgrNt8=;
 b=j2SvL0iKilXhYEPvPquqg/8rzsG1HnvHzgB7HbwToJ74zET8wogSRAqnDEZ6iIkXAmYjrg
 5I8ItG+2TNnwlrFOoR0g7I+xDaLdcyd2KRcBSUqdak2r/EZb6LhZXpBI8KBQErAmlqTeCP
 i+tjrwOe6HBL5hVzS8nkEpfpCI1QMIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704199974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qCaujLANwwJ9OLv8dcYibO00C+C5mqL2dWunRBgrNt8=;
 b=kt8yd+79cz81NKdkA9pLt5yYaaUHf8rpCfRkFUCOBMh6Tco4S/pgHZeoEtOQdy1iSOzs0R
 ui8IQhJ4gW5UPNBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1704199974; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qCaujLANwwJ9OLv8dcYibO00C+C5mqL2dWunRBgrNt8=;
 b=j2SvL0iKilXhYEPvPquqg/8rzsG1HnvHzgB7HbwToJ74zET8wogSRAqnDEZ6iIkXAmYjrg
 5I8ItG+2TNnwlrFOoR0g7I+xDaLdcyd2KRcBSUqdak2r/EZb6LhZXpBI8KBQErAmlqTeCP
 i+tjrwOe6HBL5hVzS8nkEpfpCI1QMIw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1704199974;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type;
 bh=qCaujLANwwJ9OLv8dcYibO00C+C5mqL2dWunRBgrNt8=;
 b=kt8yd+79cz81NKdkA9pLt5yYaaUHf8rpCfRkFUCOBMh6Tco4S/pgHZeoEtOQdy1iSOzs0R
 ui8IQhJ4gW5UPNBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0BEEF1340C
 for <ltp@lists.linux.it>; Tue,  2 Jan 2024 12:52:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id c66+ASYHlGV3RgAAD6G6ig
 (envelope-from <chrubis@suse.cz>)
 for <ltp@lists.linux.it>; Tue, 02 Jan 2024 12:52:54 +0000
Date: Tue, 2 Jan 2024 13:53:18 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: LTP List <ltp@lists.linux.it>
Message-ID: <ZZQHPkwg-W2R1ejJ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Bar: /
X-Spamd-Result: default: False [0.19 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 PREVIOUSLY_DELIVERED(0.00)[ltp@lists.linux.it];
 RCPT_COUNT_ONE(0.00)[1]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 TO_DN_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[24.75%];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=j2SvL0iK;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=kt8yd+79
X-Rspamd-Queue-Id: 2418421CDB
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] LTP Release preparations
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Firstly happy new year to everyone.

Secondly as usually we are supposed to produce a release at the end of
the month. I will start by going over patchwork this week and try to
review and merge as much as possible. Given that it's the start of the
January we have about two weeks for this before we have to declare a git
freeze and start pre-release testing. Does that sound fine to everyone?

If you have any patches that should be reviewed before the release,
please let me know.

I do have one patch this time, please have a look if you have time:

http://patchwork.ozlabs.org/project/ltp/patch/20231031125114.5879-1-chrubis@suse.cz/

I would like to finish the tst_fd iterator patchset if possible, but
depending on the amount of patches that I will have to review I may not
make it.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
