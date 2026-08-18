Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8932CC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 09:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787045767; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=eBjPGalEZ75MO5skG2aGKre81KBejtirw4JnBKDr28Dy20tbC+weBfIPPsRxHxHczxrQ0
 M3PznuSSrcsMsf/SqDBP6q05YQ2YJpl4hRl5dh3ibMVi033A1mrzFWqqNW+NT14oQwaruJU
 HKU4vXjRdQUBy8GlnpB50mDtvmIJViM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id AC1033CBA27
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 11:36:07 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CE0F33CBF46
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 11:35:47 +0200 (CEST)
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 7E9F7600A47
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 11:35:47 +0200 (CEST)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-49800c6a846so51538365e9.3
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 02:35:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787045747; x=1787650547; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=RalVa64vp4G4/niUgu4CSTKf8szbYGG7WcLa2Bdbsw/Eyzz37FZN+1IGjQ66ucL1eU
 Nhp51uIMQm1iNF3suaTBK9iZqP8vOHCfdI6rj8ZwRdd7r0EDRdAcHZ4TXtFTcP0NyqrE
 K6Z9/3EAlcuOEQAUEA0mgy6Wk1w4RjcwlgZs7kqOUExHfjmsKNSop8PYH+Rs9bE+17PF
 laAWVDLMI8ad4WV/toa8Gsw7D/9SzJb3LVUqMwDaq6fG+nKMaEWpYcNhwVn/rTgdb86M
 VZltJ6AEGjYyyJy5EDXYgsL/RFyB1/IvpX7btH8+dTGg1DnotvRMqzSK4rTuZdE37nF/
 S7wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787045747; x=1787650547;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=jcUHOHDuLCXruBxeuK3hraMOafgjz675sONOEMQc7zZYTUrLQrp30Umhs0bhaYE2eP
 n/2JmTUy0n91EhJiLrj3Q1MpIt+YEjnRLLPtEdr23TSRIqDLn70hGJv7fdUrRhKmLnbl
 gJznT3QzDC452ETqndq1iF3DiHl38UfZ9Uwm3pjpUem6NjHAb4j8TTv9X0e+oNv82CTr
 /odTB1vu6vFjjBE8Ep3Cf85YVTUWBI5cc1OLx809rrLjqc1InjwO1J5/oArPhVBi1zhC
 NAGK+2YEKYFlqMGeQ+GL1KF0ZB3BBA9sIqhUpo/mnbkVXpRn7uPRA1ZFnMrk1XoIIAAC
 y70A==
X-Gm-Message-State: AOJu0YyiA0xYjDfBtBFxBzPhgu3c+gLSl+7oH3P2fzZprBQ09YaunnRY
 Q17reP53GUfwFtfVdIijeN/BS0orPXWD8hskHJL6fjO2HBz8Kc7jCd28Qq4vM6zm7/hQ49cuuxi
 l6a+Zedc=
X-Gm-Gg: AR+sD11RG5cSvchA14TIZnG/LEpjWvAHRAR7EO68RuzMmA5kg6/wawpXzWNR5Xq5tYu
 SqBGfWx9SOBWDfBQAXxch16rGhMfD5cOr4kBv+jIEQmFNAiwau7zJZxkflVLGJw4O4+MW7G7Tda
 EkUEnaiYyPBMyQFOEkvloqW9Jl2FE1Xjt+xNMyNmnNH3ich1L4DFtBCpmFw/TmMHSlZv510EPa1
 NCG5Ug/t1vADteuMmP5XAjsyn3uP/iwejzGPq0GPdkNOHrX/xpS8tZ68juJ2vs6u6cSkuZMq/im
 gT03sUiosBrTOPCwJfG1hLyjzdGPTbLa65XVeHTEopOZPYsSn8fDgEXxxkJwfHcJalSV+Kp7mPC
 kzQtHBQtN0JwO/eixOW9UrsgNUyWPuBupaZSKGDJ6/fsXShm9+zSEobQW8GM1v5wOJ6A6aZrdlF
 ZGpSi5dS/AhE7gIKaNxRb9BBikNDxVxOyMfx7VD5pNx9W/HL9nLnxMSX1KAK+lipuVCJ7BS4o=
X-Received: by 2002:a05:600d:8489:20b0:499:8b13:3a98 with SMTP id
 5b1f17b1804b1-4998b133b3dmr316462515e9.4.1787045746853; 
 Tue, 18 Aug 2026 02:35:46 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49996100082sm308409485e9.2.2026.08.18.02.35.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 02:35:46 -0700 (PDT)
Message-ID: <6a842772.8119cc8f.c7618.34b1@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260814124943.36853-2-mdoucha@suse.cz>
Date: Tue, 18 Aug 2026 09:35:45 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] struct tst_fs: Add flag for checking
 filesystem mount support in kernel
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
