Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC388C38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 06:37:47 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2F4AB3CA1A2
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 08:37:45 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EFCF3C00D1
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 08:37:34 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D837C6008B3
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 08:37:33 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E63471FD74;
 Tue, 25 Oct 2022 06:37:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1666679852; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAnrRh+oj6ZJWk+pjFyv2yPd8OMTTPLT5fYZb9mt4lY=;
 b=yKjKXSZwibkDn5kOCtvvBUuNA1LjBPXbtVlzjc9c09xpIUL5u/Quix2tHfgSnzt72htkLP
 ly1C6VHj9GbNmlZUT1Gr6/WMyhI0rDzem1WqCqc9TEdeH568fyzbfV/F03ETAAlpB79fIL
 IaGL1vDZJl8r+cp9nFHK9yJcX/xBeuA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1666679852;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aAnrRh+oj6ZJWk+pjFyv2yPd8OMTTPLT5fYZb9mt4lY=;
 b=IPqS113UbXEmG8uYHOmr4BlaJfXpc5Oq+7nrI/MvOPdx7wPbogVCYkW0U7PXTbvbP6NJa8
 zaf+YN8J9226awDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2CFDD134CA;
 Tue, 25 Oct 2022 06:37:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kSr6NyuEV2N8ZQAAMHmgww
 (envelope-from <akumar@suse.de>); Tue, 25 Oct 2022 06:37:31 +0000
From: Avinesh Kumar <akumar@suse.de>
To: Petr Vorel <pvorel@suse.cz>
Date: Tue, 25 Oct 2022 12:07:29 +0530
Message-ID: <2663736.mvXUDI8C0e@localhost>
Organization: SUSE
In-Reply-To: <Y1MkHzCOXZYzomH/@pevik>
References: <20221012064929.4725-1-akumar@suse.de> <Y1MkHzCOXZYzomH/@pevik>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsgid01: Rewrite using new LTP API
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

Hi Petr,

On Saturday, October 22, 2022 4:28:39 AM IST Petr Vorel wrote:
> Hi Avinesh,
> 
> > Rewrite using new API and add test setfsgid(-1) which will always
> > fail but will determine if the preceding setfsgid() call changed
> > the filesystem group ID as expected.
> +1
> 
> Thanks, merged with fix below.
> 
> > -		gid = getegid();
> > -		GID16_CHECK(gid, setfsgid, cleanup);
> > -
> > -		TEST(SETFSGID(cleanup, gid));
> > -
> > -		if (TEST_RETURN == -1) {
> > -			tst_resm(TFAIL | TTERRNO,
> > -				"setfsgid() failed unexpectedly");
> > -			continue;
> > -		}
> > -
> > -		if (TEST_RETURN != gid) {
> > -			tst_resm(TFAIL, "setfsgid() returned %ld, expected %d",
> > -				 TEST_RETURN, gid);
> > -		} else {
> > -			tst_resm(TPASS,
> > -				"setfsgid() returned expected value : %ld",
> > -				TEST_RETURN);
> > -		}
> > -	}
> ...
> > +	gid = getegid();
> > +	GID16_CHECK(gid, setfsgid);
> 
> > -static void cleanup(void)
> > -{
> > +	SAFE_SETEUID(0);
> > +	TST_EXP_VAL(setfsgid(nobody_gid), gid);
> > +	TST_EXP_VAL(setfsgid(-1), nobody_gid);
> > +	TST_EXP_VAL_SILENT(setfsgid(gid), nobody_gid);
> 
> NOTE: all of these needed to be SETFSGID(), otherwise setfsgid01_16 would
> happily test 32-bit version instead of 16-bit version.
Thank you for this correction, will keep 16-bit thing in mind.

> 
> Kind regards,
> Petr
> 

Regards,
Avinesh




-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
