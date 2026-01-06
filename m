Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8913C47BDE
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 10:00:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C05AC3C029D
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 11:00:14 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DD003C0224
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 10:59:54 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7765760068F
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 10:59:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1C536339D3;
 Tue,  6 Jan 2026 09:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767693593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+f8eK2LsbpZeasmPl6iheoP4hEsxJlO1a3tn7EkU0JM=;
 b=GGAK9NvfCoNIjTle5M6lkQFP2o3Xk1UGCboNo+6bPcpJqmQubMsZOT+c1EP39psGCr+Ukv
 zAO/jN3FVHbsKZKwCEpXgumU8YH3o+6IpkUKTkfVgZAnDrU67S4iSjMr1XwbQD6zRYD4Rx
 27Kp1qFSQUIk5y+ax72+Prqv0QFdzi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767693593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+f8eK2LsbpZeasmPl6iheoP4hEsxJlO1a3tn7EkU0JM=;
 b=hdNo6490Q9m9NtrR/CmW/14RJckAgt7MZUq7M3bOF1QdB0ykef6e+unaP45k1d7Pupqno5
 erysaL4l2fISFeAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767693593; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+f8eK2LsbpZeasmPl6iheoP4hEsxJlO1a3tn7EkU0JM=;
 b=GGAK9NvfCoNIjTle5M6lkQFP2o3Xk1UGCboNo+6bPcpJqmQubMsZOT+c1EP39psGCr+Ukv
 zAO/jN3FVHbsKZKwCEpXgumU8YH3o+6IpkUKTkfVgZAnDrU67S4iSjMr1XwbQD6zRYD4Rx
 27Kp1qFSQUIk5y+ax72+Prqv0QFdzi0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767693593;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+f8eK2LsbpZeasmPl6iheoP4hEsxJlO1a3tn7EkU0JM=;
 b=hdNo6490Q9m9NtrR/CmW/14RJckAgt7MZUq7M3bOF1QdB0ykef6e+unaP45k1d7Pupqno5
 erysaL4l2fISFeAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0986F3EA63;
 Tue,  6 Jan 2026 09:59:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id z2ojARndXGn+BQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 06 Jan 2026 09:59:53 +0000
Date: Tue, 6 Jan 2026 11:01:03 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <aVzdX6MEYO0GSk_k@yuki.lan>
References: <20251110024805.31070-1-wegao@suse.com>
 <20251223020836.9439-1-wegao@suse.com>
 <20251223020836.9439-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251223020836.9439-2-wegao@suse.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.989]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v6 1/4] lib: Add support option for .needs_cmds
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
> +enum cmd_ids {
> +	CMD,
> +	OPTIONAL,
> +	PRESENT,
> +};
> +
> +static ujson_obj_attr cmd_attrs[] = {
> +	UJSON_OBJ_ATTR_IDX(CMD, "cmd", UJSON_STR),
> +	UJSON_OBJ_ATTR_IDX(OPTIONAL, "optional", UJSON_INT),
> +	UJSON_OBJ_ATTR_IDX(PRESENT, "present", UJSON_INT),

I do not think that we should add the present attribute to the shell
parser, that attribute should never be set by the test and is set by the
shell library.


The rest looks good.

With the "present" attribute removed from the json parser:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
