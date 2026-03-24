Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63666F532EB
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 08:21:10 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 081363E2AE2
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 09:21:09 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9A213E2254
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:20:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6CF631A0080F
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 09:20:49 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A77604D1DA;
 Tue, 24 Mar 2026 08:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774340448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dIfS/jxK+tpyHD9nG09AGXtEVEn1SN6eyH8zCcohCA=;
 b=Y6CggqmgflSjzuDnouvJSDF0feZiKoPUcJNY2q4k3QBj2fom0ScsS5TsmJpnJuJAf78mjs
 tYHRFNv2yk0+kmPBXf9m8+IPFVBw1ffX3skglpy7VNahlwWuHFLu8xX1FnfrhBpONNWRey
 bWYjhWwJPXfXtJbciJfTB7sjHXbWoH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774340448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dIfS/jxK+tpyHD9nG09AGXtEVEn1SN6eyH8zCcohCA=;
 b=PmqJPIIqxskzI35VsPnMXswS3t2PZp+GI2uGOiHUvEgc+LNMbQi4PFBbSKskEwkMi9Do2B
 ulW/cBxlTzdSA2Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1774340448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dIfS/jxK+tpyHD9nG09AGXtEVEn1SN6eyH8zCcohCA=;
 b=Y6CggqmgflSjzuDnouvJSDF0feZiKoPUcJNY2q4k3QBj2fom0ScsS5TsmJpnJuJAf78mjs
 tYHRFNv2yk0+kmPBXf9m8+IPFVBw1ffX3skglpy7VNahlwWuHFLu8xX1FnfrhBpONNWRey
 bWYjhWwJPXfXtJbciJfTB7sjHXbWoH8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1774340448;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3dIfS/jxK+tpyHD9nG09AGXtEVEn1SN6eyH8zCcohCA=;
 b=PmqJPIIqxskzI35VsPnMXswS3t2PZp+GI2uGOiHUvEgc+LNMbQi4PFBbSKskEwkMi9Do2B
 ulW/cBxlTzdSA2Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90EE843D3A;
 Tue, 24 Mar 2026 08:20:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +/5DImBJwmkSWgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 24 Mar 2026 08:20:48 +0000
Date: Tue, 24 Mar 2026 09:20:47 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <20260324082047.GA36627@pevik>
References: <20260324-fix_dio_read-v1-1-cf5dfa13e46a@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260324-fix_dio_read-v1-1-cf5dfa13e46a@suse.com>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:email];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCVD_TLS_ALL(0.00)[];
 RCPT_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:email,suse.cz:replyto,suse.cz:email];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dio_read: fix infinite loop when readsize >=
 filesize
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

> The do_direct_reads() function had exit conditions inside the inner
> for loop. When readsize >= filesize, the for loop condition is never
> true, causing the while(1) loop to spin infinitely without checking
> if writers completed or runtime expired.

> Move the exit condition checks outside the for loop to ensure they
> are evaluated on every iteration, regardless of readsize/filesize
> parameters.

> Signed-off-by: Andrea Cervesato <andrea.cervesato@suse.com>
> ---
> There's a sporadic failure in DOR000 that causes test to loop
> indefinetly under s390x. This patch tries to fix the issue by ensuring
> test will check runtime and if children completed.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

As a fix for indefinite loop LGTM. But why it happen readsize >= filesize? These
are related to -r and -s values, but we always use -r 512k -w 512k -s 32M.
I wonder why this happen only on s390x? (I'd expect ppc64le which has different
page size.

Also that means that pread() is skipped when this happen.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
