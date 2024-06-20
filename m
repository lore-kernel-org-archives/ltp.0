Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA1EFC27C79
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 05:09:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B76B3D0DE1
	for <ltp@archiver.kernel.org>; Thu, 20 Jun 2024 07:09:21 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DB21A3CF2D7
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:09:05 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 661D220A6CC
 for <ltp@lists.linux.it>; Thu, 20 Jun 2024 07:09:04 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 46F6721A2E;
 Thu, 20 Jun 2024 05:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718860143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tNTto4/zvVEN6Saa+LjBuZAJZpKup2e29p+th1aDsdk=;
 b=WiYt4U4NgaCX7bE8ETyFlWCUQioU1HaBLzmFSbPI1XUR4slMJoI61LnxF0Yjw3p1HIx3UJ
 CMYn4uGbCK29xKBoFHzUU30kNZL5657zv6XbFMLmHEtXc+fn4h+wFGgivTimS0vXxlSnTZ
 vI/XGdS1DkgeJBcBkp1YEvOSbND4ADk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718860143;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tNTto4/zvVEN6Saa+LjBuZAJZpKup2e29p+th1aDsdk=;
 b=YHVWiykvvq3cnoN104S/s++rtA8/aiPMbL7gXfBxkFcU4IrrvjOooWf+6mxqHozQVTSjVY
 wuHwJEQ7jaIbTyBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Wuu83DpJ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="d2oyi5n/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1718860142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tNTto4/zvVEN6Saa+LjBuZAJZpKup2e29p+th1aDsdk=;
 b=Wuu83DpJ1HrqnLWDVQkezpNQ/qAP/vi630wHz6muNsQjfS93Tsf2nN8VCFAy4E6BawoGJq
 yw7yIAgh8y2B8ElegjFbiWkZ8wWpUOAhG11IfmX6PGhSzlEdAtpcev3mTeJtEBfFGUkEhV
 iMj1Ijl5ZYQ6FmSX9f91rgbM68QpvvE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1718860142;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tNTto4/zvVEN6Saa+LjBuZAJZpKup2e29p+th1aDsdk=;
 b=d2oyi5n/B690SYGtHfjskvSMTURid3gEnxEyDty+8r4LLfDE48th1XICebVeuwE+OK9HTH
 apWPQhv8WmD0gVBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2F06F1369F;
 Thu, 20 Jun 2024 05:09:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GNG8Cm65c2bKJgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 20 Jun 2024 05:09:02 +0000
Date: Thu, 20 Jun 2024 07:09:00 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Po-Hsu Lin <po-hsu.lin@canonical.com>
Message-ID: <20240620050900.GB537887@pevik>
References: <20240620032737.1421923-1-po-hsu.lin@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240620032737.1421923-1-po-hsu.lin@canonical.com>
X-Rspamd-Queue-Id: 46F6721A2E
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:replyto,suse.cz:dkim];
 ARC_NA(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCHv2] logrotate: fix permission issue for test2
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

Hi Po-Hsu,

> When running this logrotate test on Ubuntu, this test will fail with:
>   logrotate_tests 2 TINFO: sleep 1 min to wait for rotating logs
>   logrotate_tests 2 TFAIL: [ -f /var/log/tst_largelogfile.1.gz ] failed unexpectedly
>   logrotate_tests 2 TFAIL: Failed to create a compressed file

> Look more closely to what this test is trying to do we will see there
> are two issues here in the tst_largelog.conf:

> 1. "include /etc/logrotate.d"
> This will rotate other log files defined here, since we are just testing
> the log rotation capability I think there is no need to rotate log files
> other than the testfile itself.

BTW (for next time): I would have separated these 2 changes into 2 commits.

Kind regards,
Petr

> 2. Permission issue
> Trying to rotate the target file on Ubuntu will cause the following error:
>   error: skipping "/var/log/tst_largelogfile" because parent directory has
>          insecure permissions (It's world writable or writable by group which
>          is not "root") Set "su" directive in config file to tell logrotate
>          which user/group should be used for rotation.



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
