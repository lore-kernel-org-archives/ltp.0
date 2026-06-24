Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54162CDB47F
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 12:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782302739; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=cY+nAckbF5GNRI0YqPv5plhppXo3Qbun/pr1fzZsCIEEtnHCzxGZKzSvhRYofLc0s5wvI
 d9xX5n5cumpIs27zdNErZIxD0bmlAzTuRLwSQAvSEEbjR0YJsjqPzaiaoIxfs3MrEHW15X7
 k/CK4kO5A4A4LfJDvCufI4nF84AQrMA=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 907953E61F7
	for <ltp@archiver.kernel.org>; Wed, 24 Jun 2026 14:05:39 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3B2713E2E82
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:05:19 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 6481F1A00985
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 14:05:18 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-490b1bbcf3aso5263675e9.1
 for <ltp@lists.linux.it>; Wed, 24 Jun 2026 05:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1782302718; x=1782907518; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=VfR4+H15LGabKdTjyltioi+pVxno27FJDkY1R39acyMUjATXpqE7SlRP4GWfS8Nz6J
 HfMdK4NWb6WCMMp24e8dFwQmpgA1XrGm3RBPCf8BqBjyRDRTBIGegsJZqErxV34VJIr8
 P4LfDzw9lgLiWbI/PxI1C4mK6jrWMwb4egedmHCj0cz7UR07z1cigaLutQNbmS8GIZsR
 QhRoRci22iUUkRHgO57zxQaYpQ4aww/vvowD+nrlYISvHYHqqKkD2eKMZlfaC73H25kd
 2NQSeYWin48lbUFZPV7FO4sbZXEEwUaV+Gv4Hro/qVWQMxk+avo9MYLKz0+KXRT+qlfe
 BqcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782302718; x=1782907518;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=SmfdpH4+tI1TGbzTJktXckbRuFUA/i0u58IF6Q87a8TS9VM8/VuSRYrZlZw3oGZw2t
 tSfMVPxRTRqDe4RkDaHocCl2M9PH1s+NWtdmRFt3M2/zq3FssI/pl3GrRc/qVKWU8+gn
 HF+FJ87ygjVODzBo71RKmZWzMPRXf5ouVDSrd9Suf6d6LbBfgfybClkd2CsSvDQ7UmJ2
 1hXdV4kilotOjprcrQxYL0fScuoHX3nCww9V5/F1wMA91rzIqpbYv4Rr0tqJ7DUcfwiu
 6OOdpzOuA7ahnFm+eliSEnxoZzist6+iMn+wfjmam7NBLQnhG4Q8r+JUKQkfpGsKvspa
 PiRQ==
X-Gm-Message-State: AOJu0YyesXXck5ACMYh55Ft6LnmGnnsWj06Js5ZeVorxXHsPDXPMqECs
 WfVNJ7fDuBA2W4Oc8OuOxbwbyTD5YbwBE3Z9fZq+j+tG6YLH6yvK/do+2Yu7buvlW7fKpY8+YkM
 6ONK9u2k6tA==
X-Gm-Gg: AfdE7ckUoJ5o+o+Uq+qcRaUEaFqFEmilWUalXwGyop4V7vu3ShoS8pFwU6QE6FihTBm
 CdXntFkUPXbyD1ukmHxUzz20ngGJZjR//36rcnb3UzSlKyL1cQ9i/ZwLzZH/YOcMu2cpogQgNeu
 IMjoW+uQiLv60oRCuVG7+uIvpooCi5JB40bjVhj+YqCfkN5HEZ3uPCwHMRJpQkIx0YfISYbwSgr
 DAx86ik5DAMSxLrUSPt44RZ+3+bpwmJ/rndqxTUNvkKAdlc/YJJV/HR1oSN/7TXzF0pqR0y3xCU
 6rmNpt/2gF7LEAL/uYif/fZZn5NoLL4ypz0UhPVBY0QiY/NMalw06GuoypDGGLxLP3/bi2zbmUT
 v4N1c7wAJ6s30GcEQrfg3EvqmeiAvBUVjG75eC8cmCc00507BCJyQRj1qGeQ5FrTCyt34im5pfE
 ZY8Lu5slm6nINe9kO4HyLb/cp0rqwXk2g5XkKxnWc4W8bna/WLduHcBNvh1CZVrg==
X-Received: by 2002:a05:600c:3113:b0:48a:5565:ec3d with SMTP id
 5b1f17b1804b1-492490a790cmr266895205e9.22.1782302716975; 
 Wed, 24 Jun 2026 05:05:16 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fd1f886sm422461575e9.4.2026.06.24.05.05.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 05:05:16 -0700 (PDT)
Message-ID: <6a3bc7fc.97b0ce82.ec1ff.b384@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260624091900.4107041-9-chrubis@suse.cz>
Date: Wed, 24 Jun 2026 12:05:15 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 08/13] lib: tst_test: Move the iterations to
 struct tst_test
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
