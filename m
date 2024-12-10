Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A089DE7717F
	for <ltp@archiver.kernel.org>; Tue, 10 Dec 2024 23:39:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 219723E9456
	for <ltp@archiver.kernel.org>; Wed, 11 Dec 2024 00:39:54 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1015D3E1169
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:39:38 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 4BDE314280AB
 for <ltp@lists.linux.it>; Wed, 11 Dec 2024 00:39:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1FB821F38C;
 Tue, 10 Dec 2024 23:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733873976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQmq9pTvCRuQm+++RjJZpQqcsjy/SdRVzZ5V/3PhvKk=;
 b=u52zLxbuZ273QDb+H8afGcfsLvvqjSUVkF6HX2EM2e4WA/aISjbSP1JfF3foeZPagulhaZ
 v0gSDcRgxmLlfByLgnoISlOF+VpYrJRKhBaAF7/Pp9gRH/VWvDEBvNDVpS/zN7H5V9qtME
 qjjW+8eVnrJgJslccS4NvRqHAScSWK8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733873976;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQmq9pTvCRuQm+++RjJZpQqcsjy/SdRVzZ5V/3PhvKk=;
 b=3If16ifyZLp97dUhpzM7arc/9sp776AxuwyONBS0/r9cMCv9cjAWvecsyXZFPLhaE1PXVT
 H7qngj9nGNTCPRBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733873975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQmq9pTvCRuQm+++RjJZpQqcsjy/SdRVzZ5V/3PhvKk=;
 b=ic9jLcP2HSdhMiX7M5FyHzz+CxLkp1M/pyfxHHOLK8Qah29L2EHl3UYES6oJh9Fj6iXlFJ
 IPdO2QXoXEG37CYXUtRJzmATv3c8MSIZRJd6hid/Yup6ET6a18k9pZimV3q9pz79AeB6rp
 OGq6CKgjbZtEpscYa6cFVdqP6Xgy8wM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733873975;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kQmq9pTvCRuQm+++RjJZpQqcsjy/SdRVzZ5V/3PhvKk=;
 b=VE4HLhrybjS4qvVxGCXWsRMZazhlbm6ih3ziBki3HsxpDIDo4aeIZunYT8ngZ3FogWg47R
 5Ms/EY64/0eiLzBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04475138D2;
 Tue, 10 Dec 2024 23:39:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +X2HOjbRWGfXMwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 10 Dec 2024 23:39:34 +0000
Date: Wed, 11 Dec 2024 00:39:29 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20241210233929.GB386508@pevik>
References: <20241203151530.16882-1-chrubis@suse.cz>
 <20241203151530.16882-2-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241203151530.16882-2-chrubis@suse.cz>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; RCVD_TLS_ALL(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email,imap1.dmz-prg2.suse.org:helo,vma05.sh:url];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/5] tst_run_shell: Add save_restore parser
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

...
> +		UJSON_ARR_FOREACH(reader, val) {
> +			if (val->type != UJSON_STR) {
> +				ujson_err(reader, "Expected string!");
> +				return NULL;
> +			}
> +
> +			if (!path) {
> +				path = strdup(val->val_str);
> +			} else if (!flags_set) {
> +				if (!strcmp(val->val_str, "TCONF")) {
> +					flags = TST_SR_TCONF;
> +				} else if (!strcmp(val->val_str, "TBROK")) {
> +					flags = TST_SR_TBROK;
> +				} else if (!strcmp(val->val_str, "SKIP")) {
> +					flags = TST_SR_SKIP;
> +				} else {
> +					ujson_err(reader, "Invalid flags!");
> +					return NULL;
> +				}
> +
> +				flags_set = 1;
> +			} else {
> +				ujson_err(reader, "Expected only two members!");

As I noted at vma05.sh, C API supports 3 members (also value).
Maybe vma05.sh does not need it, but wouldn't be better to support it?

Otherwise LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Also, while you at it:

-struct tst_test test = {
+static struct tst_test test = {


Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
