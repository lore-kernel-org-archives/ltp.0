Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80708C433F5
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 10:52:03 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9D4813C698B
	for <ltp@archiver.kernel.org>; Wed,  9 Mar 2022 11:52:01 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 02F1E3C0FBC
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 11:51:51 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 46AB6601169
 for <ltp@lists.linux.it>; Wed,  9 Mar 2022 11:51:50 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3926E210FF;
 Wed,  9 Mar 2022 10:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646823110; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYf+rtniATxr/2CBX2gVrIXeUaryCtZ+UTRKao1gCTo=;
 b=dZNTbBBEvrQ/7vj2SjluFKlD/y6HnI3oArqvpLOgrVdHSPxZ9lzhbHIF0xP8NpFi0BuaS6
 P9/+PwmwSnTAwsgAIMq435vKvCFuqHnWFzKNbTLeq2fwk0EDo+e+oS3TGXmOUIb5sQ/hP7
 e9x7zXq9LvCbr+JWGDyzn2MeQYN8qsU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646823110;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oYf+rtniATxr/2CBX2gVrIXeUaryCtZ+UTRKao1gCTo=;
 b=5kU535l41cHdV55W2Zhql+hGdYeJwMufldzyT+FJ/RRMpK0t+lGnmK2WuZzuvR/0GQWYIm
 NHLciQ83QudxHQBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 22BE913B71;
 Wed,  9 Mar 2022 10:51:50 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id IjJ2B8aGKGIQUwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 09 Mar 2022 10:51:50 +0000
Message-ID: <c25c192d-9848-d7cd-d4a1-4f1b924f67e8@suse.cz>
Date: Wed, 9 Mar 2022 11:51:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
References: <1646297678-2141-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <YiDK7g1pwLj2aXBD@pevik> <6221869A.9040109@fujitsu.com>
 <3c946010-2f96-e8bb-e7ee-0d48d482d729@suse.cz> <62280B08.3010502@fujitsu.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <62280B08.3010502@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/setsockopt09: Add another linux git
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
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 09. 03. 22 3:03, xuyang2018.jy@fujitsu.com wrote:
> Hi Martin
>> The timeout is controlled by req.tp_retire_blk_tov and the value is in
>> milliseconds. So usleep(req.tp_retire_blk_tov * 3000) should be enough.
> I tested this on my vm, it still can't ensure hit the old crash before 
> print PASS log.

That is probably expected. You'll need make a taint check after the
usleep() to detect failure. See setsockopt06 which tests for similar
use-after-free in socket timer.

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
