Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E1F7C433F5
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 15:05:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 188623CAA13
	for <ltp@archiver.kernel.org>; Fri, 13 May 2022 17:05:09 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9204F3CA48F
 for <ltp@lists.linux.it>; Fri, 13 May 2022 17:04:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id A56821A011FF
 for <ltp@lists.linux.it>; Fri, 13 May 2022 17:04:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CF70721AA7;
 Fri, 13 May 2022 15:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1652454296; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F62yM62Vou/ZUEP+3jJ3zWVCAtQ4raDfpXeS5nwamtI=;
 b=EV+vrT6uWsKd0Guoo3WRvIQuqPzrxohcuSb4ZwKoes1aXEUnoff5yn5WigrKtF9YEewTGT
 xRd8uFlbOssKFWgRT0TLNEKRJn+sII8wqxKEJmzUi0WsJelywmecGnkIr4HHJdwafHgJc+
 IS95Qn2SJ2tgcWhS3O2sGHkGrHjmzkM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1652454296;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=F62yM62Vou/ZUEP+3jJ3zWVCAtQ4raDfpXeS5nwamtI=;
 b=lXMlhHdEuikLCZCGqEUSoIl3PfXakKe9DZ4VtUEyoVfPeH0WmHMxLmxLfIwUh2YgkMgg4H
 vo0db/JfxhJveGBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B67C013446;
 Fri, 13 May 2022 15:04:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id ZIxEK5hzfmLDGwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 13 May 2022 15:04:56 +0000
Date: Fri, 13 May 2022 17:07:11 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <Yn50Hx2IqdXU1nzC@yuki>
References: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f38ee2905aa8b765c243896fa326b5507919a446.1651061197.git.jstancek@redhat.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_find_backing_dev: match mount point if
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
Cc: liwan@redhat.com, xuyang2018.jy@cn.fujitsu.com, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!
> Signed-off-by: Jan Stancek <jstancek@redhat.com>
> ---
>  lib/tst_device.c | 31 +++++++++++++++++++++----------
>  1 file changed, 21 insertions(+), 10 deletions(-)
> 
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index d296f9118cde..e560ec97460b 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -506,14 +506,22 @@ unsigned long tst_dev_bytes_written(const char *dev)
>  	return dev_bytes_written;
>  }
>  
> +static int count_match_len(const char *first, const char *second)
> +{
> +	int len = 0;
> +
> +	while (*first && *first++ == *second++)
> +		len++;
> +
> +	return len;
> +}
> +
>  void tst_find_backing_dev(const char *path, char *dev)
>  {
>  	struct stat buf;
>  	FILE *file;
> -	char line[PATH_MAX];
> -	char *pre = NULL;
> -	char *next = NULL;
> -	unsigned int dev_major, dev_minor, line_mjr, line_mnr;
> +	char line[PATH_MAX], mnt_point[PATH_MAX], mnt_source[PATH_MAX];
> +	unsigned int dev_major, dev_minor, line_mjr, line_mnr, best_match_len = 0;
>  
>  	if (stat(path, &buf) < 0)
>  		tst_brkm(TWARN | TERRNO, NULL, "stat() failed");
> @@ -524,17 +532,20 @@ void tst_find_backing_dev(const char *path, char *dev)
>  	*dev = '\0';
>  
>  	while (fgets(line, sizeof(line), file)) {
> -		if (sscanf(line, "%*d %*d %d:%d", &line_mjr, &line_mnr) != 2)
> +		if (sscanf(line, "%*d %*d %d:%d %*s %s %*s %*s %*s %*s %s",
> +			&line_mjr, &line_mnr, mnt_point, mnt_source) != 4)
>  			continue;

We did this before and it didn't work see: 5dfd9c29f094e3024ceab760715456436188ecab

We really have to parse the string based on the dash (" - ") to make it
work reliably.

Other than that the rest of the patch looks reasonable.

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
