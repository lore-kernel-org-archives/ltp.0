Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAFE7CDB479
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 13:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782307531; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=XIdTrKyRGGOwkPSpuVc4x7n3Uidn073d0J8OryfNmMU=;
 b=jMIKY7u6NgDEnUbMDgEh6WeSR/eZuwUDfugmimSdPEB0eHbSBlxL/auzK7+/GryZHVjEf
 KgcgOsqVawEW2+ZpUhOlUMavdqdC8VztfTFAEUIW54ylrML0+YR8HexeXUbcuULVj94VCDk
 ev7hhJmS3I/mSEfgeqRwxu2mAjGbc4I=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 573613E6278
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 15:25:31 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5423E3E5872
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:25:11 +0200 (CEST)
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com
 [IPv6:2a00:1450:4864:20::431])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E4FF660055A
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 15:25:10 +0200 (CEST)
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-45eeea039ebso660823f8f.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 06:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782307510; x=1782912310; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=jQXzA5zo1gXm9iDNc2CPWSmtrc/czdybmPTNqqM75QI=;
 b=QdQ214W5qKiwI7lMFwOUajHDAqVqzLr+gnMv6xJN2yNrvlbUT9pNenAJ9dWDseIXum
 WSrcXBy8cjs+8NAGyIb5FYbpViQY+ldJQso/ypd9GGNjOONYnu3ftaFwt531Qiah+Z6r
 J7OExMmEnmSxZeRTvbTgu78wriSZCf+1KGxlB/usIKqFkDbW5q6lPtt+EIYNYcZE2qxh
 h4oyJUW6+fvGtJcKzUkZC4GZ4TN6sccBd4/oUHfBeb6uM9rrZskS6uv6XTlTlwnCsofw
 888EbKHXy8D55uHfjHorrbrl96pEYHmq7E0fMTrCdOm1cX6bQBKiT5TSS5iW6x34x4C/
 fXGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782307510; x=1782912310;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=jQXzA5zo1gXm9iDNc2CPWSmtrc/czdybmPTNqqM75QI=;
 b=Hae3tCakcM2FOv7phxVuSiGRuZhqQX+wPICJBG7RBz4c8QN05U1TxLDHgfiGyaupc6
 LNe8LFdirh4c9gr316MqpcXfc5m27XFiraNeINO6w2A44tPegJLpaKacKWXyucCMj2ml
 T7bIzHi2HOm108SbrjkuVFjqJm/xCezWUmbDUYHRn5FO1gBJBtMbPIfNNM1HyDprrL8X
 xyXN+wdSDgWxZL2Rq7mKscAm/bb/Ir7JDwRj0HyCUp8Uy1LI1a7kGlddWxj7/eTIdi2Y
 Rb+49uWtra4AjM/+yaZjFpKqglY73kK3utkLhXHJfVjx1KDDjI9pZxxfcUMKLGVAoI2C
 qrQQ==
X-Gm-Message-State: AOJu0YymIHmt608aaFdsfd9Xtzhmun3NlOXn0Ed90+pIoHIGgZ0ms1x+
 6rIBkiWJRoWTVxPag8PerfCQZItxOiytdozsND1/FDzmg2EuSLXWA38UZLAcFbkzLOk=
X-Gm-Gg: AfdE7cm4aQSanlcAGpqLda4k4tGXISRg6of/SWfyuBPQkcJRdD9B1W4MjmOsiP/e3mg
 h58acufyQu4GmpXW0NSQm48O+LZXeMHVQNJOtgrvZ1recoKBRyaE+GdH38i9PBM5PDIwuCMrmYG
 pZEbPdyjZREsB3odCHDfB5HH3OQr9wpfm5uw8aK4LFLycJ5qenVvzOyW/on6/SaIG5Mpg3MzUGy
 LDNfkbVeyCKXqNhNrM1+hvklpIs6/jX6K/f2rDRrynVmqL2SlrKA3l37HMdiy7FsQq/fE9go/aw
 KOhpOntmtrAdGSmZoLUGp8mRlWEWHcfsHDbObIIZ2VN3w57qijvqpLOxbpBMg3m+eqxvNeqdfZH
 5KB85WKVyEZBcBSoJW8ey6tpiCsmZ5ePqTW8USu3vInns1+ZXxGxTlyw3G2PeFSn0shpOkXy0o+
 ccOpaewMQh2brCZzymwxMBuUl98oTr6mflC9Av+7E1ACKx1zBshS4vzAXPFNbU5AKPoETxTlE9
X-Received: by 2002:a05:6000:1889:b0:464:32d2:ecc5 with SMTP id
 ffacd0b85a97d-46c084c82c2mr5673484f8f.7.1782307510222; 
 Wed, 24 Jun 2026 06:25:10 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46c1ee0189esm7114679f8f.9.2026.06.24.06.25.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 06:25:09 -0700 (PDT)
Message-ID: <6a3bdab5.53cb9477.32fb6b.b8c0@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <ajvZ6GpGbLk6iNrj@yuki.lan>
Date: Wed, 24 Jun 2026 13:25:08 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 05/13] vma05.sh, keyctl01.sh: Add groups
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

> Hi!
> > > Also linter should be cheaper and pretty easy for this case.
> > 
> > We can easily do that yes, but I don't know where we could implement
> > this inside the make check command. I guess we need one more script
> > verifying the parent folders/test tags and cross-checking with the
> > group name which has been assigned.
> 
> Or we can write a linter for the metadata. I guess that we can add that
> to the metaparse tool. We need to check the tags for correctness
> somewhere as well, otherwise we will get wrongly formatted CVE tags in
> the future as well.
> 
> -- 
> Cyril Hrubis
> chrubis@suse.cz

That's a good idea. Let's keep metadata stuff into the metadata folder.
I will take a look at this.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
