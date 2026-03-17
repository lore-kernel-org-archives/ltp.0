Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83783FD875F
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 12:38:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1773751126; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=UIEpmKACqJK3dfyazO+UTutLr4ZyjBsJ0omfahyjFOc=;
 b=SDsNAWZnoqBKlwxhrZgT6bRmTQsp6mYBY4UkhfpYCEZ/3TmoegcPT6m8uuVHRg+uo30fx
 14pWuKCRdXTN+0sJvmNh5m328VNn/FecMf+lV6xnZ3yBDO+52mw+gbmnCWcRKfohM2NUAS2
 wQmfPoK0yE/ppNzIfpw2FDtyTlXD104=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 153503E486B
	for <ltp@archiver.kernel.org>; Tue, 17 Mar 2026 13:38:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A45A13E13C0
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 13:38:22 +0100 (CET)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 2A870600047
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 13:38:22 +0100 (CET)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-48539cbb7b1so33930425e9.3
 for <ltp@lists.linux.it>; Tue, 17 Mar 2026 05:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1773751101; x=1774355901; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DnlImt741FsMxKW+BGih89BLoikttCMGHgCBIZCrKxk=;
 b=aueZLBYkdvIxObCxXlvY9Geip1oB/jcaVrsKfWEXyRashdRfXBEYJ2c66woXWONAQU
 KWUcuJ6GOB9ofLdsOer4IKwRd4PhJEYleZ9b0pIKcE6LvqkI0X/ncwZiZr2wQvfY8mEG
 VGY7HFjjpe4cUX7fyzv75M0kB367s3l5Sd5wInFQdLyEpJt0Zzln0KW+NDd2PjmgbbzZ
 6oIL5mRBmf3kEALVlNUmhkrjSwknE+w+EuAlYJ42HUHuEIuk9JrK3Gtk5jE1rrgvogTM
 G6jazXXZtJkcJPF6RgVqzjNlYeDVeDDaE9J5LsuaT8X1Cq+XMU6W+wS60HP4E7sWqMXR
 sDow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773751101; x=1774355901;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DnlImt741FsMxKW+BGih89BLoikttCMGHgCBIZCrKxk=;
 b=QGASlWphTYeBPS8iXXsIJpN00/P0Xt0towSEkRBITV1pL3k9jrVy7F0XJUAlEDGArD
 3KQx5uu5ZOBBKYREyptQUOsQ+GvEICRhMsr9YACzcUQ4sphJh/VvK9yViBNhL5XJR6H5
 HqDieKOoGfOAvWaOU0RL3Dc11BSQ6i9eMx6CzFwLn5enM2l6seDtZahW9hvoQ9NgA9vT
 KXyl5r5oL8U3w+oo2P3fLA+i9DEN1qGQSkhzPsF3u09ykjfHcWh4j0PI+JCW74iw9Abf
 JORDzYY6zecjhOO78NREgP3imtlm/S7FOgsDMev06HmwYzYdbu5zGFpR2wKdiT4843YP
 te9Q==
X-Gm-Message-State: AOJu0YzGtC0LBkuzfXqLSQttwlhVPaRs9JyqJG5h9xsqlQ4YOr60kftt
 j77yBKiS8IPe00q13DhaKqexe5NQhP3rJgJ3RSdbJ2/wecTSMZWgdTo0rKF0Vxo6AC46FJWk4QJ
 uKu/3xW0=
X-Gm-Gg: ATEYQzysMOmAjMndeUXyBOSsSCuvHTKcFy1I3ifflACm5aK9rKYUBXPxLDcgrAYsRCq
 qAZ1fw40FSd1vihCymLFnV11jW3DtSL+ASeHd3UieEAc05HBd59Cnhkm/k1NmPq2cb9MqkgzHNC
 97m7suFpNgks/OSwlJJVHALgxqhS+133Gct05lIWs648RIyYydVTy/Oq3lbrgP6qSeb4T6S2wv2
 Z+8fzGu16Pk/qt0GtECVKTnd8aEaWw+WmTzqFgRjA+LTVWiLbolUn3BytSVqy+QwIkav8KbimNe
 s37jEum77VjBRq0bikJNHdf77kXDYnSfEHYjnpEdeiCcaa7RDQyL/IEKnhBErCYFNwWYFC9QJqu
 k6Rkctvd+rXAZbjsZTfiXlaPQL/Ma8YziryR12y4TmhaMhsE9vyxFGy/7dknCrtjzA3Jg5yrGQc
 xBYhp9oz62nwsNAcLPLQpC8g+zaIJOaEXC6aJ8v/Q=
X-Received: by 2002:a05:600c:8011:b0:485:3b00:f939 with SMTP id
 5b1f17b1804b1-485570ce1acmr262392275e9.8.1773751101469; 
 Tue, 17 Mar 2026 05:38:21 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.4])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43a0b2db487sm33808951f8f.28.2026.03.17.05.38.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 05:38:21 -0700 (PDT)
Message-ID: <69b94b3d.050a0220.29aff4.793b@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260316124022.316230-1-pvorel@suse.cz>
Date: Tue, 17 Mar 2026 12:38:20 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_kconfig: Don't consider
 CONFIG_FAULT_INJECTION slow
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

Hi Petr,

I didn't use fault injection extensively, but I read that when verbose mode is
enabled we might have a big slowdown, so I wouldn't skip this check.

Eventually, we can implement a check that verifies if fault injection is enabled
with a high verbosity. That would probably make more sense.

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
