Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC35C761AF
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 13:17:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED8963CCB86
	for <ltp@archiver.kernel.org>; Tue, 28 Mar 2023 15:17:26 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED9F23CA2F9
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:17:16 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id CEC2B14010F2
 for <ltp@lists.linux.it>; Tue, 28 Mar 2023 15:17:15 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A55E31FDCE;
 Tue, 28 Mar 2023 13:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1680009434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cs6IMD2cPb0SG0K6BVuXxkhIhq9fQ+ZqH3rp4int35c=;
 b=R4HfRqhEFBOz9kaJms/YS6cHTndOy2glWF3zbs30isry+5F2/EyYYb1umQj21oTELZh14w
 Vt0PTKIB6dDh7H2lAheQ0t0bFOjXFYuZPw7y4LqMNZdezQr0Siu0utnWE59aUWnNiO53vK
 sDlwS3OQjTnMWzexp9A+d9LMC1XgdpA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1680009434;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Cs6IMD2cPb0SG0K6BVuXxkhIhq9fQ+ZqH3rp4int35c=;
 b=TvFV4JxEZrdICTmOeOkva0O815ISLxViTr1xTl0/jP1JFewV2N4LaOPOF4DcATUPQevZKz
 oqR9aefLQppsEBAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 579C31390D;
 Tue, 28 Mar 2023 13:17:14 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xtAsEdroImRiUAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 28 Mar 2023 13:17:14 +0000
Date: Tue, 28 Mar 2023 15:17:12 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <20230328131712.GD755576@pevik>
References: <20230324062446.GA519460@pevik>
 <ZCLn3Fk26bPjm4qB@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZCLn3Fk26bPjm4qB@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Sparse checks does not include other headers in include
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
Cc: Richard Palethorpe <rpalethorpe@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> This is actually a geniune error, the tst_device.c does not include
> tst_device.h. I will send a patchset to fix the issues.

Ah, I should pay attention to the warnings :).
I guess you can merge the fix directly (simple enough).

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
