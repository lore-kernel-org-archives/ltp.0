Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CFD8CA0EEB
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 07:46:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755848778; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=H8agHTdSxep+6jrSYbT12LGhJMSZdy7f9hdteEUAPeo=;
 b=jT75Y12gJg3zssiFvY/SK9nzK3WkwlNQ/UWnJoUD2rm/+Y8FLX4rP2hwjDCkGS2vf4v3Z
 qMoCEDvnEHIjSFa30wWMIvXaZq7G/96Yv0ITYJ5nJgXgaFIa7XisuKq0UC4HMFBUhzq3Paw
 uQP+kga0+FoKbXJ+mb7qwYG6Y+bZzVY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CE0BC3CCE41
	for <ltp@archiver.kernel.org>; Fri, 22 Aug 2025 09:46:18 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 09BB63CCCE7
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:45:57 +0200 (CEST)
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 5AAAB1A00359
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 09:45:57 +0200 (CEST)
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-afcb7ae31caso337281366b.3
 for <ltp@lists.linux.it>; Fri, 22 Aug 2025 00:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1755848757; x=1756453557; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JNpeVpNAea9FMsg+BVbjmwav0EwSWFHb3a1wALyP6+c=;
 b=ILi519bLFhFVcO/lr9TbECPOe47OrQ0uZ0CrXHYibhL3u+lcLyZPjdMkdBW5ah9tJv
 OsD0d6ioXFCrDMDVPa6xdnyq8mcbJKk3+4WTogV8muejqJ5ggM5p3NknVQh7TXpa+Xvq
 1pdMdlrXhSQVuiAMp0fIKQi3N2EqHewnHMcWze6aae+mHxojxnQFJgJbONBH/cjefPgA
 I3o2XrR8oysTKI4Jtqi0TXqVsb1qWN8U3ZE4V5ZOKZnQ2foTj8s8q1pKk9waodTKIXFg
 5TVQXY2YWnOnqoDGMuHH/fhymXWznehy26dAHA5DkJ01cW6ngXsw0NuTtN6iuFAgbPcG
 2U4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755848757; x=1756453557;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JNpeVpNAea9FMsg+BVbjmwav0EwSWFHb3a1wALyP6+c=;
 b=eKaT1eJQkj93KOcdJEgghoXu/2EJmmYBXJAJ8kE93efnvY6jsqMp4XjCXooRBnbXNK
 mRoFpYfrDx3HeIwuv4KIc5ZAiAawDvdOKDpJ9kveoN4R+Ab4SKQsobo+63EwZVxBfdQf
 Zcb8WoE8eNKEAsYcbXSJaB6iqhmCeMe1xJr7LDMdx+6YS5gjY5bcSiSw0ckHeVw5gDsT
 3HVoW6bpeJLDQzKcEjzeVpMlGdgUzCBQWv1q6dfQrx+4ApHAoC8u1Yk0nQob0XT968Z9
 t2f6OMdjwESugYwQU2dNglSHqWRJY7JkCRdGBlouhMVtkqpK/xT5JCY8Dd14RrH/oujM
 zBfw==
X-Gm-Message-State: AOJu0Yy92uBacJA8YCl65mwlF4IWxe68j2IWxErnH5+dyENjAxCJEoGJ
 gfv+CstDJB4BG04Ostey9pLVmi4yIDIW2wDGjXGOeDzuiANC/rbPHIcFT69Fv+uxNw==
X-Gm-Gg: ASbGncvkiW2Sv7y3F6oz8bNd1uzmwFVgVCMs8rYpDwvQJSXJ7cNrqc5JYNBnhdlLS4F
 T7k2CZTHIaOwSFbROkCZoHFu+c7dkuWQrKWbdDsEok25quFv2NPN9AXcD2GUkVJlqB6HjC+WZ7W
 i788SdJzW0QJepKtXQUIDUq0IPfzhHPBuV37Bh8t9pXAFdxPnizwmrRfWVUubVDL+tUw/pMToSK
 0/zQ6gBapk/6X7ps5hXhOpovLCBABWzdPD/ndX1yrFXP8Ueyhyi2z45Cn5RLFsDnlpyRlb9FgwB
 SAX2fAWL/IXJRIIhoHbx/7/PVKrIDZFD+qKmcPA0MvHZIW78J+led96h9MS8xYRPPqa1PKaNxst
 gc/Tz4MTPgXnh1kmdLMgldtk/VYby/Nhibv7ko9f0dzM=
X-Google-Smtp-Source: AGHT+IGfnuKumqZ4AYCG8NrXE1dxZdk3h9LVx+eNw9JD09+g8loLlbCi0A4MpOZDEUDcG8aCJhXyVg==
X-Received: by 2002:a17:907:60ca:b0:aeb:3df1:2e75 with SMTP id
 a640c23a62f3a-afe29748f87mr175368866b.46.1755848756686; 
 Fri, 22 Aug 2025 00:45:56 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-afe0c411a55sm297987366b.100.2025.08.22.00.45.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 22 Aug 2025 00:45:56 -0700 (PDT)
Date: Fri, 22 Aug 2025 07:45:55 +0000
To: Li Wang <liwang@redhat.com>
Message-ID: <aKggM4ZVmjt7x6fJ@localhost>
References: <20250822072204.2191382-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250822072204.2191382-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_device: refine tst_is_mounted()
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
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Fri, Aug 22, 2025 at 03:22:03PM +0800, Li Wang wrote:
> Refactor tst_is_mounted() to reuse tst_mount_has_opt() instead of
> parsing /proc/mounts with strstr(). This makes the check more
> accurate and consistent with tst_is_mounted_ro()/rw().
> 
> Also moved tst_is_mounted_at_tmpdir() below for consistency.
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Wei Gao <wegao@suse.com>
> ---
>  lib/tst_device.c | 79 +++++++++++++++++++++---------------------------
>  1 file changed, 35 insertions(+), 44 deletions(-)
> 
> diff --git a/lib/tst_device.c b/lib/tst_device.c
> index b610cf14b..5b0498c03 100644
> --- a/lib/tst_device.c
> +++ b/lib/tst_device.c
> @@ -429,50 +429,6 @@ int tst_umount(const char *path)
>  	return -1;
>  }
>  
> -int tst_is_mounted(const char *path)
> -{
> -	char line[PATH_MAX];
> -	FILE *file;
> -	int ret = 0;
> -
> -	file = SAFE_FOPEN(NULL, "/proc/mounts", "r");
> -
> -	while (fgets(line, sizeof(line), file)) {
> -		if (strstr(line, path) != NULL) {
> -			ret = 1;
> -			break;
> -		}
> -	}
> -
> -	SAFE_FCLOSE(NULL, file);
> -
> -	if (!ret)
> -		tst_resm(TINFO, "No device is mounted at %s", path);
> -
> -	return ret;
> -}
> -
> -int tst_is_mounted_at_tmpdir(const char *path)
> -{
> -	char cdir[PATH_MAX], mpath[PATH_MAX];
> -	int ret;
> -
> -	if (!getcwd(cdir, PATH_MAX)) {
> -		tst_resm(TWARN | TERRNO, "Failed to find current directory");
> -		return 0;
> -	}
> -
> -	ret = snprintf(mpath, PATH_MAX, "%s/%s", cdir, path);
> -	if (ret < 0 || ret >= PATH_MAX) {
> -		tst_resm(TWARN | TERRNO,
> -			 "snprintf() should have returned %d instead of %d",
> -			 PATH_MAX, ret);
> -		return 0;
> -	}
> -
> -	return tst_is_mounted(mpath);
> -}
> -
>  static int tst_mount_has_opt(const char *path, const char *opt)
>  {
>  	char line[PATH_MAX];
> @@ -496,6 +452,11 @@ static int tst_mount_has_opt(const char *path, const char *opt)
>  		if (strcmp(mount_point, abspath) != 0)
>  			continue;
>  
> +		if (!opt) {
> +			ret = 1;
> +			break;
> +		}
> +
>  		char *tok = strtok(options, ",");
>  		while (tok) {
>  			if (strcmp(tok, opt) == 0) {
> @@ -512,6 +473,15 @@ static int tst_mount_has_opt(const char *path, const char *opt)
>  	return ret;
>  }
>  
> +int tst_is_mounted(const char *path)
> +{
> +	int ret = tst_mount_has_opt(path, NULL);
> +	if (!ret)
> +		tst_resm(TINFO, "No device is mounted at %s", path);
> +
> +	return ret;
> +}
> +
>  int tst_is_mounted_ro(const char *path)
>  {
>  	return tst_mount_has_opt(path, "ro");
> @@ -522,6 +492,27 @@ int tst_is_mounted_rw(const char *path)
>  	return tst_mount_has_opt(path, "rw");
>  }
>  
> +int tst_is_mounted_at_tmpdir(const char *path)
> +{
> +	char cdir[PATH_MAX], mpath[PATH_MAX];
> +	int ret;
> +
> +	if (!getcwd(cdir, PATH_MAX)) {
> +		tst_resm(TWARN | TERRNO, "Failed to find current directory");
> +		return 0;
> +	}
> +
> +	ret = snprintf(mpath, PATH_MAX, "%s/%s", cdir, path);
> +	if (ret < 0 || ret >= PATH_MAX) {
> +		tst_resm(TWARN | TERRNO,
> +			 "snprintf() should have returned %d instead of %d",
> +			 PATH_MAX, ret);
> +		return 0;
> +	}
> +
> +	return tst_is_mounted(mpath);
> +}
> +
>  static int find_stat_file(const char *dev, char *path, size_t path_len)
>  {
>  	const char *devname = strrchr(dev, '/') + 1;
> -- 
> 2.49.0
> 
Thanks for your patch!
Reviewed-by: Wei Gao <wegao@suse.com>



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
