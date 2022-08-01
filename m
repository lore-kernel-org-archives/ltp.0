Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4447C00144
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 14:08:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id F2D1F3C8796
	for <ltp@archiver.kernel.org>; Mon,  1 Aug 2022 16:08:23 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 237BC3C07B4
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:08:13 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 2CC0060087F
 for <ltp@lists.linux.it>; Mon,  1 Aug 2022 16:08:12 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id EC6B3208E6;
 Mon,  1 Aug 2022 14:08:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1659362891; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GowXbSLXMvBi4zZG83KNvSmMFE1PxVYjElS3XGEvFvc=;
 b=1b/ecOJjNcLcEagtJY/B3+iRLm1NZSvHeQImakjDZweNTEBVW2I2tdbCnhTTLmwDBOI4l3
 GsG7zqCY8u98moHuf4QxbdHTxFTMZh3m3MeZAvZLh2QVST03DWH3nEi61KBmW3z4MWdX05
 r3iflEvvMdHlb0woM4hz6lCAqqBBVgo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1659362891;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GowXbSLXMvBi4zZG83KNvSmMFE1PxVYjElS3XGEvFvc=;
 b=MJXa2+YVudxEuD9sBmu7OSKPRSrFH0ek7c9b1qIzFFq8dgpiAIDeLC4zjj/VEEVW076897
 epaxtfduXELFrgBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D0EFF13AAE;
 Mon,  1 Aug 2022 14:08:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Khj9MUve52IGTwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 01 Aug 2022 14:08:11 +0000
Date: Mon, 1 Aug 2022 16:09:59 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Greg KH <greg@kroah.com>
Message-ID: <Yufetwojkjxzwl34@yuki>
References: <YufZ1ZcIhkjLFEWM@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YufZ1ZcIhkjLFEWM@kroah.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] Linux kernel development reports for the 5.10 release
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
Obviously the email ltp@lists.linux.it is a maling list for a Linux Test
Project. The project is run by developers of several companies so I have
no idea how to map that to a model where email belongs to a single
entity.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
