Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 069C2C433EF
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 15:12:49 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A914A3CA6A8
	for <ltp@archiver.kernel.org>; Wed, 27 Apr 2022 17:12:47 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 46E3E3CA478
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 17:12:35 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0BE43600053
 for <ltp@lists.linux.it>; Wed, 27 Apr 2022 17:12:34 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9323F1F74F;
 Wed, 27 Apr 2022 15:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1651072353; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QtZmV/0/8D5CSTRCbYO9DtofHuvqyIdL3mzVp3s7s+k=;
 b=biPbw9Hbdjr6Oj6HKQVxt40SvV6VLzYYw7sJSX+aPlOIlGyok/Q4rJ735+Ul82o1KQeMk6
 7sKNQ4Y+0JdDuVs+x7OIhpukJChHm0LFjyBPEyuTK8gUvhibKP7LabuFbHWP+Lm+LEUcT/
 GKHz4BE3KJOcZAWTgJwAohoy8F3Oyq8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1651072353;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QtZmV/0/8D5CSTRCbYO9DtofHuvqyIdL3mzVp3s7s+k=;
 b=Crn4y7vqAff+0knxTmHOnXRDFG+pnwr5WY0D8wfFORYjntvi/FQo9oe+vIopnhxVvIiy1l
 MBjd4jqX2zLy6iDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 69A561323E;
 Wed, 27 Apr 2022 15:12:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id r8YgGGFdaWJjDQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Wed, 27 Apr 2022 15:12:33 +0000
Date: Wed, 27 Apr 2022 17:14:49 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <Ymld6Z6zaWVoz0T5@yuki>
References: <1651034362-18672-1-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1651034362-18672-1-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] syscalls/shmdt01: Convert into new api
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
> +static int shm_id = -1, shm_key, pass;
> +static int *shared;
>  sigjmp_buf env;

^ static sigjmp_buf

> +static void check_functionality(void)
>  {
> -	/* stat the shared memory segment */
> -	if (shmctl(shm_id_1, IPC_STAT, &buf) == -1)
> -		tst_brkm(TBROK | TERRNO, cleanup,
> -			 "could not stat in signal handler");
> +	struct shmid_ds buf;
>  
> +	SAFE_SHMCTL(shm_id, IPC_STAT, &buf);
>  	if (buf.shm_nattch != 0) {
> -		tst_resm(TFAIL, "# of attaches is incorrect");
> +		tst_res(TFAIL, "Number of attaches(%ld) is non-zero", buf.shm_nattch);
>  		return;
>  	}

Maybe just:

	TST_EXP_EQ_LI(buf.shm_nattch, 0);

	if (buf.shm_nattach)
		return;



Other than these two:

Reviewed-by: Cyril Hrubis <chrubis@suse.cz>


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
