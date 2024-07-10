Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09C03C38150
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 08:16:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8766C3D3826
	for <ltp@archiver.kernel.org>; Wed, 10 Jul 2024 10:16:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CC493D0B06
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:16:29 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 673371401209
 for <ltp@lists.linux.it>; Wed, 10 Jul 2024 10:16:27 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2E7A8219CB;
 Wed, 10 Jul 2024 08:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720599386; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+d8Zqa0gdh7arJvmys3dGWq0uLWhRJ6n+fI17hSOrAE=;
 b=03OXDvYlNztGwO2lJLEyDV+YRF7o8rbkX+WCuOE7FcI6vSmH+VFHA6V7UFK5+NuJcu+enA
 O4aaAmkfrJHRJLW4zeoL5S+jfNv/RrDMpMMTGEsRGbgUpJe2ZHtPaxPnKrInQWaKHGbS5h
 jIQGupz6IlGNYl+oaRPnYJEV17CvqHM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720599386;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+d8Zqa0gdh7arJvmys3dGWq0uLWhRJ6n+fI17hSOrAE=;
 b=zxLk6Ag244kZIbN1p986exNGwHyD9aOxrSSOI4N6Mlh5k7po9T2goE+g2wqcLAZFY93Ovp
 Bn9L22fVQ/BI0IDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1720599384; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+d8Zqa0gdh7arJvmys3dGWq0uLWhRJ6n+fI17hSOrAE=;
 b=vVIeKkxNp3k8zuJlyzvLD2wAYszZPPV1N6cDm2IYgUGVaOm3jyhMQjM3TOJ7Ka+wdKGy3n
 fsVzIYMNs4iAKGUc99UxSIsAgNXL2EpOMBjHeDaXdc1OOdBywFy6I6qY0S8g8MIO3Tq+Jj
 njlRGC/7Xn4x2s/W7D3wS3PSBKQL46M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1720599384;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+d8Zqa0gdh7arJvmys3dGWq0uLWhRJ6n+fI17hSOrAE=;
 b=YSLi9DbcN0bMZQVO/dzj/9K+OBHo5HZt6Le4LnCC1eV+4rIEo1HAGrWdXYf+tfWvVLRvjT
 00dtqZu9KBTriUCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1E292137D2;
 Wed, 10 Jul 2024 08:16:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ivQ4BlhDjmarQQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 10 Jul 2024 08:16:24 +0000
Date: Wed, 10 Jul 2024 10:18:55 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Zo5D7wpNvQjK6xX2@rei>
References: <20240516-listmount_statmount-v3-0-2ff4ba29bba7@suse.com>
 <20240516-listmount_statmount-v3-8-2ff4ba29bba7@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240516-listmount_statmount-v3-8-2ff4ba29bba7@suse.com>
X-Spamd-Result: default: False [-3.80 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:email]
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 08/11] Add statmount03 test
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
> +static void run(void)
> +{
> +	memset(st_mount, 0, sizeof(struct statmount));
> +
> +	TST_EXP_PASS(statmount(
> +		root_id,
> +		STATMOUNT_MNT_BASIC,
> +		st_mount,
> +		sizeof(struct statmount),
> +		0));
> +
> +	if (TST_RET == -1)
> +		return;
> +
> +	TST_EXP_EQ_LI(st_mount->mask, STATMOUNT_MNT_BASIC);
> +	TST_EXP_EQ_LI(st_mount->size, sizeof(struct statmount));
> +	TST_EXP_EQ_LI(st_mount->mnt_id, root_id);
> +	TST_EXP_EQ_LI(st_mount->mnt_id_old, root_id_old);
> +	TST_EXP_EQ_LI(st_mount->mnt_parent_id, parent_id);
> +	TST_EXP_EQ_LI(st_mount->mnt_parent_id_old, parent_id_old);
> +	TST_EXP_EQ_LI(st_mount->mnt_propagation, MS_PRIVATE);

You are missing the mnt_master and mnt_peer_group these are I suppose
set to 0 in this case. I guess that we would have bind mount the mount
and make it slave to get the mnt_master set. And I'm not sure how to set
the mnt group id.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
