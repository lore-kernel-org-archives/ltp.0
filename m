Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1750AC38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 08:37:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 907073C04BF
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 10:37:18 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0B34F3C04BF
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 10:37:08 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 8EC301400B92
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 10:37:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D91A01F74A;
 Tue, 25 Oct 2022 08:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666687027; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jzgt+q9wSwCYIY0Qfonj8BZd175tfSWx+QLrmVz9DQA=;
 b=Dm9VV9Zr2SfvtGTbB4+cfVJ1NApPmBIIAIbSdgHHLs0k5vZQQMuKJVEYY9gVRVILl6fNor
 tjYN7VhmctjHXADorQggzis7CTf2GDPWQ5TZYHvJda6gqRADo1GKte4LC7PgQ4pQ9zukIK
 84SsK3qsD9FT+N8/HAn/RjntNw5thlI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666687027;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Jzgt+q9wSwCYIY0Qfonj8BZd175tfSWx+QLrmVz9DQA=;
 b=PMgY8ICq8jNtN3/DjyuuG2Hol+1Ut6GKzRRJLn2sGpO9ukkf8jOzFu2OcR6cIqNpU3c0Ew
 qMsaHJIktgfFxsDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BB886134CA;
 Tue, 25 Oct 2022 08:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id RXbXLDOgV2MEJAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 25 Oct 2022 08:37:07 +0000
Message-ID: <4ab4ec76-c62f-9aaa-94a7-72e8b75d91cb@suse.cz>
Date: Tue, 25 Oct 2022 10:37:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To: Petr Vorel <pvorel@suse.cz>, Amir Goldstein <amir73il@gmail.com>
References: <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz> <Y1a6NXkayyy7esM+@pevik>
 <CAOQ4uxjGGxaa=snebi0wPnPWuFHgQ-9Mt9hPBr3wBAghGQQEJA@mail.gmail.com>
 <Y1bFWLQNBWG9zsdZ@pevik>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <Y1bFWLQNBWG9zsdZ@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 2/3] Add fanotify_get_supported_init_flags()
 helper function
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 24. 10. 22 19:03, Petr Vorel wrote:
>> The kernel UAPI is not very consistent about ENOTSUP vs. EINVAL
>> renameat(2), unlink(2), link(2) and other return EINVAL for unsupported flags
>> fallocate(2), ioctl(2) and others return ENOTSUP for unsupported commands.
>> It's not a clear cut, but ENOTSUP is generally for unsupported fs methods,
>> not for unsupported options.
> 
> thanks for info, I didn't know that. Otherwise Martin's note to use ENOTSUP
> would help.

I was not suggesting to change the kernel API, that's not a reasonable 
option at this point. I was just pointing out that the API design limits 
our options how to write reliable tests.

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
