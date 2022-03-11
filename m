Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94716C433EF
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 09:57:01 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 73AC53C8C98
	for <ltp@archiver.kernel.org>; Fri, 11 Mar 2022 10:56:59 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8292B3C61C8
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 10:56:49 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id B700A1001180
 for <ltp@lists.linux.it>; Fri, 11 Mar 2022 10:56:48 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E2B9B218FB;
 Fri, 11 Mar 2022 09:56:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1646992607; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWCB21CyM5fT1Bt+Z8Hf9gWAyuHxD//5RDFbmxfzoNI=;
 b=XQOCjr2KDoZF6XKfrBoRNMF0DZhvqNaPg+RgeE+QfOwTsQmM8MB4kSMj1/xVM3rlXGqlYI
 nde2vCNf3Fi95Gu26XwefG/dHiFcITAmsqvewSd1wiuj5qL87H/ZEFwAFEyNbf0bECIY+d
 kgXsQDfGYdmMkLmoHQUd8XWtdzuCCG4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1646992607;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FWCB21CyM5fT1Bt+Z8Hf9gWAyuHxD//5RDFbmxfzoNI=;
 b=6m21p1QrhJPsg0eQY7HMVYJJL3rPDTV6WI2ldigrDgdizg61jk0jYR+TAKwRAn9oBfG/t4
 y81PVirDlLd3UmBQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CAF1213A89;
 Fri, 11 Mar 2022 09:56:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id H+hRMN8cK2JVZAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 11 Mar 2022 09:56:47 +0000
Message-ID: <8378e9dd-31a5-b39e-36cc-f3d3a1d41345@suse.cz>
Date: Fri, 11 Mar 2022 10:56:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: Cyril Hrubis <chrubis@suse.cz>, ltp@lists.linux.it
References: <20220311095101.10112-1-chrubis@suse.cz>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220311095101.10112-1-chrubis@suse.cz>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] pty/pty07: Restore active console after the
 testrun
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

On 11. 03. 22 10:51, Cyril Hrubis wrote:
> The test, as a side effect, switches to a different console during the
> run, which may confuse both users and automated test systems.
> 
> Fix that by saving the console active at the start of the test and
> restore it in the test cleanup.
> 
> Signed-off-by: Cyril Hrubis <chrubis@suse.cz>
> ---
>  testcases/kernel/pty/pty07.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/testcases/kernel/pty/pty07.c b/testcases/kernel/pty/pty07.c
> index 462569c4a..af2dccb32 100644
> --- a/testcases/kernel/pty/pty07.c
> +++ b/testcases/kernel/pty/pty07.c
> @@ -40,6 +40,8 @@ static int test_tty_port = 8;
>  static int fd = -1;
>  static struct tst_fzsync_pair fzp;
>  
> +static unsigned short vt_active;
> +
>  static void *open_close(void *unused)
>  {
>  	int i;
> @@ -76,16 +78,27 @@ static void do_test(void)
>  
>  static void setup(void)
>  {
> +	struct vt_stat stat;
> +
>  	sprintf(tty_path, "/dev/tty%d", test_tty_port);
>  	fd = SAFE_OPEN(tty_path, O_RDWR);
> +	SAFE_IOCTL(fd, VT_GETSTATE, &stat);
> +	vt_active = stat.v_active;
> +
> +	tst_res(TINFO, "Saving active console %i", vt_active);
> +
>  	tst_fzsync_pair_init(&fzp);
>  }
>  
>  static void cleanup(void)
>  {
> -	tst_fzsync_pair_cleanup(&fzp);
> -	if (fd >= 0)
> +	if (fd >= 0) {
> +		tst_res(TINFO, "Restoring active console");
> +		SAFE_IOCTL(fd, VT_ACTIVATE, vt_active);
>  		SAFE_CLOSE(fd);
> +	}
> +
> +	tst_fzsync_pair_cleanup(&fzp);

If you move the fzsync cleanup to the end of cleanup(), you can end up
with the open_close() thread racing against fd cleanup.

>  }
>  
>  static struct tst_test test = {


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
