Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4F38C433F5
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 22:11:35 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E426F3C909D
	for <ltp@archiver.kernel.org>; Mon, 24 Jan 2022 23:11:32 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 92C6D3C2911
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 23:11:21 +0100 (CET)
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com
 [IPv6:2a00:1450:4864:20::435])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 2FC882009BF
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 23:11:21 +0100 (CET)
Received: by mail-wr1-x435.google.com with SMTP id a13so16244707wrh.9
 for <ltp@lists.linux.it>; Mon, 24 Jan 2022 14:11:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
 :content-disposition:in-reply-to;
 bh=0a3g+xV6LckzUTAjTCU4SC+Zd171ft53Syb7LkkBvU0=;
 b=jaIHZTFtf/pmPCx1seowPHRyrC0RY+r5pgiIUPr18n84Ik9oEJMMTTCAIjRJYvZdRT
 hFkBvfIVjE85WdMP0/71p0/MfyI1gmHu0PjOPc5XGbGKHaVbasDgB30nkRCvWJ9PVtxe
 D3H+bylXS0nzmbkqNE2LSY0S5R74ZbuJJvfQSnusjyXHSbCc3FJcXl6sk0bQSRcKUaQu
 99P/QEpBhOV1m/XbccYXnHWZAQxU70OC5nSOOCkgiA1hyUCy57iPuxE9t7WNZfaVpors
 vEFpxTyws1Qi+xr/9wT7Sk+CY1cvaLTl+N7tY3iLHf1vCBX22EArXLmu5tUHVisrwCBu
 AqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
 :references:mime-version:content-disposition:in-reply-to;
 bh=0a3g+xV6LckzUTAjTCU4SC+Zd171ft53Syb7LkkBvU0=;
 b=LEVs+XD6/ke2iOFkyEzi4oxErHUe+TRBFxqp4RvcMCgogYZRQ9tnJTB91QfuK0FZg6
 nh5GPM/Yk/8G3rGdG6r14Vqn2EShzYTiTNnGHr2B7+POYHA6zhEVPQux/S/siBt0uG7Q
 H6AeJCjRwBkVYXwLq8cE/4uhX3V019yr5iJyaoRbUbCUsuPa9eFPfV2JPfUZ2aY0WGDe
 7SrNs/1EacxtNMZnSqiiIFIsQXNu6/lTFsm5kN3d3O+SirHu/pufF1OShRLSnf5361l4
 CBsf7tzUhaUT2UT5Slm/+8lhW3pusbXxhAloRccq+cHQZWFXtBqPirHDfhBmZxkg74gQ
 cySQ==
X-Gm-Message-State: AOAM5307a8/bnQE3YV46K0v9lkYBm4k8h0idQ0iKLekGtPwj/nijkN29
 TugvYBRQlW0bQNnR2vto3yHoOLsdlVHJ/ZUv
X-Google-Smtp-Source: ABdhPJxsoFnes5hrsRIZLoFqtJDIMpXMWliYpnqdVeAIxWfRguP2CpqWPqetL0fJ4ZkJ0XMYAg4amg==
X-Received: by 2002:a5d:4b48:: with SMTP id w8mr15996982wrs.150.1643062280759; 
 Mon, 24 Jan 2022 14:11:20 -0800 (PST)
Received: from pevik (gw1.ms-free.net. [185.243.124.10])
 by smtp.gmail.com with ESMTPSA id e17sm477079wme.29.2022.01.24.14.11.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Jan 2022 14:11:20 -0800 (PST)
Date: Mon, 24 Jan 2022 23:11:18 +0100
From: Petr Vorel <petr.vorel@gmail.com>
To: ltp@lists.linux.it
Message-ID: <Ye8kBi5m4uXTEVIh@pevik>
References: <20220124220334.154003-1-petr.vorel@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220124220334.154003-1-petr.vorel@gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] tst_net.sh: Fix for disabled IPv6
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
Reply-To: Petr Vorel <petr.vorel@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

I forget to add v2.

Kind regards,
Petr

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
