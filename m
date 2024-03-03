Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 211D7C54E41
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 09:47:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709459220; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=vEeGoLGg7CIi8VpjdmEnskpR4I7ZHULyGFBpt7Hkve4=;
 b=HPkdH3g+NrDKWxFjxNLtng5oDB0+eUamk/K9og/UeqAmTmrHCrLVyWOdM7c4MiArqN2sU
 4FrqMXZG785aY0vhFDsFF7271zVuUkV+7CnTJFVVBW96PmoAYV8olcVDvWFs6qtV5WonTh0
 IJ4BZcrwo/CQq9j6qgpv81txTTILI00=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8743C3CEC0D
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 10:47:00 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id DF26D3CD010
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 10:46:39 +0100 (CET)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BCA1260095F
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 10:46:38 +0100 (CET)
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5656e5754ccso4642163a12.0
 for <ltp@lists.linux.it>; Sun, 03 Mar 2024 01:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709459198; x=1710063998; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=1Yx5eJT9ZZOsikjcHCeZCGucmbdLEeVe4I2Auv3Xp28=;
 b=JWG3o6ydZuo6DW0jhgRMwZB9gvQSQkNMTwu+xMDWXg1fT6SkoeC8j7V9isSh41MyhP
 545mSEq4FFao8N5OjHlJ0tk9UYKZXnV6zNf5AePx5Coz3zHL2JhB286NpIebU8vF+D0D
 WOSK9liKAq5sXNprZ2Ym1pg/9ZYI/XNnBOu/fK8SPF53rk+Lukn+mQkFrgAmW2IYWtsE
 XCMrNZasVXZzKe7BnnAXtGOwg11IqerINU5OmwybHGZ9iHNTQzP6F9K/PAQ7AWrn4JfR
 3AL4exyKE8O+4cih01KWuShfdT1Wk7yn1fxtyLCYLuxgxt+Jrd2YuJLaU7O4frP8tacY
 Byyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709459198; x=1710063998;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Yx5eJT9ZZOsikjcHCeZCGucmbdLEeVe4I2Auv3Xp28=;
 b=ddUsXqwlL8rpfBjswUM7r6UAH5EQIIU6+5P6flMuaCkZ/BWKUvZuwaeXvMFu2WvE50
 b8IQH1Ps8XwPXoYHEFcj8a03JVWXvUAWxe8GdWNfzpux5GHLl/kTlwE8/aFju8Fn4LN4
 8YK6TB/6QVsfmhVOCCE4nUvgI1TiV11jO0UkvAdaArid43nLCAto/NcQh9rYYC4AhEV6
 jtBvpCEhOEzZEEUYOJqy/d9E/gFx5t9yOQG6m+jwRPZ+JTgelsQuVXk1t0+OCo/u0Svt
 p2HvlioYY7X2xa4LfvbD7Uq/47q/lKO6P23LsRkEtNntWKA8R4YX0HeXSXTrrxOEu0Aw
 JvyQ==
X-Gm-Message-State: AOJu0YyFkxXShKGceUX+nFxXHeSaPKWPmLEaIHowchNGVkh5D/XG9X0N
 iZFb1aLIO/TgL6ZM/zF/D5yeCxwdQ+50xHU1uB6dlZ+qsZQhFFyOVbsEGTzMojUNgMBV6erxpWw
 =
X-Google-Smtp-Source: AGHT+IFqjk2yCvN9UPWbcF/B3SkMgD8Qba99IcufTDGlzFvnapZzS6DtuckAxlB9rrtTMeDByWVZKQ==
X-Received: by 2002:a17:906:cb8d:b0:a43:72d6:f1fe with SMTP id
 mf13-20020a170906cb8d00b00a4372d6f1femr3774609ejb.77.1709459198175; 
 Sun, 03 Mar 2024 01:46:38 -0800 (PST)
Received: from wegao.87.41.165 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a170906c41600b00a44e180b9a5sm1309630ejz.1.2024.03.03.01.46.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 01:46:37 -0800 (PST)
Date: Sun, 3 Mar 2024 04:46:32 -0500
To: Li Wang <liwang@redhat.com>
Message-ID: <ZeRG+KzmNHaokn5Q@wegao.87.41.165>
References: <20240301102347.3035546-1-liwang@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240301102347.3035546-1-liwang@redhat.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cgroup_dir_mk: set the umask to '0' before
 creating the subdir
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

On Fri, Mar 01, 2024 at 06:23:47PM +0800, Li Wang wrote:
> This is to resolve the permission issue when creating
> a new subdir in the cgroup, in case of system's default
> umask is 0077, this will trigger issues for LTP case.
> 
>  cgroup_core01.c will report following error msg:
>  cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)
> 
> Signed-off-by: Li Wang <liwang@redhat.com>
> Cc: Wei Gao <wegao@suse.com>
> ---
> 
> Notes:
>     Hi Wei, can you help confirm if this patch works for you?

@Li I have tested your patch and it can work.
@Li @Petr Thanks for your patch and comments, i suppose this patch can be merged.

> 
>  lib/tst_cgroup.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/lib/tst_cgroup.c b/lib/tst_cgroup.c
> index a8a598e0e..f6afb51d6 100644
> --- a/lib/tst_cgroup.c
> +++ b/lib/tst_cgroup.c
> @@ -361,6 +361,7 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
>  			  struct cgroup_dir *const new)
>  {
>  	const char *dpath;
> +	mode_t old_umask = umask(0);
>  
>  	new->dir_root = parent->dir_root;
>  	new->dir_name = dir_name;
> @@ -394,6 +395,7 @@ static void cgroup_dir_mk(const struct cgroup_dir *const parent,
>  opendir:
>  	new->dir_fd = SAFE_OPENAT(parent->dir_fd, dir_name,
>  				  O_PATH | O_DIRECTORY);
> +	umask(old_umask);
>  }
>  
>  #define PATH_MAX_STRLEN 4095
> -- 
> 2.40.1
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
