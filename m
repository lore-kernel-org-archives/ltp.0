Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA7E1C5AD49
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 12:54:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F1E0C3C2BEF
	for <ltp@archiver.kernel.org>; Mon, 26 May 2025 14:53:59 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E1CE83C068B
 for <ltp@lists.linux.it>; Mon, 26 May 2025 14:53:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id DA803200A13
 for <ltp@lists.linux.it>; Mon, 26 May 2025 14:53:41 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5E3E21C74;
 Mon, 26 May 2025 12:53:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748264020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MysZvvYJOwOJ0/YXm4KZazTbjxyGfX3/mYXEdMKvgLo=;
 b=bUPDfdEt7JB3EVn+dGNOwp3GH1MPij6gMlx1WqzL1jzwEZAL6kQ1IPHjd+3CtQeCi9pP3x
 gtxAEMbilf9ESZubxYxPijpHPvf+IP8dTUGz8BA+G+3oIxbUHW2nhMAncbssGaifYUJQya
 81c5d+KHxbOyP+FSbP1Xb5AP+BdQTZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748264020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MysZvvYJOwOJ0/YXm4KZazTbjxyGfX3/mYXEdMKvgLo=;
 b=2X6VOlS9/EqA6EaCGTpYAj26EJK//foZJN4wethqYZF+grkUo3CXKCi/pFywqZrDow4whH
 q3lmN/YaOnomZwCA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1748264020; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MysZvvYJOwOJ0/YXm4KZazTbjxyGfX3/mYXEdMKvgLo=;
 b=bUPDfdEt7JB3EVn+dGNOwp3GH1MPij6gMlx1WqzL1jzwEZAL6kQ1IPHjd+3CtQeCi9pP3x
 gtxAEMbilf9ESZubxYxPijpHPvf+IP8dTUGz8BA+G+3oIxbUHW2nhMAncbssGaifYUJQya
 81c5d+KHxbOyP+FSbP1Xb5AP+BdQTZ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1748264020;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MysZvvYJOwOJ0/YXm4KZazTbjxyGfX3/mYXEdMKvgLo=;
 b=2X6VOlS9/EqA6EaCGTpYAj26EJK//foZJN4wethqYZF+grkUo3CXKCi/pFywqZrDow4whH
 q3lmN/YaOnomZwCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B421513964;
 Mon, 26 May 2025 12:53:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 7S4kKVRkNGjNLAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 26 May 2025 12:53:40 +0000
Date: Mon, 26 May 2025 14:54:04 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aDRkbKVKCawsnBlR@yuki.lan>
References: <20250516151028.1254207-1-wegao@suse.com>
 <20250526143551.1321709-1-wegao@suse.com>
 <20250526095456.GA118123@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250526095456.GA118123@pevik>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 FUZZY_BLOCKED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 ARC_NA(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[3];
 MIME_TRACE(0.00)[0:+]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 MISSING_XM_UA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TO_DN_SOME(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.7 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] fsconfig04.c: Check FSCONFIG_SET_PATH
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
> mkfs.bcachefs: invalid option -- 'F'
> fsconfig04.c:82: TBROK: mkfs.bcachefs failed with exit code 1
> 
> Having a way to specify just ext3 and ext4 would be better, IMHO we don't have
> way to do it.

Of course we do, that's what we do for subset of statx tests:

	.filesystems = (struct tst_fs []) {
		{.type = "ext3"},
		{.type = "ext4"},
		{}
	};

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
