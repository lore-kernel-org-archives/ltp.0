Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60BFBC77B73
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 08:55:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C6BEF3CB8A3
	for <ltp@archiver.kernel.org>; Tue,  2 May 2023 10:55:55 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0CFA43CB8A3
 for <ltp@lists.linux.it>; Tue,  2 May 2023 10:55:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 406FA60028D
 for <ltp@lists.linux.it>; Tue,  2 May 2023 10:55:43 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1F8DA221E6;
 Tue,  2 May 2023 08:55:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683017742; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YqiqmyvTrY306TUZvUO5XmVselQNO2/Kv0IG8HzTfq8=;
 b=JrUGw1OtFZJQ0wVRfWiO7P7lb3dKAIrfhIGrXojX0mCS+iZCXm2Owg+zpd74q9mitFlRea
 0PKaJSfsf1YVpCZY/YQRW3yV2SFuXKUNSjCex5KiavK9Y+Q9sPULoYR9IvCn/Dw7lNd7Fm
 VLXe0D1DqYNmaMSGVXz2un7phhKvRjk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683017742;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YqiqmyvTrY306TUZvUO5XmVselQNO2/Kv0IG8HzTfq8=;
 b=JbvR3zLHZwo/PSP6eFoTH5OBqBFVO3KdF9gvRWq0/5i2GHFo6Hg9/xBOuV6jq2e+lPhzI2
 35P+KpUY6O6hk1Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F22F9134FB;
 Tue,  2 May 2023 08:55:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WqnNOQ3QUGT5QgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 02 May 2023 08:55:41 +0000
Date: Tue, 2 May 2023 10:53:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Mahesh Kumar G <maheshkumar657g@gmail.com>
Message-ID: <ZFDPnV2quLW4Inaj@rei>
References: <20230428153102.70919-1-mahesh.kumar.g@ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230428153102.70919-1-mahesh.kumar.g@ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Renamed test function paramter and function name
 under cn_pec.sh, cgroup_fj_stress.sh and memcg_failcnt.sh
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
Cc: Mahesh Kumar G <mahesh.kumar.g@ibm.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
I rewrote the commit message a bit and pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
