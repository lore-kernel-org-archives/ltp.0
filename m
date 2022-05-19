Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BB5C433F5
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 09:59:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CC213CAAF8
	for <ltp@archiver.kernel.org>; Thu, 19 May 2022 11:59:47 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D38EB3CA9B6
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:59:36 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 56463200BA9
 for <ltp@lists.linux.it>; Thu, 19 May 2022 11:59:35 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4D4221F7AB;
 Thu, 19 May 2022 09:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652954375; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rd/2xR+B/or83oZkaR05hR16wa8wiSppdYtxCxJf9NU=;
 b=jcc21AIbOjsvI4I4LEzMFitOHYcZ24A/sb13ubgwVYIYUR9PqaKbyYMqKndrGorP4b3ua2
 WHa35VHBtB6KQUGZj/gxJWQShfhvcMKRXHT1YjQAJhh9/Clfz6ZP2pbhR9bDZ6UCJs6Msf
 8Pk3vVCfS6gpkaZu0SxTZZiIWHKe/nE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652954375;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rd/2xR+B/or83oZkaR05hR16wa8wiSppdYtxCxJf9NU=;
 b=Vmt4Ef3cLzXQYJhNzHEuq55CMjCz0D+NGs4PqehkuyNpCwvUCZOYElSD9V7TT6Ms1jygLs
 VoF4iLpqAuJxzVDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 38F5113456;
 Thu, 19 May 2022 09:59:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id myyRDAcVhmLmPAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Thu, 19 May 2022 09:59:35 +0000
Date: Thu, 19 May 2022 12:01:46 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <YoYVimPcOcphuVIF@yuki>
References: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
 <65a82dbc6ea54c5d02a1238f5fa26d19388c5d2a.1652789936.git.jstancek@redhat.com>
 <YoPAMBxU5zuQ5xDk@yuki>
 <CAASaF6xNHMV+xgf7M=-iY-i+Hjgqu3jA1zVHu_XfgrgErCB6oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6xNHMV+xgf7M=-iY-i+Hjgqu3jA1zVHu_XfgrgErCB6oQ@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] tst_find_backing_dev: match mount point if
 major/minor can't be found
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
Cc: LTP List <ltp@lists.linux.it>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Sure, we can do that. Would you ack this for release as well?
> This has been failing for quite a while on fedora (which uses btrfs).

Sure, either way this version looks good.

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
