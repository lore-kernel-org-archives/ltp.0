Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DF60C4828D
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 14:10:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E45323CFAF2
	for <ltp@archiver.kernel.org>; Thu, 25 Jan 2024 15:10:52 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 903F33C1DC2
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 15:10:38 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 8442D605656
 for <ltp@lists.linux.it>; Thu, 25 Jan 2024 15:10:36 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id B4FAE1F891;
 Thu, 25 Jan 2024 14:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706191835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEkUqXjvuLnfiXXVSBV7281it+GW0XDg+pmoug+tZts=;
 b=rn1Z0nWHFbfk+DSjujaXPAGTjwr/75mK8vbWs3Ma7Vufyow5TmeMTNAxYz3eX3UgxhvgrK
 G4dhEKmXSTcN25QvSQgySectdvBaiDpEvEZ2yJxsk44KVZExdIjpdpRc1Wol5Egbg3yVGt
 xXoB0k+43ae9Ytqn+F8onptaYAHoChM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706191835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEkUqXjvuLnfiXXVSBV7281it+GW0XDg+pmoug+tZts=;
 b=uJZb4B0ugIl4DNRSbWQbS+r9Oqxl7kmPQSAB2wrKmdWL6D4BBsCl0NOZsRVZFZL3jiWuI+
 WGqpPazvwty+E1BQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1706191835; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEkUqXjvuLnfiXXVSBV7281it+GW0XDg+pmoug+tZts=;
 b=rn1Z0nWHFbfk+DSjujaXPAGTjwr/75mK8vbWs3Ma7Vufyow5TmeMTNAxYz3eX3UgxhvgrK
 G4dhEKmXSTcN25QvSQgySectdvBaiDpEvEZ2yJxsk44KVZExdIjpdpRc1Wol5Egbg3yVGt
 xXoB0k+43ae9Ytqn+F8onptaYAHoChM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1706191835;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZEkUqXjvuLnfiXXVSBV7281it+GW0XDg+pmoug+tZts=;
 b=uJZb4B0ugIl4DNRSbWQbS+r9Oqxl7kmPQSAB2wrKmdWL6D4BBsCl0NOZsRVZFZL3jiWuI+
 WGqpPazvwty+E1BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9508313649;
 Thu, 25 Jan 2024 14:10:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id H0eeINtrsmVWSwAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 25 Jan 2024 14:10:35 +0000
Date: Thu, 25 Jan 2024 15:10:44 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <ZbJr5IB1iCoVls36@yuki>
References: <20240123160507.31678-1-mdoucha@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240123160507.31678-1-mdoucha@suse.cz>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spamd-Result: default: False [0.40 / 50.00]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCPT_COUNT_TWO(0.00)[2]; FUZZY_BLOCKED(0.00)[rspamd.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-0.00)[19.61%]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fallocate06: Increase test loop device size to 1GB
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
> diff --git a/testcases/kernel/syscalls/fallocate/fallocate06.c b/testcases/kernel/syscalls/fallocate/fallocate06.c
> index 124fb7eae..83b4d88e6 100644
> --- a/testcases/kernel/syscalls/fallocate/fallocate06.c
> +++ b/testcases/kernel/syscalls/fallocate/fallocate06.c
> @@ -260,6 +260,7 @@ static struct tst_test test = {
>  	.test = run,
>  	.tcnt = ARRAY_SIZE(testcase_list),
>  	.needs_root = 1,
> +	.dev_min_size = 1024,
>  	.mount_device = 1,
>  	.mntpoint = MNTPOINT,
>  	.all_filesystems = 1,

Don't we need to add at least .max_runtime = 120 here as well?

Looks like I'm getting quite close to the default 30s timeout on a
machine with a old good rotating harddisc. I did measure between 10 and
20s for the case that we fill the 1GB filesystem.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
