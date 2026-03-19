Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EAD61091901
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 17:40:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BA66A3E30BE
	for <ltp@archiver.kernel.org>; Thu, 19 Mar 2026 18:40:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A1313C292A
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 18:40:38 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9F339100077D
 for <ltp@lists.linux.it>; Thu, 19 Mar 2026 18:40:37 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 570084D2A7;
 Thu, 19 Mar 2026 17:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773942036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mp/qkDhpnJos/AhQPzH7aNkkpkHDZQv7aBIZ881QJjQ=;
 b=NYBkN/rZNEEP/ueqKhMcYXy688bVtqpMf5wVdbEdOJ7H/aEYI3A8xmTErS7wYc1Y+VyEsx
 vDf3hLT64afsXK8Gp2SKqYe7iWu9rAR6ozh3a/KqdTTYxVPCat8qzC3LPKZMk2scgZwap9
 TUfyYeoypF47XMWhZt9ps2Orhr5+CuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773942036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mp/qkDhpnJos/AhQPzH7aNkkpkHDZQv7aBIZ881QJjQ=;
 b=QzzS6h79/HcjwpJwITN+0k/UCq4YXmkLGsH8Eu3ZBGrmZVxOQfx5rWJbkyqehin5e7jq7g
 9cQaDS2D0/iyshCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b="NYBkN/rZ";
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=QzzS6h79
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1773942036; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mp/qkDhpnJos/AhQPzH7aNkkpkHDZQv7aBIZ881QJjQ=;
 b=NYBkN/rZNEEP/ueqKhMcYXy688bVtqpMf5wVdbEdOJ7H/aEYI3A8xmTErS7wYc1Y+VyEsx
 vDf3hLT64afsXK8Gp2SKqYe7iWu9rAR6ozh3a/KqdTTYxVPCat8qzC3LPKZMk2scgZwap9
 TUfyYeoypF47XMWhZt9ps2Orhr5+CuU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1773942036;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mp/qkDhpnJos/AhQPzH7aNkkpkHDZQv7aBIZ881QJjQ=;
 b=QzzS6h79/HcjwpJwITN+0k/UCq4YXmkLGsH8Eu3ZBGrmZVxOQfx5rWJbkyqehin5e7jq7g
 9cQaDS2D0/iyshCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E59D4273B;
 Thu, 19 Mar 2026 17:40:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eI0eExQ1vGl+QgAAD6G6ig
 (envelope-from <jack@suse.cz>); Thu, 19 Mar 2026 17:40:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 125ECA0AFD; Thu, 19 Mar 2026 18:40:28 +0100 (CET)
Date: Thu, 19 Mar 2026 18:40:28 +0100
From: Jan Kara <jack@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <xb4a277xjifyrgtwc7xochxc2ysuewk7tioefuje3r6sak3os2@nrgti25k63ul>
References: <20260319160318.6867-1-chrubis@suse.cz>
 <20260319160318.6867-3-chrubis@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260319160318.6867-3-chrubis@suse.cz>
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email,suse.cz:dkim,suse.cz:email];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 RCVD_COUNT_THREE(0.00)[3]; RCVD_TLS_LAST(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FROM_EQ_ENVFROM(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MISSING_XM_UA(0.00)[]; DKIM_TRACE(0.00)[suse.cz:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email]
X-Rspamd-Queue-Id: 570084D2A7
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] runtest: ltp-aiodio.part2: Limit the maximal
 filesize
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
Cc: Jan Kara <jack@suse.cz>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Thu 19-03-26 17:03:18, Cyril Hrubis wrote:
> The test was operating with filesize up to ~500MB which, in certain
> cases, was making the runtime too slow. Some test variants, especially
> with many processes, were running up to 15 mintues on modern hardware.
> After a discussion we agreed that we can reduce the maximal file size to
> one quater without sacrificing test coverage.
> 
> I've also assumed that there was a typo in ADSP072 since the buffer size
> was set to be order of magnitude bigger than the file size.
> 
> CC: Jan Kara <jack@suse.cz>
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  runtest/ltp-aiodio.part2 | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/runtest/ltp-aiodio.part2 b/runtest/ltp-aiodio.part2
> index 599c9fd2f..c82f6fd02 100644
> --- a/runtest/ltp-aiodio.part2
> +++ b/runtest/ltp-aiodio.part2
> @@ -25,8 +25,8 @@ ADSP023 aiodio_sparse -o 4 -w 1024k -s 4096k -n 6
>  ADSP024 aiodio_sparse -o 4 -w 2048k -s 8192k -n 6
>  ADSP025 aiodio_sparse -o 4 -w 4096k -s 16384k -n 6
>  ADSP026 aiodio_sparse -o 4 -w 18192k -s 72768k -n 6
> -ADSP027 aiodio_sparse -o 4 -w 18192k -s 518192k -n 6
> -ADSP028 aiodio_sparse -o 4 -w 65536k -s 262144k -n 6
> +ADSP027 aiodio_sparse -o 4 -w 18192k -s 129548k -n 6
> +ADSP028 aiodio_sparse -o 4 -w 65536k -s 129548k -n 6

I think the write size of 64MB is too large for 128MB file with 4 AIO
contexts - I think the size will be autotrimmed to 32MB. So you might as
well just specify -w 32768k.

Otherwise this looks good to me.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
