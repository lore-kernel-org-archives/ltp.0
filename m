Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6DAFEE7FF4
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 09:51:54 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1D6293CB489
	for <ltp@archiver.kernel.org>; Mon, 11 Sep 2023 11:51:53 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id F01333CB3C6
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 11:51:41 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id E55201400F8D
 for <ltp@lists.linux.it>; Mon, 11 Sep 2023 11:51:40 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id E906C1F38D;
 Mon, 11 Sep 2023 09:51:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1694425899; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10XlzO66ijHSEf47WTuqHHuBXUYBa4gRIojd6Ec64e8=;
 b=m/qKakcDv7JxPxnjbbSixiiU0rL1fHA9WVo2zKyTX2nzZDB7kYGeWeuRNIWOCWg+AGjj1M
 aPp9s3hFmmIN7R/oFkKeYvLFOGHWQ6KdHsLOFRtmcj5Twttj3dZOSpyktVclw2W4Yg0Ycn
 VcazADDX8eOf/MZ29WZh0oevaC0I4aU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1694425899;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=10XlzO66ijHSEf47WTuqHHuBXUYBa4gRIojd6Ec64e8=;
 b=REneJswzzhjdw453Ty6LGvWvXaNYgVAz+ZaGy/dPb5yEIrlungiAED64Gu2FRIbGOlETE5
 V9QEOjLKjrN3NmAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D8DC9139CC;
 Mon, 11 Sep 2023 09:51:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id xh2yMyvj/mTaNAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 11 Sep 2023 09:51:39 +0000
Date: Mon, 11 Sep 2023 11:52:24 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Avinesh Kumar <akumar@suse.de>
Message-ID: <ZP7jWJNOiL-1HA22@yuki>
References: <20230901124816.30437-1-akumar@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230901124816.30437-1-akumar@suse.de>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] syscalls/mmap01: Rewrite the test using
 new LTP API
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
> +static void run(void)
> +{
> +	char buf[20];
>  
> -	/* Get the path of temporary file to be created */
> -	if (getcwd(Path_name, sizeof(Path_name)) == NULL) {
> -		tst_brkm(TFAIL | TERRNO, cleanup,
> -			 "getcwd failed to get current working directory");
> -	}
> +	addr = SAFE_MMAP(NULL, page_sz, PROT_READ | PROT_WRITE, MAP_FILE | MAP_SHARED, fd, 0);
>  
> -	/* Creat a temporary file used for mapping */
> -	if ((fildes = open(TEMPFILE, O_RDWR | O_CREAT, 0666)) < 0) {
> -		tst_brkm(TFAIL, cleanup, "opening %s failed", TEMPFILE);
> -	}
> +	if (memcmp(&addr[file_sz], dummy, page_sz - file_sz) != 0)
> +		tst_brk(TFAIL, "mapped memory area contains invalid data");

The tst_brk() does not work correctly with TFAIL, I suppose that the
best we can do here is to tst_res(TFAIL, ...) and goto SAFE_UNMAP().

> -	/* Write some data into temporary file */
> -	if (write(fildes, write_buf, strlen(write_buf)) != (long)strlen(write_buf)) {
> -		tst_brkm(TFAIL, cleanup, "writing to %s", TEMPFILE);
> -	}
> +	addr[file_sz] = 'X';
> +	addr[file_sz + 1] = 'Y';
> +	addr[file_sz + 2] = 'Z';
>  
> -	/* Get the size of temporary file */
> -	if (stat(TEMPFILE, &stat_buf) < 0) {
> -		tst_brkm(TFAIL | TERRNO, cleanup, "stat of %s failed",
> -			 TEMPFILE);
> -	}
> -	file_sz = stat_buf.st_size;
> +	if (msync(addr, page_sz, MS_SYNC) != 0)
> +		tst_brk(TFAIL | TERRNO, "failed to sync mapped file");

Here as well. Or alternatively we can add SAFE_MSYNC() to the test
library and use that.

> -	page_sz = getpagesize();
> +	SAFE_READ(0, fd, buf, sizeof(buf));
> +	SAFE_LSEEK(fd, 0, SEEK_SET);
>  
> -	/* Allocate and initialize dummy string of system page size bytes */
> -	if ((dummy = calloc(page_sz, sizeof(char))) == NULL) {
> -		tst_brkm(TFAIL, cleanup, "calloc failed (dummy)");
> -	}
> +	if (strstr(buf, "XYZ") == NULL)
> +		tst_res(TPASS, "mmap() functionality successful");
> +	else
> +		tst_res(TFAIL, "mmap() functionality failed");

This can possibly crash, there is no guarantee that the buf is zero
terminated to be suitable for str*() functions.

I guess that the easiest solution would be memchr() for each of the
letters. However the first thing that we should check is actually the
return value from the read(), if that matches the number of bytes we
wrote to the buffer we can actually be sure that we haven't written
anything past the data that did exist in the file.

> -	/* Create the command which will be executed in the test */
> -	sprintf(cmd_buffer, "grep XYZ %s/%s > /dev/null", Path_name, TEMPFILE);
> +	memset(&addr[file_sz], 0, 3);
> +	SAFE_MUNMAP(addr, page_sz);
>  }
>  
>  static void cleanup(void)
>  {
> -	close(fildes);
> -	free(dummy);
> -	tst_rmdir();
> +	if (fd > 0)
> +		SAFE_CLOSE(fd);
> +	if (dummy)
> +		free(dummy);

Again, free(NULL) is no-op, no need for the if here.

>  }
> +
> +static struct tst_test test = {
> +	.setup = setup,
> +	.cleanup = cleanup,
> +	.test_all = run,
> +	.needs_tmpdir = 1
> +};
> -- 
> 2.41.0
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
