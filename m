Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE0BC4167B
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 18:00:04 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3DFF33CE7B3
	for <ltp@archiver.kernel.org>; Fri,  1 Dec 2023 19:00:03 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A636D3CD3FB
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 18:59:52 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id A659D10009EF
 for <ltp@lists.linux.it>; Fri,  1 Dec 2023 18:59:51 +0100 (CET)
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id A520E21C9F;
 Fri,  1 Dec 2023 17:59:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1701453590;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJ3AKLgB45/r7bZc7OL6wbrXVApD/fC0HcxHcgEZtek=;
 b=j7eL0RcRJTQUKWvSaKeyM0LfVYx4/NtOlEa2H/xI3F9Ks1HZ9NC3XC8mVpUQ84m45kXsnm
 XCUJAHTCpOIq8JFtq0AUbMrdMV4d9tI0RH/aIqYkXy+7DGuVcAkWAUzB0VCZhQEho3J+VT
 j/F6j7qzysZZcjsiyLDFdZmaQ5ClzSk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1701453590;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iJ3AKLgB45/r7bZc7OL6wbrXVApD/fC0HcxHcgEZtek=;
 b=E1qLD9fjjkQny9vQjqOzYD0H5We4L2cxXj1wYjguR6BDTqll6DMJTy/BJoqsy3hnmQ/od7
 7Y073JzKD7bpKnCg==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 6BA3513928;
 Fri,  1 Dec 2023 17:59:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
 by imap2.dmz-prg2.suse.org with ESMTPSA id kDKYGBYfamWceQAAn2gu4w
 (envelope-from <pvorel@suse.cz>); Fri, 01 Dec 2023 17:59:50 +0000
Date: Fri, 1 Dec 2023 18:59:48 +0100
From: Petr Vorel <pvorel@suse.cz>
To: xuyang <xuyang_jy_0410@163.com>
Message-ID: <20231201175948.GE2829815@pevik>
References: <20231201100907.7308-1-mdoucha@suse.cz>
 <b535b89.17d1c.18c24f86d7d.Coremail.xuyang_jy_0410@163.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <b535b89.17d1c.18c24f86d7d.Coremail.xuyang_jy_0410@163.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [0.56 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 FREEMAIL_ENVRCPT(0.00)[163.com]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_GOOD(-0.10)[text/plain]; NEURAL_SPAM_SHORT(3.00)[1.000];
 RCVD_VIA_SMTP_AUTH(0.00)[]; NEURAL_HAM_LONG(-0.74)[-0.741];
 RCVD_COUNT_THREE(0.00)[3];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 TO_DN_ALL(0.00)[]; FREEMAIL_TO(0.00)[163.com];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_TLS_ALL(0.00)[];
 BAYES_HAM(-2.40)[97.23%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ioctl_loop06: Check for unsupported
 LOOP_SET_BLOCK_SIZE ioctl
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
Cc: ltp <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin, Xu,

merged, thank you!

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
