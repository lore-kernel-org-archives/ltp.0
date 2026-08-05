Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24348C55822
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 06:52:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785912775; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=G3UcuaMaAK+pmHw1bZZDFOHblR1Mmnrbg6jePS32La21CWmPMFecbA8XT2JPx7jsFJHi0
 Tach/KgizRUvQXwmnMpDT1F1FmSU1xx4H+zMgP8J8JE3mqPAFbGykH0r3UeSq/4CbZCJX/J
 IW5DUEIXBj6y5T4VAyyxnrRte+uqfGM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A35D03E2803
	for <ltp@archiver.kernel.org>; Wed,  5 Aug 2026 08:52:55 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 669503E24A4
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 08:52:36 +0200 (CEST)
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com
 [IPv6:2a00:1450:4864:20::32b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 66DBF1A00375
 for <ltp@lists.linux.it>; Wed,  5 Aug 2026 08:52:35 +0200 (CEST)
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso5193135e9.3
 for <ltp@lists.linux.it>; Tue, 04 Aug 2026 23:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785912755; x=1786517555; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aBKrEznLnra/25WGSrh2h6gKWPDd6PsOfGHfFD97hSG1W6dV6ojlReSuxnMesSKlDj
 cqSyppturK+KAQBJZqRFaWiEklwWfUWlyfU235wWuqFNcrnEQ1q9bquFdBt6xuv/SnfE
 3FdB61jJN4XW4yo7YF7rp4GWd+rlIVlYjQlN7CCnO5zCjIdnhMVzctYeBdPOzz88BQYM
 aYUvnyEQhtIkaUdU4vTIpqv2wsFlWdqOoVW0OERZX21oilBw0E1YW2GO01RD3fjAbTh2
 /k6oNbZaqUhMYw7vmyDt0Xevbcwn+VD+X+4rTK11PzQZMBgorvyOz8sx9jzKFXRTIkBB
 mmNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785912755; x=1786517555;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Ti8zZ/J7wut2lv2oWGLeDJeB/ZTNDEucWEM1iIjkaicVZ7Ikh1TXnAnSKoRq0IYuXe
 4ajvr/vmj+Bc4Lyfe4lLJed4rmzfS9g/fw4n99nSebg/NPPeJnBg2sAdI6quUwbXepHo
 xazYMtO0CpdrpU1GClzlGm+Psj8762O6ttmeQqvYq/JnOHJsAjHNPxe8wrpC82IPUaYk
 tvdep4fDCl1HhWYpyAyImOte9yGIwzAFUpWdLQVHdasIP/QK8mafDACB1WwMkJHN3LYe
 FVo8DRLfVeDYTppvZvAsWB7y881M1Uq7b5wKI50I8lD9xiIGLLSh12W8ZuHSegtWWJEM
 1btw==
X-Gm-Message-State: AOJu0YwgKWnXuE/8s+QdLINyI3BSOm5caG/HFBtZbLpqoQCrtye+Ab7V
 HW74YnLxK02Q082gpLIKBknpChIIU9nx+NOg5hgiVfDOUQE0Ywgnux/kfQAEjNoMLaH/xtnln/l
 XJdXMiiI=
X-Gm-Gg: AR+sD11zPLGULg92KVjnTm2B+7t5Twls7ECWe5s5Qaltnq/iED/keJFuIIrZOlnzNr2
 fpj+LvQ0DQCTmindqmIwvl9FklrQ39wwqhEmMkzh3au/lTZd75u7tXYNawzBHZkTVydV0RRaMxc
 p1EXl7Qlb9Y/rNvRoMlILMQ+zWFfF6plir2PFYjAUg2ePqzCnsikwIS7K8nGECvur1IbbjBfFU4
 bd4kTC2iiRpmVUKNSCwgr1G8aBITVSBR266YcAmibAOSuq49vhdFhw4lq0H8E+4IOgQyoPgqOo2
 ewHatGlg7mhVg0NE4cBu1mtdpI7juZmGZ3lNUlLaG9I/5rn70OgwZjPI34+iHu1AnpVBA+QLZX6
 cV2ZSHM+6k+TcAVvjp/y73pFbOPfSwFs/j8F5GWjUjsmuXO5R/X4BueDOzX7/NVFBJEpxHIEPdx
 C8wFA2Yd04GqK1n26XdraMqERMbHF+/6Dm1+3UZQJ1T9SKmPT/71LH8AL9bodD4ndABblemNomu
 T9wXZzua8QAFVbYuLC5qfhFCy0h1Jm8pmKd56rLfnkEBFwdVUoXrvQvxkZwdQ2cNXXw0F0=
X-Received: by 2002:a05:600c:6cf:b0:498:490:3bbe with SMTP id
 5b1f17b1804b1-4994e7ce8camr26061865e9.16.1785912754792; 
 Tue, 04 Aug 2026 23:52:34 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f11090014709bbbefdc2d5d.dip0.t-ipconnect.de.
 [2003:ef:2f11:900:1470:9bbb:efdc:2d5d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49949fc2b98sm163409505e9.2.2026.08.04.23.52.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 23:52:34 -0700 (PDT)
Message-ID: <6a72ddb2.fc4d87c3.635b2.8224@mx.google.com>
To: "Wake Liu via ltp" <ltp@lists.linux.it>
In-Reply-To: <20260805025418.1249003-1-wakel@google.com>
Date: Wed, 05 Aug 2026 06:52:33 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v4] lib: Use backoff polling to wait for loop
 device nodes
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
Cc: wakel@google.com, ltp@lists.linux.it
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
