Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA5CFA3741
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 17:23:16 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4BBB03CAC41
	for <ltp@archiver.kernel.org>; Mon, 31 Oct 2022 18:23:14 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EAFFB3C08D9
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 18:23:03 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5796F1000478
 for <ltp@lists.linux.it>; Mon, 31 Oct 2022 18:23:02 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1304D1F8E3;
 Mon, 31 Oct 2022 17:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1667236982; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8EC5F5aGQswVNBvxvTiGJE15mJe5fawI33HIIIdWu0=;
 b=eXycyEaNmGar4v8ieq/Yqxc4bU2Vc4iMukR8NuilElOKa0Qi6M8iUFQBSFrXhpPCOy3dXB
 goh615a0dg3WuNvRqNng7thBXdOo+gGOEPGFt/IEJ+wN/iOO0a2Cg1jkRebIqBb5wSdie+
 KvjEJm8VuCyCV68jDlQGNsI9P+uUuIo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1667236982;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H8EC5F5aGQswVNBvxvTiGJE15mJe5fawI33HIIIdWu0=;
 b=PdEf1s1e9J2Hd5fzIUnEBODYCZdLoFuIZH7WttaL4HVMvRgGtM+7YyYkPC2p74yt+w1Ten
 XFeNtBO/y5pzRXDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F3B3713AAD;
 Mon, 31 Oct 2022 17:23:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id S/7EOnUEYGPzVQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Mon, 31 Oct 2022 17:23:01 +0000
Message-ID: <7c3efc21-229f-5e76-21e4-3e778e7ba140@suse.cz>
Date: Mon, 31 Oct 2022 18:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221027140954.4094-1-akumar@suse.de> <Y1+zeo9kmWOl2yE3@pevik>
 <ad63ddb5-b443-c0ee-fb1b-748bded5f151@suse.cz> <Y1/SkicyE3Mg9Fpc@pevik>
 <96b14089-f1bb-e634-d74b-75fe92e58efa@suse.cz> <Y1/iFIltC2RXfDpl@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y1/iFIltC2RXfDpl@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setfsuid02: using -1 as invalid fsuid for
 setfsuid()
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 31. 10. 22 15:56, Petr Vorel wrote:
> Ah, sure, I see current_uid is used for checking only. So what is your
> suggestion to fix the problem on 16-bit?

I guess using UID_T (defined in the LTP compat headers) instead of uid_t 
is the solution, then -1 will be cast to the correct bitsize.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
