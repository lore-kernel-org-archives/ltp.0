Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2168FC5475B
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 10:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1709462028; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=JoHVRX+5/FlKOWkzPK8O37BLI7FKfZ0VDBxGeHDEOXk=;
 b=VpRSC+GuXCVjwiUozAS29CrLC8lv4AooF7xVlNQ6ykpcLUIIDmMLwzpYxjdZtnZy0ChY2
 Zq68YX6MEsiG+Xan2YxzMiA8ZkQO1FXqiKCaHhBdxkqQXxfjRdIno7eAj9VVIpsL3Rlf/7Z
 vzHfUZR3lfX6HyTSMuSyCwu35fFJuEg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 7FE4B3CE710
	for <ltp@archiver.kernel.org>; Sun,  3 Mar 2024 11:33:48 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9AB0C3CD859
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 11:33:27 +0100 (CET)
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com
 [IPv6:2a00:1450:4864:20::52c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 919FF200DB3
 for <ltp@lists.linux.it>; Sun,  3 Mar 2024 11:33:26 +0100 (CET)
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-565d1656c12so6217896a12.1
 for <ltp@lists.linux.it>; Sun, 03 Mar 2024 02:33:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1709462006; x=1710066806; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=/cbsNBTD841l2x2soFNa5FdOVsbf9cec97CdOdTGKIo=;
 b=LGtdVhFRdMftY6NrqPewlpTGzdM9dZfE7gOeNybPJ5qEWKrlzGP6H6nIG0LQUXOQ/b
 ZSoIxB04W+tEZ3gpeUPLj1nUMOkld+3bQrKiseG0ggdtyMDn1ApbriYLywp/DC5tA0sZ
 uFBqtm7G8l7DgXOTJQTK7zgMXdEmZe0Or9WflOM+VgqQX0Jl4Us3QNzoLDj2+9KdIE6y
 JZBH3SK1nqXuUKjljN+QPZArFvD0F27a++N5zK7aHbein7Vhz5XmQlvhGB/n2tDRD+HK
 X7hkm5Qw65ApMqSJV/Dx6iPxX8bKZOy5sRJDFybpQkhXZB0WYoMDCBvD5prBM7C3dnPw
 ZXLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709462006; x=1710066806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/cbsNBTD841l2x2soFNa5FdOVsbf9cec97CdOdTGKIo=;
 b=vbiiMp+Rhu5Z9kQa2Sev9Ft8QV9lqjG3fVRv2HlBpuDd4Ucbqrivobr+RJQ8dlNP8u
 SKGuvT/vW4oPE76lyj33gqEi32ICKxcCkXECwL9fssk7wBLtFrF2TOWObKD6WB1HAwyq
 kUeRu1IeF4nJ2gcreEEakEZMnjxlG8XIty0CeR1gnJdav+Nwp0UTO0ZzCYipe9bosfnN
 QXeloDLXqIld10OJBnjvsw78HFr8w8qx3zOKMEqTVTI1eUdhF6GkqMi4Rn8aarig5nyh
 XjQk4kLsbO0Lv82YTf/QU4qXUpiaq+WMsq4ymEIgN2goX+6vnU+B4SwB5hEqAW7FqmKZ
 RY/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAvwBovr/y7iHpPuORm5CQE2TaVVfnT0ncewkSAyC6TA8B7lTCzGdKxjR9A0TkOaaZR9VBYIQZbY5l8C24r2gJShw=
X-Gm-Message-State: AOJu0YyHAwYcSfXhnw3BvSfQ1MwN7MsAyyGk62HDCsqIp+38AEceyhJv
 KsrLRke2AqvBY7oMPBarschywz4Ut6Y9GAeGTYSQz0ELd+y/7Ax2OKtdGeX7SA==
X-Google-Smtp-Source: AGHT+IHxW6bGQ+KBPfjVYKqBbzVWmZQR+NPoYEfF5tumUIBZQTVtcQrgdRK1AxMz2IKnvNeW2dE3Hg==
X-Received: by 2002:a05:6402:4312:b0:567:e0e:dda5 with SMTP id
 m18-20020a056402431200b005670e0edda5mr3168587edc.17.1709462006033; 
 Sun, 03 Mar 2024 02:33:26 -0800 (PST)
Received: from wegao.170.138.163 ([81.95.8.245])
 by smtp.gmail.com with ESMTPSA id
 ef12-20020a05640228cc00b005671d898b32sm882008edb.23.2024.03.03.02.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 03 Mar 2024 02:33:25 -0800 (PST)
Date: Sun, 3 Mar 2024 05:33:19 -0500
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <ZeRR736pisSO1r9O@wegao.170.138.163>
References: <20240301102347.3035546-1-liwang@redhat.com>
 <20240301115131.GC1661970@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240301115131.GC1661970@pevik>
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
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

On Fri, Mar 01, 2024 at 12:51:31PM +0100, Petr Vorel wrote:
> Hi Li, Wei,
> 
> > This is to resolve the permission issue when creating
> > a new subdir in the cgroup, in case of system's default
> > umask is 0077, this will trigger issues for LTP case.
> 
> >  cgroup_core01.c will report following error msg:
> >  cgroup_core01.c:50: TBROK: openat(21</sys/fs/cgroup/memory/ltp/test-3519/child_b>, 'tasks', 2, 0): EACCES (13)
> 
> Reviewed-by: Petr Vorel <pvorel@suse.cz>
> 
> Setting this on single place which *should* fix problems, but still not affect
> whole LTP API looks good to me. BTW there were more tests which needed it,
> e.g. testcases/kernel/syscalls/statx/statx07.c
> https://patchwork.ozlabs.org/project/ltp/patch/20240222031018.12281-3-wegao@suse.com/
> 
Send new patch for stat07:
https://patchwork.ozlabs.org/project/ltp/patch/20240303103105.13401-1-wegao@suse.com/

> Therefore this solves just some problems.
> 
> Kind regards,
> Petr
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
