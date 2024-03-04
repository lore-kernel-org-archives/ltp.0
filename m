Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F03EC48BF6
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 16:36:17 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82E173CEB9D
	for <ltp@archiver.kernel.org>; Mon,  4 Mar 2024 17:36:15 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5BD323CCDE6
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 17:36:00 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id BBAAD603443
 for <ltp@lists.linux.it>; Mon,  4 Mar 2024 17:35:59 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 193AF1FB7C;
 Mon,  4 Mar 2024 16:35:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709570157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4q979UrQRyoubDZjwxIVjjEPhRbM31qdZAiPlY6hdk=;
 b=2gI4k0jfaH/Tvq4O9cm0IDwDwjGcuVRQjs/yeOEfCVGGrSHycvHQ/bMNy1T8L5+Lj+SmDI
 mMmPt/wrQkJ6syPjr/St7Qdri4VzqZUNKHgNI9/a5ayL8/Gyjebrd1k8Yjpc3hSPKq+Hpv
 AJGz5wVKJLmaJS6PRi9MNSjMi3TPNbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709570157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4q979UrQRyoubDZjwxIVjjEPhRbM31qdZAiPlY6hdk=;
 b=ea4O3J01PrrNNIc295xbQwXDCgvgI9dkR8ee08e+yonUSUfFiIUsgLSCIJvyhQmFGENA4F
 zf58lffIgJlrteBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1709570157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4q979UrQRyoubDZjwxIVjjEPhRbM31qdZAiPlY6hdk=;
 b=2gI4k0jfaH/Tvq4O9cm0IDwDwjGcuVRQjs/yeOEfCVGGrSHycvHQ/bMNy1T8L5+Lj+SmDI
 mMmPt/wrQkJ6syPjr/St7Qdri4VzqZUNKHgNI9/a5ayL8/Gyjebrd1k8Yjpc3hSPKq+Hpv
 AJGz5wVKJLmaJS6PRi9MNSjMi3TPNbQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1709570157;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=z4q979UrQRyoubDZjwxIVjjEPhRbM31qdZAiPlY6hdk=;
 b=ea4O3J01PrrNNIc295xbQwXDCgvgI9dkR8ee08e+yonUSUfFiIUsgLSCIJvyhQmFGENA4F
 zf58lffIgJlrteBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id E2FF013419;
 Mon,  4 Mar 2024 16:35:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id eO5VNWz45WVMAgAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Mon, 04 Mar 2024 16:35:56 +0000
Date: Mon, 4 Mar 2024 17:35:50 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20240304163550.GB3191855@pevik>
References: <20240304152119.31688-1-andrea.cervesato@suse.de>
 <20240304152119.31688-2-andrea.cervesato@suse.de>
 <ZeXur_8TD_YwfOI6@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZeXur_8TD_YwfOI6@yuki>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2gI4k0jf;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=ea4O3J01
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.90 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 REPLYTO_EQ_FROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.19)[70.66%]
X-Rspamd-Queue-Id: 193AF1FB7C
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

> Hi!
> > +	int rval;
> > +	char prot_buf[16];
> > +
> > +	switch (prot) {
> > +	case PROT_NONE:
> > +		snprintf(prot_buf, 16, "PROT_NONE");
> > +		break;
> > +	case PROT_WRITE:
> > +		snprintf(prot_buf, 16, "PROT_WRITE");
> > +		break;
> > +	case PROT_READ:
> > +		snprintf(prot_buf, 16, "PROT_READ");
> > +		break;
> > +	case PROT_EXEC:
> > +		snprintf(prot_buf, 16, "PROT_EXEC");
> > +		break;
> > +	default:
> > +		snprintf(prot_buf, 16, "UNKNOWN");
> > +		break;
> > +	}

> This is ugly and does not work.

> First of all we can just do:

> 	char *prot_name;


> 	switch (prot) {
> 	case PROT_NONE:
> 		prot_name = "PROT_NONE";
> 	break;
> 	...
> 	}

> And secondly it does not work for common combinations, like (PROT_READ | PROT_WRITE).

> So I guess that the easiest solution is to walk the bits and append the
> string something as:

> #define PROT_READ_NAME "PROT_READ | "
> #define PROT_WRITE_NAME "PROT_WRITE | "
> #define PROT_EXEC_NAME "PROT_EXEC | "

nit: maybe using stringification?

#define FLAG(f) f, #f " | "

FLAG(PROT_READ)

> static const char *prot_to_str(int prot, char *buf, size_t buf_len)
> {
> 	char *orig_buf = buf;

> 	if (buf_len < sizeof(PROT_READ_NAME) + sizeof(PROT_WRITE_NAME) + sizeof(PROT_EXEC_NAME))
> 		return "BUFFER TOO SMALL!!!";

> 	if (prot == 0)
> 		return "PROT_NONE";

> 	*buf = 0;

> 	if (prot & PROT_READ) {
> 		strcpy(buf, PROT_READ_NAME);
> 		buf += sizeof(PROT_READ_NAME)-1;
> 	}

> 	if (prot & PROT_WRITE) {
> 		strcpy(buf, PROT_WRITE_NAME);
> 		buf += sizeof(PROT_WRITE_NAME)-1;
> 	}

> 	if (prot & PROT_EXEC) {
> 		strcpy(buf, PROT_EXEC_NAME);
> 		buf += sizeof(PROT_EXEC_NAME)-1;
> 	}

> 	if (orig_buf != buf)
> 		buf[-3] = 0;

> 	return buf;
> }

> Also I would put the code that translates the prot into string into a
> separate function because that code should be used in the safe_mmap() as
> well.

+1

> > +	tst_res_(file, lineno, TDEBUG,
> > +		"mprotect(%p, %d, %s)", addr, len, prot_buf);

> Can we print hexadecimal value of the prot here as well?

+1

> 		"mprotect(%p, %d, %s(%x))", addr, len, prot_to_str(prot, buf, sizeof(buf)), prot);

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
