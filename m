Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 946DAC433F5
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 15:56:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6C5343C91B4
	for <ltp@archiver.kernel.org>; Fri, 25 Mar 2022 16:56:46 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 38DDD3C189A
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 16:56:34 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id A79E01400063
 for <ltp@lists.linux.it>; Fri, 25 Mar 2022 16:56:33 +0100 (CET)
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE437210EF;
 Fri, 25 Mar 2022 15:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1648223792; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKmOpAOLMrcSTnJttF6Z2BaNFXrZ4aCMPZZ542SJ+Zk=;
 b=F+S1a45f61uuX0uuSLhutBypDExC+EwND16C3phJ36ZdZvLVvPjKjqPV4rqi6aXRfSoyOZ
 FmaazoD/JT4/wGJz7xF8lTBAz2OzWWX2c60DxRa+CMez7cIcI/yWulB/pHn23NDPKirunI
 wsrVuWXmq3bkpZPwZgdSIqdIbM5LAZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1648223792;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sKmOpAOLMrcSTnJttF6Z2BaNFXrZ4aCMPZZ542SJ+Zk=;
 b=QKaFyELg5WHbKQxM7fFMBUMhZUN8sQy2HXL3pbaU8g4RyCUbVajcBh3/SU3dd40YxbivvZ
 /PJjd1tbeOD80pDw==
Received: from imap1.suse-dmz.suse.de (imap1.suse-dmz.suse.de [192.168.254.73])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap1.suse-dmz.suse.de (Postfix) with ESMTPS id BAB741339C;
 Fri, 25 Mar 2022 15:56:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap1.suse-dmz.suse.de with ESMTPSA id mQVSLDDmPWK9KgAAGKfGzw
 (envelope-from <chrubis@suse.cz>); Fri, 25 Mar 2022 15:56:32 +0000
Date: Fri, 25 Mar 2022 16:58:52 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.de>
Message-ID: <Yj3mvHaApe9vdQdg@yuki>
References: <20220325093626.11114-1-andrea.cervesato@suse.de>
 <20220325093626.11114-3-andrea.cervesato@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220325093626.11114-3-andrea.cervesato@suse.de>
X-Virus-Scanned: clamav-milter 0.102.4 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 2/9] Rewrite userns02.c using new LTP API
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
> +	parentuid = geteuid();
> +	parentgid = getegid();
> +
> +	sprintf(path, "/proc/%d/uid_map", childpid);
> +	sprintf(content, "100 %d 1", parentuid);
> +
> +	fd = SAFE_OPEN(path, O_WRONLY, 0644);
> +	SAFE_WRITE(1, fd, content, strlen(content));
> +	SAFE_CLOSE(fd);
> +
> +	if (access("/proc/self/setgroups", F_OK) == 0) {
> +		sprintf(path, "/proc/%d/setgroups", childpid);
> +
> +		fd = SAFE_OPEN(path, O_WRONLY, 0644);
> +		SAFE_WRITE(1, fd, "deny", 4);
> +		SAFE_CLOSE(fd);
>  	}
> -	cleanup();
> -	tst_exit();
> +
> +	sprintf(path, "/proc/%d/gid_map", childpid);
> +	sprintf(content, "100 %d 1", parentgid);
> +
> +	fd = SAFE_OPEN(path, O_WRONLY, 0644);
> +	SAFE_WRITE(1, fd, content, strlen(content));
> +	SAFE_CLOSE(fd);

I've shortened this part significantly with SAFE_FILE_PRINTF() and
pushed, thanks.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
