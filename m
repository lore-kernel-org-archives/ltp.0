Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA560C61DBD
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 08:45:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787733929; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=YBhx41zK2dGFd3BNQxBD0diSGyK5/tHRM/en8/gczjta7DEEEAl42NYC8CuLVMvdnprF+
 OZ6PcG9w3G5pifmgRkw5z231jqnzUcyPfuxvAzovo5K672tarznwdR5/7birrle3Wq6EuTz
 hpmo17glVgChh2YZl9UASeYKdpr9Dew=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 029C43CC251
	for <ltp@archiver.kernel.org>; Wed, 26 Aug 2026 10:45:29 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 48B363C2861
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 10:45:09 +0200 (CEST)
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com
 [IPv6:2a00:1450:4864:20::633])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 9905E1A00CC4
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 10:45:08 +0200 (CEST)
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so95019966b.0
 for <ltp@lists.linux.it>; Wed, 26 Aug 2026 01:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787733908; x=1788338708; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=eCvmtrdS0uxnU7vcqqisPdyGwD9MFZn0mnopwFSNg6zehdlNbKDU3vOuulxmB6ewg8
 ybBz9bPw+1u3t4srsUHJm/yEJbUP5DeqRnva/ArZFWwHm+nyjjXXvowXbWsoHOl3iDM+
 GaDCjg7FPxcQTtCNjRS4ah0KOSVR6Uxh4BP6be24mcbLBRLBFXPAb3cT5xePdGtVDqKq
 UEaJ+oFTHcYoCMOudU62Li11/3ywxhpRSk0MbsNg4tx+iK++WMaMybHzjNbsMpECM/2v
 pDmVxx4GlODk3Zw2Xo2jH3YpnqXEXMhObQoEwbuTHcqMhFmHKEuztlsLN8sSCKF6U98n
 5vMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787733908; x=1788338708;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=SM4nghOEnfcvPS2aZh6MiEvIGbKLkpUsGF+HLfzezXi8Dkb1frTaaeVzbxlG/BxuIq
 luNnJ1Pk/+EjdkbXZe/zm0eubSMC/kPZER3VBEqH+ecCNJsfVfrx4leqne5Lpbt+czoE
 mPAvUGrCsXhmy23iFQcxifAUBHGYAJtFkPCPBVncpZtsCc2pDKegeyIUFL41Ku2poRyJ
 bkMM3P9lt06kX4/fw7ecmybuIoemOEVKEMVXS575aAsphG295IWszB7/kkD7IgMiabWx
 ouDokke7qHCjAungsR0SIPymRTmsWx7dsz2P6qcAj+6inrMMs8d9stWWx3mnN4qjvh7k
 +MnQ==
X-Gm-Message-State: AFuF++nz8EVDtGbK8gLTfjqD8HKynEvF0a3uKU+g4iUKH6NsJmAclBAg
 mJsS1lCS17v/H2baQXX6cX2J0iA4IYUvkRvpz3muzb31BtmAmFHsdsDKVLZfdrci+jc/zfukkBT
 LfBvED2M=
X-Gm-Gg: AR+sD13TVPEBGmMh1qGrPEwgtDwrJumF3t2Y1sKKfFqRNI9akOtXkbdfbMbGBinkGg2
 Z3+h3VTF7Zjpu0yyY0sYkQafJR5pTeAHkZsrGw0glbuThQqsOl6tt2yv8TsvBQImT1GXVZclb+3
 C+dnPx7GjYysJzFBir93rxl9X9apr02IFNY3rjX82SaSC2qWVK1wrW5zti4CDJJkSETPyl4SSM4
 yqwVWi/ISy8T+8OkHZO14+3zqlvore+0NLnUadQ2N2+TmD0gKaE+dvbHleU5PyQVsWGckQC/3Fi
 NYC/C8a+g1pmnJTfsRHFvx0hXMdvNnYFuGu0e5q/HzxxATq0d080Wr5bRPMVbfxTylVthDJTTtH
 kFmQ3XQf/WxcpOqZIJ6LZMt8MvvbkkuqrWPub1hXxcjKEyp9/kxIpxQeyixBqbbDQqtiqvaq8tt
 GOVMunbPqRbk5Tg+cDu2BDo3JPhdKg7cyAamndQHcgQbHNFI5x2ummgSv2ynBes9/UaqW+qYICV
 V1Dq8S5Z27VZ90eVQ5Me+KD9SZhrDc+jpy1YBamj3sebzjWDft6M3cZ+UYzgsCvpcK/H3w=
X-Received: by 2002:a17:907:3cd6:b0:c21:757:1bb4 with SMTP id
 a640c23a62f3a-c250c5cb6a0mr608907466b.16.1787733907786; 
 Wed, 26 Aug 2026 01:45:07 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a5d647dsm352559166b.13.2026.08.26.01.45.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 01:45:07 -0700 (PDT)
Message-ID: <6a8ea793.e73849ad.38047.63ff@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260826020337.3685452-1-cyyang772@andestech.com>
Date: Wed, 26 Aug 2026 08:45:06 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] readahead02: Fall back to the parent disk's
 BDI for partitions
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

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
