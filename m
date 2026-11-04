Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3177F606A328
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 16:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ChEy4Bg3;
	dkim=fail reason="signature verification failed" header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KDvYn0Lw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.cz header.i=@suse.cz header.a=rsa-sha256 header.s=susede2_rsa header.b=ChEy4Bg3;
	dkim=neutral header.d=suse.cz header.i=@suse.cz header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=KDvYn0Lw
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BCA1F3CC838
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 17:44:12 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F0D823C2707
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:43:56 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 342892005E5
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 17:43:56 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AF7B221F42;
 Wed,  4 Nov 2026 16:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793810634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJFgyeb+UDRu1gmNOZp4VacF7BwLBOc/ddkUq/6ipGQ=;
 b=ChEy4Bg3cJGFvWMQREAta22r4QZ0RzbS6+3WNo9RvfBtz2dk5AsoVhszBdMwfApaKjV03X
 KbFPux7/twefIE08EVpaLGo7md5LhN2cfvshdOnTJAOT6ZAvwjKJR+0D+2kmOkeb9LvCpP
 fjoWIFQicy1vUguq4yzbYMAU70Dd2yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793810634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJFgyeb+UDRu1gmNOZp4VacF7BwLBOc/ddkUq/6ipGQ=;
 b=KDvYn0LwET8Vbnug+j2A/IBUOAzWMAI9D3JH57NwAVgdiOctBkoL7ItlsObFfdutfliUc3
 RTNBiGxAOmcpLwCw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1793810634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJFgyeb+UDRu1gmNOZp4VacF7BwLBOc/ddkUq/6ipGQ=;
 b=ChEy4Bg3cJGFvWMQREAta22r4QZ0RzbS6+3WNo9RvfBtz2dk5AsoVhszBdMwfApaKjV03X
 KbFPux7/twefIE08EVpaLGo7md5LhN2cfvshdOnTJAOT6ZAvwjKJR+0D+2kmOkeb9LvCpP
 fjoWIFQicy1vUguq4yzbYMAU70Dd2yM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1793810634;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BJFgyeb+UDRu1gmNOZp4VacF7BwLBOc/ddkUq/6ipGQ=;
 b=KDvYn0LwET8Vbnug+j2A/IBUOAzWMAI9D3JH57NwAVgdiOctBkoL7ItlsObFfdutfliUc3
 RTNBiGxAOmcpLwCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 76F4F1350A;
 Wed,  4 Nov 2026 16:43:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Xg+bFMpg62pefAAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Wed, 04 Nov 2026 16:43:54 +0000
Date: Wed, 4 Nov 2026 17:43:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>, linux-fsdevel@vger.kernel.org,
 Hungyu Lin <dennylin0707@gmail.com>, jack@suse.cz, ltp@lists.linux.it
Message-ID: <20261104164348.GA396365@pevik>
References: <20261029210701.80050-1-dennylin0707@gmail.com>
 <CAOQ4uxho=0DZTHieLYYxDXqmSxfq0yMj6gLWUtpK-YDvVoyk+g@mail.gmail.com>
 <20261030170603.GA31132@pevik>
 <CAOQ4uxjsf=6Do-uNEOS9R61M8jXcmExY1jnrLNY9ex=doNn3wA@mail.gmail.com>
 <20261030174855.GA53338@pevik>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20261030174855.GA53338@pevik>
X-Spamd-Result: default: False [-12.50 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MISSING_XM_UA(0.00)[];
 FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org,suse.cz,lists.linux.it];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com];
 RCPT_COUNT_FIVE(0.00)[5]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Spam-Score: -12.50
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] inotify13: check rename cookie pairing after
 adjacent moves
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Reply-To: Petr Vorel <pvorel@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Hungyu Lin, Amir,

Given this is a test for bug from v2.6.31 I kept it in runtest/syscalls and
merged, thank you!

I suppose the fix is [PATCH v2] inotify: do not coalesce rename events [1].
Although Jan stated "added to my tree" [2] I haven't found it in his for_next
branch [3]. Please update the hash in the test or Cc me once it's merged.

Kind regards,
Petr

[1] https://lore.kernel.org/lkml/20261027192027.8617-1-dennylin0707@gmail.com/
[2] https://lore.kernel.org/lkml/u6fltejwlekpknwpxzy6pefif7ld3dhwvzqqalbzmtwtzjjaj2@hsulwhevxfds/
[3] https://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git/log/?h=for_next

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
