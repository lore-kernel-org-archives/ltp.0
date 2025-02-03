Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29E71C02196
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 14:55:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 35D0A3C8F06
	for <ltp@archiver.kernel.org>; Mon,  3 Feb 2025 15:55:49 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5126A3C8ED5
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:55:31 +0100 (CET)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.de
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=akumar@suse.de; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 1581B141AB8C
 for <ltp@lists.linux.it>; Mon,  3 Feb 2025 15:55:30 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F37C2115C;
 Mon,  3 Feb 2025 14:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738594530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIQ+qp6yPAAi0569p4f2u5rSMZ47Tx4NB7nXUUFfAJ4=;
 b=arWunw9J3t093sS1EQFhKNgyLUJjTgeZQgfS+mjZzTJAv/37sNaVpuqUyJ7IyjY+LnUdOa
 th4oQGuoSRHQLZgL3uQ4eV0mZAhqtGx0FfQswNbVJTUdCGD4lbyNXUahv+CWAyYOUcxQ8C
 /n/opckJgzdk3KEDQWIga6g2W4v+drw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738594530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIQ+qp6yPAAi0569p4f2u5rSMZ47Tx4NB7nXUUFfAJ4=;
 b=SLeVwTmCycd00/Yaz9zFJzRFXrknoLNRsBVb9SJBNuv0iI2RGFLpxmPww+phoRTKm0sDN+
 JJ4r78btSfS6HdCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=arWunw9J;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=SLeVwTmC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1738594530; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIQ+qp6yPAAi0569p4f2u5rSMZ47Tx4NB7nXUUFfAJ4=;
 b=arWunw9J3t093sS1EQFhKNgyLUJjTgeZQgfS+mjZzTJAv/37sNaVpuqUyJ7IyjY+LnUdOa
 th4oQGuoSRHQLZgL3uQ4eV0mZAhqtGx0FfQswNbVJTUdCGD4lbyNXUahv+CWAyYOUcxQ8C
 /n/opckJgzdk3KEDQWIga6g2W4v+drw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1738594530;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GIQ+qp6yPAAi0569p4f2u5rSMZ47Tx4NB7nXUUFfAJ4=;
 b=SLeVwTmCycd00/Yaz9zFJzRFXrknoLNRsBVb9SJBNuv0iI2RGFLpxmPww+phoRTKm0sDN+
 JJ4r78btSfS6HdCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0313013A78;
 Mon,  3 Feb 2025 14:55:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MsxKAOLYoGfKTQAAD6G6ig
 (envelope-from <akumar@suse.de>); Mon, 03 Feb 2025 14:55:30 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Mon, 03 Feb 2025 15:55:29 +0100
Message-ID: <4654118.LvFx2qVVIh@thinkpad>
In-Reply-To: <20250203142213.GA1268944@pevik>
References: <20240530144406.7626-1-akumar@suse.de>
 <20240530144846.10915-1-akumar@suse.de> <20250203142213.GA1268944@pevik>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 0F37C2115C
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; CTE_CASE(0.50)[];
 MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; MISSING_XM_UA(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, suse.de:dkim]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] flock: Add test for verifying EINTR errno
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

On Monday, February 3, 2025 3:22:13 PM CET Petr Vorel wrote:
> Hi Avinesh, all,
> 
> ...
> > +++ b/testcases/kernel/syscalls/flock/flock07.c
> ...
> > +static void handler(int sig)
> > +{
> > +	tst_res(TINFO, "Received signal: %d", sig);
> How about print a signal constant/name?
> 
> 	tst_res(TINFO, "Received signal: %s (%d)", tst_strsig(sig), sig);
> > +}
> ...
> > +static void verify_flock(void)
> > +{
> > +	pid_t pid;
> > +	int fd1 = SAFE_OPEN(TEMPFILE, O_RDWR);
> > +	int fd2 = SAFE_OPEN(TEMPFILE, O_RDWR);
> How about to setup file descriptors in setup() and close them in cleanup()?
> 
> I suggest to merge with the change below.
Hi Petr,

Thank you for the review, and I agree with your suggestions.

Regards,
Avinesh

> 
> > +
> > +	TST_EXP_PASS(flock(fd1, LOCK_EX));
> > +
> > +	pid = SAFE_FORK();
> > +	if (!pid) {
> > +		child_do(fd2);
> > +		exit(0);
> > +	} else {
> > +		sleep(1);
> > +		SAFE_KILL(pid, SIGUSR1);
> > +		SAFE_WAITPID(pid, NULL, 0);
> > +	}
> > +
> > +	SAFE_CLOSE(fd1);
> > +	SAFE_CLOSE(fd2);
> > +}
> 
> Kind regards,
> Petr
> 
> +++ testcases/kernel/syscalls/flock/flock07.c
> @@ -17,14 +17,27 @@
>  
>  #define TEMPFILE "test_eintr"
>  
> +static int fd1 = -1, fd2 = -1;
> +
>  static void handler(int sig)
>  {
> -	tst_res(TINFO, "Received signal: %d", sig);
> +	tst_res(TINFO, "Received signal: %s (%d)", tst_strsig(sig), sig);
>  }
>  
>  static void setup(void)
>  {
>  	SAFE_TOUCH(TEMPFILE, 0777, NULL);
> +	fd1 = SAFE_OPEN(TEMPFILE, O_RDWR);
> +	fd2 = SAFE_OPEN(TEMPFILE, O_RDWR);
> +}
> +
> +static void cleanup(void)
> +{
> +	if (fd1 >= 0)
> +		SAFE_CLOSE(fd1);
> +
> +	if (fd2 >= 0)
> +		SAFE_CLOSE(fd2);
>  }
>  
>  static void child_do(int fd)
> @@ -42,8 +55,6 @@ static void child_do(int fd)
>  static void verify_flock(void)
>  {
>  	pid_t pid;
> -	int fd1 = SAFE_OPEN(TEMPFILE, O_RDWR);
> -	int fd2 = SAFE_OPEN(TEMPFILE, O_RDWR);
>  
>  	TST_EXP_PASS(flock(fd1, LOCK_EX));
>  
> @@ -56,13 +67,11 @@ static void verify_flock(void)
>  		SAFE_KILL(pid, SIGUSR1);
>  		SAFE_WAITPID(pid, NULL, 0);
>  	}
> -
> -	SAFE_CLOSE(fd1);
> -	SAFE_CLOSE(fd2);
>  }
>  
>  static struct tst_test test = {
>  	.setup = setup,
> +	.cleanup = cleanup,
>  	.test_all = verify_flock,
>  	.needs_tmpdir = 1,
>  	.needs_root = 1,
> 





-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
