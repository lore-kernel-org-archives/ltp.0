Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEC18C02182
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 18:13:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DEAFA3C4E58
	for <ltp@archiver.kernel.org>; Thu, 23 Jan 2025 19:13:09 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 962F13C32F0
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 19:12:53 +0100 (CET)
Authentication-Results: in-4.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 76766121A06E
 for <ltp@lists.linux.it>; Thu, 23 Jan 2025 19:12:52 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 93EF71F38C;
 Thu, 23 Jan 2025 18:12:52 +0000 (UTC)
Authentication-Results: smtp-out2.suse.de;
	none
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C66E91351A;
 Thu, 23 Jan 2025 18:12:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id JgV6LaOGkmeZfgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 23 Jan 2025 18:12:51 +0000
Date: Thu, 23 Jan 2025 19:12:40 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20250123181240.GA134067@pevik>
References: <20250123143633.3680575-1-svens@linux.ibm.com>
 <Z5JVa6MgafKoBiyt@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z5JVa6MgafKoBiyt@yuki.lan>
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Queue-Id: 93EF71F38C
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3] mmap01: fix check_file() test for file
 corruption
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
Cc: Sven Schnelle <svens@linux.ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

Reviewed-by: Petr Vorel <pvorel@suse.cz>

> Hi!
> > diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
> > index c93c37ceda52..ffbe6485a09c 100644
> > --- a/testcases/kernel/syscalls/mmap/mmap01.c
> > +++ b/testcases/kernel/syscalls/mmap/mmap01.c
> > @@ -35,19 +35,23 @@ static void check_file(void)
> >  {
> >  	int i, fildes, buf_len = sizeof(STRING) + 3;
> >  	char buf[buf_len];
> > +	ssize_t len;

> >  	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
> > -	SAFE_READ(0, fildes, buf, sizeof(buf));
> > -
> > -	for (i = 0; i < buf_len; i++)
> > +	len = SAFE_READ(0, fildes, buf, sizeof(buf));
> > +	if (len != strlen(STRING)) {
> > +		tst_res(TFAIL, "Read %zi expected %zu", len, strlen(STRING));
> > +		goto out;
> > +	}
> > +	for (i = 0; i < len; i++)
> >  		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
> >  			break;

> > -	if (i == buf_len)
> > +	if (i == len)
> >  		tst_res(TPASS, "Specified pattern not found in file");
> >  	else
> >  		tst_res(TFAIL, "Specified pattern found in file");
> > -
> > +out:
> >  	SAFE_CLOSE(fildes);

> We could close the file right after the read, that would have avoided
> the goto, but I guess that the patch is good enough now.

Good point. If you don't mind, I would merge it as following.

Kind regards,
Petr

+++ testcases/kernel/syscalls/mmap/mmap01.c
@@ -39,10 +39,13 @@ static void check_file(void)
 
 	fildes = SAFE_OPEN(TEMPFILE, O_RDONLY);
 	len = SAFE_READ(0, fildes, buf, sizeof(buf));
+	SAFE_CLOSE(fildes);
+
 	if (len != strlen(STRING)) {
 		tst_res(TFAIL, "Read %zi expected %zu", len, strlen(STRING));
-		goto out;
+		return;
 	}
+
 	for (i = 0; i < len; i++)
 		if (buf[i] == 'X' || buf[i] == 'Y' || buf[i] == 'Z')
 			break;
@@ -51,8 +54,6 @@ static void check_file(void)
 		tst_res(TPASS, "Specified pattern not found in file");
 	else
 		tst_res(TFAIL, "Specified pattern found in file");
-out:
-	SAFE_CLOSE(fildes);
 }
 
 static void set_file(void)

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
