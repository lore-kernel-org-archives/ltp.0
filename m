Return-Path: <SRS0=D2qq=N6=lists.linux.it=ltp-bounces+ltp=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DCFFC433F5
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 14:17:45 +0000 (UTC)
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0E736113D
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 14:17:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B0E736113D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux.it
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C0F7F3C91A6
	for <ltp@archiver.kernel.org>; Wed,  8 Sep 2021 16:17:42 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 599AD3C077E
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 16:17:33 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id C344E601100
 for <ltp@lists.linux.it>; Wed,  8 Sep 2021 16:17:32 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0A14A20162;
 Wed,  8 Sep 2021 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1631110652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/N/7SQ9e03BB6DVxuuNlYHVqNmT2dGt/awzGJiViu8U=;
 b=K079ZHF9Qcn0hVgXOqkPrPILLjxSvT1qZA4I3WCpZbx+qRaUVy9v68mQf/m4DpZGA0UvsO
 dsr+PXc3MVfmACvenJrAzmYk+hOl0XkBR9aTi16HRRQU6K6hYfBEulWfjq+gB6NLbT2Rcp
 Gaovp9vCRTYKsk/lqMEyfnNS+679Wz4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1631110652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/N/7SQ9e03BB6DVxuuNlYHVqNmT2dGt/awzGJiViu8U=;
 b=OUOJDMJI5PK9nZKT13uzrk62vV04Ah5on7zIg4EBDOKupRV8q+LxsCKVmkfJkwpnR42qZ5
 /00FyRb3JiVrZjBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E535B13D0B;
 Wed,  8 Sep 2021 14:17:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 1WK/OPvFOGHnEQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 08 Sep 2021 14:17:31 +0000
Date: Wed, 8 Sep 2021 16:17:45 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YTjGCeaaA0Nv56hn@yuki>
References: <20210624132226.84611-1-krzysztof.kozlowski@canonical.com>
 <YTi8qQOZU3NriZvZ@yuki>
 <3308f9e1-7766-8409-0360-9fe798276a90@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3308f9e1-7766-8409-0360-9fe798276a90@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lib: memutils: don't pollute entire system memory
 to avoid OoM
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
Message-ID: <20210908141745.d7bSIP5LgxnD98smI3BqWXYk8VMk7piNp2JuifT9vEg@z>

Hi!
> > I guess that this is another bug that should be fixed before the
> > release. I still think that the memory pollution is a best effort
> > operation and that we should be more conservative with the reserve. I
> > would go for a few percents of the free memory just to be extra sure
> > that we do not cause memory pressure.
> > 
> > If we go for 2% we will add following;
> > 
> > safety = MAX(safety, info.freeram / 50);
> > 
> > Also it looks like info.freeram is the same as MemFree: from
> > /proc/meminfo, I guess that this is not wrong, since memory that have
> > been used in buffers is dirty enough for our case.
> 
> I'd recommend dividing by a power of 2 (either 32 or 64) but other than
> that, I completely agree.

Sounds good.

Krzysztof unless you disagree I will push your patch but change the
division factor from 200 to 64.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
