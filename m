Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF2BCC624D3
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 12:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1788523418; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=J7Q+2mUEC03kyJgkwkkUop4e10gmWp6OLJJX9CVLVE4=;
 b=D5uIE4Fl8PLTd/CtIkXvdnoCa+rcsatjO/1B60zRc1FTo2sLD2i6O8ImC3CQYiXsZWuLw
 E1SHXjIcqAQLjoNR677V4ueWAdlLSjIkjaAaAnam5i+LxFfOQfiPFyVgZUpUS8sIs6lCAo3
 1Ux/Gwp7QjLrwEWiqjCjH5gtRwDFVDg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 936983E9762
	for <ltp@archiver.kernel.org>; Fri,  4 Sep 2026 14:03:38 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A10A93E5506
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:03:19 +0200 (CEST)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E22C71001122
 for <ltp@lists.linux.it>; Fri,  4 Sep 2026 14:03:18 +0200 (CEST)
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-49b9320423cso10092255e9.0
 for <ltp@lists.linux.it>; Fri, 04 Sep 2026 05:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1788523398; x=1789128198; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=37+sy+eYpHwhTlj2v6cZKjIRWWYIB2rbVzhZcS+v1v0=;
 b=WFAGkzlyEWMA3keBjQoWqYgBfe8oE7OAnz3YDE8Gw2bRC/Cs/wyDYwLZoCs6DQofZm
 rzNoCD659Ol3OGneRnTbtY5919Q5sqpMtg764VUFoyZBejhfA5+mHHLm5905Mgyiu870
 hQtz8Y5dEDqFcI+GAW5+GHSoG6UF3JoyRAlnw5ywqkPqosR6jZb7Z+/F/jnYrf6GZgn2
 6Lb6OnBrXTmglsiEAk/6ry7fYHbsEDi7+8PzUDcoCvew3Q82r2+eTHCakgNeON6iOVm+
 kmeW7y6qPD+cxZxXfTg3FGkYd53dC8VUCD8nxeU2MRAy9vXchfhoXzGWXHTwF3gwQbUR
 634w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523398; x=1789128198;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=37+sy+eYpHwhTlj2v6cZKjIRWWYIB2rbVzhZcS+v1v0=;
 b=Z4YQw4gD//wth2ZXMoR6t24JKzbkvC/JtAWApkwDxiylUk0JxyVw8acwfIdhI1+gju
 hc7nUFWeOs6lEW676sr9ozp0aS5NTwwDVXJdMgPwL/852jErpN5j29ELvNDJZilzxRyc
 /AbmH9VAptKSy1EBuS080n47XrHB0sxyZJZiuiRLj6MqfYRaI2XX7a0WCScTNp6ztVqv
 Mq96+gn0vCC+oDlVeS4WxoMkXns6ejZFowMIlJFjY6QgxHPnbfRltqXB61mIxkUreBS4
 Rc8GciNosy2vzoqUR3VhMqjMp5DHZMrFde7fPxotPwmR/eGN2HPzuequrNv+v91uUdZ2
 qeLg==
X-Gm-Message-State: AFuF++ktAcMQy+/jZ+NCoetSvl3/R57DYfZXk6NaodLQFAZco89nB2Xm
 Aim3/XVDknMQ6t2jSbTnocdHiMyyb/EfMNl+c5D7NvNucQcRmBXHSiLkz8drXhb5Vvd2Zxx4KmB
 i6f5G12Bndg==
X-Gm-Gg: AYBFou1oIB+F3edtLKGic4avaL3bi+I7R0kjyn+luwkG+NhveoUeIK9gQEoF+TTvwJ5
 C1IbdPIsTkHm1xsA59lvMcPN/QUf6zs/xVrD+L8yh1kRU/CuUrnPTvE6pmDEKdTA3V7uSOtQbK7
 8xsc4VVTtk0zuRwLF8YHBDjEr0dpswdW0fgtGcB+pBQQ1+8wfWg4YdHvVYatPPwY6+EABPpV8qm
 RFKJGHtAi7SSJ2JZeJ+Vd90wA2doehD9OrHeEddb2z5rnEpjlAxnoDZjdGll53IlJeF6EC7a0NC
 OgN6OP+6S9hY9ndi1AAtfylSFAJWX6VJh4PsEpeVAWGiA2V1qsHiQz1ucP70wGsOT8Y0a7W0mXl
 YxItGSumsR1bkHIflJxMReJtT9FXzSZGnPNYFvKvKI9LBDGDj+ui4YQiPzEFysqApTo6wcQa98s
 hT3hhy3tdXX4faQAJYIHPkI0wpa02UFQ01ls6ZniSb+9eovVO85EM5IfXR4O4Y4oGvWRzqKgAE4
 ILX1MvmHcex
X-Received: by 2002:a05:600c:4e94:b0:498:943:ccc0 with SMTP id
 5b1f17b1804b1-49cf81e368emr67934485e9.6.1788523397921; 
 Fri, 04 Sep 2026 05:03:17 -0700 (PDT)
Received: from localhost.localdomain
 ([2a02:a31b:84a1:b780:6f4e:21d6:82d2:5333])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-485883acd33sm5840252f8f.18.2026.09.04.05.03.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 05:03:17 -0700 (PDT)
Message-ID: <6a9ab385.aefdde3a.ed129.d0ca@mx.google.com>
To: "Jan Stancek" <jstancek@redhat.com>
In-Reply-To: <a308e12198ce96305761a009858fa4a80c91f932.1788518850.git.jstancek@redhat.com>
Date: Fri, 04 Sep 2026 12:03:16 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] getrusage03: Pin the test to a single CPU
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

Hi Jan,

is this patch taken into account? should we reject it and consider this
one only?

https://patchwork.kernel.org/project/ltp/patch/20260902160113.1207205-1-nirmoyd@nvidia.com/

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
