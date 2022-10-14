Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E644C433FE
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 15:56:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 119A93CAF36
	for <ltp@archiver.kernel.org>; Fri, 14 Oct 2022 17:56:49 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A22853CAEF9
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 17:56:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 18E182002D4
 for <ltp@lists.linux.it>; Fri, 14 Oct 2022 17:56:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3527021ECB;
 Fri, 14 Oct 2022 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1665762996; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvx7cDlUrzIXqG5PDhFeB13LzYaB3IIiwgAGkoNIsrs=;
 b=E7kD1dfhEM2fNH1exjNt9s6Sph8VzS/liXVkPPoCXXPAM4eSN6nwx0LkBPZii6dT8V4Oh8
 JKEKsjQFIKBz3o6InNEKxNraSxGok9l7Icx83bmhX7f7vgbnSjafIeUhAdHVkUGRJQS0Dq
 rIG9OwlWNqGUeXelZpasmQZNwapRpiw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1665762996;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gvx7cDlUrzIXqG5PDhFeB13LzYaB3IIiwgAGkoNIsrs=;
 b=ck/A2U4AHhUhV3Dhn5OH5KDRQPsSEVvzPNzO36CEiyp+ZUUPmlaN4GZ+1ublx+99cdzezz
 XgbH6WmueM8aZ8CQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 209A113451;
 Fri, 14 Oct 2022 15:56:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id yqryBrSGSWMVfgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 14 Oct 2022 15:56:36 +0000
Message-ID: <6e5e878a-d4ff-f8a5-8dc7-4bd2b99ad5a5@suse.cz>
Date: Fri, 14 Oct 2022 17:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
References: <20221013154935.20461-1-mdoucha@suse.cz>
 <20221013154935.20461-3-mdoucha@suse.cz> <Y0iMQEXsQbkNMwWf@pevik>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y0iMQEXsQbkNMwWf@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/4] Move fanotify fallback constants and structs
 to LAPI header
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

On 14. 10. 22 0:08, Petr Vorel wrote:
> Hi Martin,
> 
> although it will be used only by tests in testcases/kernel/syscalls/fanotify/,
> it's cleaner to follow LTP approach.
> 
> Reviewed-by: Petr Vorel <petr.vorel@gmail.com>
> 
> ...
>> --- /dev/null
>> +++ b/include/lapi/fanotify.h
>> @@ -0,0 +1,210 @@
>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>> +/*
>> + * Copyright (c) 2012-2020 Linux Test Project.  All Rights Reserved.
> FAN_FS_ERROR has been added in 3db153665 ("syscalls/fanotify22: Introduce FAN_FS_ERROR test")
> which is 2022. Can be changed before merge.

OK, please update the copyright header. This patch doesn't depend on the 
first one so you can merge it right away.

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
