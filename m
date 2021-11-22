Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B5CC433EF
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 09:09:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 42E3C3C8C74
	for <ltp@archiver.kernel.org>; Mon, 22 Nov 2021 10:09:08 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D92603C8C44
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:08:58 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3D34B600BAD
 for <ltp@lists.linux.it>; Mon, 22 Nov 2021 10:08:57 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3BBAE218CE;
 Mon, 22 Nov 2021 09:08:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1637572137; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3r7x83ZwM3IDUa2GCSB68lFC2eU9ja6rOB/KaY7oQeE=;
 b=DKCTYIK+JRY94XEsDgqACVoJ7F+oJjc7wdoHLsD5IhJVyv6BhGrfq+t46mjOu+wDRJeXAr
 sgPSC+6dfmmho7c+Po6KU0hb3g9IDt2uF9VVNp8yhNMmcnO288qcT0oT3uDrpOZXmwj9FC
 PauSkwi2cP7aQDwXXOX8qD4V+EyoADM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1637572137;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3r7x83ZwM3IDUa2GCSB68lFC2eU9ja6rOB/KaY7oQeE=;
 b=+ZhZceRxHJqCGkdQ268FnHPoXy8jeysVszsUPnyV8Ve5njTRyNJftIOmDFKuLxNns23d12
 LsDYUrM1nqeAw/Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id F29D513B9E;
 Mon, 22 Nov 2021 09:08:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id XFgAOihem2G3SgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 22 Nov 2021 09:08:56 +0000
Date: Mon, 22 Nov 2021 10:10:01 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Joerg Vehlow <lkml@jv-coder.de>
Message-ID: <YZteadR+AC5QBqRe@yuki>
References: <20211119074602.857595-1-lkml@jv-coder.de>
 <20211119074602.857595-3-lkml@jv-coder.de> <YZe4V8mbn7Dk8x3U@yuki>
 <091b9181-2f6c-8b84-4d1c-5398ea34fe99@jv-coder.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <091b9181-2f6c-8b84-4d1c-5398ea34fe99@jv-coder.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 02/12] posix/mq_(timed)send/5-1: Fix error
 reporting
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
Cc: Joerg Vehlow <joerg.vehlow@aox-tech.de>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> You are right, but I wanted to keep changes minimal. I think there are 
> lots of small bug in the posix tests,
> but fixing all of them while trying to just get rid of warnings, would 
> have made this patchset even bigger and
> I would have never finished. So I had to stop somewhere.

Understood, looking forward to a next patchset then :-).

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
