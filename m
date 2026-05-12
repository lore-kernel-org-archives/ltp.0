Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50A05CD4851
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 13:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778592651; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=ky7IuSW1/9z6pjzdHRsZd+/Z97G1QP+Ikg/jou9H46HisJnRRSQElErb54M9b/Hu/9rjq
 ydtv8hpTSADLbUl3E75itRW+X14aexE1CcUVCAHEmoEd733tyKOc5E6HbwUXRnHCLjE5VmI
 k90HzHvQYDsWpKz6pLf2FlnauzjpmZM=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id CC3493D0EB1
	for <ltp@archiver.kernel.org>; Tue, 12 May 2026 15:30:51 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 7BD7F3D0080
 for <ltp@lists.linux.it>; Tue, 12 May 2026 15:30:29 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 0F93F6001EE
 for <ltp@lists.linux.it>; Tue, 12 May 2026 15:30:29 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso36045585e9.1
 for <ltp@lists.linux.it>; Tue, 12 May 2026 06:30:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778592628; x=1779197428; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=ISEmEQjuWYCvXXco+cUgj6aDE0vAO1fWgmOjIKIwBfs+Zbn0QsFB8K1qOfLbjIPUfi
 7TYfg0QhP7rUXm15G4UcA8opN285sYP0+L41nSs7kKF6jLfWdOh187uKREXtPcZKdILU
 4V7bIh5R4ASHUlAjecf0A+YYezsgQRxV/BE+1MdKhEcayKneXFDmyfHhAtsg2u/DjQt3
 Me6vfIWWH6A1woTsU/rhf/k57vQkstFWVCajic3yZ1VermF3SnjjoqLhIk10y3mSZ0TW
 X5EhQ+sUo9CDECn+VTLBlGB1dUnl7ZOlt4I3FNUpGGIoD6vym2g52lp26S4f4926qZLp
 c/1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778592628; x=1779197428;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=hhU4XMxqU6V90ZI+PHGwWnryRCFecalxYu8jLuLLVnu+j/le6NM+gKRtwnAs8mh2rr
 Duft7psRwYw1Bi9254UcHzdwa/QKN0bP193WLJGF6S0LdSGnqyLa6dcgLkBb/5PzCU8a
 Uf1KFv80EiCDKPIyA4ZxpNkJudtbxJzXe4p4v5JMN6+iojrPd6kPVEx8euz0mL5RiF/g
 VQStbztt3QMjwQMjgncVnx34f+xIqIH91EZVb9uJGO24UGFrMOrroagUb8ScYkQnHqaN
 NJrfEaTKdgubzpJKN8oXdcCYZkdn8bxGfocwG4u62bPCmjWeGOaFe474BV8ahkPjx2vZ
 x0ZQ==
X-Gm-Message-State: AOJu0Yz9shV0hIO2pABdX6AUOYoYKoOjnOHaVm40yf2iKorE90WZsLr/
 AfmPgkRXvnJMuiTFLubGi14GfF1Div0qXGWi3DKpAfVUVD2+MV18Ruh7w0HetLSgPjLdsEmXLyq
 IS5bC1/Q=
X-Gm-Gg: Acq92OGZ2sdb7CPuRr9RRjMTRq/r0n7FEu3LXDGuiM8DvFsA5losGll2fqwlmJnJ3iY
 eBlh1svNOt7k4nmbhEbq13zkm3ChOyprjzG6x/6AL9Aip/+CMEhKC5iPgIaCQeTpAypTycRU/gs
 R1BAQaXK2i+geE/PnwKWS3Wl4nVXxMrkjUDsnNaogTS6wTcUQJw7TrIqr0tzmudZ2G6ucyjrsFA
 SGXqVivUJwGuP9g+5PxClpZopl3n02dj0tHjwwJIJXsE1Qhf/a8wFc9/sb1Yw4LspYnN5DRdReh
 2vW6Ne4KqZSOKMs7q5Pnv481kneOh86cP0PuKG9sseyqjYEXqXX9MrFtQCsO4G7hP6Mg9TyB4xW
 Mz48WkIzeQAOS8zSo8utJ8SUy5yiQ9pvHdbmh2VcKS/2ZhTm6xdjg59BD3xgtoCLHuUhHpkyubF
 tNGIrlXNolbQCkGm9Z/RaGXg+fAwTixvvC9aveRvN7or591dBckt1stqO3Lz0SPrKY3hdThqCoM
 bDL89oTBKOU3RtNcrB3Si2ZYz1AHACob7yU8L5zkbXLcyleUN1jvs5TWSHMoCYMyVuR+JOOvenC
 BQ==
X-Received: by 2002:a05:600c:4c25:b0:48a:65a5:750f with SMTP id
 5b1f17b1804b1-48e51f46ddamr277400765e9.21.1778592628219; 
 Tue, 12 May 2026 06:30:28 -0700 (PDT)
Received: from p200300ef2f4fc90038232d0ed1260eab.dip0.t-ipconnect.de
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f410558sm34907995e9.5.2026.05.12.06.30.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 06:30:27 -0700 (PDT)
Message-ID: <6a032b73.1b608098.57ddd.4db9@mx.google.com>
To: "Martin Doucha" <mdoucha@suse.cz>
In-Reply-To: <20260512124909.27094-1-mdoucha@suse.cz>
Date: Tue, 12 May 2026 13:30:27 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] af_alg08: Don't check recv() errno
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
