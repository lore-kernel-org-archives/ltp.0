Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0545AC10F1A
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 14:50:24 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 716503CE2E3
	for <ltp@archiver.kernel.org>; Thu,  9 May 2024 16:50:23 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 647263CE1F0
 for <ltp@lists.linux.it>; Thu,  9 May 2024 16:50:08 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CA57E200D07
 for <ltp@lists.linux.it>; Thu,  9 May 2024 16:50:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D0372387A7;
 Thu,  9 May 2024 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715266207; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUaBxJhvEP/PnJR4KeTg6wY4MBKlW/7ov79uGwbh+p4=;
 b=hBLSqV+vQ32/yAKI7yjQ+1dk8N5g2QZOm0SNEAjrVS4XCye9/2FisAzBxVvEU2ldFmNVe8
 R3m4TW0mBTNKsbGe5njtJc/2D6mcIY8AGExKx3l69xJq/FDQPJ8U/bQOiHH5F+iiLGVYKD
 1Pv/OBcO8rX9BdTUdBlHKj+2Rdg6yvc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715266207;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUaBxJhvEP/PnJR4KeTg6wY4MBKlW/7ov79uGwbh+p4=;
 b=ZRGAts52iZlxw374H6pK8HpJreQ1RBkZOiVyiPodi1ylsznMeHUjbFGOohQ4W9asvGFKZ2
 SnB0FvbM/LeROOBg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1715266206; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUaBxJhvEP/PnJR4KeTg6wY4MBKlW/7ov79uGwbh+p4=;
 b=EC4FsVPl4wLuak8xZQ22l3K4Uk5i5aMI/O0Pf2lfInZUujOiKMOYLLArLcBQ00U+/6ohQk
 VhFITuks7ZrogT9BaUKK5nUbWikodgRtTrhaq6gZzotWRnEE+hfQoKjgYAEdTbWyPh5h8r
 Ti9l9RZR4h8JUp3VpfB/oKXiG9XXQuM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1715266206;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EUaBxJhvEP/PnJR4KeTg6wY4MBKlW/7ov79uGwbh+p4=;
 b=BOmfGTlDZ40AypPgnRBuu7rFiaMGT9dN9DzAbi5p2uRQR2yCDGytXk0HpZp/yBsMaJVjb9
 3FgBq7vsl0SoaGCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C0D6113A24;
 Thu,  9 May 2024 14:50:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fhsILp7iPGY6CgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 09 May 2024 14:50:06 +0000
Date: Thu, 9 May 2024 16:49:20 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Filippo Storniolo <fstornio@redhat.com>
Message-ID: <ZjzicK0BunOFmjHn@yuki>
References: <20240509133712.3383293-1-fstornio@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240509133712.3383293-1-fstornio@redhat.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email, imap1.dmz-prg2.suse.org:helo,
 imap1.dmz-prg2.suse.org:rdns]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/mlock05: add mlock test for locking
 and pre-faulting of memory
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
> +static unsigned long get_proc_smaps_field(unsigned long desired_mapping_address, char *desired_field)
> +{
> +	bool mapping_found = false;
> +	char buffer[LINELEN] = "";
> +	FILE *file = NULL;
> +	int ret = 0;

There is no point in initializing buffer, file and ret these are written
to before we use the value.

> +	file = fopen("/proc/self/smaps", "r");
> +	if (file == NULL) {
> +		tst_brk(TBROK | TERRNO, "cannot open file proc/self/smaps");
> +		return 0;
> +	}

Use SAFE_FOPEN() please.

> +	// find desired mapping
> +	while (fgets(buffer, LINELEN, file) != NULL) {
> +		unsigned long mapping_address;
> +
> +		// check the starting address

I do not find this comment to be useful, we do have a rule in LTP not to
comment obvious and I would argue that this comment does so.

> +		ret = sscanf(buffer, "%lx[^-]", &mapping_address);
> +
> +		if ((ret == 1) && (mapping_address == desired_mapping_address)) {
> +			mapping_found = true;
> +			break;
> +		}
> +	}
> +
> +	if (!mapping_found) {
> +		fclose(file);

SAFE_FCLOSE() please and in the rest of the cases below.

> +		tst_brk(TBROK, "cannot find mapping %lx in proc/self/smaps", desired_mapping_address);
> +		return 0;
> +	}
> +
> +	// find desired field
> +	while (fgets(buffer, LINELEN, file) != NULL) {
> +		if (strstr(buffer, desired_field) != NULL) {

Can we use strncmp() to match the prefix rather a substring? At the
moment "Locked" and "Rss" are not substrings of other keys in that file
but that may change at some point.

> +			unsigned long desired_value;
> +
> +			// extract the value for the requested field

Here as well, commenting the obvious.

> +			ret = sscanf(buffer, "%*[^0-9]%lu%*[^0-9]", &desired_value);

The key value is divided by : and thge entries we are interested in are
in kB so "%*[^:]%lu kB" should be a bit safer.

> +			fclose(file);
> +
> +			if (ret != 1) {
> +				tst_brk(TBROK, "failure occured while reading field %s", desired_field);
> +				return 0;
> +			}
> +
> +			return desired_value;
> +		}
> +	}
> +
> +	fclose(file);
> +	tst_brk(TBROK, "cannot find %s field", desired_field);
> +
> +	return 0;
> +}
> +
> +static void verify_mlock(void)
> +{
> +	unsigned long Locked;
> +	unsigned long Rss;
> +	char *buf;
> +
> +	buf = SAFE_MMAP(NULL, MMAPLEN, PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	SAFE_MLOCK(buf, MMAPLEN);
> +
> +	Rss = get_proc_smaps_field((unsigned long)buf, "Rss");
> +	Locked = get_proc_smaps_field((unsigned long)buf, "Locked");

Hmm, we do parse the whole file twice here, just the get to a nearly
same line. Why can't we just point two pointrs to unsigned long to the
function and collect both while we read the file?

> +	// Convertion from KiB to B
> +	Rss *= 1024;
> +	Locked *= 1024;
> +
> +	TST_EXP_EQ_LU(Rss, MMAPLEN);
> +	TST_EXP_EQ_LU(Locked, MMAPLEN);
> +
> +	SAFE_MUNLOCK(buf, MMAPLEN);
> +	SAFE_MUNMAP(buf, MMAPLEN);
> +}
> +
> +static struct tst_test test = {
> +	.test_all = verify_mlock,
> +};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
