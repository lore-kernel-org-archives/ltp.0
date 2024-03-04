Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0928C5478C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 15:55:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A955C3CEB9C
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:55:43 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D41523C3320
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:55:28 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A30B260097F
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 16:55:27 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4037433704;
 Mon,  4 Mar 2024 15:55:26 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 20C1913A58;
 Mon,  4 Mar 2024 15:55:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LaZmBu7u5WVKcgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 04 Mar 2024 15:55:26 +0000
Date: Mon, 4 Mar 2024 16:54:23 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <ZeXur_8TD_YwfOI6@yuki>
References: <20240304152119.31688-1-andrea.cervesato@suse.de>
 <20240304152119.31688-2-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240304152119.31688-2-andrea.cervesato@suse.de>
Authentication-Results: smtp-out1.suse.de;
	none
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Rspamd-Queue-Id: 4037433704
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 1/2] Add SAFE_MPROTECT() macro
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
> +	int rval;
> +	char prot_buf[16];
> +
> +	switch (prot) {
> +	case PROT_NONE:
> +		snprintf(prot_buf, 16, "PROT_NONE");
> +		break;
> +	case PROT_WRITE:
> +		snprintf(prot_buf, 16, "PROT_WRITE");
> +		break;
> +	case PROT_READ:
> +		snprintf(prot_buf, 16, "PROT_READ");
> +		break;
> +	case PROT_EXEC:
> +		snprintf(prot_buf, 16, "PROT_EXEC");
> +		break;
> +	default:
> +		snprintf(prot_buf, 16, "UNKNOWN");
> +		break;
> +	}

This is ugly and does not work.

First of all we can just do:

	char *prot_name;


	switch (prot) {
	case PROT_NONE:
		prot_name = "PROT_NONE";
	break;
	...
	}

And secondly it does not work for common combinations, like (PROT_READ | PROT_WRITE).

So I guess that the easiest solution is to walk the bits and append the
string something as:

#define PROT_READ_NAME "PROT_READ | "
#define PROT_WRITE_NAME "PROT_WRITE | "
#define PROT_EXEC_NAME "PROT_EXEC | "

static const char *prot_to_str(int prot, char *buf, size_t buf_len)
{
	char *orig_buf = buf;

	if (buf_len < sizeof(PROT_READ_NAME) + sizeof(PROT_WRITE_NAME) + sizeof(PROT_EXEC_NAME))
		return "BUFFER TOO SMALL!!!";

	if (prot == 0)
		return "PROT_NONE";

	*buf = 0;

	if (prot & PROT_READ) {
		strcpy(buf, PROT_READ_NAME);
		buf += sizeof(PROT_READ_NAME)-1;
	}

	if (prot & PROT_WRITE) {
		strcpy(buf, PROT_WRITE_NAME);
		buf += sizeof(PROT_WRITE_NAME)-1;
	}

	if (prot & PROT_EXEC) {
		strcpy(buf, PROT_EXEC_NAME);
		buf += sizeof(PROT_EXEC_NAME)-1;
	}

	if (orig_buf != buf)
		buf[-3] = 0;

	return buf;
}

Also I would put the code that translates the prot into string into a
separate function because that code should be used in the safe_mmap() as
well.

> +	tst_res_(file, lineno, TDEBUG,
> +		"mprotect(%p, %d, %s)", addr, len, prot_buf);

Can we print hexadecimal value of the prot here as well?

		"mprotect(%p, %d, %s(%x))", addr, len, prot_to_str(prot, buf, sizeof(buf)), prot);

> +	rval = mprotect(addr, len, prot);
> +
> +	if (rval == -1) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"mprotect() failed");
> +	} else if (rval) {
> +		tst_brkm_(file, lineno, TBROK | TERRNO, NULL,
> +			"Invalid mprotect() return value %d", rval);
> +	}
> +
> +	return rval;
> +}
> +
>  int safe_mincore(const char *file, const int lineno, void *start,
>  	size_t length, unsigned char *vec)
>  {
> -- 
> 2.35.3
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
