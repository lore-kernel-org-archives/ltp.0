Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C641BC433F5
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 11:53:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9DF903C8D46
	for <ltp@archiver.kernel.org>; Mon, 25 Apr 2022 13:53:39 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 90B353C1348
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 13:53:29 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 07D6314002A7
 for <ltp@lists.linux.it>; Mon, 25 Apr 2022 13:53:28 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2B34D1F38C;
 Mon, 25 Apr 2022 11:53:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1650887608; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsj5vjp5bc6lDQh7hTrCFZsjoy248WCJHfMYDHtwAtc=;
 b=s81nnBZdDcP2Zr7JfMKcpgfPyVDte7TP9oZ7py1uTCx7HBeEiOXBZ4tpKR6mfpyINwj+4K
 xKZ6quT3SkgV9Mdgo73LB48ZOpkL3asoZBMmkxCjTVARu+4WZFVOu+V3Tnuka+gJbweFM4
 ba80Z5d+L16vy6n31VFQxS4XNJwkFg0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1650887608;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hsj5vjp5bc6lDQh7hTrCFZsjoy248WCJHfMYDHtwAtc=;
 b=cs7F8BZ8ylnZzcpktbgOimbt6lW2aRiuzJW6gNFyCNxqbafR70f4R/iMPH5k+0MmLr/1Kg
 7WpSQKSGpV/mfjCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 161E513AE1;
 Mon, 25 Apr 2022 11:53:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xxrhA7iLZmKSXAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 25 Apr 2022 11:53:28 +0000
Date: Mon, 25 Apr 2022 13:53:01 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Wang Kunfeng <threefifteen.wangkunfeng@huawei.com>
Message-ID: <YmaLnbeI1N76l3HM@rei>
References: <20220422033552.257763-1-threefifteen.wangkunfeng@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220422033552.257763-1-threefifteen.wangkunfeng@huawei.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] kernel/hugemmap05.c: Skip test when default
 Hugepagesize 1G
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
> The kernel is not allow to change the file that
> /proc/sys/vm/nr_overcommit_hugepages,
> when default Hugepagesize 1G,so the testcase
> will be fail when close it.

I'm not sure what the exact problem is, but I guess that there is not
enough (continuous) memory to enable the overcommit, right?

In that case disabling the test on 1GB hugepages is certainly wrong.
What errno do we get if we attempt to close the file?

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
