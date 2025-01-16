Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC727C02183
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 14:58:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32C0B3C7BF4
	for <ltp@archiver.kernel.org>; Thu, 16 Jan 2025 15:58:14 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4DA113C7BE9
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 15:57:56 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4B0C8228F19
 for <ltp@lists.linux.it>; Thu, 16 Jan 2025 15:57:55 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DD1EF211A6;
 Thu, 16 Jan 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9EB1E13A57;
 Thu, 16 Jan 2025 14:57:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6aVcJHIeiWc9IgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 16 Jan 2025 14:57:54 +0000
Date: Thu, 16 Jan 2025 15:57:41 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z4keZU7GWrRPziZU@yuki.lan>
References: <20250116-fix_setsid_tests-v4-0-910f062a7235@suse.com>
 <20250116-fix_setsid_tests-v4-10-910f062a7235@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250116-fix_setsid_tests-v4-10-910f062a7235@suse.com>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: DD1EF211A6
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 10/12] Refactor pty01 test
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
> +	tst_res(TINFO, "Send message to master and read it from slave");
>  
> -	errno = 0;
> -	if ((i = read(slavefd, &c, 1)) == 1) {
> -		tst_brkm(TFAIL, NULL,
> -			 "reading from slave fd should have failed, but didn't"
> -			 "(read '%c')", c);
> -	}
> +	memset(buf, 0, BUFSIZ);
> +	SAFE_WRITE(SAFE_WRITE_ALL, masterfd, STRING, string_len);

I guess that we can read and check the exact lenght here because no
conversions happne when we write to the master.

> +	SAFE_READ(0, slavefd, buf, string_len + 1);
> +	TST_EXP_EQ_STRN(STRING, buf, string_len - 1);
>  
> -	if ((i = write(slavefd, &c, 1)) == 1) {
> -		tst_brkm(TFAIL, NULL,
> -			 "writing to slave fd should have failed, but didn't");
> -	}
> +	tst_res(TINFO, "Send message to slave and read it from master");
>  
> -	if (ioctl(slavefd, TIOCGWINSZ, NULL) == 0) {
> -		tst_brkm(TFAIL, NULL,
> -			 "trying TIOCGWINSZ on slave fd should have failed, "
> -			 "but didn't");
> -	}
> -
> -	if (close(slavefd) != 0) {
> -		tst_brkm(TBROK, NULL, "close");
> -	}
> -	tst_resm(TPASS, "test2");
> +	memset(buf, 0, BUFSIZ);
> +	SAFE_WRITE(SAFE_WRITE_ALL, slavefd, STRING, string_len);

Maybe a note that we need to read string_len + 1 here because kernel
converts the newline into carriage return + newline in this case.

> +	SAFE_READ(0, masterfd, buf, string_len + 1);
> +	TST_EXP_EQ_STRN(STRING, buf, string_len - 1);
>  }

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
