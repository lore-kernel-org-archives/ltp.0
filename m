Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CE3CC5B543
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 07:32:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D5F03CA280
	for <ltp@archiver.kernel.org>; Thu,  5 Jun 2025 09:32:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 727213C91FB
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 09:32:35 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id B65D51A0153C
 for <ltp@lists.linux.it>; Thu,  5 Jun 2025 09:32:34 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DBF402219D;
 Thu,  5 Jun 2025 07:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749108752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1EcyaZOBI+FVRu6oLNRFqISxEvhNrV3CanfOE/+jfw=;
 b=LVceivnqeSOwsgivWvvBRpORRb5vhZv3Sf9Ft3bwRttBifea5QjxDnk+QK7CUhlqyjUdgE
 ZDeCwuzQq40elfEmP9KulH+GB7uajC8hRrtd95DCqJe4/zXf74C3sx4NUXcXCp4FaI1wxf
 y6rdxORpNofov2Jy1eq+ioM/12iO4eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749108752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1EcyaZOBI+FVRu6oLNRFqISxEvhNrV3CanfOE/+jfw=;
 b=IKttv1I4CAo17brhhnJzvB1u+PqeoXrI79QfEoDYaY4fqyw3n1Y5a8QMNA9LhBTCdiRrzl
 XBoIi7c0AFRSU6DQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LVceivnq;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IKttv1I4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1749108752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1EcyaZOBI+FVRu6oLNRFqISxEvhNrV3CanfOE/+jfw=;
 b=LVceivnqeSOwsgivWvvBRpORRb5vhZv3Sf9Ft3bwRttBifea5QjxDnk+QK7CUhlqyjUdgE
 ZDeCwuzQq40elfEmP9KulH+GB7uajC8hRrtd95DCqJe4/zXf74C3sx4NUXcXCp4FaI1wxf
 y6rdxORpNofov2Jy1eq+ioM/12iO4eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1749108752;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=d1EcyaZOBI+FVRu6oLNRFqISxEvhNrV3CanfOE/+jfw=;
 b=IKttv1I4CAo17brhhnJzvB1u+PqeoXrI79QfEoDYaY4fqyw3n1Y5a8QMNA9LhBTCdiRrzl
 XBoIi7c0AFRSU6DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAAEF1373E;
 Thu,  5 Jun 2025 07:32:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id h6WjLBBIQWg/LgAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 05 Jun 2025 07:32:32 +0000
Date: Thu, 5 Jun 2025 09:32:31 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Ricardo =?utf-8?B?Qi4gTWFybGnDqHJl?= <rbm@suse.com>
Message-ID: <20250605073231.GC1190804@pevik>
References: <20250425-conversions-mknod-v4-0-222e0d2e7ef1@suse.com>
 <20250425-conversions-mknod-v4-3-222e0d2e7ef1@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250425-conversions-mknod-v4-3-222e0d2e7ef1@suse.com>
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[];
 RCPT_COUNT_THREE(0.00)[3]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_ALL(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_DN_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Queue-Id: DBF402219D
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4 3/8] syscalls/mknod03: Convert to new API
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
Cc: Linux Test Project <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Ricardo, Andrea,

...
> +/*\
> + * Verify that mknod(2) succeeds when used to create a filesystem node with
> + * set-group-ID bit set on a directory with set-group-ID bit set. The node
> + * created should have set-group-ID bit set and its gid should be equal to
> + * the "nobody" gid.
>   */

> -#define MODE_RWX	S_IFIFO | S_IRWXU | S_IRWXG | S_IRWXO
> -#define MODE_SGID       S_IFIFO | S_ISGID | S_IRWXU | S_IRWXG | S_IRWXO
...
> +#define MODE_RWX 0777
> +#define MODE_SGID (S_ISGID | 0777)

And here also dropped S_IFIFO. Did I overlook a discussion that mknod() can be
called without S_IFIFO? (I don't think so).

And old tests use S_IFIFO also for mkdir(), but that is IMHO not needed.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
