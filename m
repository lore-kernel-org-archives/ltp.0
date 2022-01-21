Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84814C4332F
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 09:26:26 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58E503C96E5
	for <ltp@archiver.kernel.org>; Fri, 21 Jan 2022 10:26:24 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D5E113C9232
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:26:14 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 1666B1A01134
 for <ltp@lists.linux.it>; Fri, 21 Jan 2022 10:26:13 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 610402195A;
 Fri, 21 Jan 2022 09:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642757173; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zJxQgiAus1NtGp2id7Oze+DKLA4PQewik6kvs1g0uF0=;
 b=iBofLoTUIhWwPkPuSgfFqFGZKU/4K+3A8GnzjYkdf3Coik1reZ7xRnq/MJTmCFGaDPPZzR
 SvTrSQVvnaO7SSpfbAuZxaWcgyumCYAq/mZAZJzlkYupVSXGbfKoivwN4Qqvb3Nhbf3F2j
 MV0AKBVK9ieCQx5GeoONmIPn0T57BoI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642757173;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zJxQgiAus1NtGp2id7Oze+DKLA4PQewik6kvs1g0uF0=;
 b=F1OyRkz3dmixKO8jc+YopfmZgL69R+odK1BgONfSAPHHqpM/PrhPtXBEhELoK405cchZmS
 4AsFas8Pqj21MAAQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 40A4E13C1A;
 Fri, 21 Jan 2022 09:26:13 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Fef+DjV86mE4UQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 21 Jan 2022 09:26:13 +0000
Date: Fri, 21 Jan 2022 10:27:58 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yep8ntzBsWApxU8c@yuki>
References: <20220120150421.26639-1-andrea.cervesato@suse.de>
 <YemAQcXuJMGLh/kc@yuki> <Yep1Wm84sKzl3iB6@pevik>
 <Yep6u4N+phjB32Xd@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yep6u4N+phjB32Xd@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] Reduce needed memory by the dio_read test
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
> No, this is wrong. Also the issue can be just a timeout.
> ADSP074 (uses -n 512) runs framework ~3.5 min, ADSP075 (uses -n 1000) gets killed
> by LTP timeout. Do we want to increase tst_test.timeout for test?
> 
> Am I correct that we cannot increase based on particular input (for particular
> getopt value) as we cannot later update results.timeout during run?

There actually is tst_set_timeout() however in this case I wouldn't
bother because the test runtime largerly depends on the actuall speed of
the disk it is writing to and other parameters of the test such as block
size and the actual formula would be quite complex.

Also I do plan to fix this properly by V2 of the runtime patchset once
the release is finished, so I would go for minimal fix just before the
release which would be setting tst_test.timeout to sufficiently large
value.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
