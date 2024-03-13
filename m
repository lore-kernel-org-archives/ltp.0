Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08C1EC54791
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 16:15:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5FFCC3D05E6
	for <ltp@archiver.kernel.org>; Wed, 13 Mar 2024 17:15:53 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 2A4203C06A6
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 17:15:36 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:2; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 5BC34613BDF
 for <ltp@lists.linux.it>; Wed, 13 Mar 2024 17:15:35 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 08F821F7CE;
 Wed, 13 Mar 2024 16:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710346533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fj38uLP6XbDaxPi8CoJACOprIRqh/iyBtRmjll2nNPU=;
 b=IQUoG2lww1F+MhkFJlQ6VMhcfDMdd+ctl3xV5iUiUxfHBUaBJrfkvWSCOa1stPbXUQN/5Q
 LyrwTDZ2BNrD9sIrk6VhzxEJJQ5NNqLuowvbSwHp9gYxGk3CtqUlntnIYfioud6BGod4YU
 euDcfxAHH89Cnd546SmseHTxd7pSBu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710346533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fj38uLP6XbDaxPi8CoJACOprIRqh/iyBtRmjll2nNPU=;
 b=nlR1wo5P1ukmTIvWZfIzBUpYHzDWDFtNQZTu27be+7QdopHUECnCSJ42s+Z8m9cFgvyhut
 xS1s+czt2AbcGyDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1710346533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fj38uLP6XbDaxPi8CoJACOprIRqh/iyBtRmjll2nNPU=;
 b=IQUoG2lww1F+MhkFJlQ6VMhcfDMdd+ctl3xV5iUiUxfHBUaBJrfkvWSCOa1stPbXUQN/5Q
 LyrwTDZ2BNrD9sIrk6VhzxEJJQ5NNqLuowvbSwHp9gYxGk3CtqUlntnIYfioud6BGod4YU
 euDcfxAHH89Cnd546SmseHTxd7pSBu8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1710346533;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fj38uLP6XbDaxPi8CoJACOprIRqh/iyBtRmjll2nNPU=;
 b=nlR1wo5P1ukmTIvWZfIzBUpYHzDWDFtNQZTu27be+7QdopHUECnCSJ42s+Z8m9cFgvyhut
 xS1s+czt2AbcGyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DF2E81397F;
 Wed, 13 Mar 2024 16:15:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id GhxbNSTR8WUBCAAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Wed, 13 Mar 2024 16:15:32 +0000
Date: Wed, 13 Mar 2024 17:14:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Shiyang Ruan <ruansy.fnst@fujitsu.com>
Message-ID: <ZfHQ5zpMZntW5hSD@yuki>
References: <20240126040139.2534873-1-ruansy.fnst@fujitsu.com>
 <20240126040139.2534873-3-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240126040139.2534873-3-ruansy.fnst@fujitsu.com>
X-Spamd-Bar: /
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=IQUoG2lw;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=nlR1wo5P
X-Spamd-Result: default: False [-0.51 / 50.00]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_TWO(0.00)[2];
 MX_GOOD(-0.01)[]; FROM_EQ_ENVFROM(0.00)[];
 MIME_TRACE(0.00)[0:+]; BAYES_HAM(-0.70)[83.34%];
 ARC_NA(0.00)[];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,linux.it:url];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,linux.it:url];
 FUZZY_BLOCKED(0.00)[rspamd.com]; MID_RHS_NOT_FQDN(0.50)[];
 RCVD_TLS_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
X-Rspamd-Queue-Id: 08F821F7CE
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/3] fdatasync03: add [Description] tag and
 cleanup code
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
> +/*\
> + * [Description]
>   *
>   * It basically tests fdatasync() to sync test file data having large dirty
>   * file pages to block device. Also, it tests all supported filesystems on a
> @@ -37,10 +37,7 @@ static void verify_fdatasync(void)
>  
>  	tst_fill_fd(fd, 0, TST_MB, FILE_SIZE_MB);
>  
> -	TEST(fdatasync(fd));
> -
> -	if (TST_RET)
> -		tst_brk(TFAIL | TTERRNO, "fdatasync(fd) failed");
> +	TST_EXP_PASS_SILENT(fdatasync(fd));

There is a subtle difference the TST_EXP_PASS_SILENT() does not exit the
function as the tst_brk() does, so this should be:

	TST_EXP_PASS_SILENT(fdatasync(fd));

	if (!TST_PASS)
		return;

So that we do not continue with the test if the fdatasync() failed.

>  	written = tst_dev_bytes_written(tst_device->dev);
>  
> -- 
> 2.34.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
