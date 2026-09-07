Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8AAC79F9E
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788762784; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=L5A7BhIOunWXhQPTforihi5Q3i+d56RCQ5+ucVteSd+kyB7vuadTUBmM8RIdZ/WE2RnXD
 Lw31J7U5fjGTroBKAt9lwEq6TR9mRak8JrUOWSRqntLdD2jYviLUuuB/EN+yvZ7pMQ4rfpJ
 jRw3uotIHrEFglbShT3fsXM95iK/NIc=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 275E13E4E5A
	for <ltp@archiver.kernel.org>; Mon,  7 Sep 2026 08:33:04 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 286573E1EA9
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:32:44 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9DE84600205
 for <ltp@lists.linux.it>; Mon,  7 Sep 2026 08:32:44 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-49b8687630fso26543075e9.3
 for <ltp@lists.linux.it>; Sun, 06 Sep 2026 23:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788762764; x=1789367564; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=LZaD27QqcEW130SBBzFTQMy9BOEkzBCBJgMbc8BdwAU1rkhy7zMDwr88LfsNvygZMn
 Q++ic4/Si4bDt4skXo1vehrbG599kvEJqJ2SSWAfDhC4s4mo9SZauWS/n52uAlyMTykV
 EP8Rk0y5BfIoOGk+vhWDQWB03u42h/er8Xe+KSBApFLyWWardLuI4nV5FKcXrVrUOePh
 s4LLSEDG0ujtxt35qZrWqxcuy87Xl3ZW2JBa2YRG1tYZVuJpERfcZLscPn/9C3uc+8Ui
 qa1V+r6UeAhDwBQHWFTi3NEiDqqnhe9XK2S61JkPdKT4c2o2BMcnRUhRe3YfY+ejpsZS
 X8Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788762764; x=1789367564;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=aDJGf04vKlwBMod9vfX9PoRfQOo/6JqR2C/mgG9YeFAjFZPSpsvEq5nfBZnexVBOfv
 2hhybrzhmby9qiU+0+F5+EfjBc+KCFRUkbWuKbTSqUHx+y0bAMJAbrGZTZGSmb9JvRwK
 j5h0l7qoZoOvQr20NKccAsSxqWQ0Fw5xRm6laZMunwWcelk2mYCzSxIj7MOrWmB8oiR/
 Lz2IKpDHET6CaaAvgS0lyDdKBdf1DOKFXpfgWKqpIH98Y7Y/xuLaG8K+AxAKFcMiAMyG
 5/K6g10qU0sYQJYA1A8nQOCvqNKDQr9j5Vi4+zPaC49WBTc7+Y77/U2Kc+8H4eBDqV2G
 EHQw==
X-Gm-Message-State: AFuF++lcTd0EpKaSxOvhGmaBARpAPsmk2z320hwXGZ+zR0gCwVgksX6+
 czwfTS7IJIuhPiRtP5HHWHKiqK8+QfQJKuHql72PQis2o0Q50OE6mJE33AaSKn7UagBkMO60+Df
 Exp6PnBpaCQ==
X-Gm-Gg: AYBFou1NOy7WiBV9cdOnfP+0z7qfs6VR0Uou2xG6GtaVZjVJ+BtJCzXnMXej+zB5Siu
 BEzRnyV6hKM9/yIYamjrra08IsIfd1OQeaEVep0id5y3DpPRoU08SFATXWgkX8PdqszJn7aX8Yi
 STKQi6IHOJOzO/81hLiMkQYj6ZWLBfk814X9Ow+1PjTZnsHLyiQupMsT5VqaQm4ANbFgQWhRYUP
 WhvYj5tZQ8UUyJc/ZI+YesyKMNzd3LLbM8YXmKlCLo+xvujrCzzQXprj1iyaRGZpFj+uZh0CXJL
 ns9Xg3zkN3yD5MKZtx1LlB5Wu4CUz4bB/z6FliCwtDjrtMBc+Y2uT2heVUnMOvLJhWqfIpxq2CX
 fUSTNrMp01jSqSZvx9aUHPtrk0GYj2rEb8QibJhslv1afgIP/EL9wvhEwRMIZQz8Ql8MKbPoSPu
 ZuCgp4Rdf5nz4JMs9GXBWmYrKzB0TQ0QWJGUA3RkkcL8gRA9AvD5jyH241wF+HvWhZ/wCcejUPz
 WQz03ihVn8iUb10X4kEgajDYz9PSlC8qo2I5wBozzZYzfMa8z/GJIYrPfkKEi9uzTXTyho=
X-Received: by 2002:a05:600c:4f83:b0:49d:91:274 with SMTP id
 5b1f17b1804b1-49d00910374mr131267405e9.10.1788762764014; 
 Sun, 06 Sep 2026 23:32:44 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49ce831af89sm263038915e9.1.2026.09.06.23.32.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 06 Sep 2026 23:32:43 -0700 (PDT)
Message-ID: <6a9e5a8b.f7ae31e8.8b3f0.91e4@mx.google.com>
To: "Victor Cheng-Yen Yang" <cyyang772@andestech.com>
In-Reply-To: <20260907014516.450196-2-cyyang772@andestech.com>
Date: Mon, 07 Sep 2026 06:32:43 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] hugemmap24: Restrict the 1TB slice layout to
 64-bit powerpc
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
