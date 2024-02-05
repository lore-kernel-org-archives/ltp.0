Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FB4C4828D
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 17:35:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 14E203CF6FC
	for <ltp@archiver.kernel.org>; Mon,  5 Feb 2024 18:35:11 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D7DA63C90CF
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 18:34:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 211C7601A66
 for <ltp@lists.linux.it>; Mon,  5 Feb 2024 18:34:54 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 213C021ED6;
 Mon,  5 Feb 2024 17:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707154494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVg+Ds3kO4SDO9UCQ6B+hMOEumK/afcXibkbRR1jIPk=;
 b=l5E0ELKtKsPWE2GdIp0j3I/SAWVGPi4lv9pRiNkUsrgEp5MwJ13bS3zpIYOEpc2oGi7yx/
 Gx0n+WPF3Er2NsMYGR+y3GsP6THodKlTLhaxXOtexAP57EsFev3bFY7s+eRAVCWWIRDWnl
 XBm3uookzJ89rZIR2a9t1x/NeCZxbwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707154494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVg+Ds3kO4SDO9UCQ6B+hMOEumK/afcXibkbRR1jIPk=;
 b=pwa/hyh0cp4I7fjfprpj4oFg7XIof8X0TTO0I44psmMis6uQ5SU3+cxc0TQiQqAfpkZ8+e
 4huqo8BzFZ5/IkDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1707154494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVg+Ds3kO4SDO9UCQ6B+hMOEumK/afcXibkbRR1jIPk=;
 b=l5E0ELKtKsPWE2GdIp0j3I/SAWVGPi4lv9pRiNkUsrgEp5MwJ13bS3zpIYOEpc2oGi7yx/
 Gx0n+WPF3Er2NsMYGR+y3GsP6THodKlTLhaxXOtexAP57EsFev3bFY7s+eRAVCWWIRDWnl
 XBm3uookzJ89rZIR2a9t1x/NeCZxbwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1707154494;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rVg+Ds3kO4SDO9UCQ6B+hMOEumK/afcXibkbRR1jIPk=;
 b=pwa/hyh0cp4I7fjfprpj4oFg7XIof8X0TTO0I44psmMis6uQ5SU3+cxc0TQiQqAfpkZ8+e
 4huqo8BzFZ5/IkDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0315D136F5;
 Mon,  5 Feb 2024 17:34:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 1oy3Oj0cwWUaIgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 05 Feb 2024 17:34:53 +0000
Date: Mon, 5 Feb 2024 18:34:52 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20240205173452.GB218023@pevik>
References: <20240130162813.20278-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130162813.20278-1-mdoucha@suse.cz>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.70 / 50.00];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 RCPT_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] waitpid01: Test all standard deadly signals
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

Hi Martin,

first this change (merged as ed5ccf6c1 ("waitpid01: Test all standard deadly
signals") is failing on 6.6 on Debian:

ed5ccf6c1 ("waitpid01: Test all standard deadly signals")

waitpid01.c:88: TINFO: Testing child: raise(sig)
waitpid01.c:109: TPASS: waitpid() returned correct pid 236064
waitpid01.c:118: TPASS: WIFSIGNALED() set in status
waitpid01.c:126: TPASS: WTERMSIG() == SIGIOT/SIGABRT
waitpid01.c:143: TPASS: Child dumped core as expected
waitpid01.c:109: TPASS: waitpid() returned correct pid 236071
waitpid01.c:118: TPASS: WIFSIGNALED() set in status
waitpid01.c:126: TPASS: WTERMSIG() == SIGALRM
waitpid01.c:109: TPASS: waitpid() returned correct pid 236072
waitpid01.c:118: TPASS: WIFSIGNALED() set in status
waitpid01.c:126: TPASS: WTERMSIG() == SIGBUS
waitpid01.c:143: TPASS: Child dumped core as expected
waitpid01.c:109: TPASS: waitpid() returned correct pid 236082
waitpid01.c:113: TFAIL: WIFSIGNALED() not set in status (exited with 0)
...
waitpid01.c:88: TINFO: Testing child: kill(getpid(), sig)
waitpid01.c:109: TPASS: waitpid() returned correct pid 236165
waitpid01.c:118: TPASS: WIFSIGNALED() set in status
waitpid01.c:126: TPASS: WTERMSIG() == SIGIOT/SIGABRT
waitpid01.c:143: TPASS: Child dumped core as expected
waitpid01.c:109: TPASS: waitpid() returned correct pid 236176
waitpid01.c:118: TPASS: WIFSIGNALED() set in status
waitpid01.c:126: TPASS: WTERMSIG() == SIGALRM
waitpid01.c:109: TPASS: waitpid() returned correct pid 236177
waitpid01.c:118: TPASS: WIFSIGNALED() set in status
waitpid01.c:126: TPASS: WTERMSIG() == SIGBUS
waitpid01.c:143: TPASS: Child dumped core as expected
waitpid01.c:109: TPASS: waitpid() returned correct pid 236187
waitpid01.c:113: TFAIL: WIFSIGNALED() not set in status (exited with 0)
...

But it works on 6.8.0-rc1-2.gf4ba5db-default Tumbleweed, which I tested it
before.

Also patch does not apply. I had to patch waitpid01 myself, hopefully I did that
correctly [1].

Kind regards,
Petr

[1] https://github.com/pevik/ltp/blob/mdoucha/waitpid05/testcases/kernel/syscalls/waitpid/waitpid01.c

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
