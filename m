Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3CF1098792
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 14:36:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774017386; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=qGo2ovQfNnULD73F1zt2HdT0Kjf4KKakl7Rc3Y72Y1E=;
 b=A0uxkJ2ZBjwxvxkQ3oMMPg1wIE6qI47TilC7OuWgvB4+knacju3Pw0jJD06CdNFGk/eQz
 widVo4o1VkqDls/E3zvjwyZ87RdYwByc9o+nCcTcKBLp3TfNgTV/sWoU+26AHF7Rlvh5NvM
 g7ygbsf6s7vzbUYmDNvellHrRuMJNWs=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D350F3E55BF
	for <ltp@archiver.kernel.org>; Fri, 20 Mar 2026 15:36:26 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id AC9953E1402
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 15:36:03 +0100 (CET)
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com
 [IPv6:2a00:1450:4864:20::429])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 18C2310006AB
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 15:36:03 +0100 (CET)
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-43b4f48c47cso560549f8f.0
 for <ltp@lists.linux.it>; Fri, 20 Mar 2026 07:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774017362; x=1774622162; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=7kfNX4sZQxAdE9uXp2t6kx+Am0vUibEZIHeXjPSjC4E=;
 b=guK6UzggMCYvzHYvYTNTddct4bTu5hazlq3wV0DHfAbA4N5IzGNDXB3laxIixGNqHp
 w0W5a5OPwSSYbnVJKQJbwUmfxWGdfPJFZ0MN/OcUXaEmlaTjiO38jB/sdHfKUocx5Ppi
 WWogG4us4a6lu6jL2LSO+WSKtyHxUeiQ8SkJcD0gYJkEwH20KDdbhWtkscePC7DZpGkA
 GMv6FUPlrHHZSyb0TtgXunwzLAs6wJGYFOFCmsLenNgkpwnZNLY7+OR/0Q58grssirR3
 Sug+nSs8B4UvdgzjLK6WjdmWPD7icw62aK38FlZ2+S/l7Y39yAw1OSiF43n8AD4GZI/5
 33gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774017362; x=1774622162;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7kfNX4sZQxAdE9uXp2t6kx+Am0vUibEZIHeXjPSjC4E=;
 b=ADRy9m91BNvLuf+gCeCw2emAenMGVs7xVIKZZocRmxYiGgDw0aojifM8dQE1EJ5MaG
 dfpwFwLm9htO0ZUbcmu0iMVLy8+eH679D1SHKFRuNVzU7JHyNoIbYGgQqFcS57nyoPiq
 5bh0Qe39GrUjAiP9J/3X9BjbS+nwn6KmiKyWYaOt9r60FmTQ1FQ80GIefrtsKbDrtOZZ
 xf6/AQf5CfgQgEAmOY733OHe+xsN5A2VoeLQ2RFkWatIUXk/PvNeMXR0qLWVOZOfQund
 kL6t9X1lKGPhOxS3sL5UvA8sf5/CQ1CCskbhlBtbGMxCQawiXblC653Ph1ra8Eo3OzLP
 Irkw==
X-Gm-Message-State: AOJu0YxpiXGR+OZ1y03hIm6ybbytPQ4fCOhO932Va5eefoK4d8+JcV2M
 LC6Td2B9b7bB1XYVPdf19+xIcR8P4296/D+U2m2hWHTeDpV7Pv1n81/J9vpOfjWRH2U=
X-Gm-Gg: ATEYQzwQU7aLbY12gxdMwWbTeWAkz4fggHIRT5aDqKGUK19wZIxg/kg8o8ViFSpxnaI
 IOImRCEG4UlSJ4G6lbYcllK8Ucj0nPlK0+gnUb0LlmX1GbSc3wl68yD5WFCL3CZAwXZMJw3kd5h
 aQVkjizuNJPNtpavAPVAkJMg6/3zB8BgCA69W3H7ljUZi/iTaDU2pIrrw8yQxXH7eRjYunSAVTF
 yLMDJ1FdVQVSGPVkCAWmSiwPHtuTWk1hMcJLR1tlcZwBv2zxR7F5qgK4dJAUt6IKuNn84qDjMwV
 qSCaOeodglUGvp0czAGru3MVvDxMSsJUXtAVoZHIPlV8OBz3IeYwKgcHKF4MysI4R6BwVDSQUhC
 SDX+rRVPtmg09FqgIy2wnFCnUajmNNu5fTPVj9Cz+R7lZlS2njfe/KU0r8ItrecR5lHfuqoNut6
 35b2toDWFDplrLI8jhL7SFpMMV8X2T8zJWs48fEiS4U1UuhuI=
X-Received: by 2002:a05:6000:1a88:b0:432:5c34:fb32 with SMTP id
 ffacd0b85a97d-43b64257edamr6016537f8f.23.1774017362336; 
 Fri, 20 Mar 2026 07:36:02 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6470393fsm7396135f8f.17.2026.03.20.07.36.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:36:00 -0700 (PDT)
Message-ID: <69bd5b50.5d0a0220.315f1e.026e@mx.google.com>
To: "Wei Gao" <wegao@suse.com>
In-Reply-To: <20260226022536.20175-1-wegao@suse.com>
Date: Fri, 20 Mar 2026 14:35:59 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2] mseal02: Handle multiple errnos for 32-bit
 compat mode
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

Hi Wei,

LGTM

Reviewed-by: Andrea Cervesato <andrea.cervesato@suse.com>

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
