Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98B7DD690F8
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 10:55:12 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F30F23DBBCC
	for <ltp@archiver.kernel.org>; Thu, 28 Nov 2024 11:55:10 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC35C3DBB2A
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 11:54:55 +0100 (CET)
Authentication-Results: in-2.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=2a07:de40:b251:101:10:150:64:1; helo=smtp-out1.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BC6F163F2BB
 for <ltp@lists.linux.it>; Thu, 28 Nov 2024 11:54:53 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E5D2721109;
 Thu, 28 Nov 2024 10:54:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732791292; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPuXSiyS4K+vqWhykNsa1gRvd/bNfAm6+iPphCg3YnU=;
 b=1YmS6YBwH5lt6c7mMRYgxVe5A59aTTFHjjWCNSP3GP4EBGGwGemy/YsfKIFLxHteuc41OF
 fJLNS18QUlQ2Skbm49Yprrwp9A6h1p0yjOVHftpZBv/5jrebJrUVo8LTDTyqMju9PRZKXQ
 tHlPQJVA3PDdKB5ZmWWAtmm8sK9usf8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732791292;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPuXSiyS4K+vqWhykNsa1gRvd/bNfAm6+iPphCg3YnU=;
 b=FFNtT98HYQarQNhE9JtMvbrxzMiMn7qkVoHdzXeWs9WYE6jFrG2MOVF+WPD6c70iB3tkUI
 oGuqljCE0HFjEjBg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=JHI9e2cP;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=aDTOjY4w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1732791291; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPuXSiyS4K+vqWhykNsa1gRvd/bNfAm6+iPphCg3YnU=;
 b=JHI9e2cPZmt4Y0RH/NovycRuzLlpK9duHGx+e3+nkQ3p3mDiUwrkI4u+v6Q2s5yLJI8Hg1
 9ASZTmNQym/8gafGmZSTiB6s5btip+uxaCavI+cD6EWzlfM/XV7j/YqjXB2dynn+ULcW+r
 efACkF3cr/kvij35LNeEKX587S1Mbdo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1732791291;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=FPuXSiyS4K+vqWhykNsa1gRvd/bNfAm6+iPphCg3YnU=;
 b=aDTOjY4whj5Bw2CMGyPBjvpyxaf6WWyzw21o3wUbG0F+FT5EQw9kEbKLzsaRkZ6gkTGVz8
 USOnf9XKoNY4oUBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D4AF513690;
 Thu, 28 Nov 2024 10:54:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mHkmM/tLSGdYTgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 28 Nov 2024 10:54:51 +0000
Date: Thu, 28 Nov 2024 11:55:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Z0hMCHO0cBpmj91V@yuki.lan>
References: <20241125-input_refactoring-v1-0-b622b3aa698d@suse.com>
 <20241125-input_refactoring-v1-7-b622b3aa698d@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20241125-input_refactoring-v1-7-b622b3aa698d@suse.com>
X-Rspamd-Queue-Id: E5D2721109
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 ASN(0.00)[asn:25478, ipnet:::/0, country:RU];
 MISSING_XM_UA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_TLS_ALL(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FUZZY_BLOCKED(0.00)[rspamd.com];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.cz:dkim,suse.cz:email];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 7/7] Delete depreacted input test suite helper
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
> -static void check_ui_get_sysname_ioctl(int fd)
> -{
> -	char sys_name[256];
> -	char dev_name[256];
> -	char *path;
> -
> -	SAFE_IOCTL(NULL, fd, UI_GET_SYSNAME(sizeof(sys_name)), sys_name, NULL);
> -	SAFE_ASPRINTF(NULL, &path, "/sys/devices/virtual/input/%s/name", sys_name);
> -
> -	if (FILE_SCANF(path, "%s", dev_name)) {
> -		tst_resm(TFAIL|TERRNO, "Failed to read '%s'", path);
> -		free(path);
> -		return;
> -	}
> -
> -	if (!strcmp(VIRTUAL_DEVICE, dev_name))
> -		tst_resm(TPASS, "ioctl UI_GET_SYSNAME returned correct name");
> -	else
> -		tst_resm(TFAIL, "ioctl UI_GET_SYSNAME returned wrong name");
> -
> -	free(path);
> -}
> -
> -void create_device(int fd)
> -{
> -	int nb;
> -	struct uinput_user_dev uidev = {
> -		.name = VIRTUAL_DEVICE,
> -		.id = {
> -			.bustype = BUS_USB,
> -			.vendor = 0x1,
> -			.product = 0x1,
> -			.version = 1,
> -		}
> -	};
> -
> -	SAFE_WRITE(NULL, SAFE_WRITE_ALL, fd, &uidev, sizeof(uidev));
> -	SAFE_IOCTL(NULL, fd, UI_DEV_CREATE, NULL);
> -
> -	for (nb = 100; nb > 0; nb--) {
> -		if (check_device()) {
> -			check_ui_get_sysname_ioctl(fd);

This check is being removed without replacement. This was added in:

commit ccc8bc7b8104d932daf5d1131b0522250eaa14ce
Author: Wei Gao via ltp <ltp@lists.linux.it>
Date:   Tue Oct 17 09:16:46 2023 -0400

    testcases/input: Add test for UI_GET_NAME ioctl


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
