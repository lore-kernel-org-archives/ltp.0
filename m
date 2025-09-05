Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7F50CA1012
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 02:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757038260; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=t7flszyyg4kb0fZWeQnFSDMn+0Wvjs/hNKIR9I9pvd0=;
 b=hRCnhjsoqqUVl9vH0cNFkku82WtFZwSt/lvIt42Pc16nBkC7Rc89pZZGUmwiq8IgAyyz7
 XOuXbX0lVxtN9vJHWgWuqtJmHTkRkBgfh80miENtYpwI3HOnDa9TIvdHPx2tVHTL7zFfupq
 xhm0GymuWutRWLJ1aeYisah1PEbAS+w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E74E83CD4CA
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 04:11:00 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75C6B3C9EB8
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 04:10:39 +0200 (CEST)
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 6D08A600057
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 04:10:38 +0200 (CEST)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6188b5ae1e8so2247302a12.0
 for <ltp@lists.linux.it>; Thu, 04 Sep 2025 19:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757038238; x=1757643038; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=uXnfoLLQH1rInKZE9V1QUMITOPeYSbO8Fi6i2Blgn8Y=;
 b=cSnIaQVlEiKlqW4l62obORMh17VLjPJoJNjms+Tk+BsNYbjg+QRsVxMfpMGVLWCE1O
 FvGhLW3O7l5ZjOf/IYYtahKOEtpB9jAtrTWo0wx1nwwLwfXhvmgnJQBNKiKpEpFJOZgR
 ttdf4T08J+wvOXKSIJsFM350C47i8b72yCw4qZQdDoWv8FldYTyazVX3T0E505wQOLiz
 szfJroHeo/bih8P/2Bzwrf/z5JXIrLLZDXNR91KgkTKR37AnxQnaVg9AwIfEaosZfMSf
 s60TRX5VMr+9zOeprVGmmjdy0UU/rxYfMh/Wj6qv7B8yVQyPCnTf47hshlQG3CoyxVhu
 cAZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757038238; x=1757643038;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uXnfoLLQH1rInKZE9V1QUMITOPeYSbO8Fi6i2Blgn8Y=;
 b=SA+Z1ExQqyvtKegbDZtdTTbjGesuFe7HijJd1l9wVwWUy48m+LQ3OPyLJrsrSSG0p9
 /LJ5u5j7FjeUIid2NezwamHs9KWF81CPKSNUCIgqKME7JjsEpcB/XdpN7btLFl/3qjC1
 tekx90Mnx9Q+tz6Np7vy9kjrhcSNKI+CM/m7LE8QeQLrpZ4iYcwuOEKb1NN+fLzQfgnA
 9e7kUFQBVuPWxRaCc2eRwt6dsq7p5yGrzYbSi72esjNEZrQf50pKJgysppzkEI0Ohr+G
 hKDHlmvku5YBLP7qxmKZHljhJY6sN5OEtD+WPXcMHLKvP7LLPOnLcxJm0NBN14wcMkUb
 GvPQ==
X-Gm-Message-State: AOJu0Ywpz/A+h2z7lsKE1roqSRxvPIbrCepZjJszTi3xvbSinjw0Ubxg
 ShMBGqZd8UsiDqqdf9DMzfJOlw5SphqNzJu4MuOQr+fooeZunLhz9XC4BxxAapJjsA==
X-Gm-Gg: ASbGncs/Zb4/fuDCg6Vjwy2PqCcmohteut3qphIe8RcMG75vv7BjrThc/uhTa5w2PCY
 FZAXgSkK9XLJQk80e8zyqJAUcrqsibkoopQVnenL5cr9m9BgAYCz6zI8/tYOwi5RRqaeYPYsHNb
 0KLAPldZt+ddV19B92Diaioc/w2Qw2+UQjlkqjS02w57PEYieZU22obMfkwoGpXnBwG3nelvi9x
 sWg27Paz/6YAwDdM7L0DVFmoSQyPhhltHHlkexzzjf41zPtkE8qkM4c5v/XwUVDBxEYZ2HrRv5Q
 BsjsWDkBE7N92tkHOGX9tP6WFvqHR1faLPV3X054CSNQAK24T8I3sITZcDBoJMEyRm/cDEg/Uci
 JucT1wl3Y+MUP9XKRJpOjtpiYJ0JzejAs9mIOfYlVJ0w=
X-Google-Smtp-Source: AGHT+IFxFdMSy3ngYG2TASPG/+vFRDDrbU7ylhASRI/8vcFEsfFYTwsG0e5VWmrbsW8ScXDOoj7GAQ==
X-Received: by 2002:a17:906:6a29:b0:afe:dd76:7cd4 with SMTP id
 a640c23a62f3a-b01d97b6ab7mr2501779466b.57.1757038237780; 
 Thu, 04 Sep 2025 19:10:37 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aff0971379esm1624125166b.102.2025.09.04.19.10.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 Sep 2025 19:10:37 -0700 (PDT)
Date: Fri, 5 Sep 2025 02:10:36 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aLpGnKpwkgF-rxIM@localhost>
References: <ZQF5J0UJ25_QLwcQ@yuki>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZQF5J0UJ25_QLwcQ@yuki>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] LTP Release preparations
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

On Wed, Sep 13, 2023 at 10:56:07AM +0200, Cyril Hrubis wrote:
> Hi!
> As usuall we are supposed the release LTP at the end of the month. In
> order to get at least two weeks of pre-release testing I would like to
> freeze the git starting next week. I will try to review and merge as
> much as possible till the end of this week. If there is anything that
> you think should go into the release let me know so that I can have a
> look.
I would like add fix for current openqa failed case cpuset02. Futher
more fix is simple and should not trigger side effect.
https://patchwork.ozlabs.org/project/ltp/cover/20250904015920.7432-1-wegao@suse.com/
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
