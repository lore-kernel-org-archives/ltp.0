Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DACD0CCA470
	for <ltp@archiver.kernel.org>; Wed,  1 Oct 2025 10:47:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 062883CE393
	for <ltp@archiver.kernel.org>; Wed,  1 Oct 2025 12:47:38 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 933F83CE2E3
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 12:47:21 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D4E5320005C
 for <ltp@lists.linux.it>; Wed,  1 Oct 2025 12:47:20 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D86E3373E;
 Wed,  1 Oct 2025 10:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759315638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnnZ61k4ypmAp/HXMzyKFHFSt/ak0Al0rAl+3LKPB9M=;
 b=iegbdIPV4WatBQubVclsM88d6f5Zm1dXld+MdGf9J+0ygDa39APbTC61F8Eq3v/8SmKm6s
 gLt3iY2na6LjJWymkXaTbR7geKor3vndw181Hlz/zR9FhIVx21vm8X9gpX3kgaEadxSQd3
 r9BLFyNTQC2p11NvZBzyCAOObnwaFrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759315638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnnZ61k4ypmAp/HXMzyKFHFSt/ak0Al0rAl+3LKPB9M=;
 b=qXbICzEtFKO4WVv4dwR8bzObSSj3vhgOR0C8tKQs3VZPBFEGqsZFZ7MXCzLeJYWBkNnOml
 6WGfFOaJjXZhaRCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=iegbdIPV;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=qXbICzEt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1759315638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnnZ61k4ypmAp/HXMzyKFHFSt/ak0Al0rAl+3LKPB9M=;
 b=iegbdIPV4WatBQubVclsM88d6f5Zm1dXld+MdGf9J+0ygDa39APbTC61F8Eq3v/8SmKm6s
 gLt3iY2na6LjJWymkXaTbR7geKor3vndw181Hlz/zR9FhIVx21vm8X9gpX3kgaEadxSQd3
 r9BLFyNTQC2p11NvZBzyCAOObnwaFrY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1759315638;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bnnZ61k4ypmAp/HXMzyKFHFSt/ak0Al0rAl+3LKPB9M=;
 b=qXbICzEtFKO4WVv4dwR8bzObSSj3vhgOR0C8tKQs3VZPBFEGqsZFZ7MXCzLeJYWBkNnOml
 6WGfFOaJjXZhaRCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A204013A42;
 Wed,  1 Oct 2025 10:47:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id K/AGJbUG3WhKXQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 01 Oct 2025 10:47:17 +0000
Date: Wed, 1 Oct 2025 12:47:11 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, Cyril Hrubis <chrubis@suse.cz>,
 Wei Gao <wegao@suse.com>
Message-ID: <20251001104711.GA265041@pevik>
References: <20250929112950.24420-1-wegao@suse.com> <aNp1-2OnRNauyQ2e@yuki.lan>
 <c4c658bc-1a29-45de-972b-c6582e926db6@suse.cz>
 <20250929181114.GA217041@pevik> <20250930085858.GA224315@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250930085858.GA224315@pevik>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_THREE(0.00)[4];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 0D86E3373E
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] mount08.c: Add min_kver for test case
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

Hi all,

...
> ...
> > For a record, d80b065bb172 is a merge commit, the fix contains actually 7
> > commits. IMHO none of them has been backported to any stable / LTS kernel.  I'll
> > ask Christian and Greg if it makes sense to backport it.

> asked [1]. (unfortunately I forgot to delete message-id and From: from the
> original message).

FYI answer from Aleksa [2] suggests it will not be backported, but let's wait
if somebody else give his opinion. Anyway, I'm not advocating for this patch
(to add .min_kver = "6.12"), although it wouldn't harm to document it in the
test that unlike kernel folks which consider it as a "new feature" we consider
it as a "security fix".

Kind regards,
Petr

> Kind regards,
> Petr

> [1] https://lore.kernel.org/all/20240806-work-procfs-v1-0-fb04e1d09f0c@kernel.org/
[2] https://lore.kernel.org/linux-fsdevel/2025-09-30-emerald-unsure-pillow-prism-nKVGLB@cyphar.com/

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
