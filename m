Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB32BC02183
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 16:18:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6869E3C7BE8
	for <ltp@archiver.kernel.org>; Fri, 17 Jan 2025 17:18:07 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7D1103C7BE8
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 17:17:51 +0100 (CET)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id CE37222615B
 for <ltp@lists.linux.it>; Fri, 17 Jan 2025 17:17:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2C6291F37C;
 Fri, 17 Jan 2025 16:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737130669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwI0Ilq8UoFMUFjWTLa87MPa/gyEXMg3++L6KuPFqZ4=;
 b=jI+jbAPLLdE/mUwU5YUJxnI+pJK9TXXovNQU3jTtDusaYPXCTkmUGD9iJAKy06J/q/CGAy
 7TeE3fiSMRLfFuoUzdW6gjM3JisemDVyRsjXO93weeHvLaNGOaCXBMVU4YTS+oui/kkD3M
 EYcwJz9z8V8cjsoNizg2C1/s8HE77s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737130669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwI0Ilq8UoFMUFjWTLa87MPa/gyEXMg3++L6KuPFqZ4=;
 b=M04AZGt+1PvL4p49vFtNGwpn9ziOBUe4VQ/fFR2+UlpABRPf95/dxBggaIVIQIDlbt6+Gf
 AXnHJnLIWdYJI5Cg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1737130669; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwI0Ilq8UoFMUFjWTLa87MPa/gyEXMg3++L6KuPFqZ4=;
 b=jI+jbAPLLdE/mUwU5YUJxnI+pJK9TXXovNQU3jTtDusaYPXCTkmUGD9iJAKy06J/q/CGAy
 7TeE3fiSMRLfFuoUzdW6gjM3JisemDVyRsjXO93weeHvLaNGOaCXBMVU4YTS+oui/kkD3M
 EYcwJz9z8V8cjsoNizg2C1/s8HE77s4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1737130669;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZwI0Ilq8UoFMUFjWTLa87MPa/gyEXMg3++L6KuPFqZ4=;
 b=M04AZGt+1PvL4p49vFtNGwpn9ziOBUe4VQ/fFR2+UlpABRPf95/dxBggaIVIQIDlbt6+Gf
 AXnHJnLIWdYJI5Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 17B78139CB;
 Fri, 17 Jan 2025 16:17:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id e8LlBK2CimcAbgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Fri, 17 Jan 2025 16:17:49 +0000
Date: Fri, 17 Jan 2025 17:17:40 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Attila Fazekas <afazekas@redhat.com>
Message-ID: <Z4qCpIiCZHME7r_e@yuki.lan>
References: <20250117135745.909549-1-afazekas@redhat.com>
 <20250117135745.909549-2-afazekas@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250117135745.909549-2-afazekas@redhat.com>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: move get_numcpus to librttest.[ch]
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
> +int get_numcpus(void)
> +{
> +	long numcpus_conf = sysconf(_SC_NPROCESSORS_CONF);
> +	size_t size = CPU_ALLOC_SIZE(numcpus_conf);
> +	cpu_set_t *cpuset = CPU_ALLOC(numcpus_conf);
> +
> +	CPU_ZERO_S(size, cpuset);
> +	/* Get the number of cpus accessible to the current process */
> +	sched_getaffinity(0, size, cpuset);
> +
> +	return CPU_COUNT_S(size, cpuset);
> +}

Can we please add another patch on the top that adds CPU_FREE() to this
function?

For this patch:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
