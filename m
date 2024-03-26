Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46C3DC6FD1F
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 14:47:25 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6DE43D0EC6
	for <ltp@archiver.kernel.org>; Tue, 26 Mar 2024 15:47:22 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 47E643CC7D4
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:47:08 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5DD3810060A4
 for <ltp@lists.linux.it>; Tue, 26 Mar 2024 15:47:07 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D11C537CE7;
 Tue, 26 Mar 2024 14:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2zXnTnc5pmAHQnnpYe/wpU1v2kkWvw+szD4GSYwY4o=;
 b=vuedZq0hVWVMgBvmaS/EdtNG7CeEruqHTDYtkxf/Y71Dd53mXckndigPokUruBoZntzvil
 1eYsckTAz4Wbjl1rn9rCTCA22sB4Yve7vZkR58NgjnF9mwf6hYDbp8s4jLVXSWsRbLlSpV
 cO4svrKSX3OxSB18UoSG5/MMfQi92to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2zXnTnc5pmAHQnnpYe/wpU1v2kkWvw+szD4GSYwY4o=;
 b=hf1XcLNkYQCsQrNNacifc1ES/0g5Tb3G2jjK3XP+gprJGYdEM+7yCYKtwchElQbhLPDS5R
 5pI1mlGGrPtWngBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1711464426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2zXnTnc5pmAHQnnpYe/wpU1v2kkWvw+szD4GSYwY4o=;
 b=vuedZq0hVWVMgBvmaS/EdtNG7CeEruqHTDYtkxf/Y71Dd53mXckndigPokUruBoZntzvil
 1eYsckTAz4Wbjl1rn9rCTCA22sB4Yve7vZkR58NgjnF9mwf6hYDbp8s4jLVXSWsRbLlSpV
 cO4svrKSX3OxSB18UoSG5/MMfQi92to=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1711464426;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c2zXnTnc5pmAHQnnpYe/wpU1v2kkWvw+szD4GSYwY4o=;
 b=hf1XcLNkYQCsQrNNacifc1ES/0g5Tb3G2jjK3XP+gprJGYdEM+7yCYKtwchElQbhLPDS5R
 5pI1mlGGrPtWngBA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id B959213215;
 Tue, 26 Mar 2024 14:47:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id QptoKurfAmYdTQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 26 Mar 2024 14:47:06 +0000
Date: Tue, 26 Mar 2024 15:47:05 +0100
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Message-ID: <20240326144705.GG715328@pevik>
References: <20240326144145.747735-1-pvorel@suse.cz>
 <20240326144145.747735-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240326144145.747735-3-pvorel@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [-0.56 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 NEURAL_HAM_SHORT(-0.20)[-0.991]; RCPT_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 BAYES_HAM(-0.06)[60.99%]; ARC_NA(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/3] tst_test_macros.h: Require to pass array
 size in TST_EXP_FAIL*_ARR()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

> Although having to pass ARRAY_SIZE() of the expected errnos is not
> ideal, it gives more flexibility to the tests allowing to use just
> portion of the array (will be used in fanotify14 in the next commit).

> It looks to be better than keep introduce yet another functions.

I'm sorry, also splice07.c needs to be updated. I'll fix it before merge
(unless more changes require to send new version).

Kind regards,
Petr

+++ testcases/kernel/syscalls/splice/splice07.c
@@ -54,7 +54,7 @@ static void check_splice(struct tst_fd *fd_in, struct tst_fd *fd_out)
 	const int exp_errnos[] = {EBADF, EINVAL};
 
 	TST_EXP_FAIL2_ARR(splice(fd_in->fd, NULL, fd_out->fd, NULL, 1, 0),
-		exp_errnos, "splice() on %s -> %s",
+		exp_errnos, ARRAY_SIZE(exp_errnos), "splice() on %s -> %s",
 		tst_fd_desc(fd_in), tst_fd_desc(fd_out));
 }
 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
