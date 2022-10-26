Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB6DC38A2D
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 14:34:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 694AC3CA7F0
	for <ltp@archiver.kernel.org>; Wed, 26 Oct 2022 16:34:54 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7129E3C0282
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:34:44 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 77FBF200AF2
 for <ltp@lists.linux.it>; Wed, 26 Oct 2022 16:34:42 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 91E6921FEC;
 Wed, 26 Oct 2022 14:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1666794882; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YrVALiDraGBseRIadwXtjqLjBeGT22GqQ1Ei1cARL7U=;
 b=X42hxT9h1F0KxztDxubtQtGY1+aGXkbuv7rQbKt5FXydfWU/c0ASCe7xPoW1Hcp44ETxIu
 0FYGcrrt6O3WVBfUE4PCGdmmtVdWUDn+yj+KW7ls7asVlai9Ae7gIkPKzf/u9kZGlcpip+
 1KkwYcrm766tG/8TCtq8N9DCDIHmXZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1666794882;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YrVALiDraGBseRIadwXtjqLjBeGT22GqQ1Ei1cARL7U=;
 b=2WOuSVeukswFEVd9TiSm/rtgnMwI4MWv539Ol01oJnm5flhWw3OfOrvfOGYx1OuC6qauaK
 lOQLOnFKiyvAlPCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 7421313A77;
 Wed, 26 Oct 2022 14:34:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id STB3G4JFWWOyBgAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Wed, 26 Oct 2022 14:34:42 +0000
Message-ID: <7d316fe8-96ac-86db-485c-dd4d5957085c@suse.cz>
Date: Wed, 26 Oct 2022 16:34:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Amir Goldstein <amir73il@gmail.com>
References: <CAOQ4uxi=3aS+ROZ_kcQbVK9C4qiW76M1junEz2J+fdai5xjnAQ@mail.gmail.com>
 <b3443f46-37fc-3c15-76d6-0985e6da0535@suse.cz>
 <CAOQ4uxianp4e7gykk_N-yPKPPsK4xYu2HnH5d=N93+gAM60c=Q@mail.gmail.com>
 <9b1164dd-68fa-0335-0b38-f820e3d303be@suse.cz>
 <CAOQ4uxizXrthqR7G8Tx7kq+bz6kPTUxTSYs1BfireEXRpiNw4w@mail.gmail.com>
 <ea4fd7d6-0985-2983-d0ce-489a32a2f6dc@suse.cz>
 <CAOQ4uxib_vxncQa3RiObKYwQg0CQvPXLH+nyRckO9FVg=ihERQ@mail.gmail.com>
 <d80e2e12-899d-f0d2-27c2-f4a92f1b2be4@suse.cz>
 <CAOQ4uxgUXZS4D1VDToGLqXV2nDuPFqUHWqwoY8V=u=iUcQFruw@mail.gmail.com>
 <ab0f73ef-9e6d-5e7e-4ee1-8aa31ef2802e@suse.cz>
 <20221025094810.pakqhh6yoxfy3h7x@quack3>
 <ac20968f-ce12-27fb-8451-7e01d7cde229@suse.cz>
 <CAOQ4uxjiduWkp9bhV4Svs5GzoA6ac4TKmeDm8rUOsNOo5b1NYQ@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAOQ4uxjiduWkp9bhV4Svs5GzoA6ac4TKmeDm8rUOsNOo5b1NYQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
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

On 25. 10. 22 18:53, Amir Goldstein wrote:
> All right.
> 
> Let's see which flag combinations we have in the relevant tests in fanotify14:
> 
> FAN_REPORT_DFID_FID,
> FAN_REPORT_DFID_NAME,
> FAN_REPORT_DFID_NAME_TARGET,
> 
> That's all.
> 
> Support for FAN_REPORT_FID is a requirement for the entire test.
> 
> FAN_REPORT_TARGET_FID depends on all the rest of the flags
> and support for it is already checked explicitly to skip test cases.
> 
> FAN_REPORT_NAME depends on FAN_REPORT_DIR_FID.
> 
> So effectively fanotify_get_supported_init_flags() only checks
> FAN_REPORT_DIR_FID separately from the combination
> FAN_REPORT_DFID_FID.
> 
> fanotify16, which tests *legal* combinations of these flags
> already checks the separate flag FAN_REPORT_DIR_FID
> so fanotify test cases with FAN_REPORT_DFID_FID would
> fail if a kernel that supports FAN_REPORT_DIR_FID does not
> support the combination FAN_REPORT_DFID_FID.
> 
> Bottom line:
> fanotify_get_supported_init_flags() did not add any test coverage.
> 
> This is why it is a slippery slope to suggest fixes without
> proving that there is a bug.

If this is a slippery slope, then we're already sliding down since 
commit fe31bfca which broke test case #8 because it's painfully hard to 
maintain multiple separate feature checks in setup() as you insist. I 
want to fix this mess with one simple helper function that will be 
reusable in all fanotify tests. The helper function is an up-to-date 
replacement for the old deprecated FAN_ALL_INIT_FLAGS macro. Nothing 
more, nothing less.

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
