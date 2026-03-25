Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B41FEA83B
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 09:38:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 85D413E2ACD
	for <ltp@archiver.kernel.org>; Wed, 25 Mar 2026 10:38:09 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 945023CC6A9
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:37:50 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 13E751400331
 for <ltp@lists.linux.it>; Wed, 25 Mar 2026 10:37:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F33215BCCD;
 Wed, 25 Mar 2026 09:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774431469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9QgMDXlcIROaSOmmRQ/T+X1V+RqnDjM3foR61GXhCM=;
 b=JvMxbiWXIRl9nyMPl6qxbdOcIm3MNxaDNwDuitax4M5OsbGVMdFYc8sUfP7COyKTQawOPC
 tCPa9ONATaSjOxBcscxudfWXOlThpcoJxamHDS/+ixc7T+K0TBlelpPEelha8M3bR3oRfJ
 4J7RkU5MNrERi/SH9l3eDGJXpczRWIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774431469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9QgMDXlcIROaSOmmRQ/T+X1V+RqnDjM3foR61GXhCM=;
 b=pr2vRkkWcw5OPOnOoUnQGKPzlCyIWx6Ui75No54pLs/nKIeyQ4nS/kktKarpiyxJ9fqAwF
 t09dTBjevx52B2DA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774431469; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9QgMDXlcIROaSOmmRQ/T+X1V+RqnDjM3foR61GXhCM=;
 b=JvMxbiWXIRl9nyMPl6qxbdOcIm3MNxaDNwDuitax4M5OsbGVMdFYc8sUfP7COyKTQawOPC
 tCPa9ONATaSjOxBcscxudfWXOlThpcoJxamHDS/+ixc7T+K0TBlelpPEelha8M3bR3oRfJ
 4J7RkU5MNrERi/SH9l3eDGJXpczRWIQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774431469;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o9QgMDXlcIROaSOmmRQ/T+X1V+RqnDjM3foR61GXhCM=;
 b=pr2vRkkWcw5OPOnOoUnQGKPzlCyIWx6Ui75No54pLs/nKIeyQ4nS/kktKarpiyxJ9fqAwF
 t09dTBjevx52B2DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DE0BA44325;
 Wed, 25 Mar 2026 09:37:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z39fNeysw2n1GQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 25 Mar 2026 09:37:48 +0000
Date: Wed, 25 Mar 2026 10:37:50 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Cermak <mcermak@redhat.com>
Message-ID: <acOs7mrlNceEtchW@yuki.lan>
References: <20260323210805.20929-1-pvorel@suse.cz> <acKPE_1MwQhayd4O@yuki.lan>
 <20260324140938.nxlzn5f2f6iakrm5@lida.tpb.lab.eng.brq.redhat.com>
 <20260325090648.diugdugszgd3inuo@lida.tpb.lab.eng.brq.redhat.com>
 <20260325091003.GA86256@pevik>
 <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260325092156.3sxnn26nlejzzygn@lida.tpb.lab.eng.brq.redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.997]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] [RFC PATCH 1/1] LTP tests: Run
 without LTP_REPRODUCIBLE_OUTPUT=1
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
Cc: valgrind-developers@lists.sourceforge.net, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I still feel these 2 variables somehow overlap, wouldn't it make sense to merge
> > the functionality into a single variable?
> 
> That sounds reasonable to me.  Which one would you prefer to
> keep?  I'm inclined to suggest keeping LTP_REPRODUCIBLE_OUTPUT
> and dropping LTP_QUIET but no really strong preference on my
> side.  Thoughts?

Maybe we can finally implement proper debug levels in LTP. E.g. hide
TINFO and TWARN messages with debug level 0 and default to debug level
1. With debug level 2 we would show TDEBUG as well and with debug level
3 we would show TDEBUG messages for library too.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
