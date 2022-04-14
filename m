Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A946C433EF
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 15:12:38 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5B7EF3CA5E8
	for <ltp@archiver.kernel.org>; Thu, 14 Apr 2022 17:12:36 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 551913C1BD6
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:12:26 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 407FC14002B0
 for <ltp@lists.linux.it>; Thu, 14 Apr 2022 17:12:24 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5735021614;
 Thu, 14 Apr 2022 15:12:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1649949144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XZ001iMvKQifgSSxwxAJHE/ghg692Nh5/9d2yPt/lwg=;
 b=ik6YYWCuReBHt4XnSJx8Z0orEtxnkO2/DC8pIY8w0uaZfhHNo92FY6hAIpJyCKFzNQev6c
 aPfkxWQv6QtHRkazmTEy131NzlP2UmBHFE49dpqaU7acRjgBMqJmRjvbd8WK5cPhw61Fd0
 V9Nqp7fhSrDUsIFTXzwxvUO2hhod3pE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1649949144;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XZ001iMvKQifgSSxwxAJHE/ghg692Nh5/9d2yPt/lwg=;
 b=5YYpEoCeKpY4d2VRwtJlz/CR65JFHzoAZ4Qm4xjxows5AWNR6HsohpprGm3llcmY1FnxBW
 BDCjKze7KAdoP0Cg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 134B313A86;
 Thu, 14 Apr 2022 15:12:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id id1vAtg5WGL6bAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 14 Apr 2022 15:12:24 +0000
Date: Thu, 14 Apr 2022 17:12:21 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Amir Goldstein <amir73il@gmail.com>
Message-ID: <Ylg51UMuHsxbHRSA@pevik>
References: <20220414145357.3184012-1-amir73il@gmail.com>
 <20220414145357.3184012-2-amir73il@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220414145357.3184012-2-amir73il@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/6] syscalls/fcntl: New test for DN_RENAME
 (dnotify)
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: Matthew Bobrowski <repnop@google.com>, Jan Kara <jack@suse.cz>,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Amir,

could you please fix fcntl39.c to be running for more iterations?

./fcntl39_64 -i2
tst_kconfig.c:82: TINFO: Parsing kernel config '/proc/config.gz'
tst_test.c:1459: TINFO: Timeout per run is 0h 05m 00s
fcntl39.c:68: TINFO: Testing no DN_RENAME on rename from parent to subdir
fcntl39.c:73: TPASS: No event on parent as expected
fcntl39.c:77: TPASS: No event on subdir as expected
fcntl39.c:79: TINFO: Testing DN_RENAME on rename of subdir itself
fcntl39.c:82: TPASS: Got event on parent as expected
fcntl39.c:88: TPASS: No event on subdir as expected
fcntl39.c:62: TBROK: open(test_dir,0,20254540) failed: ENOENT (2)

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
