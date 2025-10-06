Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C77CAC5B8
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 09:36:05 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 488313CE088
	for <ltp@archiver.kernel.org>; Mon,  6 Oct 2025 11:36:04 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ECBD03CD1FB
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 11:35:46 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 3DD9F140044C
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 11:35:45 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 814AB1F7DE;
 Mon,  6 Oct 2025 09:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759743339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
 b=MuR8qeLzx/k+M3urYrvkqVZprq3RG4WU2XRSL7W6WFvBYWv3Z8bJ2bG3E2sO+WcMGrkQf4
 rWbx+y3+LxBcjEfsI7oPHhdKGfaYXK+AdL8D5GhP8mLi8mh0HBiUqcptftP+nPqdCnG6y6
 ufFoeH/fmux4lvMch1MwpuOv13Wh66A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759743339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
 b=C+LvNU6Zk/GAl+9ljhy2UvDxGFr/zLXt4Tc6awd/oWFneELrA3Sq/L0CJB8T7bqVJ1usOA
 jQNjNHnwjWw9PgDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=MuR8qeLz;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=C+LvNU6Z
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759743339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
 b=MuR8qeLzx/k+M3urYrvkqVZprq3RG4WU2XRSL7W6WFvBYWv3Z8bJ2bG3E2sO+WcMGrkQf4
 rWbx+y3+LxBcjEfsI7oPHhdKGfaYXK+AdL8D5GhP8mLi8mh0HBiUqcptftP+nPqdCnG6y6
 ufFoeH/fmux4lvMch1MwpuOv13Wh66A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759743339;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MIKGvbg7G2meU14KSmH35tkTzGrasWbNJ/rdqPPFnkM=;
 b=C+LvNU6Zk/GAl+9ljhy2UvDxGFr/zLXt4Tc6awd/oWFneELrA3Sq/L0CJB8T7bqVJ1usOA
 jQNjNHnwjWw9PgDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5ACD413700;
 Mon,  6 Oct 2025 09:35:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uSFvFGuN42i/QQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 06 Oct 2025 09:35:39 +0000
Date: Mon, 6 Oct 2025 11:35:38 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20251006093538.GA66983@pevik>
References: <20251002083701.315334-1-pvorel@suse.cz>
 <DDB27AD5V8CC.HACBLFITNI9R@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <DDB27AD5V8CC.HACBLFITNI9R@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 814AB1F7DE
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 0/4] ima_{conditionals,
 measurements}.sh enhancements
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
Cc: linux-integrity@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Andrea,

...
> What about creating a tool simulating sudo? I thought that was our main
> goal. Using 'su' is ok, but this forces us to create a new user all the
> times we execute a new suite, while our new sudo implementation would
> create and destroy the user only for the specific session.

Jan suggested to implement it [1] ("changes uid/git based on parameters and
executes whatever we give it"). I'll move the discussion under that thread so
that we have it on single place.

Kind regards,
Petr

[1] https://lore.kernel.org/ltp/CAASaF6yjdrLLVnehESx1TjsrB_z48nmN_2i585GPfkG3Vvg15Q@mail.gmail.com/

> - Andrea

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
