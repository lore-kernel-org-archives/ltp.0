Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F177EC433F5
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 13:49:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id BE7523C9439
	for <ltp@archiver.kernel.org>; Thu, 17 Mar 2022 14:49:48 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id ED0193C6D9E
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 14:49:38 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3108A1000F69
 for <ltp@lists.linux.it>; Thu, 17 Mar 2022 14:49:37 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4C7F71F38D;
 Thu, 17 Mar 2022 13:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1647524977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cR3Bid3osRk9Q86TYqFSOjzLE/suYtQl+k62RIA8fk=;
 b=EjqdTyZKPA8CrXRp5sHoznqY5pExXVkePwns99PWELIZgIrNQPwwFAGWNlyu4XsaxKONW3
 Pj3F0rvhTHUbDJChCPtVTlFZJhLVfAGqqo4xU6k6/GcvlldQUuxp5tiRG4zF3Tt0Lb+oK0
 EWHrJVqNhhhskRy7etTfxL+Bb6hDI04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1647524977;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2cR3Bid3osRk9Q86TYqFSOjzLE/suYtQl+k62RIA8fk=;
 b=0OtU6P39CqfZ5D1VCNGNRmcJpjzloj2A0UQaScqz2oQgUAyw3sKuyTCIvQLY7eITj10AA7
 tV4bojzin6/NtFDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 11D8F13BAC;
 Thu, 17 Mar 2022 13:49:37 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BUy3AnE8M2JWHAAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 17 Mar 2022 13:49:37 +0000
Date: Thu, 17 Mar 2022 14:49:35 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Martin Doucha <mdoucha@suse.cz>
Message-ID: <YjM8b0hcQBrxRzjw@pevik>
References: <1647401546-2898-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <cd942f2c-27db-c174-570a-cd2fd836bfe4@suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <cd942f2c-27db-c174-570a-cd2fd836bfe4@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/quotactl04: Use correct min_kver
 version check
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> Hi,
> this should have been sent as two separate patches but otherwise:
Well, these are 2 actions, but I treated it as somehow atomic (the check is
needed only after fixing .min_kver). I don't have strong opinion whether merged
separated or as single commit.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
