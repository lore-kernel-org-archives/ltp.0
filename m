Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9BAAC83F27
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 03:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1752637346; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=/fVmmcFPnesHPkGFm0KOHp87zpxVPM74yjagl15JBso=;
 b=rGlbM9mSFbK/Qb39yyjbmEwg2pfjyuHCN+/w3ApkuyboTxqXDZreIdQyG8LtUk3tXfecr
 P5CXBejNjtMfkPtNd1+K0VYa0ynEn4B6SLoORzTGaVPvZs1WxcI/E5PqSXwkYOpnEh2RLcD
 Mwm4j5xz5Si9RqiKxdK0vHFThG9fva4=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E1CB43CB4D2
	for <ltp@archiver.kernel.org>; Wed, 16 Jul 2025 05:42:26 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 431EF3CB4D2
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 05:42:05 +0200 (CEST)
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com
 [IPv6:2a00:1450:4864:20::42a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 3CB141A002DA
 for <ltp@lists.linux.it>; Wed, 16 Jul 2025 05:42:05 +0200 (CEST)
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3a50fc7ac4dso2869299f8f.0
 for <ltp@lists.linux.it>; Tue, 15 Jul 2025 20:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1752637324; x=1753242124; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=03ysxQ6lGcODNJFi0DHH9r+sAag9GQJMZYqFLPgLwDw=;
 b=Gr0EVMi037l7BTiMeQDE9q4pkHeyLs34G2CLdoXs+uxUucFkkwYmRyN2HSmhRznPbY
 tHkFx7Z/hJR7C0zfA2inQFyOMbmIkRhg/aTc9OIP1VQKya3FWfHJaTrZ/U6atndT71UN
 jlsjxuD9au+OJBJIgG35RSxYjTGMWWaY7oh/s30YU3Q1VGf7el5uTyTfdiiK3z49Twwg
 c7h5Lfj6ZYGVChXVYnKngu64+KiT0INy6Q1L+SGPkbBVhxoR4pt4pW+NBD3cnCts8tpl
 Bibfo3BouMBzn92WsQZeSRx4yHp1o2Dyi4JNcLWc93dhZ6LrK7Ymuy9P7xxH/+XLJGdd
 0WQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752637324; x=1753242124;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=03ysxQ6lGcODNJFi0DHH9r+sAag9GQJMZYqFLPgLwDw=;
 b=occZ9q7cWdCGkxpa/RweCWM/RmyMTckAX00bY3FCwIXPAUO8aoZXKVtOvvHkmZ0Vrz
 tMDvX8U/ttYEE+ztiWXaEhF+3viS7aM0MqdYSCb/GT8CWv8bMBVqwrA6D24VuRA1fTKl
 nYJWTExB/ItZrfoS+wjofqSKzG4l/4vBMU5yomeifuf6jJSav+QglDilfAHqqCgejpT6
 fum1KXFHgsGo52R1QsfdijvOv+GD4EzDup++9xskbc9U3l2wU4PSNwjhi49MJoPXUeyp
 JgRuhVQ+xP6Q4PVxkFOYnSzoebiMONs/kLEGbV/OufDkbvKktPnf7SoPU1Ti/d8rMVVR
 OAeg==
X-Gm-Message-State: AOJu0Yz/P5TgAZGYv6EY5hHS3bcxGkUh2Ymby5a49/t3upGbfDtO4MVn
 DuIsER4uEEo01gn8OR24GZrQ+dDcwsvf65bwyp76F94UM4j84gJG/af9aq5cHD8AfQ==
X-Gm-Gg: ASbGncveobqGdCQjqpK4X83ac8HS4YsQMSruZo8R+egnoOyPyAWt4Ps4tXImwSPXXq2
 QmYLZbmwluySqFkB+7upQOQgBnwuGdZISykLFy2wtzsbA8SaCTp9ZSY77PxnJHKMwfcpPMBJ8I0
 3dLLTc2gceQ5HvQ7FNrG9icQQT/4IF1tia/KxMl5+Z4TuFsZMh6BoVOcaNzOwBR8hpDxhjHjE5c
 wTGAhYvNd52ezEWrRn16WPF9fbPMY7z5/5MrVkwbz7u+ffmvN/hDnLSpKmpgBM2Zx8s2HBRY4Ei
 h1YOXQF4iLQwnTWiQOiqOVwI05fdXiKjWGhucdZeBCh40xIc+c28Ypx2S7/kdFj+0e00Tm+SQDV
 nRl5zNhkLTQt+N3K88fsM+Q==
X-Google-Smtp-Source: AGHT+IH6VayuzzUEP0LT60r8D386TRsNXPzjy6KbLwWrWzto2q7iS0VXpAnnr4fkFL7fSMucbkUVGQ==
X-Received: by 2002:a05:6000:230e:b0:3a4:f520:8bfc with SMTP id
 ffacd0b85a97d-3b60dd7ac78mr1045640f8f.36.1752637324460; 
 Tue, 15 Jul 2025 20:42:04 -0700 (PDT)
Received: from MiWiFi-CR6608-srv ([202.127.77.110])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c9f21f3fesm429503a91.40.2025.07.15.20.42.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Jul 2025 20:42:04 -0700 (PDT)
Date: Wed, 16 Jul 2025 11:41:20 -0400
To: Florian Schmaus <florian.schmaus@codasip.com>
Message-ID: <aHfIIIVSD6KcEiOH@MiWiFi-CR6608-srv>
References: <aHWsnL8bUYkTJt21@MiWiFi-CR6608-srv>
 <20250715091931.505865-1-florian.schmaus@codasip.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250715091931.505865-1-florian.schmaus@codasip.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] fanotify22: Make 'dev' the last debugfs argument
 for musl compat
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

On Tue, Jul 15, 2025 at 11:19:31AM +0200, Florian Schmaus via ltp wrote:
> The debugfs(8) man page specifies that the device to operate on should
> be the last argument. So instead of
> 
> debugfs -w /dev/loop2 -R "sif internal_dir/bad_dir mode 0xff"
> 
> the correct command line invocation would be
> 
> debugfs -w -R "sif internal_dir/bad_dir mode 0xff" /dev/loop2
> 
> The former works on glibc-based systems, due to glibc's optind
> handling. However, it breaks on musl-based systems, where the
> fanotify22 test will hang because debugfs is awaiting user input.
> 
> Signed-off-by: Florian Schmaus <florian.schmaus@codasip.com>
> ---
>  testcases/kernel/syscalls/fanotify/fanotify22.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/kernel/syscalls/fanotify/fanotify22.c b/testcases/kernel/syscalls/fanotify/fanotify22.c
> index 20c7a6aca243..357e74dbc702 100644
> --- a/testcases/kernel/syscalls/fanotify/fanotify22.c
> +++ b/testcases/kernel/syscalls/fanotify/fanotify22.c
> @@ -61,7 +61,7 @@ static void trigger_fs_abort(void)
>  
>  static void do_debugfs_request(const char *dev, char *request)
>  {
> -	const char *const cmd[] = {"debugfs", "-w", dev, "-R", request, NULL};
> +	const char *const cmd[] = {"debugfs", "-w", "-R", request, dev, NULL};
>  
>  	SAFE_CMD(cmd, NULL, NULL);
>  }
> -- 
> 2.49.1
Thanks.
Reviewed-by: Wei Gao <wegao@suse.com>
> 
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
