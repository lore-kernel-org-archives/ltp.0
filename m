Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2E1BD29C2D
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 14:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1768831419; h=mime-version :
 date : message-id : to : references : in-reply-to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=0o8Bk+Tf7ITbJqEaaiWwZY6xrAbZPI/X66HGW3j5KyM=;
 b=XeUtmCa3g57BMuvZPJSRXN2AkJx2vtRt15XOCpIgMle9s9QYmN8AgyajXE9kbLEibQFLw
 w7kUf+Owm6lo0tGbVa6QTzMz/oTVj49X9LfgFmBRgUuqUbO6weomm5lB0Z4EFDf/8mWgXCB
 nQMaK0KhlFKJlMwL+dgciZXtBMBtank=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 276B33C9A26
	for <ltp@archiver.kernel.org>; Mon, 19 Jan 2026 15:03:39 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C3C753C7C2C
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 15:03:14 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 096021A006F3
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 15:03:13 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47f5c2283b6so28031745e9.1
 for <ltp@lists.linux.it>; Mon, 19 Jan 2026 06:03:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1768831393; x=1769436193; darn=lists.linux.it;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xSR0vcQ5fBbfjuYMjXE6l3V8m/Oj/egoG5dIlA9gmz0=;
 b=P8eZKYvc61ItlzjZ/LtUuxOfF4qcwFH60y5EUC4+2HJsUivIQZ7fHGB2qg2Tq/ZFl3
 3Ei9TBxUvQHovtZIIGgE0qltBMZkAsrhtZpY4xXAE9cif6VKUeyW7DckXT2fJcWhXbIq
 BBMdlNBomXw4cearo4iKidq6spNwlwDSugNLoJ3Zo9LVMd6wLkPIlNVv24CrFRBjdW+f
 4Cw3wiR6MNCTpirlOFWhdb86I6fqNggKKruoKjhQceVyMTTXkhU9309jH8fmO83ESq/j
 fW3Dou25sLDxFpbE+f3ag4LFd/3yVa1L05xkWTpTWr75+wFOlEMgDT2Zs5IP6RarAeFD
 FC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768831393; x=1769436193;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=xSR0vcQ5fBbfjuYMjXE6l3V8m/Oj/egoG5dIlA9gmz0=;
 b=k0rPC0QEUMjiTWmuNMgLlEUIAbIObL5U+VQpYV8RZc0j90wXINGwFfyW8dZGflIMlx
 mdvPebaQ4TvLpKdNq18YQxID2FLfFSEbU4Zl6prb3X8s2nfhMEa4156WKE25h8peT9za
 FTG3nU6nRogfidg1YIjmo1w5E8JcHI9jLWjY/OJQsPwM7KvVFz3SLxL0ahVNc1S1a2TQ
 YzV5cbXZKR+OqPBF6IAFQkU+M5Ic0P/qlxJDoegN8/TQiA7cnJsCYMLIW9qqx6NiBVV5
 UX38BUZIU29N+nxBWDVQ+/j6XoBDjHQpKKv797i3RzHIViOOujn6Dq3hEjA14y69CCSk
 gwtg==
X-Gm-Message-State: AOJu0Yzl9hLAwmAxWkGROVukOGax30wKx1DNTSuycscx5XSX+fSBsJjE
 xstxDQy99GFbU0ACwtJiauNLeQLq3mTUxC7R69Sm+DU1Fl8hr7zW3A/NPI3xeHSepbM=
X-Gm-Gg: AY/fxX6wANhY9Uhzw3R2BDluhzcuuRuiOpMwQioZ1awWvG35+O62LMkS4KszPC67B8s
 BToS9LYBwc/z9vTUz2YBn2rnfg+U/1QnS2YEQqpDGqvvc8gbXhz0sQW3BrVAqlzhEsGvtA0k+M8
 dT4X0NGfwiK1ZWK+sNCZ5NVimz9bP1CXQ9zkIDempDbxXUbgP8MUAuWbe7BPTA+QpYJK7RkcLPG
 gZi/sbH+wyXzb3JOlM8t4Lu5OiIgofx8sSTr26WovEmZCPDhuxJSVgboaNDCSvTCwR5txb3sVPQ
 U36Fb9qkzivxhE7OIbNqF7q6NFAwnawKDS3jXO/TWUrNSpUlV00feaCX0AHDITXIQfq26ZEvd2Y
 u3WA12g1SXMdjDNtV1x5p4QGdyBYndVyTyR75Ro4Q5n3og3Usb4F7pRMMq0JVMscAPBgKmkwT3L
 YgEpshl/0EfQyO4JbS3DSjBwG3FEg+uWULxR4NnqaDfaVnM9WyNAeRKVNhRnMHL+tm0mPLKoeUY
 /R2
X-Received: by 2002:a05:600c:1990:b0:47e:e712:aa88 with SMTP id
 5b1f17b1804b1-4801e34cd36mr147584065e9.31.1768831393210; 
 Mon, 19 Jan 2026 06:03:13 -0800 (PST)
Received: from localhost
 (p200300ff0f0b7b017e458f16f8082810.dip0.t-ipconnect.de.
 [2003:ff:f0b:7b01:7e45:8f16:f808:2810])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e879542sm202341255e9.4.2026.01.19.06.03.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Jan 2026 06:03:12 -0800 (PST)
Mime-Version: 1.0
Date: Mon, 19 Jan 2026 15:03:12 +0100
Message-Id: <DFSMEBM9PYDT.3TJXEU3C8W31R@suse.com>
To: "Cyril Hrubis" <chrubis@suse.cz>, "Andrea Cervesato"
 <andrea.cervesato@suse.de>
X-Mailer: aerc 0.18.2
References: <20251014-file_attr_eopnotsupp-v2-1-c9827c8d8127@suse.com>
 <aW4mDAH6pVh_VyC2@yuki.lan>
In-Reply-To: <aW4mDAH6pVh_VyC2@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] syscalls: add file_attr05 test
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
From: Andrea Cervesato via ltp <ltp@lists.linux.it>
Reply-To: Andrea Cervesato <andrea.cervesato@suse.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi!

On Mon Jan 19, 2026 at 1:39 PM CET, Cyril Hrubis wrote:
> Hi!
> > +	.filesystems = (struct tst_fs []) {
> > +		{.type = "vfat"},
>
> I wonder if we can add more filesystems here, just to make sure that we
> run the test even when vfat is not compiled in the kernel. Does ext2
> implement the file_set/getattr calls?
>
> > +		{}
> > +	},
>
> Reviewed-by: Cyril Hrubis <chrubis@suse.cz>

vfat and ntfs are the only ones which don't support both file_setattr()
and file_getattr(), while ext family, tmpfs and btrfs don't raise
EOPNOTSUPP for file_getattr() only. I'm wondering if that's a bug, since
xfs is our reference for this implementation, or this has been
introduced in 6.18-rc2 by 7ea30958b3054f5e488fa0b33c352723f7ab3a2a
commit.

-- 
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
