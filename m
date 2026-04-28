Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A36FF885D
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 11:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777375417; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=cGvfooOEK7oiAr38ex5PbcopWBspVOsuwoX8j4QNB2o=;
 b=J7c8YP4bmHkZvblGdCAuSftH1cuU7s3wj4tcA8sHnEPWrG1KgEh59tEWipOeuoFM/GSIs
 BW62xLEGwy+O2Pmn0Pq93XMQeISgd2dEPRx/0O89yxWAgvvm+Z/i+lQ3FaKMWTcekQr9hm1
 XpLjAYpfZ+RJKz3lYcb1clY9vqmA26M=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id DBF793E49E3
	for <ltp@archiver.kernel.org>; Tue, 28 Apr 2026 13:23:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 87A8A3C682F
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:23:14 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3530C600B70
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 13:23:14 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-488b0e1b870so192735105e9.2
 for <ltp@lists.linux.it>; Tue, 28 Apr 2026 04:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777375393; x=1777980193; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=XATwyeLgYW7CdaRB3kl73Y8pfN8lG7qIBz5ucKCSHdI=;
 b=BhpYJVMHxLSXzts2NYglXYdpSkbM6pQsjc9cXkyCZ1PPgAUEb4EdpQAp14+xJ3IaRs
 NkjsGz/j1fMNWLUWcN6vcCVCezfxl5GqkTF8WtIWkU0vmF5zn2QlrwF4OyqwGLGNR4UU
 IDtl4Bj+HITTZI+8jkBSD8DpxYyUNffXbLP2qJzm6JN46+mlk2bmBzSfRVqr+qVNxlPT
 OCmaoZaygomdgAHqxW58twzmreNCEqqJjB6vyk0MhhweALSWJdUYe5Fqtn32xYg8f393
 SVmYP+hTfzojPa6zOCfd1VaIjb6Mory/Up0KforzefyBvwTq2tlEil0Nc7d9n6keDdS0
 yQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777375393; x=1777980193;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XATwyeLgYW7CdaRB3kl73Y8pfN8lG7qIBz5ucKCSHdI=;
 b=IKB4ZQG9HB0VmnCIUv3SALr5c8Ci/wcjqAKfzMPPasoEkg7W8e+iOcu91WX3CnoJUA
 hbpeVi9ex0DPLsYw1oyyG/LDqzx7fDk07MxbIzhyc/bV84Gp8GxLtH9ueowuMcT9CufI
 OEAyUbXXE8lpgdquj9YHW+A2tUwVHq6xfrOI2H/VyY4skgitK2sXVhAlVg1vVGCcWLi4
 eKS9XklENyHrJ7DngKF6WPkSwlpZov8Qd8q0YKRppiM/fkFNFQBgFPWVAzVIKXOI/gJP
 LWNKOHmW10HY93UAeS245Thx+JpHgKuOTtOhhbakIXVRiHCiMkx88+fvGRhphD6uIdfs
 0ZSw==
X-Gm-Message-State: AOJu0YwyNys74afaz++2PjmJYJQDah2C8DN/iZtnro8+xomgYNormRzj
 uiYKTX/Ox4btCm8ImAeiNjkJmSuwp7hZmURejIgcJv8ZGUWlW1nkqPEQl11Ud+Vkal8=
X-Gm-Gg: AeBDies6yFwStYyQ44Zro3/dyuUq1WfxSeW79aix8sDVYM6y7mQTzmVNOYts/NAFihX
 yEqAZERqPpLgAN/8vA7YQq0kJ6Te+c4/TNpUnZipRb7SRvXqOuf5RxM1yHN28FSfZQgx+Cybf27
 KGWgE6uWEc94mt7ODjGRYHTvb0Rt4wWUmjOz3goo0c6A1teEWAcSqOa8Jnzb5M6St1wJ+g6RHto
 Rc/Cbk5sJ10wC60ymjgN6K7Nbu1Nv8XU9q8yYky7TPGOc14QuWm+iaPHUcv3F1JkUi8KvxuSmv4
 c2H74Iqa6Znu8tO9gmrtWXJ2taqrZXxdcKUz14ewqmnDSsNbQWU//HR2TdolJqIZs5pqMLDYWjw
 6guViDxgrORpxdntH1PioBB5kMhfemnLTTJzui4nFPmY0m87Y7AIHkfqfPXN6G7KnOgcw9ByAEI
 id1aLrinaZ0yiGUpRvSTPfWLTBzrRezYHW6hlux+Qdbxd9ZhpOHOhugQGIlqtQA9pb97Ab+gr56
 YMQjvMegaN4Pn5l75b0Kvh9sq8iwnWe/Luc+Xu3B3mFjg==
X-Received: by 2002:a05:600c:138b:b0:485:46fd:7887 with SMTP id
 5b1f17b1804b1-48a77af5e1cmr43193295e9.13.1777375393445; 
 Tue, 28 Apr 2026 04:23:13 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a773e7c26sm45981345e9.9.2026.04.28.04.23.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 04:23:13 -0700 (PDT)
Message-ID: <69f098a1.050a0220.127d14.da73@mx.google.com>
To: "Piotr Kubaj" <piotr.kubaj@intel.com>
In-Reply-To: <20260422103542.20933-2-piotr.kubaj@intel.com>
Date: Tue, 28 Apr 2026 11:23:12 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] cpufreq.c: add new test for cpufreq sysfs
 interface validation
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
Cc: daniel.niestepski@intel.com, tomasz.ossowski@intel.com,
 helena.anna.dubel@intel.com, rafael.j.wysocki@intel.com, ltp@lists.linux.it
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi Piotr,

patch is not compiling. Check the results in the CI please:

https://patchwork.ozlabs.org/project/ltp/patch/20260422103542.20933-2-piotr.kubaj@intel.com/

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
