Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 166A7C4332F
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 15:51:29 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6D2C13C8121
	for <ltp@archiver.kernel.org>; Wed, 16 Nov 2022 16:51:28 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 439173C06C8
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:51:18 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id C2953600098
 for <ltp@lists.linux.it>; Wed, 16 Nov 2022 16:51:17 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 41E72336FA;
 Wed, 16 Nov 2022 15:51:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1668613876; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o91wtMpyxFRYB13XVDIgOKeW5J0tAYeke566OWIkKJ4=;
 b=fsa65GkVqcuo0wExezJZx3SbR0iMqNZvgav5rVMhLy0ld4+ydt9lPO9rEGkJRBkFsxwgMg
 8ycuAqGtwyFW6nxIpSHdJSgMKrw5dSmYmP+8cNcr+H62MZgTm9FCfr/bOUYI4/GXGpKNV2
 H3A8fy1IhwZQ7ESUFHqLjthMQiNLKNI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1668613876;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o91wtMpyxFRYB13XVDIgOKeW5J0tAYeke566OWIkKJ4=;
 b=LBrO/RYr2J9R7tFqYEejXzpRuvdgH0lF1xeuwHnSmUr7KoarKw2gg4i5bEATkSpSmtjOE+
 x85um05aWNk4qBDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2E5C1134CE;
 Wed, 16 Nov 2022 15:51:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XaJFCvQGdWNyeAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 16 Nov 2022 15:51:16 +0000
Message-ID: <bbf6dd3f-f736-88dc-96bb-575dfd2110cb@suse.cz>
Date: Wed, 16 Nov 2022 16:51:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Cyril Hrubis <chrubis@suse.cz>
References: <20221116145411.21299-1-mdoucha@suse.cz> <Y3UF2Jgkf0Svj7lm@yuki>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y3UF2Jgkf0Svj7lm@yuki>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] save_restore: Introduce new struct field for
 flags
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

On 16. 11. 22 16:46, Cyril Hrubis wrote:
>> +static void print_error(int info_only, const char *err, const char *path)
>> +{
>> +	if (info_only)
>> +		tst_res(TINFO | TERRNO, err, path);
>> +	else
>> +		tst_brk(TBROK | TERRNO, err, path);
>> +}
> 
> If I remmeber correctly I did ask for this to become a macro or pass
> __LINE__ so that we have a correct lines in the error output and you
> haven't commented on that.
> 
> Otherwise the rest looks good to me.

Right, sorry, I forgot about the line numbers. I'll send v5 shortly.

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
