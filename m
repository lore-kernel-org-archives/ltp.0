Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0718FF8867
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1777473726; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=dirhb8eTVETq9sgfVNIIfj31/v8wzctM9owyJQFbSeFQyRZAN2W+xft7AdzFq7UAlUkbk
 0KHTXiPPmgKgz6w4oEKbKGccEgryv1XxxF636oXE0vX1kQyMod4jyUT/bLFnRxalOgA6C+P
 rkVyr5XFWDdt4qQzTDRyXvsmiJGrumU=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 9AFB83E2D43
	for <ltp@archiver.kernel.org>; Wed, 29 Apr 2026 16:42:06 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 5DF3B3E2587
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:41:42 +0200 (CEST)
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 6E69E1400337
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 16:41:41 +0200 (CEST)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4891e86fabeso141549015e9.1
 for <ltp@lists.linux.it>; Wed, 29 Apr 2026 07:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1777473701; x=1778078501; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=cpy0hh1r04GUejHbUvjKz9yzlVo2zuTw1wMrBY4niWfbpNt44kWe8FtMy3sMrYzQVU
 v72sSW9Zl3YAJZkvhoOPXbMTROAIt6jrMtOa7YbQ0GopspNIugIF9dONPIx99bLV8qnI
 9NaUYIWvoB2/eL1iBlhBmiaMryggD1/eU5jWfKjKhJYVSsOOJD0pOU12IusSGiBSYxYz
 uWddGhg+gh4B7ofpI0FVWmZliGb3V1THQlpD2FKLc+Eeu7UETrdgHQ3FHWnN/el6htT1
 O6LxfH5HtsnwpKf0iVwOSUNii+yAU9RxVSvs9qWmtjZxkBASJwYKtflqisagFWe7JqLz
 ysRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777473701; x=1778078501;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=TWbFeaVMfoTaSSXk3O/9OeeSEg3Ura7iCXjlx76gcVFfx+tNmIBvlcXuWzZxGkpVu6
 6aGVdmMcE70GlE6Vv4yZ/vGUyLzt9LSMotiXVoXdKQJcuS8iWvwx1EhehEiXt3XNgP9M
 WhNMlKwWUunK0UTLWuOW77P/MaCLqk/1jEQMBcpXiQPQUX/3acBSI1qJKx+5iC0l/lyO
 mkX7Wd3x2+gehPsERcnb+hBo/dDspuDoMRxowZVNQasxUhiJPNXcFRc6FpeVytTwa64E
 LQTzwZzWdN9cvQvQL8Bwoy4zj7SxgvSS1V8iaya3ubOkfuzF2mbgprAbRJ+EETdXXYl0
 xQ+g==
X-Gm-Message-State: AOJu0Yy8vvumn2AVN+3CCU+YvZen+l1mLziTc+NugsPNJssXBZd0kh7o
 +l7dTzoHl/DT1lZh2bmKu97p5TNTvWYtb1M4rRzK5KbV5DYAnPBEsSC9UpuP4OjiCapawh2MyEa
 X9eXaNyxB0g==
X-Gm-Gg: AeBDieuZORl0gZqHQLTe6bAQ48nPTtoFLobfhx/wuFEwYya4WLCi8vYYxCnlcndtzqd
 85ndh0MvvYWRdl0LmfCm2rD2aWiioSkSWQYVH1zQVqxqzc6TuA7AR3tJP6d9mKMI9UKoaAUcKDA
 e0mvWUDQqQg5a1HLqmXdgTJtnQYZ+ZbyxT0cW9n1dqZEQ8v8nn0XEnbSHprivnJqMMCJCrYrLC3
 Tp9Z6yy6d3HdGVBkN8sj9YRgE+FSMgITzhpJ6vgasiszyZpNuLwPPK2OgL0i/+lezG5wtHg6YkG
 MphdJIiQhx7WOvSZP95MP0c/0ydUPrPQzq2WSOaXNstO+GYDLLn9JDElfFloT/CvTBxxIriMz/x
 RyM03AN9BvaJ+Da6OmEq4Xx7p+5Vx/Qe8lvuQ7T8Brkvt3D2SiS2knaLSkBYFhJB1lsObOF64Yu
 Z1ERemwFG67sV4XPZrlGFVXjmKH5bYSbv7R2D5oQVnHRKOd2DXlQ==
X-Received: by 2002:a05:600c:4241:b0:48a:80cb:1bb4 with SMTP id
 5b1f17b1804b1-48a80cb1bffmr1960595e9.22.1777473700589; 
 Wed, 29 Apr 2026 07:41:40 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.1])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b72176fesm6021170f8f.17.2026.04.29.07.41.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 07:41:40 -0700 (PDT)
Message-ID: <69f218a4.df0a0220.133ab4.ca38@mx.google.com>
To: "Soma Das" <somadas1@linux.ibm.com>
In-Reply-To: <20260413180725.411367-1-somadas1@linux.ibm.com>
Date: Wed, 29 Apr 2026 14:41:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] mq_unlink01: fix EEXIST failure when run in
 parallel
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
Cc: somadas1@linux.ibm.com, ltp@lists.linux.it
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
