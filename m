Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9C6C433F5
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 09:52:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 975163CA0CF
	for <ltp@archiver.kernel.org>; Fri, 18 Feb 2022 10:52:39 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7EDE53C9ABC
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:52:26 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 573011001599
 for <ltp@lists.linux.it>; Fri, 18 Feb 2022 10:52:25 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 54C04219A0;
 Fri, 18 Feb 2022 09:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1645177945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pccB/1ZHJa5epEtiuuYNzdynF+TZN00liXgEPiWCh0=;
 b=vN+35+YLesNptGWXnH46/6nrFwrWsOMYEFuwcEUT/UowxVHRhB3J8a9u3muYbd+R6P3Aro
 khUuG8hyjSBQ+wr+smKCyv4UpwGKBqWDTPKLtLKTibUsZKdjAMJMOqHoEEZvz3T0sacu68
 jF0/+q4pd9HbJGWMgcwe50RO58PJLQk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1645177945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+pccB/1ZHJa5epEtiuuYNzdynF+TZN00liXgEPiWCh0=;
 b=c0ZaYYt2fLiY53IGcjIUbBMWgFcZK9W60uBUrCP7zSfaHV1zk2Lk/vKV7/t26AqYilfo4H
 w0gxrmz5Iu1tH3Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3E99913C53;
 Fri, 18 Feb 2022 09:52:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id Lt7mDVlsD2JIdgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 18 Feb 2022 09:52:25 +0000
Date: Fri, 18 Feb 2022 10:54:34 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <Yg9s2lzZmavrQCuf@yuki>
References: <20220217142730.19726-1-chrubis@suse.cz> <Yg56J2hVIMMO3cvX@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Yg56J2hVIMMO3cvX@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] test_macros: TST_EXP_EXPR() add auto
 stringification
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
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> Good idea.

It occured to me that this is probably not the best result though, since
in the case of the failure it does not print the expected and actual
value. So maybe it would be better to add TST_EXP_EQ() macro instead. I
will send a patch later on.

> BTW I'm thinking to add some comments to "top level" macros.
> because it's getting hard to read these macros.

Well yes, it's getting a bit hard to read indeed.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
