Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CA53C3ABCD
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 13:26:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 41C713CC2AA
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 15:26:53 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3D03C3C1A7F
 for <ltp@lists.linux.it>; Mon, 12 May 2025 15:26:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E51C910006C1
 for <ltp@lists.linux.it>; Mon, 12 May 2025 15:26:35 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B99741F38C;
 Mon, 12 May 2025 13:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747056394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reCGM90CSes1qQN/dIj8fpWqXoe8OrH1Ngp1i3OQEyM=;
 b=oRNlYdfxU/uLNZzdsENmRUPzlNmxjQyrkY5JKVC2Oe/iW3wAGTOaHQdNO5wIczkiUVMVCx
 VGcqrvUY4xjNlnfjeLk8S3D8DpgPjpX+1Lfs1HJ/kv9FSHN7ZrguiwcKlSn5k1+9Wjpghy
 kkNLGNqRbccc+oB7+HwE6y2IFZtXAm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747056394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reCGM90CSes1qQN/dIj8fpWqXoe8OrH1Ngp1i3OQEyM=;
 b=d7Gn86xdu1A2Q7QtszpvkcmkCysKzUCMS1QfCKPujxcPOQt1Iu1ohSBZpSvjCRLTOcisEV
 Kc0g2h+4UsZcgtDA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747056394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reCGM90CSes1qQN/dIj8fpWqXoe8OrH1Ngp1i3OQEyM=;
 b=oRNlYdfxU/uLNZzdsENmRUPzlNmxjQyrkY5JKVC2Oe/iW3wAGTOaHQdNO5wIczkiUVMVCx
 VGcqrvUY4xjNlnfjeLk8S3D8DpgPjpX+1Lfs1HJ/kv9FSHN7ZrguiwcKlSn5k1+9Wjpghy
 kkNLGNqRbccc+oB7+HwE6y2IFZtXAm0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747056394;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=reCGM90CSes1qQN/dIj8fpWqXoe8OrH1Ngp1i3OQEyM=;
 b=d7Gn86xdu1A2Q7QtszpvkcmkCysKzUCMS1QfCKPujxcPOQt1Iu1ohSBZpSvjCRLTOcisEV
 Kc0g2h+4UsZcgtDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9E194137D2;
 Mon, 12 May 2025 13:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sDVIJAr3IWhrJwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Mon, 12 May 2025 13:26:34 +0000
Date: Mon, 12 May 2025 15:26:29 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20250512132629.GA213602@pevik>
References: <20250509113206.59574-1-mdoucha@suse.cz>
 <20250509123410.22406-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250509123410.22406-1-liwang@redhat.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; RCPT_COUNT_TWO(0.00)[2]; TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:replyto,suse.cz:email];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mmap_24-1: update code comments
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

Hi Li,

> Follow-up: mmap_24-1: Change vm.max_map_count if needed

Thanks!
...
> +++ b/testcases/open_posix_testsuite/conformance/interfaces/mmap/24-1.c
> @@ -7,15 +7,23 @@
>   * source tree.
>   *
>   * The mmap() function shall fail if:
> - * [ENOMEM] MAP_FIXED was specified, and the range [addr,addr+len)
> + * [ENOMEM] MAP_FIXED was specified, and the range [addr, addr+len)
>   * exceeds that allowed for the address space of a process;
> - * or, if MAP_FIXED was not specified and
> - * there is insufficient room in the address space to effect the mapping.
> + * or, if MAP_FIXED was not specified and there is insufficient room
> + * in the address space to effect the mapping;
> + * or, if the process exceeds the maximum number of allowed memory mappings
> + * (as defined by /proc/sys/vm/max_map_count).
>   *
>   * Test Steps:
> - * 1. In a very long loop, keep mapping a shared memory object,
> - *    until there this insufficient room in the address space;
> - * 3. Should get ENOMEM.
> + * 1. In a very long loop, continuously map a shared memory object without
> + *    unmapping previous ones.
> + * 2. The loop continues until mmap() fails with ENOMEM.
> + *
> + * Note:
> + * This failure may occur due to either exhausting the process's
> + * virtual address space, or hitting the system-wide limit on
> + * the number of memory mappings (especially on systems with large RAM).
> + *
nit: please remove before commit this blank line.

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

>   */

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
