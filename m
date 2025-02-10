Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C322C02198
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 13:54:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ACA6D3C98AA
	for <ltp@archiver.kernel.org>; Mon, 10 Feb 2025 14:54:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 248CA3C2F65
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:54:21 +0100 (CET)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 77AA060F451
 for <ltp@lists.linux.it>; Mon, 10 Feb 2025 14:54:20 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7AE421F390;
 Mon, 10 Feb 2025 13:54:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739195660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAse3lQ7R9CD11kowR8EMieDH5neCX+e3nPbK4kt4ec=;
 b=oe6s32b275eFA866hC2quZKsyKq9Sf4EZ3Yo7c3hlMhpAJyg0Cp1+AcPjOhXiyJP1Fc1bB
 s8lWabHoaO2fc/o8SunKkNK7qkerkmI8R0mhLY/Cdth/V7zxVL01tQR6kdoytYkTbUWohb
 dP+Cp3w3LrN2lKP7evzbLGB+p4Y++aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739195660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAse3lQ7R9CD11kowR8EMieDH5neCX+e3nPbK4kt4ec=;
 b=eii9wGHYZbUSQUQn8QvPjN/2Spx/pRETXOBMuR7+02w7/NMsU2RyO0Bq3dqe6AMlFpXqV9
 EaOB/+HD/IAnseAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1739195660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAse3lQ7R9CD11kowR8EMieDH5neCX+e3nPbK4kt4ec=;
 b=oe6s32b275eFA866hC2quZKsyKq9Sf4EZ3Yo7c3hlMhpAJyg0Cp1+AcPjOhXiyJP1Fc1bB
 s8lWabHoaO2fc/o8SunKkNK7qkerkmI8R0mhLY/Cdth/V7zxVL01tQR6kdoytYkTbUWohb
 dP+Cp3w3LrN2lKP7evzbLGB+p4Y++aI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1739195660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pAse3lQ7R9CD11kowR8EMieDH5neCX+e3nPbK4kt4ec=;
 b=eii9wGHYZbUSQUQn8QvPjN/2Spx/pRETXOBMuR7+02w7/NMsU2RyO0Bq3dqe6AMlFpXqV9
 EaOB/+HD/IAnseAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5FC8413A62;
 Mon, 10 Feb 2025 13:54:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 41ptFgwFqmcrFQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Mon, 10 Feb 2025 13:54:20 +0000
Date: Mon, 10 Feb 2025 14:54:09 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: pvorel <pvorel@suse.de>
Message-ID: <Z6oFAYL5a9dnxeUZ@yuki.lan>
References: <20250210113212.29520-1-chrubis@suse.cz>
 <20250210113212.29520-3-chrubis@suse.cz>
 <01a16c47a0920ed4c60db277087f9ea7@suse.de>
 <Z6n59mHMpZxIMcZk@yuki.lan>
 <a3395c69a6b9c9b8de6ef0f0fe6e35f3@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <a3395c69a6b9c9b8de6ef0f0fe6e35f3@suse.de>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCPT_COUNT_THREE(0.00)[3]
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 02/13] lib: Replace path_exist() with
 tst_path_exists()
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
I will wait till tomorrow so that other have chance to have a look and
then push the patchset.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
