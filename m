Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D05BE77184
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 10:46:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D700D3EC926
	for <ltp@archiver.kernel.org>; Thu, 19 Dec 2024 11:46:16 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 00E723E5E55
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 11:46:02 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 6A4A31039A2B
 for <ltp@lists.linux.it>; Thu, 19 Dec 2024 11:46:00 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2BE3E21164;
 Thu, 19 Dec 2024 10:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734605157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfRvgwzbGZ6hI4a3KhYxkkftIryzsc7E5SefRdz/2N4=;
 b=xPPDM1wKTq7reYW1OkQ3ANJ1tsmmHr9EWq9sluRWrWjEpVQ8AbMTN/4TCgpMPy9hWCkJz1
 uKh7LVlhKkobYLMcDjhxwsxA2Uqs+C/853/uzCO9QOzwwp/6ihulhJOMPYHGqTNSTWIDeS
 t4q4Q5e0KxclRZfX+r4ubr6EDLvbkEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734605157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfRvgwzbGZ6hI4a3KhYxkkftIryzsc7E5SefRdz/2N4=;
 b=ZkcBY0IPSP9IBfgdFQzJZScWNHB2wyIEvUpvadRDQuGnbAMIPhFfz+FbEJwHQadC++CYoy
 2PAtI2XBjhfuB1CA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1734605157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfRvgwzbGZ6hI4a3KhYxkkftIryzsc7E5SefRdz/2N4=;
 b=xPPDM1wKTq7reYW1OkQ3ANJ1tsmmHr9EWq9sluRWrWjEpVQ8AbMTN/4TCgpMPy9hWCkJz1
 uKh7LVlhKkobYLMcDjhxwsxA2Uqs+C/853/uzCO9QOzwwp/6ihulhJOMPYHGqTNSTWIDeS
 t4q4Q5e0KxclRZfX+r4ubr6EDLvbkEc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1734605157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dfRvgwzbGZ6hI4a3KhYxkkftIryzsc7E5SefRdz/2N4=;
 b=ZkcBY0IPSP9IBfgdFQzJZScWNHB2wyIEvUpvadRDQuGnbAMIPhFfz+FbEJwHQadC++CYoy
 2PAtI2XBjhfuB1CA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1C5CB13A8D;
 Thu, 19 Dec 2024 10:45:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YoTzBWX5Y2fVZgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Dec 2024 10:45:57 +0000
Date: Thu, 19 Dec 2024 11:45:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z2P5ZkeorHaHC0nh@yuki.lan>
References: <20241218190029.15015-1-chrubis@suse.cz>
 <20241218190029.15015-6-chrubis@suse.cz>
 <20241218192136.GE80422@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241218192136.GE80422@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 5/9] metadata: data_storage: Add two array
 functions
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
> > - data_node_array_last() returns last element in an array or NULL if empty
> 
> > - data_node_array_last_rem() removes and frees last element from an array
> Would you mind to add the above as /** */ doc to the functions before merging?
> (no need to repost).

The whole file needs documentation, I will add that to my ever growing
TODO.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
