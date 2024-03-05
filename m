Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E86A4C54798
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 22:00:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4739C3D0B8D
	for <ltp@archiver.kernel.org>; Tue,  5 Mar 2024 23:00:31 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 290493CC53D
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 23:00:16 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 7E9E91A00A2E
 for <ltp@lists.linux.it>; Tue,  5 Mar 2024 23:00:16 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 025C720A0B;
 Tue,  5 Mar 2024 22:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709676015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4pDglPyMQz589P7UJ9UiuxC20DPpCD+vTOOB8nts2g4=;
 b=z2w8zuDiqo4gKlUywNVK3FgbfHxJZHv6RQ+LSEhoovpKnU5E0iTGWkcK79Jwb5YaHAfFm0
 QUYHi4WCBrZoX4Zz/Q/iQEYIIQQgssiDbL5yS/Zg0401LZi1Z7mA/XACwK0h39fkqxKrQn
 jZvZF215reCeW5E3RzA8auTkWTebUCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709676015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4pDglPyMQz589P7UJ9UiuxC20DPpCD+vTOOB8nts2g4=;
 b=CeuEAYsOt1tgdZ2pTI/L3kD6Iq2EkpM6oeXsCmPmcMDu8CJHdBQ1uVbP5Zju1e69dtmf2U
 89pXTTqTUldPT2AQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709676015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4pDglPyMQz589P7UJ9UiuxC20DPpCD+vTOOB8nts2g4=;
 b=z2w8zuDiqo4gKlUywNVK3FgbfHxJZHv6RQ+LSEhoovpKnU5E0iTGWkcK79Jwb5YaHAfFm0
 QUYHi4WCBrZoX4Zz/Q/iQEYIIQQgssiDbL5yS/Zg0401LZi1Z7mA/XACwK0h39fkqxKrQn
 jZvZF215reCeW5E3RzA8auTkWTebUCw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709676015;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4pDglPyMQz589P7UJ9UiuxC20DPpCD+vTOOB8nts2g4=;
 b=CeuEAYsOt1tgdZ2pTI/L3kD6Iq2EkpM6oeXsCmPmcMDu8CJHdBQ1uVbP5Zju1e69dtmf2U
 89pXTTqTUldPT2AQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id C742313A5D;
 Tue,  5 Mar 2024 22:00:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id R3IiLe6V52UWJAAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Tue, 05 Mar 2024 22:00:14 +0000
Date: Tue, 5 Mar 2024 23:00:13 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <20240305220013.GC44833@pevik>
References: <20240130122540.13215-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240130122540.13215-1-akumar@suse.de>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [-0.50 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.00)[37.75%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/mmap01: Rewrite the test using new
 LTP API
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

HI Avinesh,

> - use SAFE_MSYNC() macro
> - fixed the test for iterations > 1
> - enable test for all filesystems
+1

> Signed-off-by: Avinesh Kumar <akumar@suse.de>
> ---

> Changes v3->v4:
> * Changed the logic to verify that mapped file has not been changed.
> * Enabled all filesystems.


>  testcases/kernel/syscalls/mmap/mmap01.c | 223 +++++++-----------------
>  1 file changed, 61 insertions(+), 162 deletions(-)

> diff --git a/testcases/kernel/syscalls/mmap/mmap01.c b/testcases/kernel/syscalls/mmap/mmap01.c
...
> +static char *addr;
> +static char *dummy;
> +static struct stat stat_buf;
nit: struct stat stat_buf is used just in the setup, it could defined just
there. It can be changed before merge.

> +static const char write_buf[] = "HelloWorld!";

> -int main(int ac, char **av)
> +static void setup(void)
>  {
...
> +	fd = SAFE_OPEN(TEMPFILE, O_RDWR | O_CREAT, 0666);

> -	cleanup();
> -	tst_exit();
> -}
> +	SAFE_WRITE(SAFE_WRITE_ALL, fd, write_buf, strlen(write_buf));
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
> +	SAFE_STAT(TEMPFILE, &stat_buf);

> -static void setup(void)
> -{
> -	struct stat stat_buf;
> -	char Path_name[PATH_MAX];
> -	char write_buf[] = "hello world\n";
> +	file_sz = stat_buf.st_size;
> +	page_sz = getpagesize();

> -	tst_sig(FORK, DEF_HANDLER, cleanup);
> +	dummy = SAFE_MALLOC(page_sz);
> +	memset(dummy, 0, page_sz);
> +}

> -	TEST_PAUSE;
> +static void run(void)
> +{
> +	char buf[20];

> -	tst_tmpdir();
> +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
...
> +	addr[file_sz] = 'X';
> +	addr[file_sz + 1] = 'Y';
> +	addr[file_sz + 2] = 'Z';
...
> +	SAFE_MSYNC(addr, page_sz, MS_SYNC);
...
> +	SAFE_FILE_SCANF(TEMPFILE, "%s", buf);

> -	page_sz = getpagesize();
> +	if (strcmp(write_buf, buf))
> +		tst_res(TFAIL, "File data has changed");
> +	else
> +		tst_res(TPASS, "mmap() functionality successful");
nit: I would prefer something more descriptive (what mmap() actually did, e.g.
"mapped file has not been changed"), but I guess it's ok to keep it as is.

The rest LGTM.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
