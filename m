Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CA9DC433EF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 14:46:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1C0D23CA12E
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 15:46:37 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CF8303CA0C0
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 15:46:27 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id DB4F01A006F2
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 15:46:26 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0DD8B1F380;
 Fri, 18 Feb 2022 14:46:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645195586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmNrqB4vYK0QE+GOLFnQAGXAiZrMq4L3HfkVuTtqma8=;
 b=ZX9Lg/J9Hsc1074O8wdaflyIWpeNts9rg/Nl0R9j7Y8Ub+hbQo5dLcjf74j/FgnlqAr1X5
 HxW74t6vq1cWIPZN37PWoFrOFHs/37Hi1xCn7XLSDzlAWFpmuPYSgEX9AIwWt2rriJ98ow
 NErFa8kcqWU54eErvutho9cHW3+6eSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645195586;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jmNrqB4vYK0QE+GOLFnQAGXAiZrMq4L3HfkVuTtqma8=;
 b=9VrMR8uiaplsFFQArSc2HhuBQN5SBZIpuP5PrU5/W4DdbyL0laOexdAZzS9t6PbMvSJTBK
 L4lfvOP0NceBw+Bw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E8C5813C94;
 Fri, 18 Feb 2022 14:46:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WhFjOEGxD2JwDwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Feb 2022 14:46:25 +0000
Date: Fri, 18 Feb 2022 15:48:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yg+xwn2UsG8CxmnQ@yuki>
References: <20220211114401.24663-1-mdoucha@suse.cz> <YgZcu4frLBaKVXL2@yuki>
 <2e218131-be2b-d6c8-51f7-f12b9091e859@suse.cz>
 <CAEemH2fqy3_t=-dbqE9Bx3VH6sZbNvM_bMon4zMukOh+rmw42Q@mail.gmail.com>
 <Yg+RXbUTOxK56iZa@pevik> <Yg+UQM+YCmNU1ShF@yuki>
 <Yg+wPtDfI4+bn1ww@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg+wPtDfI4+bn1ww@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] 72b1728674 causing regressions [ [PATCH v2] Terminate
 leftover subprocesses when main test process crashes]
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
Cc: LTP List <ltp@lists.linux.it>, Martin Doucha <martin.doucha@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> > I guess that it's a race between the SETSID() and exit(0) in the
> > move_to_background() function. If the main test process calls exit(0)
> > before the newly forked child managed to do SETSID() it's killed by the
> > test library because it's still in the old process group.
> 
> Thanks!  Yep, it'll probably be a race.
> 
> Your patch causes server being killed:
> tst_test.c:1511: TBROK: Test killed by SIGUSR1!
> 
> (no big surprise)

Ah right, we have to set up a dummy handler for SIGUSR1 since default
handler for SIGUSR1 will terminate the process.

Or set the .needs_checkpoints in the tst_test structure and use WAKE and
WAIT pair to synchronize.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
