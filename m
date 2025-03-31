Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FAB1C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 16:06:28 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 539D83CACB6
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 18:06:26 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A1013CA67A
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:06:08 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id E850D2003AC
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 18:06:07 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 30F0121201;
 Mon, 31 Mar 2025 16:06:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743437166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l0S+om/SJ9jv+MGbH0OeS7MEN6RgM5jLtqUkzUQAtfM=;
 b=FBpZ630O36quH23jvU1kMxU00f7WMnUoQ7ASvRtLwvEfvwSezznJMm0Jw9wmiMrGCtzxQN
 ++ORo7zynkbtXaDq0vLO7VekTRC8CcgSvnSOQIYjYytKqpAQUKBzWiMkEn0uVU3sCGS7qx
 1WBIXXJmW73iGUDvl+sVGoDIW3DmrrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743437166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l0S+om/SJ9jv+MGbH0OeS7MEN6RgM5jLtqUkzUQAtfM=;
 b=mcT1OGXa6YJ9y0+ooA0ARZGSzNvtzAP9oq1ish4oqniWcjrzRsuhTh7hcHM172VOOHCORJ
 o/aC79p2rzaka2Cw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743437166; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l0S+om/SJ9jv+MGbH0OeS7MEN6RgM5jLtqUkzUQAtfM=;
 b=FBpZ630O36quH23jvU1kMxU00f7WMnUoQ7ASvRtLwvEfvwSezznJMm0Jw9wmiMrGCtzxQN
 ++ORo7zynkbtXaDq0vLO7VekTRC8CcgSvnSOQIYjYytKqpAQUKBzWiMkEn0uVU3sCGS7qx
 1WBIXXJmW73iGUDvl+sVGoDIW3DmrrE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743437166;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=l0S+om/SJ9jv+MGbH0OeS7MEN6RgM5jLtqUkzUQAtfM=;
 b=mcT1OGXa6YJ9y0+ooA0ARZGSzNvtzAP9oq1ish4oqniWcjrzRsuhTh7hcHM172VOOHCORJ
 o/aC79p2rzaka2Cw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 21B9013A1F;
 Mon, 31 Mar 2025 16:06:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id yvRYB2696mdYWAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 31 Mar 2025 16:06:06 +0000
Date: Mon, 31 Mar 2025 18:06:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z-q9gk5PhocL1R7H@yuki.lan>
References: <20250328114311.187541-1-pvorel@suse.cz>
 <20250328114311.187541-3-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250328114311.187541-3-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 RCVD_COUNT_TWO(0.00)[2];
 URIBL_BLOCKED(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,yuki.lan:mid]
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 2/2] Use safe_get_nodemap()
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
> --- a/testcases/kernel/mem/ksm/ksm06.c
> +++ b/testcases/kernel/mem/ksm/ksm06.c
> @@ -124,9 +124,7 @@ static void setup(void)
>  
>  	page_size = getpagesize();
>  
> -	nodes = tst_get_nodemap(TST_NUMA_MEM, nr_pages * page_size / 1024);
> -	if (nodes->cnt <= 1)
> -		tst_brk(TCONF, "Test requires at least two NUMA memory nodes");
> +	nodes = safe_get_nodemap(TST_NUMA_MEM, nr_pages * page_size / 1024, 2);
>  }
>  
>  static struct tst_test test = {
> diff --git a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> index 3c854d1096..031c35f40e 100644
> --- a/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> +++ b/testcases/kernel/syscalls/get_mempolicy/get_mempolicy01.c
> @@ -142,9 +142,7 @@ static void setup(void)
>  {
>  	unsigned int i;
>  
> -	node = tst_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024);
> -	if (node->cnt < 1)
> -		tst_brk(TCONF, "test requires at least one NUMA memory node");
> +	node = safe_get_nodemap(TST_NUMA_MEM, PAGES_ALLOCATED * getpagesize() / 1024, 1);

Hmm, we are actually requesting at least 1 node.

The question is if we shouldn't change this. It's very unlikely that we
get wrong answer about on which node memory has been allocated if there
is only one node.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
