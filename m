Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D04FE77183
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 17:16:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DC423EC3EE
	for <ltp@archiver.kernel.org>; Mon, 16 Dec 2024 18:16:27 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B35E53EC3BE
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 18:16:12 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D638E658FF9
 for <ltp@lists.linux.it>; Mon, 16 Dec 2024 18:16:11 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 251221F395;
 Mon, 16 Dec 2024 17:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734369370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQq/nzPGeAcKTgqsih8291WTBa+Sf8E7Cue5sC1fLjE=;
 b=q9I2Mp1EACtvJVF7ATk3jTGHTnHd16F9R3EkvdYTXV35OmE/oWUWfWD2srSH/zMK9ytInd
 6gZwxNGjZsxUEIt++hqbP67meAVHpj9HDi+C+E2NEHbkVl6akX2yQ+MiYXuhTwxGJn2bIP
 C7Qzr6pWnaabQ59s331JI6QB6NMhD/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734369370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQq/nzPGeAcKTgqsih8291WTBa+Sf8E7Cue5sC1fLjE=;
 b=YT8MlbLiJKrKjnENpOFKTPWSpmHYslTE3wEtVa8ZcmI+0sSso7Ho7PVtuVgMcxHxK4ZoKv
 k2egV3RQzQlUE6DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734369370; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQq/nzPGeAcKTgqsih8291WTBa+Sf8E7Cue5sC1fLjE=;
 b=q9I2Mp1EACtvJVF7ATk3jTGHTnHd16F9R3EkvdYTXV35OmE/oWUWfWD2srSH/zMK9ytInd
 6gZwxNGjZsxUEIt++hqbP67meAVHpj9HDi+C+E2NEHbkVl6akX2yQ+MiYXuhTwxGJn2bIP
 C7Qzr6pWnaabQ59s331JI6QB6NMhD/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734369370;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQq/nzPGeAcKTgqsih8291WTBa+Sf8E7Cue5sC1fLjE=;
 b=YT8MlbLiJKrKjnENpOFKTPWSpmHYslTE3wEtVa8ZcmI+0sSso7Ho7PVtuVgMcxHxK4ZoKv
 k2egV3RQzQlUE6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 12C0C139D4;
 Mon, 16 Dec 2024 17:16:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id J4h8AlpgYGfjLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 16 Dec 2024 17:16:10 +0000
Date: Mon, 16 Dec 2024 18:16:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z2BgWWKUWr4cBuxZ@yuki.lan>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-6-chrubis@suse.cz>
 <20241210233453.GA386508@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241210233453.GA386508@pevik>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/5] mem/vma05.sh: Convert to the new shell library
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
> > +# env
> > +# {
> > +#  "needs_root": true,
> > +#  "needs_tmpdir": true,
> > +#  "needs_cmds": ["gdb"],
> > +#  "save_restore": [
> > +#   ["/proc/sys/kernel/core_pattern", "TBROK"],
> > +#   ["/proc/sys/kernel/core_uses_pid", "TBROK"]
> C API .save_restore has 3 members:
> 
> struct tst_path_val {
>         const char *path;
>         const char *val;
> 	unsigned int flags;
> };
> 
> Why don't you use it here? (e.g. NULL).

I did look at the parsed metadata in the ltp.json to check if we match
the format there and it seems that the parsing is broken, so there is no
point in designing the interface before we fix the C parser I guess.

This is there for the ksm01:

   "save_restore": [
     [
      "/sys/kernel/mm/ksm/run",
      "TST_SR_TBROK"
     ],
     [
      "/sys/kernel/mm/ksm/sleep_millisecs",
      "TST_SR_TBROK"
     ],
     [
      "/sys/kernel/mm/ksm/max_page_sharing",
      "TST_SR_SKIP_MISSING",
      "TST_SR_TCONF_RO"
     ],
     [
      "/sys/kernel/mm/ksm/merge_across_nodes",
      "1",
      "TST_SR_SKIP_MISSING",
      "TST_SR_TCONF_RO"
     ],
     [
      "/sys/kernel/mm/ksm/smart_scan",
      "0",
      "TST_SR_SKIP_MISSING",
      "TST_SR_TBROK_RO"
     ]
    ],

This is because the anonymous structures are parsed by the array parsing
code in the metaparse.c which is overly simplistics. And there are more
bugs in there unfortunately. I can fix the most pressing problems there:

- missing macro expansion
- missing NULL in the middle of intiliaziation
- properly concatenate entries
- limited recursive #include directive

Which will produce much saner output, but we will likely never be able
to produce clean enough output without using a proper tooling that can
do compile time arithmetics. Yes we have things like .needs_hugepages
with number of hugepages defined as (5 + 1) * 5 after a macro expansion.
Which ends up in the JSON as "(ARSZ + 1) * LOOP" which ends up as
"(50 + 1)*5" after this patch. Which is stil way better than the mess we
had there before.


Anyways, I will send a patch for the metaparse.c tomorrow, so that we
can fix that first.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
