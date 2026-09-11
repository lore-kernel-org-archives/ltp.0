Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF960C88E4D
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1789132001; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=34fdjgQNrJAJRUGIWtXYUqE5GgrCLEsJhJtSlI/xQdY=;
 b=MEFqP39hj/SXWdMC907tSG5duqf8/rGxdhhsX2eG10enu02AeOslXeJBhL2nLhYUqQXaM
 HbWTdDbpPtMLPdqWVLovtKQXnHDlZZWmrjSExyslrpQ28QDp5q8baDCN3mKyBVkPTk29vDZ
 4offYVt4qTp7XJvztgBlp7LN5wcKGbI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id EA90A3E9218
	for <ltp@archiver.kernel.org>; Fri, 11 Sep 2026 15:06:40 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05D063E2E82
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:06:19 +0200 (CEST)
Received: from mail-wm2-x10.google.com (mail-wm2-x10.google.com
 [IPv6:2a00:1450:4864:31::10])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id BF8071000A4F
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 15:06:18 +0200 (CEST)
Received: by mail-wm2-x10.google.com with SMTP id
 5b1f17b1804b1-49ccfd61ecaso9221395e9.3
 for <ltp@lists.linux.it>; Fri, 11 Sep 2026 06:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1789131978; x=1789736778; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=SysNkF7JeqAWiDRzxqW9d3MeIiKIdHiCKem6Mgp9f6iajP7LGj3zm70OenNl+j7K7E
 VAQ19h03kTA/18fWJPNEJDgFHzmEBivvosLk9+ylMRvfF9xo/C0tGY+dLp67r6Id1e5y
 2nezA2xJCfYaraHLVGDjmUTpvhAXwQqj25KWa7m1ilpMTTN7sOEpIGuIqnTn6PHAYQue
 8uJ5189AoSq2fMW4q1+mM6WfaKpS4XAGyMPuzpvCULY9aeRa8djM9TreBn3hgJw11tje
 kLQxcde3YDyHlkG/WaiuTRdJ/mKg/3OuWLSt9zyyfdjiYZ1J05oIVf/IHmARI6wKER3h
 dCWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789131978; x=1789736778;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=kuPSF5DA5kUKtzsujCUy981zMHn6OKsgw6LQ7prm57Q=;
 b=dse0VQ70y1WVtMeq8KReL+netcH2AYv1v93384I3SvSpLl2t+Dxxgi45iJCd66NWJy
 2sdCzPg8GBH2VrBAmiFnjluerunDTjIeGflVgVNi1fLur62duUXMuQkoMJaUnHUshStu
 sXNlPHfxBywh+cXdEaanRLMu+1gxHvJrwGHcl5szBlAkglph05mEJ9NtbvgdpBcXM1sm
 4b6FJZ0P/zigGK7U6szFPM6TiBBUeDXYgOvmClCgxgw44kVNuK8E3EXwuKftvm8retOV
 dBKuYci8RAP9pgSbN3Ar5kMcGLjQViwX3cdvLqG0EiGJM+KDwLG+6c1bR8xlCY2tjC3S
 BioA==
X-Gm-Message-State: AFuF++kOWh7CWeKQfPnzRgslGQd3PRot48lP+PVAIM1kgmBsOdDBSGjG
 68R+L8Cx9nzqQLK+CZJ4kgmn3YRyzHKuYq/kRC2U1ck0J//x65zqDzEaaeVBmmImg+A=
X-Gm-Gg: AYBFou3LYG123Hp0LUG6J2HoMDUj8PgEwfWkPL0Z2qSJALTihzQLMrybuFXxI1nmcQL
 nGUSk2iYszUrqJvvzw3tDvzkEo9qr+3ymE2wy1AQFPrXrws4U8psQRt3WYJnnxuE0ZeQTGPxWvY
 sKc3wopkHG+PhuU3I3xzw5CSokpjLHy+wOEQzViE9Dhirb8l4Ph2sTQ/gVTujcGWasH9Vh0lR+f
 8IS2ztF0Utse18fQAz1M585+ozhv8tYthVXxaYticxL0Im0j6hBY3TwdHMbtr0c8lc8OkVMzn8q
 YAm2i7xLBlDDg2LnKY1mjT2907DjJpDc4ZjmAy47upezZzPLQ0BCpaBcyuhAmwCRizP+lwqcEQU
 nCwaS0pejzGZDKJigTyHYKULqqtnaqK/Uk+qOxGgMLq7utFmVmZYGWHmXNbW5B1En0ey7+0ykXF
 XljiXAT9cg42MmXAWo6wDvjbk4g7Mhb99CcTW5XdWajySbX+VQ777YIDnw8kYT+lkb68B1TapRZ
 1cY2bFly60+okDXixZNqFDDBV7zWvU8K+nhnkeZ7ABp6fcc/KpClzMC+XppFt5bQAMwVmOdKLrB
 8WqKMA==
X-Received: by 2002:a05:600c:3ba9:b0:49c:fa21:e73e with SMTP id
 5b1f17b1804b1-49e619c0558mr57120605e9.20.1789131977989; 
 Fri, 11 Sep 2026 06:06:17 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f066800c8b8b5e69b9f6a3a.dip0.t-ipconnect.de.
 [2003:ef:2f06:6800:c8b8:b5e6:9b9f:6a3a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e61a81943sm45601585e9.1.2026.09.11.06.06.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Sep 2026 06:06:17 -0700 (PDT)
Message-ID: <6aa3fcc9.232cdbff.2b2c6c.0270@mx.google.com>
To: "Andrea Cervesato" <andrea.cervesato@suse.de>
In-Reply-To: <20260911-fix_documentation-v2-0-716b2613c477@suse.com>
Date: Fri, 11 Sep 2026 13:06:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 0/9] doc: Improve and fix documentation and API
 comments
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
Cc: Linux Test Project <ltp@lists.linux.it>
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
