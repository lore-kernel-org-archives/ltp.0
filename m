Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C3DC46CD2
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 20:00:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 37E273CEC60
	for <ltp@archiver.kernel.org>; Wed, 24 Jan 2024 21:00:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17E8D3C08CC
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 21:00:40 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 101D914013B0
 for <ltp@lists.linux.it>; Wed, 24 Jan 2024 21:00:39 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E6FF91FD86;
 Wed, 24 Jan 2024 20:00:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706126438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
 b=bsa8IUuCyMQj1+5ItOzpNLdT3qdq3WAbbs74m+bMYKF3/aEFHrCdTg/aopMIA1+P5rr7F7
 OXA9djRAkR3q1QnmreJnFedun0RcykvGehlArbCGiDdNeWFsg1uRHZPiuPnjbAIJJDQYRm
 ni+6hgt8WFYyXsGO3BqM7u7UOsNyl0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706126438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
 b=EOYy6Szke58Zr9Lku7VcdziX/RE4c9vZQ+FTkLpmeNUfbRUUnifytgPO2APKmdhByCrJcF
 gNEs5G4mZat2c2Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706126438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
 b=bsa8IUuCyMQj1+5ItOzpNLdT3qdq3WAbbs74m+bMYKF3/aEFHrCdTg/aopMIA1+P5rr7F7
 OXA9djRAkR3q1QnmreJnFedun0RcykvGehlArbCGiDdNeWFsg1uRHZPiuPnjbAIJJDQYRm
 ni+6hgt8WFYyXsGO3BqM7u7UOsNyl0E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706126438;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type;
 bh=9WDyjkO8pqVbP2nVSHovZI6utBCUXWI/CXKQZzAtRR4=;
 b=EOYy6Szke58Zr9Lku7VcdziX/RE4c9vZQ+FTkLpmeNUfbRUUnifytgPO2APKmdhByCrJcF
 gNEs5G4mZat2c2Bg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 748AE1333E;
 Wed, 24 Jan 2024 20:00:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iLkFGWZssWVAYgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 24 Jan 2024 20:00:38 +0000
Date: Wed, 24 Jan 2024 21:00:32 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>,
 Brian Foster <bfoster@redhat.com>
Message-ID: <20240124200032.GA343522@pevik>
MIME-Version: 1.0
Content-Disposition: inline
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[36.87%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] bcachefs fails to mount loop device on kernel
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
Cc: linux-bcachefs@vger.kernel.org, linux-kernel@vger.kernel.org,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

bcachefs fails to mount loop device on kernel on both 6.7 and 6.8.0-rc1.
Is mounting loop even supported?

dd if=/dev/zero of=test_file bs=400M count=1
losetup /dev/loop0 test_file
mkfs.bcachefs /dev/loop0

mount -t bcachefs -o loop test_file /mnt
=> Unknown command /dev/loop0

modprobe bcachefs
mount -t bcachefs -o loop test_file /mnt
=> mount: /mnt: failed to setup loop device for test_file.

mount -t bcachefs test_file /mnt
=> Unknown command test_file

mount -t bcachefs -o loop /dev/loop0 /mnt
=> Unknown command /dev/loop1

mount -t bcachefs /dev/loop0 /mnt
=> Unknown command /dev/loop0

bcachefs mount /dev/loop0 /mnt
=> Unknown command mount

Thanks for info.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
