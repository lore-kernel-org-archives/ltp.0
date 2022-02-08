Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F076C433F5
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 10:40:40 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 254AA3C9B69
	for <ltp@archiver.kernel.org>; Tue,  8 Feb 2022 11:40:38 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id EBB723C5795
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:40:28 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 4C53F600736
 for <ltp@lists.linux.it>; Tue,  8 Feb 2022 11:40:27 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 623DF210FB;
 Tue,  8 Feb 2022 10:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1644316827; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eHoHmRbtotvmkdwCWe8N6GDMgG94ZTOVL+nvKtzn5bk=;
 b=q4iTUqrO+ww+P/kZ0+zGA8VEGY5qCCFNnG62qQBH0NWCox3qBi7ZnoSON1tQWI5bKiF6ic
 a20pWohduxOp/H3KtJv+Xe+NBqaNKikLdWT3bByiQ9vPJvyYBiIRBqeygl+4VcTq1lHGAw
 c8dcSoFHycZNDeJW6AdvdTnQU0cD3V4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1644316827;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=eHoHmRbtotvmkdwCWe8N6GDMgG94ZTOVL+nvKtzn5bk=;
 b=qHS7qP2hD8epFW/l5i68Gy+L3PdCOsTOYQhkxNAj7YeCZSCcnrqXR3EduTVNY1bQ6SWRi8
 e6EKvWmyvONIeNCg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4621D13C08;
 Tue,  8 Feb 2022 10:40:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id 5vDpD5tIAmJxAgAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 08 Feb 2022 10:40:27 +0000
Date: Tue, 8 Feb 2022 11:42:31 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Kushal Chand <kushalkataria5@gmail.com>
Message-ID: <YgJJF5dtbW48JKMv@yuki>
References: <20220208100302.44347-1-kushalkataria5@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220208100302.44347-1-kushalkataria5@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1] fstat_02: Increase test coverage by creating
 hard links to file and validate using fstat
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
>  #define TESTFILE        "test_file"
> +#define LINK_TESTFILE   "link_test_file"
>  #define FILE_SIZE       1024
>  #define FILE_MODE	0644
> +#define NLINK	        2
>  
>  static struct stat stat_buf;
>  static uid_t user_id;
> @@ -61,6 +63,12 @@ static void run(void)
>  		fail++;
>  	}
>  
> +	if (stat_buf.st_nlink != NLINK) {
> +		tst_res(TFAIL, "stat_buf.st_nlink = %lu expected %o",
                                                                  ^
								  Why %o?
> +			(stat_buf.st_nlink), NLINK);
                      ^
		      this should be casted properly
> +		fail++;
> +	}
> +
>  	if (fail)
>  		return;
>  
> @@ -78,6 +86,8 @@ static void setup(void)
>  
>  	if (tst_fill_file(TESTFILE, 'a', FILE_SIZE, 1))
>  		tst_brk(TBROK, "Could not fill Testfile!");
> +
> +	SAFE_LINK(TESTFILE, LINK_TESTFILE);
>  }
>  
>  static void cleanup(void)
> -- 
> 2.25.1
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
