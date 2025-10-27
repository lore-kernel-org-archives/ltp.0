Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E3B0CCF9E0
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 15:19:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 98AA03C66C5
	for <ltp@archiver.kernel.org>; Mon, 27 Oct 2025 16:19:49 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 248223C0756
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 16:19:34 +0100 (CET)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AFB2F6002C3
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 16:19:33 +0100 (CET)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-475dd54d7cdso7412475e9.1
 for <ltp@lists.linux.it>; Mon, 27 Oct 2025 08:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761578373; x=1762183173; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ql6lBfCs4nBElwWY5m0iKqMZNUGYMiTmOd/bYwvhujQ=;
 b=Q/PBFhWXGrUmRauEm4jKVFRimBaoX2bv5pC7F3M1v3Dv2FWuciGkJq1nPltdpvCHhM
 7yev8KUfRneto+Ym9ZPu05jUv+6a3lfPfr03yicNcEcD3jOl/YXOHgVT+lXv4BzGG/0B
 35gjO9XjBN7U5OWhQ+Z4UOcK0XtuFVTy3c5Migpe0EYahhlbdOnZhO6P1LyHPkiWIwx0
 DbW83IxPrzk97LBL0emHWof8ebMrYJV4w9psARmybt2JtPo57RMMs2AVkQK+IX1N8UDh
 RJbfI81rBK21wH03FU443kxNErjmL4VuuNboqNw51DAoVnx20sRmINREpPTOGcF3x+A9
 i5Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761578373; x=1762183173;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ql6lBfCs4nBElwWY5m0iKqMZNUGYMiTmOd/bYwvhujQ=;
 b=OWckHwlzFqJ6Yzu8dU2sPJ7MLQqwv+BhUiyr9tmSLxuJUiRkYA+evTYGiwQcUTvlXn
 fW/KhBBdlOOuIQErSJFl8sUYwYkb2Rizyr+PMxG7a1DaeA6MDWo9gMxdA7GkCimrnIvJ
 QBr66uEQni/n73Uhfptmx8XpWZDECZWX0uxeFio+lh66h8CammHh5MumtjlCpqa8GiVD
 NUij61luUjf3+FQG0AXIM1IHYUGnWL6ahwEWzp/vAk9lMSsVN41neVSzIchk+c8LfD7G
 jAK3xxfIUUFVrjiHjec6iDpNU7AZAJgJL3scEfBXPTqVrB44CtgHJtJOuvcVkKEmhyvf
 Zp+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCW1fPYPBQ0JXKIh5osAOdGey30kXSjnNdpU8ln6E4mExXNDze3d+pP46g+PR0gnAvKTnaw=@lists.linux.it
X-Gm-Message-State: AOJu0YwO2BqJ0rDBYL0WVRWMBqNAmY2f+EtuKfN6OrKEO5sA5YZaP3zy
 5zQ1rqnoiewOPfKsmotQRelT5iroQKhQURQiqOu8o8nmcf+HMdGXQloHruf9P31M/8s=
X-Gm-Gg: ASbGncvgmRiIO1o2Rxyi5rKiDk+Aw19Zp+VqR4H47GGjvuyZc0l7xcbzJHhFHa+aw5L
 i23raoGyIgSggmy9St/K4sVZLqMFvvE7sJh0GYgbG11kZnCkOupogU2eGu+aBNkAecNCNEdT+iV
 kba69TJMY5lOFlmGZDTQQOpSj5qBgtYb4TA0icPOPe2QYowVGEoSa6MrVQcYBYfBAJmNZhC2yi6
 ycSraj1M7Trxl8Y5PtHGAPKmI6wZor0OHrAxnrockgrOM7NkRutsgKqrCiSA4wI0r2YdarEtoRM
 k89p8bG/2jVu0qbfcwHzIG0byM9Eded+WNXxWNi5eec7GxXwgCp5qI+s6pKv9pbkQbLGV9wolXr
 8Sp/5aFbBb1hJoQzOtz8GoSvVKKbpouxMs6tT83DAv/TD/u9RdlBFgq6BXSNN3blnOk28B74fr7
 ryv93qdQ==
X-Google-Smtp-Source: AGHT+IGddl4FAseMUcpwO2WqW8WockRC6y/TI0Lkt2pyLA88MZl2pv9hUda9A8kdcBrKvEOEGAjcpg==
X-Received: by 2002:a05:600c:8710:b0:46e:4c67:ff17 with SMTP id
 5b1f17b1804b1-47717dfe5b1mr298565e9.14.1761578372775; 
 Mon, 27 Oct 2025 08:19:32 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 5b1f17b1804b1-475dd494d5csm145190345e9.9.2025.10.27.08.19.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Oct 2025 08:19:32 -0700 (PDT)
Date: Mon, 27 Oct 2025 18:19:28 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aP-NgESHEFgnpD_l@stanley.mountain>
References: <20251024125613.2340799-1-anders.roxell@linaro.org>
 <20251024133035.GA590258@pevik> <aPu2lqXN8G7h4e7D@stanley.mountain>
 <aP85jhbSvlYxeOiQ@rei>
 <CADYN=9JgKUWnqgJMe2KRWmtd=wctWwKKYr=abHO9e2S5u4c1qQ@mail.gmail.com>
 <aP-LmrecdhvHTLAc@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aP-LmrecdhvHTLAc@yuki.lan>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] file_attr02: Add XFS kernel config requirement
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
Cc: ltp@lists.linux.it, benjamin.copeland@linaro.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On Mon, Oct 27, 2025 at 04:11:22PM +0100, Cyril Hrubis wrote:
> Hi!
> > Indeed, this fixed the issue I tried it, for both file_attr02 and file_attr03.
> > 
> > Will you create a patch or do you want me to create one?
> 
> Just send the patch with your Tested-by: thanks.
> 

Since you're the author we would need your Signed-off-by as well.

regards,
dan carpenter


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
