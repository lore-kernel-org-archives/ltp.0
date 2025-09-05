Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0B6DCA1015
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 08:12:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1757059969; h=date : to :
 message-id : references : mime-version : in-reply-to : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=i2/GnImdOYZpnNv/IBpf+jR84eoPwAUoJVUSbyXSGLI=;
 b=DB/qETV1yzILoLfhg8lwbhcxs9oTyx5vRY/MMOwoW3PGQ5HCk7MA49cGXwiP+zuctZOzT
 h7IbExRM7/6uDYGnjYJFW9YgpCbOa4YbbA0NkF/0Bc/KM6FvQvJHLg3yVFKGGvZ2yj2TNGf
 l8ek/XHuqpQVV3mmL1XNQTeD0l98WRM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5DAF73CD4DF
	for <ltp@archiver.kernel.org>; Fri,  5 Sep 2025 10:12:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5136E3CAC22
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 10:12:28 +0200 (CEST)
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com
 [IPv6:2a00:1450:4864:20::636])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id BDB8B6009E6
 for <ltp@lists.linux.it>; Fri,  5 Sep 2025 10:12:27 +0200 (CEST)
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-b0473327e70so321153366b.3
 for <ltp@lists.linux.it>; Fri, 05 Sep 2025 01:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1757059947; x=1757664747; darn=lists.linux.it;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=x6m83jcsEcmv/jrG/S3yC08WDOXh+CIrui99HH8+pwk=;
 b=GXtZ5vw99GHQooj++sbSV2wYDLZ18jQbUix57Cj7u0UBGg6Z2zgu714QJQu8u4ouTY
 YNb+AAiP1v1/HR+RgG42WgHOSmPwd/Q7RNCWRhmMEnW0syAMK2gFFFk2qpSwamvSX2Nz
 IrYmwjLuWUpJPfzyNqVdY6xWPbe0k3HaYmJBml+yi2iLwPpvIH8+Ea5SVR7FWALR4IWi
 JmLdWDIc8VABT8uWzKzr0UM5J5fu1JhhdXb9iyAq0oL9woxXWcM8Lok3pa+uadlZ7mQ2
 QD+FKiwjWie4Mv8i+T+65UUG5Tgp48h9q3tYmxVKPExMdqbFFWmA2WqQFdAtPgmAwv5H
 IqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757059947; x=1757664747;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=x6m83jcsEcmv/jrG/S3yC08WDOXh+CIrui99HH8+pwk=;
 b=d9jmNOs97OYgV34NsRS9BSB1C4E6+POmp35i/BQltv0TIC2EE/Ogn0uLpAHbfvnRmA
 nGpmT0vfLCwkridW5RrT1dcNOS4wT1t4Y+dtOu7WCE7UYCrzpifj8NrVoWvWnyzMnVsA
 +OPUztNOiAOx/N0Y2RoH/3OO7Yu0lPqpXcNJOfxTyhkFU+bhIcO3zl7JKrKevyJekwGm
 SQsBAbscKyZIiXfDW9Wj+enThu7BGqCFuw0dRRpbViLK9ZY7JNqd3SX04JS2iqhDF+nA
 zwnzSHQnKMp3PEVTL3EKOD2ILHb+x45sbyQYQw8ltsMO/rXsAoMJj1TxHJ2rOYKKBrX/
 EKRA==
X-Gm-Message-State: AOJu0Yxyhd4EP32k2lCesFReheKoKRNwo12LK3KDHIqi8Q+XRq8f92JJ
 9vbS87/RcbEt+H5igHwuRmtMt1mBS6kI6qY0F3vOY8P1oNxgVVWwA7SJMCZik6hU9TTPVhmmHQ5
 g+Wrk5g==
X-Gm-Gg: ASbGnct1hau6c1CPvYlkeRH/+DtlQkAuRrxnbQ4v7+YU/9LWeGyGR+eNokB7us+WXC9
 UPD9cztfpZXJelEYGXghXLB+emmqdu9i3p4IpsGOkKjffMx/rkkZqSA1hx2QUfBpcZRqlgj/mVy
 iN0nNowwZZEGhl3bIm08VRsOoc+eUKU3b5f89tSqzO+SO1tQyO2zp5mI33hDmbTGPmDRQyugISO
 oBDpQohY38AXbxLOrPJ9TBMWhkCjbKoYkyk3ztXXOlF6+7BcI+1CPAD91lzHuz8HUOmXSb3fxWh
 OdxjVOF64CqJUc5ge/yjZe3aOoRXM/hvHaaL9bxkkH6Jquvs4qwiZvtAr7IgdkU+/L7PpHiKeHh
 IggL+M5iJi8IFOzr+1BAHhzoaYMdxQuz3kXX17yMcz5o=
X-Google-Smtp-Source: AGHT+IF6EZwfjLF8FkT8LpfOAgrcN+RgTCa5IZU//OE/73N3Nj7ASVys34X2/1HqqgV4X11KwWGBSw==
X-Received: by 2002:a17:907:9703:b0:b04:9acf:46cd with SMTP id
 a640c23a62f3a-b049acf49f5mr137875766b.42.1757059947104; 
 Fri, 05 Sep 2025 01:12:27 -0700 (PDT)
Received: from localhost ([2a07:de40:b240:0:2ad6:ed42:2ad6:ed42])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b02152cc1b8sm1509063766b.36.2025.09.05.01.12.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 01:12:26 -0700 (PDT)
Date: Fri, 5 Sep 2025 08:12:25 +0000
To: Cyril Hrubis <chrubis@suse.cz>
Message-ID: <aLqbaZKE2TNvHSgK@localhost>
References: <aLVzVyaVhr4IHkyd@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aLVzVyaVhr4IHkyd@yuki.lan>
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

On Mon, Sep 01, 2025 at 12:20:07PM +0200, Cyril Hrubis wrote:
> Hi!
> It's about the time we start to prepare for the September release. As
> usuall I will go over the patches in the patchwork in the next week or
> two. If there is something that you think should be part of the release,
> please point it out so that I can have a look ASAP.
I would like add fix for current openqa failed case cpuset02. Futher
more fix is simple and should not trigger side effect.
https://patchwork.ozlabs.org/project/ltp/cover/20250904015920.7432-1-wegao@suse.com/
Thanks.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz
> 
> -- 
> Mailing list info: https://lists.linux.it/listinfo/ltp

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
