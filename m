Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75831E9A049
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 13:06:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A46AF3D074A
	for <ltp@archiver.kernel.org>; Thu, 19 Feb 2026 14:06:01 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9E6EA3C840B
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 14:05:41 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 34FD11400053
 for <ltp@lists.linux.it>; Thu, 19 Feb 2026 14:05:40 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2628C3E71F;
 Thu, 19 Feb 2026 13:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771506339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyEukK5l8U1d1cFLK3g/c2NHsBQwow3KkzrMwse/kxw=;
 b=x+sWnsaZ49bOpYAnkDhWcJfiQE0L/o2TObf7yF9/aWA+rfVrP4sDIl6ZtBOG1GLFEFoJQk
 cKImBIeFcFOJZW/nGaYeLXhciHzGENH0uc4sXEJrgI7ZzCaCpzxcQ8lWeK31egH5vhZ5G0
 /xNZWJsJBggPpgJDSu329tXRwa5kNkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771506339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyEukK5l8U1d1cFLK3g/c2NHsBQwow3KkzrMwse/kxw=;
 b=1MtU4HGDQSfdK00nqvGyOOJzemTNIU3yVIoHDAF5ZaOxdk9yOv361kEZ3Ncyx9LRWs2gX8
 LOS5INCx4S+P2dCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=x+sWnsaZ;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1MtU4HGD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1771506339; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyEukK5l8U1d1cFLK3g/c2NHsBQwow3KkzrMwse/kxw=;
 b=x+sWnsaZ49bOpYAnkDhWcJfiQE0L/o2TObf7yF9/aWA+rfVrP4sDIl6ZtBOG1GLFEFoJQk
 cKImBIeFcFOJZW/nGaYeLXhciHzGENH0uc4sXEJrgI7ZzCaCpzxcQ8lWeK31egH5vhZ5G0
 /xNZWJsJBggPpgJDSu329tXRwa5kNkw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1771506339;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DyEukK5l8U1d1cFLK3g/c2NHsBQwow3KkzrMwse/kxw=;
 b=1MtU4HGDQSfdK00nqvGyOOJzemTNIU3yVIoHDAF5ZaOxdk9yOv361kEZ3Ncyx9LRWs2gX8
 LOS5INCx4S+P2dCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 08AA23EA65;
 Thu, 19 Feb 2026 13:05:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id NmwQAaMKl2mAFwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 19 Feb 2026 13:05:39 +0000
Date: Thu, 19 Feb 2026 14:05:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <aZcKpKvJNU73Ow1G@yuki.lan>
References: <20260123-stream_refactoring-v1-0-281b85f6ab02@suse.com>
 <20260123-stream_refactoring-v1-2-281b85f6ab02@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260123-stream_refactoring-v1-2-281b85f6ab02@suse.com>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns, yuki.lan:mid, suse.cz:dkim, suse.cz:email]
X-Rspamd-Queue-Id: 2628C3E71F
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/6] fs: rewrite stream01 test using new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> -char *TCID = "stream01";
> -int TST_TOTAL = 1;
> -int local_flag;
> +static void read_file(const char *file)
> +{
> +	char buf[2];
> +	FILE *stream;
>  
> -#define PASSED 1
> -#define FAILED 0
> +	memset(buf, 0, sizeof(buf));
>  
> -/* XXX: add setup and cleanup. */
> +	stream = SAFE_FOPEN(file, "r");
> +	SAFE_FREAD(buf, 1, 1, stream);

Here we read at most 1 character from the stream.

> +	SAFE_FCLOSE(stream);
>  
> -char progname[] = "stream01()";
> -char tempfile1[40] = "";
> -char tempfile2[40] = "";
> +	TST_EXP_EXPR((buf[0] == 'a') && (buf[1] == 0),
                                         ^
					 Hence this is always true
> +		"%s file contains the correct data", file);

If we wanted to assert that the file has a single characted written into
it we need to let the fread() read the whole buffer:

	SAFE_FREAD(buf, 2, 1, stream);

With that there is at least chance that the buf[1] may be overwritten
with some data.

Or we can check the size returned from fread(), if it was 1 there was a
single characted in the file. But again, we have to pass buffer that is
at least 2 bytes long.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
