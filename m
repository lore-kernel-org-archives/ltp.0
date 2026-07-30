Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460E4C55160
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 13:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1785418724; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=a18zBVm65Vny0XNo0Nt3G+7lusrFBBHBCN2ivMqTTGM=;
 b=nKPxxfk3lLBwVyK8cK85/gXqJs/a16aVTsACPUi1tqvDQ1l3hnsvp24pbGXObknvohEW6
 RffvSgnATB3Oy15NMVaCzUSR3yzl8ubwiiohNcf3ujXLIBJrUXyowyGRkMqVGfYbaxh+XaE
 FBkAUjBCPuUI0BWwQWA7HclXIuKjEBw=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 713BC3E7250
	for <ltp@archiver.kernel.org>; Thu, 30 Jul 2026 15:38:44 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83573E7282
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:38:11 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 322EF100037C
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 15:38:11 +0200 (CEST)
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-498028b3d5eso6708545e9.1
 for <ltp@lists.linux.it>; Thu, 30 Jul 2026 06:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1785418690; x=1786023490; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=8uoq3gwdSTcBln+LHH61gjJSOkhGa8uLduFKNQMFlz8=;
 b=bXv2d+GlcbyL4sQMfTVdoEwdDE/eD2FbOrAYXEGzngFMY4yiP0ziLqra0ve5FzkroU
 EMLF216hUY4l3EJxDoDnidgoc5f6eU9mHCI8JGMW3AcDp4+VIK0CpXzZzO2e+sJ+DiEk
 10prsXR97ELCU2CcDwNArAVcJ955ysP86U2Yya/IunBzV7hVNcBZbTyrAmR95lXSgGDt
 S9LJTq0EvjUgpcAbHxTzT0CdoWI62AdC9mp3RgsHTFrIqJYQkkWzZNWBGAzs8DKT0Wry
 cOlg+EO8hrogeowbSjoZgwdozLCGCCCfOIaWs657/NunFJ2s+yn6LQDC0uImcQ08i0Kw
 Oyzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785418690; x=1786023490;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8uoq3gwdSTcBln+LHH61gjJSOkhGa8uLduFKNQMFlz8=;
 b=Mslo04lAcTjdve608HRca4/fPVFXEy/eJHWe32fKKhVodXC8VXxdDfcecifzvYYkSj
 CfCwN1siczoA/JJk6VSjSwzZoftCzI2EL65aHO/CdmFPYa/yJu5WUy7cabJH6cGSVAce
 kxCqn37rj4VNP2ZKK6ATzrLFkQn04F/895WKcwB/8xnduwoqzM8ATDKMexPlDV/ZS+kh
 YKDztOYfaZpiyo0VvV5a1My5vCXrzSN7HmFp32UE76S4EPS5+ang+MBSDSydAV+NxdMX
 dmQ8F/RDG3RlxlnRzJckxMT4psz0ctyUCQREQFyqJ7CkfDj9q4hbf7zluXP2pz376t89
 AUIA==
X-Gm-Message-State: AOJu0YyUiWufiBoFMzZD6Ln7LExq/QAikudLlWxkAAcK2OXojrEENajJ
 xUNU52ers+VtzrzZ1cwu/0uZ5pfeIEc6oQHKkj2GVJHXKsQgHGHoOD7NVGD+soczWkw=
X-Gm-Gg: AR+sD10sNYXMhDTugRnBV2ofiWsp2hU6pJw5Bg1F69jV7zu8EAJdcAF4np3HDWequ0z
 rFcVap0Aiu8wLWCPPLXhyOYAXUYKtRMbZ/x7pbPGPb02zXIbotLrFnNRTIsZn55oEKBF5FtQRoE
 fWbqx8th/VGE/QxUgcdAdMBqfhJEZPkPfH7atamE5Tpj6fqDv26LPj6Ckp6r2+vF0Li0Z93k5kV
 OO7vJcEkLs5zODENwlGm3K677A+c/+jmZUdUw229EAS24TxCFl1ZN92At7tJpkxZplLt2FjJCyS
 jIVxhQjBfvcWlpONJjkfCFldzwwgeBwNas7Bh6NUeXi9ChjdmqN3Jm0tBAq4O/Pwqp7+qHxgIqm
 RU6mXhjNpcNBdgkpPy578Tb/LIqHhlWDBMJwZ5IgUXDdHxllU5iqy+iAx/4qG8fVqH58wibUDWl
 8xbtGh5q4bUZVmYlXYx7+jpv7z8PeD11jf9ATFnHtdWsUtJ5pLJtzcRlwM3qbPhqD8JOAMHn7cc
 COHJmRGVbk0XfWsCr+lLKz2lhcYBrx1GODNuA==
X-Received: by 2002:a05:600c:524d:b0:492:4e09:9fc1 with SMTP id
 5b1f17b1804b1-49800e76529mr36902265e9.15.1785418690563; 
 Thu, 30 Jul 2026 06:38:10 -0700 (PDT)
Received: from localhost.localdomain (p4fcc8213.dip0.t-ipconnect.de.
 [79.204.130.19]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49764d72d9asm145115355e9.3.2026.07.30.06.38.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 06:38:10 -0700 (PDT)
Message-ID: <6a6b53c2.1583746b.ff433.885a@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260429105644.986278-1-pvorel@suse.cz>
Date: Thu, 30 Jul 2026 13:38:09 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] Move runtest/irq into runtest/kernel_misc
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
Cc: Tim Bird <tim.bird@sony.com>, ltp@lists.linux.it,
 automated-testing@lists.yoctoproject.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Petr,

what is the status of this patch?

Regards,
--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
