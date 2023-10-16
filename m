Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F52CDB465
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 08:04:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1CF713C88B0
	for <ltp@archiver.kernel.org>; Mon, 16 Oct 2023 10:04:04 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C40403C869D
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:03:53 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA44D1000D8F
 for <ltp@lists.linux.it>; Mon, 16 Oct 2023 10:03:52 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CB66121857;
 Mon, 16 Oct 2023 08:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1697443430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBrkjGDHzXLe57ButDestDoPwVAV+CJMQvTd1SsPnB4=;
 b=jIG+O9FQ5aghRI6VEIHIsJmQuk4hoVaJNtyagdIx378hppuF3TyO9gUsZuCSdSyCwuZSqR
 5YnEnunHZSyEcsagPFMOw0e3+IMdwlQQpgZpfX+GRNS5tACjaJkXysW/jbUvN3MVoeVMdD
 ZCwktsIy/A6rFWtvIWpWc+dcYvNY0lE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1697443430;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gBrkjGDHzXLe57ButDestDoPwVAV+CJMQvTd1SsPnB4=;
 b=zhFKgVCnS29YLYIBPs4pDoZi7EjGtNIov6NpwGW0Ux+th8BCSlAbJ/ZOxZt/EBQB6th8cd
 Xt0dcpGfy8cqdvBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CDE1133B7;
 Mon, 16 Oct 2023 08:03:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 2dwRJWbuLGXfAQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 16 Oct 2023 08:03:50 +0000
Date: Mon, 16 Oct 2023 10:03:49 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <20231016080349.GA844528@pevik>
References: <1694770587-9502-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1694770587-9502-1-git-send-email-xuyang2018.jy@fujitsu.com>
Authentication-Results: smtp-out1.suse.de;
	none
X-Spamd-Result: default: False [2.57 / 50.00]; ARC_NA(0.00)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz]; REPLYTO_EQ_FROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_THREE(0.00)[4];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-1.00)[-1.000]; NEURAL_SPAM_LONG(3.00)[1.000];
 FROM_EQ_ENVFROM(0.00)[]; MIME_TRACE(0.00)[0:+];
 MID_RHS_NOT_FQDN(0.50)[]; RCVD_COUNT_TWO(0.00)[2];
 RCVD_TLS_ALL(0.00)[]; BAYES_HAM(-0.13)[67.37%]
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls/renameat: Remove renameat fallback
 definition
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

Hi Xu,

> Looking at man renameat, it was added into kernel 2.6.16 and since the
> oldest kernel we support is 3.10 (see doc/supported-kernel-libc-versions
> .txt) we can as well completely drop this fallback definition.

BTW although man is correct, the lapi function was IMHO done due missing libc
support. It was added in glibc 2.4, thus not sure why the support was added in
2014, probably to support the oldest distros.

Also, without kernel support the function would not work at all,
therefore it is irrelevant when readlinkat was added into kernel.

Thus I dared to update the commit message.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
