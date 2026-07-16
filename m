Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE5CC44501
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 10:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1784199580; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=D/dgpTeNMTeba88tIFjo/lUt07bBib6MzILUqP/PcbVoGB+rYrZVCtsgRJoNWPejBPjXb
 9N16N1DV+S5zprHDn4Fl3UCVf8C9TrN1IEH66IbobZI54Y3/lyJ+fXJQmHqzOw9IC257uS7
 nI32pppt0Li9i2jcH8B7/LtJOXo6Mw0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C4BB73E5615
	for <ltp@archiver.kernel.org>; Thu, 16 Jul 2026 12:59:40 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 75F613E5693
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:59:04 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 20CD42000F3
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 12:59:04 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-493e4ccccc2so40487725e9.2
 for <ltp@lists.linux.it>; Thu, 16 Jul 2026 03:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1784199543; x=1784804343; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=XDr3e7OcpINxCy4JBr9lvSXldMvVqJrZSU7E36Ma75I+zkVGLYjimquzpQyupPaY3J
 HUN+iQ4KVInN4m/WFeEEdrCMIPDlBj8EoiTtRjijcn6p5uXGcX+exXc35c1KOp3WOCjY
 m8jd1XnhGcgyPg88nnJ4D7kbkmzPK6sUC4cnUJkLv1fMRtp0JBnFiArtsOu0MDabGzZL
 yisAR72zZhGl5vnrjG5A4mVoUow617aLqvUqCSV7w8XznXT/KLVuj2d5V4dKV4qz8rk4
 kyR93ss8J+3vXm7A21gtQvWfjTba5SSPacy6IiI3eQQKHIe51aqGXXML7Hwe8j8Lutc2
 Yk9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784199543; x=1784804343;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ZAnh3ohTCwqkNeBq1mPMFhpvC2/BrRdgZESxlCCjH+UK/zXBDXJ7pvv2P4/mXx6kJ2
 5ZsS8q4WqhAtTh4ewubmt1XLlHwrnqY4vxiWC1buybTO6t+xCW9EfsosjbJThbl8L8iK
 M8LHN7GLNDs2G4KcsVaIGkvYFBrTWtfGPOZQWqZHMBFIoHQYMFZJlVTvRa4DmKCZBuoQ
 t9GbKbx9gpVmPTxlC9Zsj59Gt9cLvdp36B2Jh2tZAu0X6soTldjdJYKF9iwofAwiBVnf
 w+9orFs/ge2vqI3X4KfekoSI8OO6CADYect2PTn3ssiOE1oBjoksuH+xg0jn7YKD/Txx
 +Zdw==
X-Gm-Message-State: AOJu0YwAEp+C21Puy9rk4JacN6lyLV1AJGeOpqPgPvKpN77Q4dR96Ane
 offmhgOumEXnqzRK8RJdghP6IDNfgTx5Wbc4OfajuWmK4wpA+4+TpsKPBfrombo4xuI=
X-Gm-Gg: AfdE7ckAFvSeqBUrEiaH9UO/PyuB7JboEe2JRLYuhMl5XUwr83aINTy+mn/0q9D5Ux6
 doTJXpFanGiSgvxmiuMKMHslbBQ70WwIEnEb5YWWxfD5EBc2vP2e440QeSCadJ/yviNgTvF+nOa
 nWk8IXDwoCt4729abmOz6rDb3mLeT2Z8kWJMmE6EEPrp/GpS1S8ze3n/vw3ta45a/ganiaj2QYb
 tkppwWiJ7fH0yZ2c0b2VA+DedT2c6xBCXEtjnlnFAHTVz/4TuUuo+Xim555I0DQGc2A0XIhLLVY
 tuRepFRVjOq+ySl16soUs/hI/+4umAyr6llj58J791bysCyt8LomsUsLritkoKht0CZQAqSx1sH
 3KnyIK2py+NG2gFPZX7OGRFUMkri4lCkofyW4amfY3KVwnHp/ueBxe+7AXqr6T2V3Wfiba4lrR+
 Mmhy7Kgf/o3CSZ7xbeMfZFLmGGn8HzlfXj
X-Received: by 2002:a05:600c:48a5:b0:493:c6ed:a044 with SMTP id
 5b1f17b1804b1-495389dc98fmr80594595e9.34.1784199543412; 
 Thu, 16 Jul 2026 03:59:03 -0700 (PDT)
Received: from localhost.localdomain ([153.19.102.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464c7c96sm23213500f8f.33.2026.07.16.03.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 03:59:03 -0700 (PDT)
Message-ID: <6a58b977.359f6b3d.1dc26e.28f9@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260716105344.263649-1-pvorel@suse.cz>
Date: Thu, 16 Jul 2026 10:59:01 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] submodules: Move from git:// to https://
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
