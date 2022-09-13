Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421DFC6FA82
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 09:22:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 930183CAAF5
	for <ltp@archiver.kernel.org>; Tue, 13 Sep 2022 11:22:15 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E7CCD3CA6CB
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 11:22:04 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C81DE1A010FA
 for <ltp@lists.linux.it>; Tue, 13 Sep 2022 11:22:03 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3F595C0CB;
 Tue, 13 Sep 2022 09:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663060922; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8BuBhanrMVIZuZQyzzS/4IHi+QOg9sxIcHt9OSbJ3Yg=;
 b=PH6EVMFoMjq1oRTo59I3S/54ge/suTRJU03RI00ZQu3EOk+xcveSfy1HnL91N7UpwU5aNQ
 gr1eYqi1ZHEc/yhRZQZcrdLvGCdtGvV8kZjjQ0qM91AzUDC7sJmwtbi3jrMLk9hVJcvg0t
 2Tjk77z6ktOzv9d07z54G3Ht1FD/rvQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663060922;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8BuBhanrMVIZuZQyzzS/4IHi+QOg9sxIcHt9OSbJ3Yg=;
 b=tGdP43GEzPLoB/XJi8ImzAXTp7IxmW/WVi1Vu2GBE3y9W0ykPBz7PHlVRcLwk2qlGTdKkP
 SK8C1dt6OGpbeNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B2DD9139B3;
 Tue, 13 Sep 2022 09:22:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Tf8iKrpLIGOpLgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 13 Sep 2022 09:22:02 +0000
Date: Tue, 13 Sep 2022 11:23:58 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YyBMLuCWwI/H1hcj@yuki>
References: <Yxr+EpKTnKQbKXTb@yuki>
 <3880769c-49e0-6158-c480-634632fb3c76@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <3880769c-49e0-6158-c480-634632fb3c76@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] September LTP release
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> [1]https://patchwork.ozlabs.org/project/ltp/list/?series=313791
> [2]https://patchwork.ozlabs.org/project/ltp/patch/1657106160-2126-1-git-send-email-xuyang2018.jy@fujitsu.com/

I will have a look.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
