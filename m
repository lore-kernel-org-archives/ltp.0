Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C71DC38A2D
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 08:51:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 53CB93CA2EA
	for <ltp@archiver.kernel.org>; Tue, 25 Oct 2022 10:51:13 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E38403C04BF
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 10:51:03 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5E20A1A006E1
 for <ltp@lists.linux.it>; Tue, 25 Oct 2022 10:51:02 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 1DB502207F;
 Tue, 25 Oct 2022 08:51:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666687862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j72ytjjIFAc42MM57g/6V0bMxEaXhnzjuDBHvndymYY=;
 b=w9JEB9wDd3Cjvhznh+mIBeNrFYHg3CUtZWJ4HyLbjTX0OkDPlopGRTpYjnJdL2mvWs/l8P
 XE8A1q+4U3BTdlMJU8UCd7Oehw4OPX9id9//Fr4p3EFXrc+m2p/A7FvmuxEJ0Wnc+kqBIX
 Mo6BppN9Mpbph2YVjks5N9+Y3osJ7eQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666687862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j72ytjjIFAc42MM57g/6V0bMxEaXhnzjuDBHvndymYY=;
 b=xPdAXrkdYlKOzBcnDwbCe9YDqIxnbFHwF3i2x1Bicl+tjF/obrRpFedCs6ec0n9rwic6Qs
 XuuCDUjxg09w69Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id E6889134CA;
 Tue, 25 Oct 2022 08:51:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id gKV4N3WjV2PWKwAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Tue, 25 Oct 2022 08:51:01 +0000
Message-ID: <ab0f73ef-9e6d-5e7e-4ee1-8aa31ef2802e@suse.cz>
Date: Tue, 25 Oct 2022 10:51:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
References: <20221020130843.15147-1-mdoucha@suse.cz>
 <20221020130843.15147-3-mdoucha@suse.cz>
 <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
 <CAOQ4uxgUXZS4D1VDToGLqXV2nDuPFqUHWqwoY8V=u=iUcQFruw@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAOQ4uxgUXZS4D1VDToGLqXV2nDuPFqUHWqwoY8V=u=iUcQFruw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
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
Cc: Jan Kara <jack@suse.cz>, LTP List <ltp@lists.linux.it>,
 Matthew Bobrowski <repnop@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 24. 10. 22 18:18, Amir Goldstein wrote:
> Show me how this could hide a real bug.
> Give an example.
> It does not need to be a specific kernel
> use an example with imaginary kernel with a backported feature if you like.
> 
> fanotify14 is not about making sure that flag combinations are allowed
> it is about making sure that flag combinations are not allowed.
> 
> If the test case is testing illegal init flags, the outcome must be
> fanotify_init
> EINVAL.
> 
> If the test case is testing illegal mark flags, the outcome of fanotify_init
> may be EINVAL meaning that this test case will be skipped.
> It does not matter which specific init flag or init flag combination
> causes this EINVAL.
> 
> I am ready to be proven wrong, but with examples,
> like the one you provided with test case #8 and kernel 5.3.
> hand waving and talking about vague "real bugs" won't convince me.

Imagine two init flags, A and B (doesn't matter which ones) that are not 
supposed to conflict in any way according to documentation. And we'll 
add 3 fanotify14 test cases with the following init calls:
- fanotify_init(A)
- fanotify_init(B)
- fanotify_init(A|B)

All 3 init calls are supposed to pass and then fanotify_mark() is 
supposed to fail. Now imagine that we have a buggy kernel where both 
flags are implemented but fanotify_init(A|B) hits a weird corner case 
and returns EINVAL. In your version of the code, the test will assume 
that it's due to a missing feature and report the test case as skipped. 
In my version of the code, the test will report a bug because it knows 
that all the required features are present.

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
