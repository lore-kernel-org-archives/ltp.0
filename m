Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98C12C433FE
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 12:07:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E6F563CB387
	for <ltp@archiver.kernel.org>; Fri,  4 Nov 2022 13:07:52 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A37F23CB3E6
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 13:06:08 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3E8321000EBE
 for <ltp@lists.linux.it>; Fri,  4 Nov 2022 10:51:43 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 095141F8C1;
 Fri,  4 Nov 2022 09:51:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667555503; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fdIHas1MK8r7WtqB6IfLEQ9kD6WFsslZZe1zZ8bETLk=;
 b=IRGJu8YoBWj7C2Wh7D7wrFZnRwjR1njepqwTyT4k1r4igxLfHIh0ghrGyFmbmsSS3LNi9m
 ThLy+E/e/lhBm5YliNeUTyxblFkbZVhWcEAqTPZQBYCpFOO27OlSw3cfJLfst97BarPD0I
 WXUzxN3jC8MNfALpYugW3MXmxU+HnrI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667555503;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fdIHas1MK8r7WtqB6IfLEQ9kD6WFsslZZe1zZ8bETLk=;
 b=XqQhrODiuCP5D2WmlHkZQEXWOgHuveP2aL5wM3hPsqotNwc1Me7iftZVd+SWJM6DChkPtK
 p4Tq25bzfiBWToBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EB8F71346F;
 Fri,  4 Nov 2022 09:51:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5ZnYN67gZGMIEQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Nov 2022 09:51:42 +0000
Date: Fri, 4 Nov 2022 10:51:57 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Tarun Sahu <tsahu@linux.ibm.com>
Message-ID: <Y2TgvVtZcKqAKtvU@rei>
References: <20221104062716.615021-1-tsahu@linux.ibm.com>
 <20221104062716.615021-5-tsahu@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221104062716.615021-5-tsahu@linux.ibm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v7 4/4] Hugetlb: Migrating libhugetlbfs
 corrupt-by-cow-opt
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
Cc: sbhat@linux.ibm.com, aneesh.kumar@linux.ibm.com, geetika@linux.ibm.com,
 vaibhav@linux.ibm.com, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> +static void setup(void)
> +{
> +	hpage_size = SAFE_READ_MEMINFO(MEMINFO_HPAGE_SIZE)*1024;
> +	huge_fd = tst_creat_unlinked(MNTPOINT);

Same here, HUGEFILE instead MNTPOINT?

The rest looks good.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
