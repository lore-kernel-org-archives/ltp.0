Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 337E4606A320
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=FyOdv9Oz;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=FU0m2uov
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794189210; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=kN3+OcandWPLPBqWyAbCU9YniH0jkhBAliWaoDlDmHY=;
 b=FyOdv9OzxzOPHxjVGf+Ye4pexVekkfm3nDUMmez9hCQfg0b8Iiu3A4oWAEhZkoEflpl4j
 8xa9HWKEj6GwFxR19+CODCWO0DbGppK9SSc67r6l7OD5s0rMjIRv1F9OGiOXOpNsszVtxUd
 nnl2gqyPkNGklVgk0X8lqssAfu78jL8=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0EFA63E1565
	for <ltp@archiver.kernel.org>; Mon,  9 Nov 2026 02:53:30 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B08273C1904
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 02:53:08 +0100 (CET)
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 5A93E140024E
 for <ltp@lists.linux.it>; Mon,  9 Nov 2026 02:53:07 +0100 (CET)
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-49d05d51553so2105755e9.2
 for <ltp@lists.linux.it>; Sun, 08 Nov 2026 17:53:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1794189187; x=1794793987; darn=lists.linux.it;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=B63GPfK1cvLBxWlr2CvEcQWu4D46gcT6dTSKma8LQAc=;
 b=FU0m2uovCkF7bhJgdS8xeMZ5jHImbCR6K/S+8KgCdcmelgXwCTeHZ6frW8fn0/IwsD
 r4vcAEL8JAWp9hdwDzcpJWFVZQRjhKBeJB9E618oFuzQnxzL/I++TVJsHJ1RAIIdjqES
 c2Co/wQmY2ArPTMv3R5pmiVt38gGJJp+f2l3LC5zFstlTwuIAhI9W2e17YzFUmZ5nCxQ
 cle/VplMz+sch4IABuxKjya22MEHR0g48I8pwW+tKXCrQgzK1hacRZXmry1HbUYqL2VB
 69DRPwf/suFTjnlUmLOL6Q4zjDXM4ZQ4FjSBTz+gkwY8zBLJki2jGJKm8OnSUduSWdxg
 ozfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794189187; x=1794793987;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=B63GPfK1cvLBxWlr2CvEcQWu4D46gcT6dTSKma8LQAc=;
 b=YXuP7TqOyj02uXKhVuGnbcJJO31tm45JpX39Qps9K74Fnnvb9LA7r7vK+5QmFgSsdF
 +4q+kp2wsE8eDDmSm9GnWyT/tbGUWZtOr4kJ9/PEcWKCKXHkaf0lId+c/cX8V2fLR0MT
 zy8PovrkhiX+mhrNrGVcSvv3KSWmLly6vFxuBMVUUfRPw5Ga69ACZf288ak1LBAw3SGq
 Zzrf2fEDjD3+DvLDlx6e3S3x/Ahy/N/fQiguil3JiEiC3qxazPWs+0aDYlYdlPCg78kY
 4vfsOO/BlR3Akv8Z2peoDYSnUNrD6Kq7jk9S9cW/E9AvQFN7GZP99wu80eR0zl2KEQGC
 t5hA==
X-Gm-Message-State: APuU4Z9mQOiSFIJ7a6FkMZ62ULgXgQ8tFWkzsbI/h6eFrNA41u4zRwEs
 lZIC2pPA5LA0sJbSYqDF0wAK/Dc4jIysNb5wA6bESVFVI3Qi3nWgKd2aYhu43rkypg==
X-Gm-Gg: AYBFou1s7TtIKMBZvJXvlgXaq46GBmR+HvHj4oStwuwv5LG2ARlSecegdtVAICY4fBX
 k3hobMA+87FMaZMgUxQtq3lJJghoblYpCIG8rYL5IbtTexBXqJwv8rPzP9r0dj/0wxsrF7F/5hm
 blbyAk9E9epEZbJ3ZuLAYN3ntBiep95iDi9b7zi8u0H/o8t2QJEUEK8iFkGbEvFry5q6sQ7lC8i
 nMsHIXUkGPftCvr0sVOtkFBKnrfyt6JVsOyOIHsCX67Gdo9o9g7s59HP4GcqsEtw05rCz1WovuF
 pRV6DFedGf5UCXq4zapXveowKgkRRY7RfX3uyZjZJejj202MqVXkShTIgsdLwFAHGyMiQD2n3Aw
 m+ZkRWMnJN9euNX8c8lqC2u0FGN96bI4Bt7Xd5W9uUVToYTaoYBaZCI9uxxW2Prruymon+qXLTt
 yRqQjg6r1jc3nWlia5RiA7mivVN7KnKpsTwKLkJqxfl9TQKq3MThs+QrELtgF9koYmskWMRUc8/
 BfVvuW1+v3KSB2D1PcXsoLjQBIVPvtjMk/AiYppdYbF3O0ig5AJPonYomEdIXMpMYQ1HwLWvxU9
 RNc5XAW47kDSvnB0x+crZ1VJbHkqbZEYQvRTf8885p9x2gXcdYt9qS8wcnXg9HZgbWyikqztzOZ
 cZ2l9U9OfIshqc37aqJZFKc22Pw==
X-Received: by 2002:a05:600c:4f52:b0:4a1:dadf:9876 with SMTP id
 5b1f17b1804b1-4b963c6e061mr60446595e9.23.1794189186654; 
 Sun, 08 Nov 2026 17:53:06 -0800 (PST)
Received: from autotest-wegao.qe.prg2.suse.org
 ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-49597371cc4sm6708607f8f.36.2026.11.08.17.53.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 08 Nov 2026 17:53:06 -0800 (PST)
Date: Mon, 9 Nov 2026 01:53:04 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <avEngNz6aHO73w7W@autotest-wegao.qe.prg2.suse.org>
References: <20260929022340.524-1-wegao@suse.com>
 <20260930035332.3360-1-wegao@suse.com>
 <20260930035332.3360-2-wegao@suse.com> <autSV7Dh55A_Vz5Q@yuki.lan>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <autSV7Dh55A_Vz5Q@yuki.lan>
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] memcontrol: Add bind_to_current_cpu()
 helper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wei Gao via ltp <ltp@lists.linux.it>
Reply-To: Wei Gao <wegao@suse.com>
Cc: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Wed, Nov 04, 2026 at 04:42:15PM +0100, Cyril Hrubis wrote:
> Hi!
> We have this piece of code in getrusage03.c as well, so I suppose that
> we should add this to the include/tst_cpu.h in order to make the
> function available for all tests.
getrusage03.c does not have any CPU binding operation, i guess you mean 
perf_event_open02.c which contains the exact identical bind_to_current_cpu() 
function?
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
