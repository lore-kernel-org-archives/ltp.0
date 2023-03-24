Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFBF0C6FD1C
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 11:51:41 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 101683CD1E3
	for <ltp@archiver.kernel.org>; Fri, 24 Mar 2023 12:51:40 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E76E63C0204
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 12:51:29 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 3DB611000D52
 for <ltp@lists.linux.it>; Fri, 24 Mar 2023 12:51:28 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 6E83E1F898;
 Fri, 24 Mar 2023 11:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1679658688; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HM6IJ3Ll+YR5RnoJ1IHGqqowqq2TyuOO5Gi4JtaoXXA=;
 b=NxII+gGEsu9MAV1/4Jt/QDQ3Bfy69BseWIRIDeBy51AVhJaGnMv5PV8CSOX7z4gx0/au2J
 7xLMQuu27TJxuI6GFP5YJkpQScE6l5hng74S8sRq1VlVgiJsebj7FlgHvQCrYyVfey4omx
 kcKgGNiVpXe7gOKJyq8aLZWLL5YMCSU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1679658688;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HM6IJ3Ll+YR5RnoJ1IHGqqowqq2TyuOO5Gi4JtaoXXA=;
 b=6pQa/bJalJXTrgZ4PmN2mEJ1JdNrfu6WNkOrxUXTUwo89e1QlAm3VAk7KAxZiUX2ocrxLH
 P99ZLAOBVozPq+AQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5332D133E5;
 Fri, 24 Mar 2023 11:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id y6iRE8COHWSgcQAAMHmgww
 (envelope-from <chrubis@suse.cz>); Fri, 24 Mar 2023 11:51:28 +0000
Date: Fri, 24 Mar 2023 12:52:39 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Teo Couprie Diaz <teo.coupriediaz@arm.com>
Message-ID: <ZB2PB6adFr+3sYI8@yuki>
References: <20230323160508.672397-2-teo.coupriediaz@arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230323160508.672397-2-teo.coupriediaz@arm.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/sockioctl: Align buffer to struct ifreq
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
> In setup3, the following line can lead to an undefined behavior:
>   ifr = *(struct ifreq *)ifc.ifc_buf;
> 
> Indeed, at this point it can be assumed that ifc.ifc_buf is suitably
> aligned for struct ifreq.
> However, ifc.ifc_buf is assigned to buf which has no alignment
> constraints. This means there exists cases where buf is not suitably
> aligned to load a struct ifreq, which can generate a SIGBUS.
> 
> Force the alignment of buf to that of struct ifreq.
> 
> Signed-off-by: Teo Couprie Diaz <teo.coupriediaz@arm.com>
> ---
> CI Build: https://github.com/Teo-CD/ltp/actions/runs/4502204132
> 
>  testcases/kernel/syscalls/sockioctl/sockioctl01.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
> index 486236af9d6b..e63aa1921877 100644
> --- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
> +++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
> @@ -52,7 +52,13 @@ static struct ifreq ifr;
>  static int sinlen;
>  static int optval;
>  
> -static char buf[8192];
> +/*
> + * buf has no alignment constraints by default. However, it is used to load
> + * a struct ifreq in setup3, which requires it to have an appropriate alignment
> + * to prevent a possible undefined behavior.
> + */
> +static char buf[8192]
> +	__attribute__((aligned(__alignof__(struct ifreq))));
>  
>  static void setup(void);
>  static void setup0(void);

Looking at the code, shouldn't we rather than that declare the buffer as
an struct ifreq array, that would naturally align the buffer without any
need for tricky __attribute__.

diff --git a/testcases/kernel/syscalls/sockioctl/sockioctl01.c b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
index 51dac9c16..206a4999e 100644
--- a/testcases/kernel/syscalls/sockioctl/sockioctl01.c
+++ b/testcases/kernel/syscalls/sockioctl/sockioctl01.c
@@ -52,7 +52,7 @@ static struct ifreq ifr;
 static int sinlen;
 static int optval;

-static char buf[8192];
+static struct ifreq buf[200];

 static void setup(void);
 static void setup0(void);
@@ -218,7 +218,7 @@ static void setup2(void)
        s = SAFE_SOCKET(cleanup, tdat[testno].domain, tdat[testno].type,
                        tdat[testno].proto);
        ifc.ifc_len = sizeof(buf);
-       ifc.ifc_buf = buf;
+       ifc.ifc_buf = (void*)buf;
 }


-- 
Cyril Hrubis
chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
