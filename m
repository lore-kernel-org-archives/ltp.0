Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F22E3C5AC82
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 11:15:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7B5F13CF242
	for <ltp@archiver.kernel.org>; Mon, 10 Aug 2026 13:15:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BBE243C56E2
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:15:32 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D45D16002F8
 for <ltp@lists.linux.it>; Mon, 10 Aug 2026 13:15:31 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id B6E008083F;
 Mon, 10 Aug 2026 11:15:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786360526;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vr1v49JS4f6+PvqanDDIwUdG1ir9+s3LDSHDVP07W2Q=;
 b=SeYXi8kf3R+e5MvJepMbTYuOjD6zQ0ydROikb6RjSS+CWzbmphhg8lLZHH86vBjo3EAB3Z
 nWGSfqZHv3LM9UBfH92V1DxWlN+MmSxcDkjwNYkHhGTR/JdiPZfWYt36CQCI/+naGzsjn9
 zwepY93hzHpU9MtaqNFQmFCL8dcn07g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786360526;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vr1v49JS4f6+PvqanDDIwUdG1ir9+s3LDSHDVP07W2Q=;
 b=HShbMXQ47WYSSDcnQJQEAs5LrbhclTSeA0jXrvAZbm/xB9tBCVZOpKkHX3owxImRPKU7aR
 8OGe/Udqw2QmxcAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="Y1eJU/iW";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=OiNVesJK
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1786360522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vr1v49JS4f6+PvqanDDIwUdG1ir9+s3LDSHDVP07W2Q=;
 b=Y1eJU/iWdrpwLdve9zTuQX+Qfrg1lTV/2fFcGfLg06NTczOgUS+JBr0YiCJBpfHjt83MJh
 3WSXX+NHqCepIN+T4bsuWq9H7yicletb0PJKxD1VW8QF8wQBZSq1Gi7bXKmXb4sJR9ajo5
 /mCc84601frgHy5I3PZauJKCfsx/DCk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1786360522;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Vr1v49JS4f6+PvqanDDIwUdG1ir9+s3LDSHDVP07W2Q=;
 b=OiNVesJK03a01h9Z+4hJnsUSHQWA0ZR/HoDz7C3nl6XWbXYg3aQgIs05kugF95chdLpwH8
 HyBVQqPGbD03lMAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A51B779B2;
 Mon, 10 Aug 2026 11:15:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UPTWJMqyeWoUEwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 10 Aug 2026 11:15:22 +0000
Date: Mon, 10 Aug 2026 13:15:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20260810111521.GB918586@pevik>
References: <a1d939127b54c51fd29f869b0fe1706f@suse.de>
 <6a758e79.5fb1dcdd.355f96.e2e4@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a758e79.5fb1dcdd.355f96.e2e4@mx.google.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:replyto,suse.cz:dkim];
 TO_DN_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: B6E008083F
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6] cve: reproducer for cve-2026-64600
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

> Hi Petr,

> > > +			.min_kver = "4.16",
> > It got introduced in 4.11. Is there a reason for testing from 4.16?
> > Or is it just the copy paste error?

> 1e369b0e199bb ("xfs: remove experimental tag for reflinks") was merged
> in 4.16

Well, 1e369b0e199bb just remove warning from dmesg that reflinks are
experimental. Why to hide from users that kernels from 4.11 to 4.15 are
vulnerable? Also, Darrick marked his fix as vulnerable from 4.11 (Commit has
"Cc: stable@vger.kernel.org # v4.11" [1]), blog publish 4.11 [2], but LTP test
says "Test requires 4.16" => potential user of 4.11 will think "ok I'm safe".
IMHO perfect example of hiding kernel bug, specially due the fact that oldest
fixed kernel is v5.15.212, which backported upstream fix 2f4acd0fcd86 as
dc11be133efc, it was not backported to still supported LTS 5.10.x (EOL 31 Dec
2026) because it has conflicts.

> > Other than that LGTM.
> > Reviewed-by: Petr Vorel <pvorel@suse.cz>

> > > +			.mkfs_ver = "mkfs.xfs >= 1.5.0",
> > > +			.mkfs_opts = (const char *const []) {
> > > +				"-m", "reflink=1",
> > > +				NULL
> > > +			},
> > > +		},
> > > +		{}
> > > +	},
> > > +	.tags = (const struct tst_tag[]) {
> > > +		{"linux-git", "2f4acd0fcd86"},
> > Can you please before merge use longer hash
> > "2f4acd0fcd862e22eab45690ec2c08c80b6ef2e7"?

> I thought as a rule we always have to use short hash, we never use
> longer one, besides a couple of tests. Is there a reason for it?

I'm not sure if there was ever such rule, we just use short hash.

But isn't the possible git hash collision is a good reason to use full hash?
(Kernel repo has many commits => chance is higher in smaller repo e.g. LTP git.)

Specially in "linux-git" which has no git commit description, therefore user
would have to search by timestamp which has was valid. Also, that hash is used
as part of URL to the commit in git.kernel.org.

Because I have no evidence of git collision for 12 chars hash, let's use 2f4acd
(6 chars). URL in git.kernel org with hash collision [1] shows "Bad object id:
2f4acd".

User trying to investigate with git will see:

	$ git show 2f4acd
	error: short object ID 2f4acd is ambiguous
	hint: The candidates are:
	hint:   2f4acd0fcd86 commit 2026-07-13 - xfs: resample the data fork mapping after cycling ILOCK
	hint:   2f4acd6a2004 tree
	hint:   2f4acd8324d7 tree
	hint:   2f4acda35a5c tree
	fatal: ambiguous argument '2f4acd': unknown revision or path not in the working tree.

Anyway, I discussed it in the past [2] and I got ack from Cyril [3] and Jan [4],
and I posted my intention to implement it [5]. I'm sorry I did not post it to ML
to get the approval and instead merged it in 36dad3e738 [6]. I considered it as
agreed and I did not want to bother with yet another review. But I could have at
least sent informal patch with [COMMITTED] subject (maybe I should do at least
now).

Kind regards,
Petr


[1] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=206c09b04dc5469c7ff14d8aceff2d47c88078d9
[2] https://blog.qualys.com/vulnerabilities-threat-research/2026/07/22/refluxfs-a-linux-kernel-local-privilege-escalation-to-root-in-xfs-cve-2026-64600

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=2f4acd
[2] https://lore.kernel.org/ltp/20260331072051.GA5254@pevik/
[3] https://lore.kernel.org/ltp/act71G89AKEf63LA@yuki.lan/
[4] https://lore.kernel.org/ltp/CAASaF6xgitWDpquGfcALptj+Rv8iNg=FEifXzw+1dfXNVYNVxw@mail.gmail.com/
[5] https://lore.kernel.org/ltp/20260401094946.GA126168@pevik/
[6] https://github.com/linux-test-project/ltp/commit/36dad3e738e61c86669a76affb6d557f17311a7e

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
