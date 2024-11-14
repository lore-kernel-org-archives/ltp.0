Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1948D65C76
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 11:19:07 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FA6C3D6D91
	for <ltp@archiver.kernel.org>; Thu, 14 Nov 2024 12:19:05 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D2AB13D6D83
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 12:18:48 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E9E041A0D2DA
 for <ltp@lists.linux.it>; Thu, 14 Nov 2024 12:18:46 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3DC481F7A8;
 Thu, 14 Nov 2024 11:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731583124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UZicdjeE7cCqu2AhTg8eKSUJXpVcejDhl9c2yJlwvhM=;
 b=Snz0bx2n3bpqVnjBQ5EDDq96KQ56D5giFSRzc2CVE0h9Poqa35X9/nXrNTQp7KQRaAoXQB
 rBzTPqw5wUZ8zaqPnpLIZB60Cw4CCtwb45q3E27cAjvSwrN9yRf299pi8kY9lyfnPOwvmV
 FvN89KfZtAfUq9IbmvFXpg8DIE/YHlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731583124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UZicdjeE7cCqu2AhTg8eKSUJXpVcejDhl9c2yJlwvhM=;
 b=wu2HC0jm5kFKl8hOZmRDOUckY+J3bSN2sXZNyXyk1Xq3hKkmwz7IrPMC9b3xefLL10fYnQ
 4zCDEAKV2c4aBODw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Snz0bx2n;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=wu2HC0jm
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1731583124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UZicdjeE7cCqu2AhTg8eKSUJXpVcejDhl9c2yJlwvhM=;
 b=Snz0bx2n3bpqVnjBQ5EDDq96KQ56D5giFSRzc2CVE0h9Poqa35X9/nXrNTQp7KQRaAoXQB
 rBzTPqw5wUZ8zaqPnpLIZB60Cw4CCtwb45q3E27cAjvSwrN9yRf299pi8kY9lyfnPOwvmV
 FvN89KfZtAfUq9IbmvFXpg8DIE/YHlg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1731583124;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UZicdjeE7cCqu2AhTg8eKSUJXpVcejDhl9c2yJlwvhM=;
 b=wu2HC0jm5kFKl8hOZmRDOUckY+J3bSN2sXZNyXyk1Xq3hKkmwz7IrPMC9b3xefLL10fYnQ
 4zCDEAKV2c4aBODw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 23BEA13794;
 Thu, 14 Nov 2024 11:18:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id E93iB5TcNWe7MgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 14 Nov 2024 11:18:44 +0000
Date: Thu, 14 Nov 2024 12:18:38 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>,
 Dominique Leuenberger <dleuenberger@suse.com>, ltp@lists.linux.it
Message-ID: <20241114111838.GA321369@pevik>
References: <20241113105925.295697-1-pvorel@suse.cz>
 <ZzSr-X47F4MfM831@yuki.lan> <20241113140712.GA162955@pevik>
 <ZzS1xaQp1xKcHagu@yuki.lan> <20241113151701.GD162955@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241113151701.GD162955@pevik>
X-Rspamd-Queue-Id: 3DC481F7A8
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[3];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] select03: Fix false positive on TCONF
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

in the end we decided with Cyril to simply revert [1] the commit which caused
the regression [2].

It will be applied after Cyril fixes the library.

Thanks all for your input.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/commit/b21fd2072ba4ef415e8e590abbf431ed97608473
[2] https://github.com/linux-test-project/ltp/commit/ffdd3b36cd90ad3f4e199344d20c00fb06762eb2

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
