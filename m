Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 278C2C54EE9
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 08:59:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C97483CAC69
	for <ltp@archiver.kernel.org>; Fri, 16 Sep 2022 10:59:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E6DEC3CAA2F
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:59:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E25E4602F55
 for <ltp@lists.linux.it>; Fri, 16 Sep 2022 10:59:07 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 56B40200E7;
 Fri, 16 Sep 2022 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663318746; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hJ0vcZAX7XAEx1PyM0d3lIbNbCScGHAn700qvbAWug=;
 b=EojrGERcyyTGORButoMR5XbKuxQtoWSJ7eA+suxBVCupiwUvkeMZTJSKOR4gXR+8FuDXfS
 DFTm0UADXNpDZwpUYaJHUHShyi2J/PHk8gYiPLvNGVRCcKN33U5CojF1NzsxsF6ib1F5HM
 asSxbexnY4RwG1GC/9d/6UVXvJ7FqcQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663318746;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5hJ0vcZAX7XAEx1PyM0d3lIbNbCScGHAn700qvbAWug=;
 b=uCvlzv5/zyiUYfEgvd9dNWYNARTZLrwj0+JKVNL7djCgmzZSIlW4OUdxqcg6HJ3+IEwaCX
 ogrfFVmMBkvwCpBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A74C1346B;
 Fri, 16 Sep 2022 08:59:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 0ab/DNo6JGOJTgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 16 Sep 2022 08:59:06 +0000
Date: Fri, 16 Sep 2022 11:01:03 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YyQ7TwLFUu2dhp7m@yuki>
References: <20220915160343.21773-1-mdoucha@suse.cz> <YyQ2i0t6JEL0ksib@yuki>
 <98b89722-1cbe-5617-381b-df78d04f9d31@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <98b89722-1cbe-5617-381b-df78d04f9d31@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] ksm: Add max_runtime to tests
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
> Yes, that's a leftover, ksm05 gets executed for a fixed period of time 
> via the -I parameter in runfile so it doesn't need static max_runtime. 
> Otherwise the test finishes almost instantly. I forgot to remove the 
> mention in commit message, sorry about that.

I've fixed the commit message and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
