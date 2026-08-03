Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D83C5518E
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 10:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785753310; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=F+gOySutCRevptdEwSmbuUuqDYOSG5oeQ1KeORB9hHw=;
 b=jcogzG3FrW9wKwUuoZt2rsGOwxPCZShLJYW1UEat6cNcr9JL7T14sjbgXpwjUjmj07ebV
 Raie8CoIuzibsKd59TEx1kVb/1jhdsG1ibFDHlOWWk+GGjaGds5TfLrL0DP9QPDARyyyckX
 oOLBdyWfpE7R/8b7RAD8WNcwSiRa914=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AEFAB3CC870
	for <ltp@archiver.kernel.org>; Mon,  3 Aug 2026 12:35:10 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17A8F3CC870
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:34:49 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 88F52100022D
 for <ltp@lists.linux.it>; Mon,  3 Aug 2026 12:34:49 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49802c418b5so15584285e9.1
 for <ltp@lists.linux.it>; Mon, 03 Aug 2026 03:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785753289; x=1786358089; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=xzT7jSy67vVfBX0hGRKhK2UwjtKNz6O2OSjdMe++9VA=;
 b=MIq6mkf0jt1kktCm2mFyYBIlVFiQCpywFQI/UcnCJLSLLCtdS0SARY+r0xSA+ZZ4DP
 HiP7TDvrhSESZQquxWosO4vVgAiETzkAyyHGlOq40pMx9Xtti121jUtDVcWNBV7zYZTq
 LO29ZTXYN9kXDLTqrqag+f4qtIzhaFJzIwl7zvxyDlagciXqG5VTHBOx6mHG5/PSreTr
 WjoCdGhps56WBIAYMDX7l6juYkLqlHa8XR8haj1+HjuK1YuNtQW/FbkR3eBXwg9yNhco
 pLU2YoJVAM0xIEbD94snyWs+rn1duX31689xzSwyKKVfBOXGAmkw3YVXluszFKMyn6Lq
 oicw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785753289; x=1786358089;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xzT7jSy67vVfBX0hGRKhK2UwjtKNz6O2OSjdMe++9VA=;
 b=jpfTA+OA9gZibGjixz+FgpELQKMbxA+uZstwYpW7UTW25HDSt0HSCPlWA7VgFrLbDf
 RkjUzFZqxCVBcwN6z8R+mEN6ffnNmb26ciV3sUfx68XqKcoED3majlGXtBJYcG5G+mRF
 gbeW1owr+VG3uDmo52q82uZqS9gDqTwWi3s2Udi1J6sNOWemeqA3ZT9BGsc8Pw6I9FYw
 xZnQ+ivyAa/pUvItBsdgeSCyM4mf2RQ8X3QYBG/FqT5v4idHEwzFA9NJ9TA/dcS0sWAU
 oSrU0eZDtdrHEwoMF/K2ProC8we1Bx9uSztiZubYB/ppUjbHshj1K1jmFRtZ03aWIsvd
 vApw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoUkeyEN2mWeXasG+oYe2xe1F3tCL3GVkF91Y3NPq1FDITR9+hP+mPlGIeDNUAIzHYRhxc=@lists.linux.it
X-Gm-Message-State: AOJu0YyWkpcEQlKLRUt/iUhpc+f0Sy+tpCdvaDtQVovWJn9iMQKZ07Zu
 i+4Oxc8PDZkrjcSNqS9a+gY3YmTx33r3ZWtSy54lG4d54x1eiWVnGsb2vq5FpRUeh9c=
X-Gm-Gg: AR+sD13HEebjXq8x5WxirxeAGe/InrmCMum6WbOuLoGD2B7eNavG4rVeG0nvjnNGVSR
 rlmPyLT6Eq9jwXywRP9/SiMXfh9GHQ9IB3V96Qk/iswy+NwRn8EQebW1oOSY+yqOg6UDNTb4M2r
 Rw4VzRS5xcuee6DrhgQrdVijxPlIupUZjimjGuTY9YCuvVGLSSh+6TzuLHNeCr8gAlElN3ny6Nk
 8MVn5H3E1j6BPO/F/PbVpC1ewplSry2+rJGqp0jeDIbO7nx0qtp6u97FA5cyoXg228XYlQ9OybN
 Z7GgcJn3RImCt+0C2+SSQod45FzNmoGKT8y2xZH9Bu15uZW0IU6dvfzWNAXgn+Z9TO2GFAU5eoB
 qYt9WiqHHn5pRlP18TTQPWcI7u0XUZb8lqcbnRKHOptpLVtlXotFSI7UoaWr2s6nbEWWxRgkMeD
 u7Y4Wa5j6jKaXDfxpmgBxk1sNq3eoLA2AeIxZqD2QkRP8tat6ihh3A9hGfXkrSBFmEV/m2qwYoV
 m/K54NvkpTHLg0f8buyNJlyg8Ck/aLPsgvQmgPsIE/27A+T+6YEHWNO69+yNsLehN7abVyvG3fg
 0tUmGA==
X-Received: by 2002:a05:600c:34d1:b0:495:7561:a9ed with SMTP id
 5b1f17b1804b1-4980c679d9dmr231221275e9.17.1785753288917; 
 Mon, 03 Aug 2026 03:34:48 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd456a6besm30171823f8f.22.2026.08.03.03.34.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 03:34:48 -0700 (PDT)
Message-ID: <6a706ec8.9099b29d.2d8c98.bbf9@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260803102407.GB217746@pevik>
Date: Mon, 03 Aug 2026 10:34:47 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Switch to patchwork.kernel.org
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

> FYI we already have history in git as an public-inbox [6]:
> git clone https://lore.kernel.org/ltp/

+1

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
