Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFFAC61DB9
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 11:16:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787915805; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=PZJQiNDiW8E3ZjHxFb5mCkhY6EQQdN/HM/ABp7pEVk8y02xyDVg+q90zazaVwKGq7AO2H
 blNHk3vGC+tIOSBjP6jMB+diu3Rflk1ZIEjQTtUlPZ/1Kay6iyVdOrKF38sbDcvcA7FKNQ6
 MRxElW8yga1X3X6ZatvzOE8X7uMKnKk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 00D993DFDB3
	for <ltp@archiver.kernel.org>; Fri, 28 Aug 2026 13:16:45 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 55AC33E5D7A
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:16:16 +0200 (CEST)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E874D1A0079B
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 13:16:15 +0200 (CEST)
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-47db714766aso1471475f8f.0
 for <ltp@lists.linux.it>; Fri, 28 Aug 2026 04:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787915775; x=1788520575; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=H/7LLYrIvhRXFbwp3ECtQZgoOqhqHadleSyV4LuBAEDxaI1GCCSJexraxdPhB7d10t
 07NXjXQZt3rSi11mcMwR9v/a5yehd86NHBbQD96GhZIuYJGr3tD5Qq9HYpauDsI53H1N
 s0FS5yM0MaqBisTDmMdnvhmVNT3n7lSW8UhLJWf1RpZiF2H4pWFbMbhdFBLZzqbzjH+m
 olO9RUSMBaxrVYzoJMGzC+5vHZSU0Z/6tWx340D7TJLEeu4/5cIMNvUwMD0sx4MvvNhR
 pVVlYUD1Fhp9FUITiYNE73DlwvMLJz2shdwnx+TCwb9n6+ugPNhOTtABIz5Bz8xKi4S5
 nWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787915775; x=1788520575;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=JQprJmzlNsKtZNJSWf4jkMfkA8RyGIs5Isrsj3Wli3pbnSF4wzFa3gigU/nKtpOieI
 Prh4oPP3/czda+t+Vo2AKAuGRp+LO1g9RiiNrjXZuWfwHFmjTUqbIobjxo3jFJDnn9Dn
 idtn742iTbHu6CAXrFy/7q9rbfcqn8ePvzlxcWZyE145tEQvIuTBrlwbG1j5cXndCYvv
 u6AtFkOAdGU3UarS7kxc6De0XVJBYk1n6pMKzrqkFFiVBL76PkBE5GE8qQZtkHRN2N2G
 moSI/VrsEFOTHbeAxxWJmYItBFIyik+5xuaANKJifYO0IHPEqltQ/+BATz7CTh6fpa5Q
 5DcA==
X-Gm-Message-State: AFuF++nHjli6OOd2x9dGrB91ahGqb9nD02s9mQcA7NAhXprqTHjdGX1L
 APFVgR7gDKv9oocLeD5PZDKkpb73DG2NSFinHaBAKDl8Pai22Tn4pNG8ApLgZQ7gD5U=
X-Gm-Gg: AR+sD12q+RQlXeYGI8F1LwmcEzVNzjM+z+S4J9RDaCOT7Qsov9CkLZMDDreI8rnwbva
 oHPNq8DHW/8MM/hcYrxWD5IMl90tOUfu3MfgwD94rB4NokgS6aAMSEvuyq5oAVLON+Jj10ujPOs
 LJguBYO6kpak+AgVJsLN+HOWVp10o7263MNJjvdzVf9yxKZZAggTIFwhfRBizwFOSI4hGtIH2DL
 lyJchQkieI758r2c2miMG3nUXaEFiLJ+ElM0cl+fl235yjbJxwnWqFbigMSgwPP8v5fqSN78s5Q
 6iA9WG1FcPF0/9lH2sR6+s2uF/2Wy7wK2il4RkAPMUrxE7NbMNa7FYgSzJ7AQriBjatPj3B3gAA
 T4zbl2bRXScvYDosfjt8N81d1DpIi6yEUwDsknj5ecYyofjIaIMqiiZ7LMI5oN3ysV7WS377xxP
 xBs+pHpNGxXrDtGulIlyLyKGkZSZkI5Z+AetFb+wVuuq+uuur6GMW6/MPDASO8sbAK/lqp/pCOZ
 NGt0JVKsls12AVaXKTJhONNqF96s5bZnKUs
X-Received: by 2002:a05:600c:3104:b0:495:5d6d:9cc1 with SMTP id
 5b1f17b1804b1-49b919ddbbbmr71001625e9.0.1787915775233; 
 Fri, 28 Aug 2026 04:16:15 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b95013d1dsm39840405e9.13.2026.08.28.04.16.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 04:16:15 -0700 (PDT)
Message-ID: <6a916dff.dfcca1bd.1554aa.40c6@mx.google.com>
To: "Avinesh Kumar" <avinesh.kumar@suse.com>
In-Reply-To: <20260828095724.194900-1-avinesh.kumar@suse.com>
Date: Fri, 28 Aug 2026 11:16:13 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] setsockopt08: Handle EPERM from disabled compat
 xtables in userns
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

Merged, Thanks!

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
