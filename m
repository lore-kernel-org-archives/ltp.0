Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12AD8C4332F
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 13:26:22 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8B52C3CA368
	for <ltp@archiver.kernel.org>; Thu,  3 Mar 2022 14:26:20 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 4A2AF3C9544
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:26:11 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 9E1AF1000954
 for <ltp@lists.linux.it>; Thu,  3 Mar 2022 14:26:10 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C5081218D6;
 Thu,  3 Mar 2022 13:26:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646313969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KU1ESgWGVcxhNgj7MsT+FVwOhStany1C1ykZ09FN0Mg=;
 b=HZWgYtq7HnA7M5U+f+aBCXYiJR4TTDaZxLJHb+IOyuyVR+E4Ccdoj8hpA3CGLWX8QT5LN8
 ZYxNdHM1E1VebGIiwoajXxasinCCEjzjUADx9sdJHNKx1EA3mIYCNSzqP0DfWVnLQPXuG4
 PQfuqXBhdxreSLipWkx9yF0efZWSslE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646313969;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KU1ESgWGVcxhNgj7MsT+FVwOhStany1C1ykZ09FN0Mg=;
 b=JPSgQmYl30tREmq6lr/WT2sLUMriKIG5iMewt3TfeFPWCONEiv0FkD7r9YR/WCEQve0CfG
 mbCtDp1blW8aMoBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 910EC13C23;
 Thu,  3 Mar 2022 13:26:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yKTJIfHBIGKAWgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 03 Mar 2022 13:26:09 +0000
Date: Thu, 3 Mar 2022 14:26:07 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <YiDB7wO3Se/vN15+@pevik>
References: <20220223200731.1859670-1-yaelt@google.com> <Yh+S7JD2q8oalRoM@yuki>
 <YiBcyvtqTX1CerM4@pevik> <YiC4Pj1sH8UIHY7k@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiC4Pj1sH8UIHY7k@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/keyctl09: test encrypted keys with
 provided decrypted data.
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
Cc: linux-integrity@vger.kernel.org, Yael Tzur <yaelt@google.com>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Cyril,

> Hi!
> > > I this case I guess that in this case the change is so minimal that we
> > > can add this test into LTP once it reaches Linus tree.
> > Cyril, maybe we could finally merge our policy (waiting ack for you):
> > https://patchwork.ozlabs.org/project/ltp/patch/20220203101803.10204-1-rpalethorpe@suse.com/
> > and put keyctl09 into runtest/staging now.

> I guess that we still did not agree on exactly how this should be
> handled or did we?

Isn't it enough "Once a feature is part of the stable kernel ABI the associated
test must be moved out of staging." ?

If not, we should raise this question on that patch thread to find a conclusion.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
