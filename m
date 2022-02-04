Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E48D0C433F5
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 13:40:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D3A6F3C9AEC
	for <ltp@archiver.kernel.org>; Fri,  4 Feb 2022 14:40:37 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8EA2F3C9AA5
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:40:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 5B268601236
 for <ltp@lists.linux.it>; Fri,  4 Feb 2022 14:40:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6A4DC21101;
 Fri,  4 Feb 2022 13:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1643982027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2ndXwMBDMqgT75kPQG1vXqUenbDODqUiq0qnwx96/Y=;
 b=eR6EcTa6l+qETLUpvcmbQV4KCcjFkZTY5LWv/uJJXRBjm3t+OEEX3dVV54GPxGTqHa8/Vk
 NDdSC4a+VeqoIGUhuBPYaJD2eFfnSrReG8J66R55xM1U/dU6ZDcswEc3kQAy2vZgybQSwv
 EmMvCLHXh71sm2BKHTgUdH13I/EOuaM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1643982027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X2ndXwMBDMqgT75kPQG1vXqUenbDODqUiq0qnwx96/Y=;
 b=5JfyC4sPtR6djFEgOQW6+L1k9b80qi/CblQGkAh5O1jfq0W9tm+5QAew5EpSyzKt6qH4Ee
 Shd+xKujFfESKRBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 466C513AA9;
 Fri,  4 Feb 2022 13:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Cqw2EMss/WFfdgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 04 Feb 2022 13:40:27 +0000
Date: Fri, 4 Feb 2022 14:42:26 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Dai Shili <daisl.fnst@fujitsu.com>
Message-ID: <Yf0tQuDcTRRd9v9P@yuki>
References: <61F36C39.9030806@fujitsu.com>
 <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1643365754-5366-1-git-send-email-daisl.fnst@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] syscalls/statx09: Add new test
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
Cc: xuyang2018.jy@cn.fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
Pushed with minor adjustenment to the documentation comment, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
