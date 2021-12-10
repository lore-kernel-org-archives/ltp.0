Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F724C433F5
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 12:26:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 59EBA3C8115
	for <ltp@archiver.kernel.org>; Fri, 10 Dec 2021 13:26:55 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E393F3C7729
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 13:26:45 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 335131400965
 for <ltp@lists.linux.it>; Fri, 10 Dec 2021 13:26:44 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6E65D210FE;
 Fri, 10 Dec 2021 12:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1639139204; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9083BlSf2wv6VL72u8QdylBa2qX7vRkUGRgy7NY8qZY=;
 b=GAfir/48LTU109mtGTAYaickzTMCQMHf8jizRjoxf+EHo84BUUh5ISkIYOLgAP8lMdel6O
 fge+rU2Jatc8GL7+v7BOEfknazxGZz60BHTJzDnNDjJ+w/Z9y64/8TXqN+/bNOSnagDm7r
 elY6IfQXnDinJ6veO+7dNaT0KjcLEcc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1639139204;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9083BlSf2wv6VL72u8QdylBa2qX7vRkUGRgy7NY8qZY=;
 b=KST+lQBZ79vrAiPK8ugH8c07YlmI/exmRjVzs3TkkKpd8O7o4rfgTNApY2EWVlT/jRXbM8
 wVP8MdXXvWDKrKAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5BF6713E02;
 Fri, 10 Dec 2021 12:26:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fNKEFYRHs2FHCgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 10 Dec 2021 12:26:44 +0000
Date: Fri, 10 Dec 2021 13:28:04 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <YbNH1J8E3nzH15Cu@yuki>
References: <YbJ3SKsLu7iNoqZc@pevik>
 <1639136448-2148-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1639136448-2148-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1639136448-2148-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 3/3] zram/zram03: Convert into new api
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
> Also add removing zram module step in setup, so we can avoid the situation that
> zram module is being used by zram-generator.
> 
> Fixes: #888
> Signed-off-by: Yang Xu <xuyang2018.jy@fujitsu.com>
> ---
> Not use lsmod to detect because tst_cmd doesn't support "lsmod |grep zram". Or
> I miss something?

We can do the same here as we do for the swap detection here.

Just SAFE_FOPEN("/proc/modules") and loop over the lines and do strstr() for zram.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
