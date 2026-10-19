Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8D7C606A31C
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 20:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=TPm5KBhq;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=E/SuaMcl
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1792440190; h=message-id :
 date : mime-version : to : references : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-transfer-encoding :
 content-type : sender : from;
 bh=Tno06zCkVOAxmt3kgrrhUp+x7BE1c/LcDtOj1PV7+9Y=;
 b=TPm5KBhqiymmobBfCM77+oZQxkBD4sc8s4KUDSLysBDRGWlQZjJkQ4/W9rJWpiFa0TaJU
 3miDWLbBGym0c6y8WEQJMH44Ur69ubX4f89+25ZcLn5kNisnJAB2vDxx3nIbf1zR96w5GtG
 BiM9Hn0391dDb2DK+jPZLTsGKW5tXpA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 19BA43E9AD8
	for <ltp@archiver.kernel.org>; Mon, 19 Oct 2026 22:03:10 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D4A913E2F38
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 22:02:49 +0200 (CEST)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 401EB60080C
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 22:02:49 +0200 (CEST)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1635731f8f.0
 for <ltp@lists.linux.it>; Mon, 19 Oct 2026 13:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1792440169; x=1793044969; darn=lists.linux.it;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=E/SuaMclr24CjP+A3k8zkS/PeqqegeZyywiu6sx1VYpJQHO+p4N5q4B/vIPx9u8aTx
 isj/XYdIeeGAyMxiMmQZWcfvZQe8iSipHja2A7s+B6t+qAW/3Qfn9zYvBEKKH6fm9zr6
 MMKYgZacgi4c+P+TAMu6K4N2I+RGpHJDG4PLYx5Rjp+bZ2v+2o698m63z/zGOfwgbiYq
 OXoP3ksqpPmohZGCDBmhe90Sm4Kt/LqeWQzQ5myaeN6vJijYku/ylhEjnCTl+JJuNUEo
 VYJVSyCK9+BBqXTUU7xxkIkLC2kiDsiGjjU8JyXu2Ys9TRIHq9STe+OPgLKs9ViIxxFV
 gJRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792440169; x=1793044969;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DcHkyqFXT1xe36fvKxDKnxC6Rfqa1aykIxuEQiZgWLA=;
 b=Ma8zoyO7uqCZpiD04YwU+h1IPM6OEl+qqFKUG6y3/64sDb0zQ8N2aqlkx7ivTthmpL
 gpM9I8PomZUDrjQKL6FU4BwTR7w5vQow1FwO3ewAeiLQ+o4ANF1e156g+uKa2KLpUE91
 1H6kbBPCLY2Ef55P7FxKOv3AB7zp1P0YDgn3NWHExuAtjd9KCNqYWAzZUi7tCpLiH01U
 by3QN4o7AmMyzj6rQIFbEvFrsZmWq8Vr+FlXB3lg+Xe8Wy2XyHFUX6GPwpDhVGQqCm9K
 V32RX8M9Rz5Lw2rgsWSb1dn6yFg9kwnM3yRzu7FwaUNUVC8kB+EFZtnGoeu4hapPDfA6
 vA0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBw0vPQ2v/K+KCFN/PXNag6samie3UTylxNICO3vK29rfSZIDCPAX9VpW7Z8rrPoaQA6zPw=@lists.linux.it
X-Gm-Message-State: AFq9FYIrFMwZikIceR1estgg7OsDDBlWMWehgqNFH6xpKyYUYTachnUy
 svwcML5CSoZno0NM/kQms4Tsl545MG9BQar5A874M7n/0UILwLXiCLsB/sYrpjUUA7k8oP9OSG0
 /1T6D4Fw=
X-Gm-Gg: AYBFou2ctNFkJvzCULl4KjNfjX9fQBFMOGhMzrAG0P+xHvV8RREm/3tlgjw3FGed21a
 /NkuAcdKm1dt+7gUsgdYPGZvkt6Xd+q5xbeppwa6KefSgMS6Mk1VLCt9/EyoKr87WlR1Ku1fGCT
 cbGYyRyldhUkZR+JxILsjimorvWCnI6lkhlkUgTw+I+h9GikF3yJwG94G+ShBnUj/f3l1/idb78
 3WH4Ruuu1AwZf9kLfQmMicq36Ms+4TJnO+74djTkjOEYnDKioWRiKSm86UkYtGo0TmamLUEiX5h
 fGzCiCMJ5beQjq3lVUVDzIoNOhmwTrd9Hf6Mz5d/DRQHtf09QTJscEnTOKNNtcohACAKr3+qPHx
 uNBGp6vSwvvv28n1OxchyD4Ljf205Ub3EDM6TRV81qtw6KpEm0qPv1clATdTL+KKkG6iJ+4CvUF
 6/A2WdBD9DfVUXMEBs1c6pGmBLxpJNGYhJQ9fvPhWYPe6DK5qd95RnEACBkGHH4z9tXJsFurlWQ
 Lyeey9Hv+Nbmz1I
X-Received: by 2002:a05:6000:4021:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e0c845d7amr16108092f8f.14.1792440168610; 
 Mon, 19 Oct 2026 13:02:48 -0700 (PDT)
Received: from [192.168.1.109] ([176.114.240.8])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e1d80f9cdsm1008084f8f.11.2026.10.19.13.02.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 13:02:48 -0700 (PDT)
Message-ID: <b937c228-12bd-423e-adf2-5dbf62a8c7c7@suse.com>
Date: Mon, 19 Oct 2026 22:02:47 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wake Liu <wakel@google.com>, ltp@lists.linux.it
References: <20261014093618.1475191-1-wakel@google.com>
 <20261019132621.3943362-1-wakel@google.com>
Content-Language: en-US
In-Reply-To: <20261019132621.3943362-1-wakel@google.com>
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] swapon04: Report TCONF when SELinux denies
 loop device I/O
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Avinesh Kumar via ltp <ltp@lists.linux.it>
Reply-To: Avinesh Kumar <avinesh.kumar@suse.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

Reviewed-by: Avinesh Kumar <avinesh.kumar@suse.com>

Regards,
Avinesh


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
