Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03867C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 17:56:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9BF3B3CAD83
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 19:56:19 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DEA2E3CAD30
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:55:54 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 21CFF200345
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 19:55:53 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 93E70211DD;
 Mon, 31 Mar 2025 17:55:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743443752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhMbOPMBiF66Ak9LM+fmPtPWPqUa2xCsPmDNUkSOB4s=;
 b=qsyBfFS3GIKcYS/iqFuHPFL5U5WIx0kgWvkwsXMxtMNUYfskcTtkB4ODFajYAcVVfOH6xF
 P3sxt+2NngfIDGEY8zIaIrs0Wf7W4z2EC3ng4X1dz8tBUjI20seuw2WF6Q5tg+5sM6ckbZ
 jkPu5QEu1WJzMuC+ngixOx5cbipWzAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743443752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhMbOPMBiF66Ak9LM+fmPtPWPqUa2xCsPmDNUkSOB4s=;
 b=RmSDM89OfqMHZlvZ08Y3M+NvuzvJ76vl5xg2mzvIzF7m0U5atAk+OuxjcvnpV5AG+SSECn
 Lo4gz/s1TtRd3gBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=qsyBfFS3;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=RmSDM89O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743443752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhMbOPMBiF66Ak9LM+fmPtPWPqUa2xCsPmDNUkSOB4s=;
 b=qsyBfFS3GIKcYS/iqFuHPFL5U5WIx0kgWvkwsXMxtMNUYfskcTtkB4ODFajYAcVVfOH6xF
 P3sxt+2NngfIDGEY8zIaIrs0Wf7W4z2EC3ng4X1dz8tBUjI20seuw2WF6Q5tg+5sM6ckbZ
 jkPu5QEu1WJzMuC+ngixOx5cbipWzAw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743443752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xhMbOPMBiF66Ak9LM+fmPtPWPqUa2xCsPmDNUkSOB4s=;
 b=RmSDM89OfqMHZlvZ08Y3M+NvuzvJ76vl5xg2mzvIzF7m0U5atAk+OuxjcvnpV5AG+SSECn
 Lo4gz/s1TtRd3gBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6904713A1F;
 Mon, 31 Mar 2025 17:55:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id IRlVGCjX6me0eAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 17:55:52 +0000
Date: Mon, 31 Mar 2025 19:55:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250331175551.GB268097@pevik>
References: <20250328114311.187541-1-pvorel@suse.cz>
 <20250328114311.187541-2-pvorel@suse.cz>
 <Z-q8EyVlXNbHRbeg@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z-q8EyVlXNbHRbeg@yuki.lan>
X-Rspamd-Queue-Id: 93E70211DD
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/2] libs: Add safe_get_nodemap()
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> > +struct tst_nodemap *safe_get_nodemap(int type, size_t min_mem_kb, size_t required)
> > +{
> > +	struct tst_nodemap *nodes;
> > +
> > +	nodes = tst_get_nodemap(type, min_mem_kb);
> > +
> > +	if (nodes->cnt < required) {
> > +		tst_brk(TCONF, "Test requires at least %zi NUMA%s node%s",
> > +				required, tst_numa_type_name(type), required > 1 ? "s" : "");
>                                                                      ^
> 				     It does not make any sense to
> 				     request a NUMA with at least 1
> 				     node. Every computer has at least 1
> 				     node.

Thanks!

> It may make sense to TBROK if the minimal number of nodes <= 1

+1.

I guess we will find use for this even in the case of more complicated version
with struct tst_numa (it'd be used in tst_lib.c and in tests which specify nodes
via the command line parameter.

Thanks for your review!
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
