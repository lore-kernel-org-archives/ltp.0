Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9F66E7716C
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 10:35:08 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ADDF53DF91A
	for <ltp@archiver.kernel.org>; Thu,  5 Dec 2024 11:35:06 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8A0DE3DB3E0
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 11:34:51 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.130; helo=smtp-out1.suse.de;
 envelope-from=pvorel@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9A3561BD1721
 for <ltp@lists.linux.it>; Thu,  5 Dec 2024 11:34:50 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7482021114;
 Thu,  5 Dec 2024 10:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733394889;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsBvewCCCpwJtELBro6UIDIlDac5x8RAOz/QFYscTe4=;
 b=Vb1WKHPsZzi5SE82g+dYZMbDV6pq7V3EhNySrxsn81Vq1dWCRUmfx3SP/Iyo8dr5fMD7vY
 +OHVnC7wA4LsuPIdrpx6yK2M5G3mlVkfYTu2dAStO7OB00++AGoqgjVChaeSrPXSAOAwDa
 0bHxFeQWrRHoYbJG7u3xAnmBaspUbSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733394889;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsBvewCCCpwJtELBro6UIDIlDac5x8RAOz/QFYscTe4=;
 b=4HGuCwTaC4j8I+XNpi6O6CAZm24DHjTz1XNlGk14ZfoNnA2mKJXHYci0PdtUTYGr5C1fGe
 F31uwJyxCtYukRCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1733394889;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsBvewCCCpwJtELBro6UIDIlDac5x8RAOz/QFYscTe4=;
 b=Vb1WKHPsZzi5SE82g+dYZMbDV6pq7V3EhNySrxsn81Vq1dWCRUmfx3SP/Iyo8dr5fMD7vY
 +OHVnC7wA4LsuPIdrpx6yK2M5G3mlVkfYTu2dAStO7OB00++AGoqgjVChaeSrPXSAOAwDa
 0bHxFeQWrRHoYbJG7u3xAnmBaspUbSo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1733394889;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsBvewCCCpwJtELBro6UIDIlDac5x8RAOz/QFYscTe4=;
 b=4HGuCwTaC4j8I+XNpi6O6CAZm24DHjTz1XNlGk14ZfoNnA2mKJXHYci0PdtUTYGr5C1fGe
 F31uwJyxCtYukRCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2BABE132EB;
 Thu,  5 Dec 2024 10:34:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id k5m7BsmBUWdxFwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Dec 2024 10:34:49 +0000
Date: Thu, 5 Dec 2024 11:34:39 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <20241205103439.GA28204@pevik>
References: <20241204172312.34099-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241204172312.34099-1-mdoucha@suse.cz>
X-Spamd-Result: default: False [-7.50 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 1/2] nfs_lib.sh: Add support for extra NFS
 mount options
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

Hi Martin,

...
> +		nfs_opts="-o proto=$type,vers=$i"
> +
> +		if [ ! -z "$NFS_MOUNT_OPTS" ]; then

We have -n for non-null string. Even just [ "$NFS_MOUNT_OPTS" ] would work,
but -n is more obvious. I can change it before merge:

		if [ -n "$NFS_MOUNT_OPTS" ]; then

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr

> +			nfs_opts="$nfs_opts,$NFS_MOUNT_OPTS"
> +		fi
> +
>  		tst_res TINFO "Mounting $local_dir"
> -		nfs_mount "$local_dir" "$remote_dir" "-o proto=$type,vers=$i"
> +		nfs_mount "$local_dir" "$remote_dir" "$nfs_opts"

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
