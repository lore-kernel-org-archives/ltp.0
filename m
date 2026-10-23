Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1885606A31A
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 10:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=ksj/2CbM;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FQX/lgGT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792752621; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=OchFe3RrpH4VGPpUuxXjDIQpvGP5eTu428TPSeIPhvE=;
 b=ksj/2CbM8RhnRswUBX+wfFOIjHaUeNHfU8/DgYKKIelw4+C+lXSYm6m7x95jHM4UiInBp
 NRpJapVH1Z+Adobvzwc6Nn8AfmZAyBlJYtBpAYx40to1FFOkzJP5LOaCJde/gPf2AiHlqFA
 2NE1EXaAGdenAXd3sUatU07xaKTafQw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 16D903E9BE0
	for <ltp@archiver.kernel.org>; Fri, 23 Oct 2026 12:50:21 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D301F3D25F8
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 12:50:00 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id A04C6602783
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 12:49:59 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-4a1fe9efc0eso7820085e9.2
 for <ltp@lists.linux.it>; Fri, 23 Oct 2026 03:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792752599; x=1793357399; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HQAdPl0ojKRQIUo9TvrEnntTMbksvwNwjYLKi85TDfc=;
 b=FQX/lgGTcOP+BFXFsM3Q1/MlSH8Ugmn83dZgzjU+hdhNM1jSO1KraOnEY9lAbof3lA
 cjGi39JzSqmztNqKGp+xOJtQwHKfVBy9ZMa/RwYrCYKWnMPOU4hS9uufFKphb5knQZk0
 prtHlgrc5CLkc+6XAVYzxZ12hkjq9N5XY73FkQETNvDB5+kVBYeoA9ZkG5F1W1SHcPD3
 ZCnlRjezUZ54Lsr+zizlEXsFcE9G8oEHpWJGtxfRX5nUNNBY3AfKWSHgEGEHXeZsnD2Q
 NDNm3FwcwfijmxaClAnjDCPrM6BUt23c40B8KF1fCJZppOQtSjoRf3Jedg4LeeUkbU/m
 RfHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792752599; x=1793357399;
 h=date:content-transfer-encoding:content-type:in-reply-to:cc:to
 :message-id:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HQAdPl0ojKRQIUo9TvrEnntTMbksvwNwjYLKi85TDfc=;
 b=NxDGjmimJW55l9r7YhkJzAY4IXlPYhKa3+v8LnrFv1D8LuA2tYYsz8HYELuO6punX4
 Kj6+3PqGL9C9nfbhElfwFNLSYYSLTPokyKsNZ4oNJ9RjH4CdscXjbUFkk7YX6QjsYdbo
 bhFkBZcpp6D4Yj6ornFzX4xg4jxWrmnDDE7EQoEKCrYP1sjw5wHTqZAtTSGqxv9oXL+t
 2J1o7TKbzf5QjeQ/7d/Ub6x8QpJTVhC6NNeuHyxalVWfUq7GH8i+0sxRN2ZglW07cgzv
 KJjy8SjZU3bHgRNyXG15gGsjHcgtEgslPwjMezCX8m4IBN7QYPhJy7KX2o6CJwlG31Et
 soyQ==
X-Gm-Message-State: AFq9FYKlT6RkFkmUgA0ejIJCXhMMthATQIJOMaCGoZKLcRAJjgH4boVS
 7hc175v8Q7delR/8S0jCAmjDSonlvOMF/YO/yXaODOtGEQ4kktqE0IQkbH+KCDgPXJw=
X-Gm-Gg: AYBFou0i6p9/wB5UhbVxz1REqtkx1Yesubkq0B2UzvQYH0T+rQBjDMoYiQDgpD2aWO8
 t4orJ2UECyb1BmVdC8dSuIveozYIIcb1kJMhI54PzbFCr+LJf2+n0pbzM8Ix7ZCuAUrge9GKoIW
 bEBmnIT9RAQ8ug+QJDelB/hB/FtlIK+kLTJ3oy65/QvTut4XGNlx+Yf+9DSv++NFqbir8V7jYDI
 WH/ggqMd1baRWXEq0U6xtUFvl8hvmonutdr0ZLoUbjneiGj+X5CEcgE3U2Ao9e8ZbIDMYAXe4lP
 vxlrx1INbP6GQZzw/dCOELj3bZBCFjzt9xjDRZSezsDIHgKwemyiqPd0a4gjBT6t1MeswbOEzFA
 oT2O/rYru5OLMGAvPHrIUTcKvOu5/9uEnEeH5vRL75BvkXY5D3C+EIu1dG/YT4icYcNbgFjMpZu
 s6I/4wN5idObhd01IRFRPEyWx6kpkA3Hl9ke++UJgBgIu82LBiX8k3TRNpk7DVOL7R3fIT2e/30
 YH9LoPwwVvASBCuppmvQCwmSD3sfkioQcWT1wWjBfBVC2auGolJW/z614iAXoFHR1SIrJflLro9
 1Lry1em0WSX9dUjfVMYEQ9WqL0SdqU6zsW23iURHsrBV/D0QWeim7MSQPGg=
X-Received: by 2002:a05:600c:6099:b0:4a2:104b:93a0 with SMTP id
 5b1f17b1804b1-4a211cb510dmr30806245e9.10.1792752598986; 
 Fri, 23 Oct 2026 03:49:58 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f310000926bd7eee21e6eee.dip0.t-ipconnect.de.
 [2003:ef:2f31:0:926b:d7ee:e21e:6eee])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a21047b524sm68120165e9.14.2026.10.23.03.49.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2026 03:49:58 -0700 (PDT)
Message-ID: <nyxmYT58cq0uOlU7fpl6RzXmIEKsQXtL83EA@localhost.localdomain>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20261022022824.19735-3-wegao@suse.com>
Date: Fri, 23 Oct 2026 10:49:58 +0000
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v16 2/2] open16: allow restricted O_CREAT of FIFOs
 and regular files
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Wei,

> diff --git a/include/tst_path_defs.h b/include/tst_path_defs.h
> index 1a60028d3..2995150be 100644
> --- a/include/tst_path_defs.h
> +++ b/include/tst_path_defs.h
> @@ -47,6 +47,8 @@
>  #define PATH_FS_PIPE_MAX_PAGES			"/proc/sys/fs/pipe-max-pages"
>  #define PATH_FS_MAX_USER_GROUPS			"/proc/sys/fs/fanotify/max_user_groups"
>  #define PATH_FS_MAX_USER_MARKS			"/proc/sys/fs/fanotify/max_user_marks"
> +#define PATH_FS_PROTECTED_REGULAR		"/proc/sys/fs/protected_regular"
> +#define PATH_FS_PROTECTED_FIFOS			"/proc/sys/fs/protected_fifos"

I just figured out that these were added in the same commit that is
modifying open16. They should be inside an another commit.

Kind Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
