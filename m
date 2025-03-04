Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7A4CC021B8
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 04:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1741061031; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=QCaXZVXklBkf8SAogLUvJctkyJXpVpWeHTA8xx8J6OA=;
 b=LP7qCiqLGdtAv8wkOq3KfkEJ7RoaxSmGarUtgBMcAwMwBXG4NdVpJJ0JU4rXUgaBWa7CD
 /M28r4wXzSj/5JClbTTGSGnFslZuS2QBMVz3I2mCf9ObOOEB05d96bLLV9iDw6iCb6fNTly
 8hpHbPvNp0ToA6OdokeVWpBSFp6nd7E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E4E523C9E40
	for <ltp@archiver.kernel.org>; Tue,  4 Mar 2025 05:03:51 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 99E543C7B03
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 05:03:30 +0100 (CET)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E12691A00278
 for <ltp@lists.linux.it>; Tue,  4 Mar 2025 05:03:29 +0100 (CET)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-43bcb1a9890so2192905e9.0
 for <ltp@lists.linux.it>; Mon, 03 Mar 2025 20:03:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1741061009; x=1741665809; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=M2qSVeC6vO03J25LXLHTsXRqZs2LCwlMiUwuO+9jHoM=;
 b=GeJ/f78+ZcRt4pRppeWjQ4FdcLAEU2KtdnmZczwGAhfdWqaJ1TwvrmmuQCSSnzczsr
 fWnFjeVG0cslWwrcoVXiM0qAKaYqOLjJ/M4o9fuVGkeNBEDef90LUw2G0EFHec030nAc
 axC32rlh9Ed/F0N6pNHYCNV410C6uK+NSWm6kRMmVbVcusJB41P8sCzxKKm0ojZmG8Vv
 Ybej6ASrs76otF7EQETs/ipJR7YrJhIVP0pwtbJ8jgHZC0qRZdwb0AcW7V2ECD1D5XZ1
 vT6OnUf7WsuBRR88m7uApkgHwr+z/5neGY9eQ1ZF00lyxbP1qazp0Iq7gUfXhJOss4JN
 C8bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741061009; x=1741665809;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=M2qSVeC6vO03J25LXLHTsXRqZs2LCwlMiUwuO+9jHoM=;
 b=U3Q8Hou5i/e11Jox3rY6ZOMLadqDMmfbUQ1OVG6xLrkLPDtOYXa2U8kYOSPiNE29Cc
 thi6D6pfIPnK54pYMvB7gJtYcQLUymIZ/k3QbhEXs2ToKsYphH0WVbgrW9p3lMBspkWG
 JvabRbJG+67H6wglfZMYhoOvQAdJQVQdgDvCBVdcMjvpOtiJL2PwMOd8axlQ+L6VhNNv
 tRSEOzPsJHl7Md/xWzNLlrAMVHHZ0zJSyn8p5I1Uwtp8fXMjFgAcKujodo2COP2oRknC
 zS0FxkyXTgtQ444fVb9P4UIKkUvzxu0czwA1r/NGlbM7irllLiN2Zun/AzN9rFVwZ+Om
 9RxQ==
X-Gm-Message-State: AOJu0Yz8l06ylVWDqKESIdYNV2cDXH1fnG0YUBC4BOwCg326amN2v0ax
 V5G1c/dLR8PZcWba1ZtybDVaGOZvTLc9SGI+lsTtLU0mQytpA4RDVEG2kdlbdQ==
X-Gm-Gg: ASbGncviU9dYXFbPpf5/+76SUOsa3dZl9wpIxWTJD5g37vcbhdto17DaEnCLynE1wZg
 GT54QQWbp4dyWUsWcoWjrFnQpfP0rJQtOvAEEQTNh622iYZA/87KFJZyAUbv5sR7bcmZDK/I4bO
 bzs3KsdRg4bUW+5YslORhGFHMpjBs2cKN7zOKGwBlegGuY64hI7YzN0o4PS9hwxCT1hYU9ssxWz
 +TCzVw/BkxZc1NpxfCPqrwUwF+snKchYS0DIqZETPS/l7yQ3qToTRyMh1GNvBel5QK6Bf14qdb6
 AxdbCyxtUU9HCgpHG8EwwIu/W5Y7PdzZXDqR8gY=
X-Google-Smtp-Source: AGHT+IFSm63kOASJxb1W1PKelM9fEh3x2wGOUkgnGgMd8CiJkxppizu2xpMomrrObjhQOCZJio0yhQ==
X-Received: by 2002:a05:600c:a403:b0:43b:bfa7:c7d with SMTP id
 5b1f17b1804b1-43bcae04e3cmr11965365e9.2.1741061009297; 
 Mon, 03 Mar 2025 20:03:29 -0800 (PST)
Received: from wegao ([202.127.77.110]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba538b9fsm216378105e9.17.2025.03.03.20.03.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Mar 2025 20:03:29 -0800 (PST)
Date: Mon, 3 Mar 2025 23:03:22 -0500
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <Z8Z7imFU4KAW46rr@wegao>
References: <20241219081951.8340-1-wegao@suse.com>
 <20250303094243.5782-1-wegao@suse.com>
 <5a4dc2a7-dbfd-4927-ad85-7c3e0d8a00ee@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5a4dc2a7-dbfd-4927-ad85-7c3e0d8a00ee@suse.com>
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] unshare03.c: Add test coverage for dup_fd()
 failure handling in unshare_fd()
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

On Mon, Mar 03, 2025 at 11:47:34AM +0100, Andrea Cervesato wrote:
> Hi!
> 
> > +
> > +	SAFE_FILE_SCANF(FS_NR_OPEN, "%d", &nr_open);
> Here we can print the number of open file descriptors, using tst_res(), to
> help debugging.
> > +
> > +	SAFE_FILE_PRINTF(FS_NR_OPEN, "%d", nr_open + 1024);
> 
> In the previous version I made a mistake in the review. The original test is
> using /proc/sys/fs/nr_open to set limits first, then it reads back them from
> the same file in order to have a starting limit. This is probably needed due
> to the kernel configurations. So please bring back the
> SAFE_GETRLIMIT(RLIMIT_NOFILE, &rlimit); line I asked to remove. Sorry for
> that.
> 
> Also, if we are going to use new increments, we need to update the next
> increments as well according to the previous ones. So feel free to leave it
> as it was before.
> 
> I must have been distracted that day :-)
No problem at all :)
I have sent new patch, feedback me if any misunderstanding.
> 
> 
> The rest looks ok.
> 
> Andrea
> 

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
