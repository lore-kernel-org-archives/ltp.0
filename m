Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F161C3600B
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 15:52:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C7443CACD1
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 17:52:25 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 809AD3CAC94
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 17:52:08 +0200 (CEST)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 851966008CD
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 17:52:06 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D9D6D21189;
 Mon, 31 Mar 2025 15:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743436325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QnpEvmDBLdmPOYSi5sPa6NMP6PWY2PsjDiRF7xoukuE=;
 b=bHbL+BQ8HSeKnSHpqh44OZW1B3ucbHQZq06Ros6ErBu4Wv2oZE/dF/tjIL722yhK6ZfAqP
 KcnshHl/WPaH5u++gXkp0+8I4J9/2J7rtGg2WpsN5PmKCkw/nrPPxtfoNrQiDhseaAhXyu
 wivWLXyyoMhAxN/lgzMxLpyI7fFaFgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743436325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QnpEvmDBLdmPOYSi5sPa6NMP6PWY2PsjDiRF7xoukuE=;
 b=nNNLtNdVH60zk0TgmdcEnmNFV83RbVp6UPPfthr5C3l0nkgECffPdD1YIZU3MuDvBD7pBq
 bhV0qY1dN44ClRAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743436325; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QnpEvmDBLdmPOYSi5sPa6NMP6PWY2PsjDiRF7xoukuE=;
 b=bHbL+BQ8HSeKnSHpqh44OZW1B3ucbHQZq06Ros6ErBu4Wv2oZE/dF/tjIL722yhK6ZfAqP
 KcnshHl/WPaH5u++gXkp0+8I4J9/2J7rtGg2WpsN5PmKCkw/nrPPxtfoNrQiDhseaAhXyu
 wivWLXyyoMhAxN/lgzMxLpyI7fFaFgE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743436325;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QnpEvmDBLdmPOYSi5sPa6NMP6PWY2PsjDiRF7xoukuE=;
 b=nNNLtNdVH60zk0TgmdcEnmNFV83RbVp6UPPfthr5C3l0nkgECffPdD1YIZU3MuDvBD7pBq
 bhV0qY1dN44ClRAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C971E13A82;
 Mon, 31 Mar 2025 15:52:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gv+jLiW66meuUwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 31 Mar 2025 15:52:05 +0000
Date: Mon, 31 Mar 2025 17:52:26 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z-q6Okh-lkvbx5mA@yuki.lan>
References: <20250328114311.187541-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250328114311.187541-1-pvorel@suse.cz>
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_THREE(0.00)[3]
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 0/2] Add safe_get_nodemap()
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
> not a huge improvement, but because all tst_get_nodemap() are in the
> setup (and only ksm06.c allows input parameter) we could have struct
> tst_test member which would call safe_get_nodemap().
> 
> e.g.:
> 
> .nodemap = (const struct tst_path_val) {
> 		.type = TST_NUMA_MEM
> 		.required = 2,
> },

I do not get this, the struct tst_path_val is something completely
different.

> safe_get_nodemap(tst_test->nodemap->type,
> 	tst_test->nodemap->required * getpagesize() / 1024);
> 
> This would not work for non - page sized nodes, e.g.:
> nodes = tst_get_nodemap(TST_NUMA_MEM, 2 * PAGES_ALLOCATED * page_size / 1024);
> 
> => extra member would need to be added:
> 
> .nodemap = (const struct tst_path_val) {
> 		.type = TST_NUMA_MEM
> 		.required = 2,
> 		.size = PAGES_ALLOCATED, // default == 1
> },

I've avoided the size to be in pages and choosen kilobytes instead
because the page size can differ a lot.

> would call:
> 
> safe_get_nodemap(tst_test->nodemap->type,
> 	tst_test->nodemap->required * tst_test->nodemap->size * getpagesize() / 1024,
         ^
	 This does not make any sense.

The memory parameter is supposed to be minimal free memory on each node,
for each node we check that it has at least min_mem_kb in the
node_has_enough_memory() function.

There is no point in multiplying that by the number of nodes we require.

And this looks like it uses kilobytes not pages.

> 	tst_test->nodemap->required);

I guess that what you meant is that we will add tst_numa structure such as:

struct tst_numa {
	enum tst_numa_types node_type;
	unsigned int min_nodes;
	unsigned int min_mem_kb;
};

And then use that in tst_test structure. That would certainly make
sense, but I guess that we would have to move the numa library to the
lib/ as well. I'm not sure that we can have a function call from
tst_test.c library to something that is not compiled in by default.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
