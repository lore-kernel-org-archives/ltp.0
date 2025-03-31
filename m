Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDDDDC3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 10:38:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 522CC3CABA2
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 12:38:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7DE103C1ABE
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:37:57 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5109460220B
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 12:37:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 656052117C;
 Mon, 31 Mar 2025 10:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743417473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MB7OXTDdY7dv1sr6F7fMKRPmrHLqpOvBocVU6zQ3cE0=;
 b=pEmqZo8TOBWWahjm2aJilIgArshpiZ4iLYErpRGqLAb2EgI+oEPQR35nHBUESvsHm535RS
 wWkW3IJApORjpJsODU1Whv5VpdrfSbg1LZFB5uSNEifgJJoJjfg15mKe7kIyCW+LXlFveU
 tIL7pVTdVJ0LgVpUzWSHvni0nUvtc8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743417473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MB7OXTDdY7dv1sr6F7fMKRPmrHLqpOvBocVU6zQ3cE0=;
 b=sNUtpqyMl+c1p5pK+nh2NyluUEJBv29DwZXnqm/rtmDJ5kA8741GyBLfuDySImInFyn1y2
 0OT43cedQ3cK+kCw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pEmqZo8T;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=sNUtpqyM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743417473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MB7OXTDdY7dv1sr6F7fMKRPmrHLqpOvBocVU6zQ3cE0=;
 b=pEmqZo8TOBWWahjm2aJilIgArshpiZ4iLYErpRGqLAb2EgI+oEPQR35nHBUESvsHm535RS
 wWkW3IJApORjpJsODU1Whv5VpdrfSbg1LZFB5uSNEifgJJoJjfg15mKe7kIyCW+LXlFveU
 tIL7pVTdVJ0LgVpUzWSHvni0nUvtc8Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743417473;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MB7OXTDdY7dv1sr6F7fMKRPmrHLqpOvBocVU6zQ3cE0=;
 b=sNUtpqyMl+c1p5pK+nh2NyluUEJBv29DwZXnqm/rtmDJ5kA8741GyBLfuDySImInFyn1y2
 0OT43cedQ3cK+kCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 451EE139A1;
 Mon, 31 Mar 2025 10:37:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eo/eD4Fw6mcoaAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 31 Mar 2025 10:37:53 +0000
Date: Mon, 31 Mar 2025 12:37:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Wei Gao <wegao@suse.com>
Message-ID: <20250331103751.GB244431@pevik>
References: <20250328075958.7616-1-wegao@suse.com>
 <20250331031945.5948-1-wegao@suse.com>
 <20250331031945.5948-2-wegao@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250331031945.5948-2-wegao@suse.com>
X-Rspamd-Queue-Id: 656052117C
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v9 1/2] cpuset02: Convert the test6 from
 cpuset_memory_testset.sh to C code
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

Hi Wei, Li, Cyril,

...
> +static void setup(void)
> +{
> +	node = tst_get_nodemap(TST_NUMA_MEM, getpagesize() / 1024);
> +	if (node->cnt <= 1)
> +		tst_brk(TCONF, "test requires at least 2 NUMA memory nodes");
Naive question: why test requires 2 memory nodes? Wouldn't be 1 enough?

Kind regards,
Petr

> +
> +	check_node_id = node->map[node->cnt - 1];
> +
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +
> +	char path[256];
> +	unsigned int i;
> +	unsigned int nr_hugepages;
> +
> +	for (i = 0; i < node->cnt; i++) {
> +		unsigned int current_node_id = node->map[i];
> +
> +		sprintf(path,
> +			"/sys/devices/system/node/node%d/hugepages/hugepages-%ldkB/nr_hugepages",
> +			current_node_id, hpage_size / 1024);
> +		FILE_PRINTF(path, "%d", 1);
> +		SAFE_FILE_SCANF(path, "%d", &nr_hugepages);
> +		if (nr_hugepages != 1)
> +			tst_brk(TCONF, "reserve 1 huge page on node%d failed", current_node_id);
> +	}
> +}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
