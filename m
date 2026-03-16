Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89AE3EFCBBB
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 07:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773646746; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=/NMmMlru0YaLLymZId4andy+swUr7CRTbwIZTUz46Bc=;
 b=EkvMOchgWjmR7VRdmpcafgG94oZNCBPsktAKscVYIeaxd9ILGCrm64YScCUmP4ceEdCc0
 9ZXUiBmwCYT/eEZGlbpcGzMM7ody3oPEQhm17hy5tdtixzOCa2DbcR315ZbaNBKkPxKcBSP
 rLIsPy3moHHfp8w0cTZoZOlSkM1i7BY=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 046233E1D39
	for <ltp@archiver.kernel.org>; Mon, 16 Mar 2026 08:39:06 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 9EAA73D06EA
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 08:38:42 +0100 (CET)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D48DB600833
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 08:38:41 +0100 (CET)
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-485409ab264so29009375e9.1
 for <ltp@lists.linux.it>; Mon, 16 Mar 2026 00:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773646721; x=1774251521; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=f5x8ZcGy19cpAkb88Zd9zrxZX9Nv1WYemzgpcBnNHyY=;
 b=Lw47b/WJOtUhUMDeN+xHiR9IFuoBZYMu4i6v2wxIec56US/i1g1PEK8pQHjxaX8JVJ
 alWuSDp3EXdlHeeW/HLhWR/LrzIuwNekT++gy+at7XC4KLO8tRGhHG7LM5jBLen3CSU5
 eA42N1VqBTUd1AavQ/IakmpgM2zxuU8rRJ4UoE3MJRUhCCWBRB5sNuzIWv+++RFftEXT
 fiTDZSZ6K+AXFQTG0tXHyCulB/nFTri7Gn+skKeNzRAnN4m8e7aMS0yBnYksvdBHJ2Zh
 EeDXf1AnenHyYyrhu7ZDD1M36cCCMXaVOFXk9APKO3vh0Qf/CvfIAPbQw+fJx4tIf2qs
 BdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773646721; x=1774251521;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f5x8ZcGy19cpAkb88Zd9zrxZX9Nv1WYemzgpcBnNHyY=;
 b=YQasrj1IgFgwvYAAdowlkg2u1QXhdvjItFs6oVo2V79f7LPa8rm5NMdkmcztilfBxt
 LaM2a1udwY+m8bRRALt5+9/sQYFE4yLTXXEOgqn9GsW21QEcmvleq0EV8S19fUQOfl3B
 BZeX8vV7/OwD5ug5dnQSMaTXL+K3sDEzXq8zdpbKpXgz99bMXmHkN2Z/A/WwUtRBu3Rq
 7tRbgeNfZ2CSrtvdzm95v/mXtH5iuaRDLo+y9TZebJYVmhqjOvkv3l+ipIQSFFOi+VqR
 TvqHtclzY83fDp/sP2ObKENcVGtjak9+dOvfYoAqTbhJPm19IYuwE3CgPh7TGqc+d8Jt
 x5RQ==
X-Gm-Message-State: AOJu0Yx4YGxgnNlEzxBh1daHojwLIyvz2FHOiBqkISFq8xW3DIo1ptHh
 cbfBNOTAEXg9ZWtwaQHWzmytNSPLcE3/NEtj/smni0nlD7HQLjDq0YGO370jVQU5vmY=
X-Gm-Gg: ATEYQzwF2fE9iPwT0dqrfrd19aMRvWxzT5bb04LMUlj+CtaSaq4uBEF7WvbWVr/MEta
 UYrjLhLolvqZ9r4zkdz4kfgRv31LFBXePVdlibnM/ziIvgmiUfie5FDfZYtxjfyYE+smNdJ1h/H
 TaIJ3vq+0i/RVOMrqRxyP1KeX24IMG1BfwFJBRJ/8s+0PnedFcn+BGIP75vglNc2ASxASPbjfMT
 N4gstTCyVZHDprRtwJmqMulgMOEgsBTA8vSO0rGy/qo3/mgUZ6FfNXFwbx4QXr0Y9f2hypMDKm1
 i6ZHJo1DAQMHj+E6LBn0g79kXLk1GLf+NYPVCMOXpgjQhNiq7nGutn4RN4ujW1MlrcimXD1Tkxe
 IapiCQONXJq6I0GKZq3GkA0Mto0VT4GzOb4AxQ/Kas8oaYt37O5ih8X7zSTX+U6T+F8RIi8Nh9p
 YlW3Q+6Oq6M+fn8EfA0cSt5jiASsIAPgtDiHqHln7gJ/AX3M8k/jyF8vOIDTofO1Eroc7WbfMQl
 xDiRYvcc+dt
X-Received: by 2002:a05:600c:1395:b0:485:3e00:944a with SMTP id
 5b1f17b1804b1-48555b2c86bmr192904985e9.9.1773646721146; 
 Mon, 16 Mar 2026 00:38:41 -0700 (PDT)
Received: from localhost.localdomain (p54ad8f8a.dip0.t-ipconnect.de.
 [84.173.143.138]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856c2823afsm3185675e9.19.2026.03.16.00.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Mar 2026 00:38:40 -0700 (PDT)
Message-ID: <69b7b380.050a0220.2e2929.0639@mx.google.com>
To: "Jinseok Kim" <always.starving0@gmail.com>
In-Reply-To: <20260315072721.2083-1-always.starving0@gmail.com>
Date: Mon, 16 Mar 2026 07:38:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v5 1/2] open: remove O_DIRECTORY case (move to
 fstat test)
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

Patch doesn't apply.

Please verify CI before sending patches, otherwise they will ignored.
https://patchwork.ozlabs.org/project/ltp/list/?series=495939

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
