Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DAD9C36010
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 16:00:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D0C03CACF0
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 18:00:14 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 071723C9FB0
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 17:59:55 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6B8D11400332
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 17:59:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 737D2211E8;
 Mon, 31 Mar 2025 15:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743436794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yAeupur2fdzJ8rdFWL1jeUYpLXvot3h650Z0Chqvxc=;
 b=KoGLct/pj64d7ztW8YV6y/+8VeaVxZN417iy+lWiWOOVSB1fWD3as5IrPM5AqX0MFSw5MX
 uYp10x88rjs6khiO3feYbhiL1HfY4zIoV+KzEJEi+LsgHA4ZH02C25s3AvnQFlLVYLos3J
 daTC9e02zpU1hZz0q/rhD+I5Cs5I6Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743436794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yAeupur2fdzJ8rdFWL1jeUYpLXvot3h650Z0Chqvxc=;
 b=WWZVS9Yf8EsgUSMmaRwGurkRzfrsGF9UJ6NCPKe1qnwrpJ2X75tQVnuk+XMZX6bw/+PQo9
 dScz/8YtjElGXiAg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="KoGLct/p";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=WWZVS9Yf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1743436794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yAeupur2fdzJ8rdFWL1jeUYpLXvot3h650Z0Chqvxc=;
 b=KoGLct/pj64d7ztW8YV6y/+8VeaVxZN417iy+lWiWOOVSB1fWD3as5IrPM5AqX0MFSw5MX
 uYp10x88rjs6khiO3feYbhiL1HfY4zIoV+KzEJEi+LsgHA4ZH02C25s3AvnQFlLVYLos3J
 daTC9e02zpU1hZz0q/rhD+I5Cs5I6Xo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1743436794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3yAeupur2fdzJ8rdFWL1jeUYpLXvot3h650Z0Chqvxc=;
 b=WWZVS9Yf8EsgUSMmaRwGurkRzfrsGF9UJ6NCPKe1qnwrpJ2X75tQVnuk+XMZX6bw/+PQo9
 dScz/8YtjElGXiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6248F13A1F;
 Mon, 31 Mar 2025 15:59:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id XRKkFvq76mc5VgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 31 Mar 2025 15:59:54 +0000
Date: Mon, 31 Mar 2025 18:00:19 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Z-q8EyVlXNbHRbeg@yuki.lan>
References: <20250328114311.187541-1-pvorel@suse.cz>
 <20250328114311.187541-2-pvorel@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250328114311.187541-2-pvorel@suse.cz>
X-Rspamd-Queue-Id: 737D2211E8
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; TO_DN_SOME(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [RFC][PATCH 1/2] libs: Add safe_get_nodemap()
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

On Fri, Mar 28, 2025 at 12:43:10PM +0100, Petr Vorel wrote:
> This requires to add also tst_numa_type_name().
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  include/tst_numa.h   | 41 +++++++++++++++++++++++++++++++++++++++--
>  libs/numa/tst_numa.c | 14 ++++++++++++++
>  2 files changed, 53 insertions(+), 2 deletions(-)
> 
> diff --git a/include/tst_numa.h b/include/tst_numa.h
> index a1f9616300..191a57fa6b 100644
> --- a/include/tst_numa.h
> +++ b/include/tst_numa.h
> @@ -106,8 +106,30 @@ enum tst_numa_types {
>  };
>  
>  /**
> - * tst_get_nodemap() - Allocates and returns numa node map, which is an array of numa nodes which
> - * contain desired resources e.g. memory.
> + * tst_numa_type_name() - Convert enum tst_numa_types to a description of a NUMA type.
> + *
> + * @type Bitflags of enum tst_numa_types specifying desired resources.
> + *
> + * @return a string describing a NUMA type.
> + */
> +static inline const char *tst_numa_type_name(int type)
> +{
> +	if (type & ~(TST_NUMA_MEM))
> +		tst_brk(TBROK, "Invalid type %i\n", type);
> +
> +	switch (type) {
> +	case TST_NUMA_MEM:
> +		return " memory";
> +	case TST_NUMA_ANY:
> +		return "";
> +	default:
> +		return " unknown";
> +	}
> +}
> +
> +/**
> + * tst_get_nodemap() - Allocates and returns numa node map, which is an array of
> + * NUMA nodes which contain desired resources e.g. memory.
>   *
>   * @type:       Bitflags of enum tst_numa_types specifying desired resources.
>   * @min_mem_kb: Minimal free RAM on memory nodes, if given node has less than
> @@ -119,4 +141,19 @@ enum tst_numa_types {
>   */
>  struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb);
>  
> +/**
> + * safe_get_nodemap() - Calls tst_get_nodemap() with check for minimal required
> + * NUMA nodes. Call tst_brk(TCONF) if not enough NUMA nodes.
> + *
> + * @type:       Bitflags of enum tst_numa_types specifying desired resources.
> + * @min_mem_kb: Minimal free RAM on memory nodes, if given node has less than
> + *             requested amount of free+buffers memory it's not included in
> + *             the resulting list of nodes.
> + * @required:   Minimal number of a required NUMA nodes.
> + *
> + * return: On success returns allocated and initialized struct tst_nodemap which contains
> + *         array of numa node ids that contains desired resources.
> + */
> +struct tst_nodemap *safe_get_nodemap(int type, size_t min_mem_kb, size_t required);
> +
>  #endif /* TST_NUMA_H__ */
> diff --git a/libs/numa/tst_numa.c b/libs/numa/tst_numa.c
> index c3297013be..f004e29014 100644
> --- a/libs/numa/tst_numa.c
> +++ b/libs/numa/tst_numa.c
> @@ -221,4 +221,18 @@ struct tst_nodemap *tst_get_nodemap(int type, size_t min_mem_kb)
>  	return nodes;
>  }
>  
> +struct tst_nodemap *safe_get_nodemap(int type, size_t min_mem_kb, size_t required)
> +{
> +	struct tst_nodemap *nodes;
> +
> +	nodes = tst_get_nodemap(type, min_mem_kb);
> +
> +	if (nodes->cnt < required) {
> +		tst_brk(TCONF, "Test requires at least %zi NUMA%s node%s",
> +				required, tst_numa_type_name(type), required > 1 ? "s" : "");
                                                                     ^
				     It does not make any sense to
				     request a NUMA with at least 1
				     node. Every computer has at least 1
				     node.

It may make sense to TBROK if the minimal number of nodes <= 1


> +	}
> +
> +	return nodes;
> +}
> +
>  #endif
> -- 
> 2.49.0
> 

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
