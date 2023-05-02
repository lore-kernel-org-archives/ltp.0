Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C25C77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 19:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9F3703CE373
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 21:46:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C9FA03CB8FA
 for <ltp@lists.linux.it>; Tue,  2 May 2023 21:46:46 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 53F52600072
 for <ltp@lists.linux.it>; Tue,  2 May 2023 21:46:45 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5FB2721F95;
 Tue,  2 May 2023 19:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683056803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpVe/q1811U+h4l2e4WnWEeNKYYEH0v4oXEdRJBveCI=;
 b=QspIPt0TLsoCtpx8bPzyQOJUT1n40lg1ZSEPFCmK6UOV6eQW6CzVVEBvmMssChA0ytMEUC
 yr/JAf+Ulnrm9SBALbFkYJDnJ29XyZYBXHiJlydX385zpruySfkVD+BviONO6zxX8QfieE
 Ug7KoVe/AoSuJx2DxGt+s8aR3P/UuJk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683056803;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QpVe/q1811U+h4l2e4WnWEeNKYYEH0v4oXEdRJBveCI=;
 b=A5EOaGVu4/YwTBw+Jtu6VptiSwlseiQwcSiV8V2aKVcUUgtbcM+I3J3o1rBrq7FPSk/DgK
 3yt7UWxlBZPpbzAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E89CF134FB;
 Tue,  2 May 2023 19:46:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id GIusMqJoUWQaHwAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 02 May 2023 19:46:42 +0000
Date: Tue, 2 May 2023 21:46:56 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>, ltp@lists.linux.it, nstange@suse.de
Message-ID: <20230502194656.GA3693086@pevik>
References: <20230421145746.5704-1-mdoucha@suse.cz>
 <20230421145746.5704-3-mdoucha@suse.cz>
 <20230502142607.GC3666374@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230502142607.GC3666374@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 3/5] KVM: Fix infinite loop in ptr2hex()
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Martin,

Thanks a lot, merged with amended commit message.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
