Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAEECDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 13:22:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C5A0F3E6273
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 15:22:03 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 987BA3E2876
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:21:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 321621400990
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:21:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 95AFB75ECF;
 Wed, 24 Jun 2026 13:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782307304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91wUyOVpzOxrfjAE5XY8AIvNC7cJgtLgVW3cQmnm+oA=;
 b=hNmp0SO1LO1Gc87o8zMTCmmD45zebrLPc4tXdU+ebVDvMmGOfvTOP1QYojWHWAHRWez9AS
 elQAN9ELn0M3udb2hIpmRMM2e6vUmmCB5BslkfI+fc6sBHA6c9/zIkUmvi8079CyDVNKcD
 ADiRo+XQmrEPw+gX3Yz8De+FjzQqOuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782307304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91wUyOVpzOxrfjAE5XY8AIvNC7cJgtLgVW3cQmnm+oA=;
 b=1nVEgOKaCvJWYNToFQyebrA+J4ZGGxb3eRUmSvu14n/TJ8L6DXJV+VndNFAvdsVRCSFKhh
 N0Ht6OgFCa6ftQBg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hNmp0SO1;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1nVEgOKa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1782307304; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91wUyOVpzOxrfjAE5XY8AIvNC7cJgtLgVW3cQmnm+oA=;
 b=hNmp0SO1LO1Gc87o8zMTCmmD45zebrLPc4tXdU+ebVDvMmGOfvTOP1QYojWHWAHRWez9AS
 elQAN9ELn0M3udb2hIpmRMM2e6vUmmCB5BslkfI+fc6sBHA6c9/zIkUmvi8079CyDVNKcD
 ADiRo+XQmrEPw+gX3Yz8De+FjzQqOuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1782307304;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=91wUyOVpzOxrfjAE5XY8AIvNC7cJgtLgVW3cQmnm+oA=;
 b=1nVEgOKaCvJWYNToFQyebrA+J4ZGGxb3eRUmSvu14n/TJ8L6DXJV+VndNFAvdsVRCSFKhh
 N0Ht6OgFCa6ftQBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 85131779A8;
 Wed, 24 Jun 2026 13:21:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id WzQoH+jZO2rfAgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 24 Jun 2026 13:21:44 +0000
Date: Wed, 24 Jun 2026 15:21:44 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <ajvZ6GpGbLk6iNrj@yuki.lan>
References: <ajvNadKNfin2Ati9@yuki.lan>
 <6a3bcf9b.a1a40faf.11c7da.da5c@mx.google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6a3bcf9b.a1a40faf.11c7da.da5c@mx.google.com>
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 95AFB75ECF
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/13] vma05.sh, keyctl01.sh: Add groups
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
> > Also linter should be cheaper and pretty easy for this case.
> 
> We can easily do that yes, but I don't know where we could implement
> this inside the make check command. I guess we need one more script
> verifying the parent folders/test tags and cross-checking with the
> group name which has been assigned.

Or we can write a linter for the metadata. I guess that we can add that
to the metaparse tool. We need to check the tags for correctness
somewhere as well, otherwise we will get wrongly formatted CVE tags in
the future as well.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
