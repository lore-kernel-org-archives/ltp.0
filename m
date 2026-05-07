Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 219BECD3427
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 08:30:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1778142618; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=g3zs3r6rQ8OBjIt0ik5Ud7QMQc76BI2+gzvwiI9j3lpLqeNysVrLUVIYL3bCVvGkYcYtR
 T9FfAZt7tJJ/ssqhmg8czznesWsHeCdrhlryQrmOXm/oBoHL+Q+JNyJl74u0e3p2ZZGH2z5
 YtGDw2bvjUdQQen1ZUlK767fUdIBHxk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id C17EA3E5F5C
	for <ltp@archiver.kernel.org>; Thu,  7 May 2026 10:30:18 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CB22B3CAD2E
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:29:41 +0200 (CEST)
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com
 [IPv6:2a00:1450:4864:20::331])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 0E0FF6008BC
 for <ltp@lists.linux.it>; Thu,  7 May 2026 10:29:41 +0200 (CEST)
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-48d146705b4so6735215e9.3
 for <ltp@lists.linux.it>; Thu, 07 May 2026 01:29:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1778142580; x=1778747380; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=eh7osQjuddTBmK3MkqXbNg7l5NQbEhnTJdbpXRCriZz5LW5zdp9Yudi2mCpSklcrYn
 DOAy4EYqmxcLb/EVvqK/80f4IeYCgbhBDzONCRz3EmbwIG36eXsRP/njqyS6t3ucXD+H
 58t8BPkLdeCWkkSBaGOMvosmv8CO+C5MhwNTj27OXQs5jTHGPYmUPjXDLOpzWfJOL/bN
 Qec2idnxaZpu4ANwL1Y0jwNqWMu3/KwhigivUJ0d62VkUytvqytKl6WLUDx89b0XTgxE
 EdEKG/TkmTLsv67Q10i65nexmTeWyBjMqSHi31wf1ukRVoA3zmloBvWcTuMNvE77WSdX
 df5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778142580; x=1778747380;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=FY3YujaZ8185uNTfggMETxVaSzzVMCYYvht9MAFz4BBKo5AJYXlJJ3LiaJ7En5fAMz
 KnfzZLg66oxCDjvsBoySNXkVuPFKWmOtI3TlHDnAyacF45+gJN4UBX/KloAuAaraBVX5
 t/GwQ0K6p/7DujfBzmMCSSCM3kdtLpfjuaZ/1fEdZ2EYnC1rG1lkZY8LpW0tMrIb8F9n
 tw5rvy5zcLFLmTgsICcnFaRMFqrfmytxk+ZM4quhrlXoFjt2lddKRsXSIwDeianWgfhH
 GVxKlnETihBnRg6ko8mRguUfW3YNCeuCbPBZiskQLthtZfad68sHwibeQVVeGSBK2d7o
 2zlg==
X-Gm-Message-State: AOJu0YyTWdXIxzORwdr4LEY5hmofPVn6dSvIvpIN8JLXkyTPBS450vaq
 aH+4cSmGY9oXrKG6Q7P6KiTtuBhyvUnbutaKzL7HvBelQRMl8YgDo2ONxCrsQYUpRfsRKpqNZju
 A1s5D3KTbFg==
X-Gm-Gg: AeBDievLkrFg8N5bPM8qU+Zk+tHZrGL7bvJgo2qvNP4U2WfHv1wlWzyG2MqQkXg5YO/
 rk62LybyyM372FBvbyxgtOdK2R02jcFZEVhVchDqX9m8hcKkm8AN23uxmy26hwBdFVckhVSl0/M
 JVQIZ3Z0B/ZkEnfSUmq+t7sksdKSy68iA+yWsRIbhv1/7t+u1yeVYIZQjoAD+GmeAcBKhV26+Nv
 5NoYRjhtpjcWAhEgzpvRU1gcH8e9TPsv33k77kxJo45oCkDoukq0OBvKsOEPwmkV8tYQl945UfY
 vxon7NeI4qqcLASZXRN/Bx64e8qrIus94cCNSiKlUltSvJnSahMoR7P/PsmyJjPU18zpuhfBNzp
 9HcDMO0Dvek4LwR+/b4oYy7piXkrW+dVVuMwDO0CVsSErsxihb4EJuS4XNfMHNsuiXv8mJzhAMV
 3q2fnx/cxdQEmn4REaIp9v6qknm+gxKmLXrKqAZgww31wQKWK0AscVIZdmVLzdblU7rgKt8/t6n
 6bgoldSvrXdY5Yb/sGbHOkEKft0IUT3olwIZryFGk346N8qLYc8c4Nd
X-Received: by 2002:a05:600c:8485:b0:489:1f3e:5f6f with SMTP id
 5b1f17b1804b1-48e51f327f0mr115731365e9.12.1778142580202; 
 Thu, 07 May 2026 01:29:40 -0700 (PDT)
Received: from localhost.localdomain
 (p200300ef2f4fc9009ff26ae1d4042002.dip0.t-ipconnect.de.
 [2003:ef:2f4f:c900:9ff2:6ae1:d404:2002])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45054b02abbsm17599198f8f.18.2026.05.07.01.29.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 07 May 2026 01:29:39 -0700 (PDT)
Message-ID: <69fc4d73.5d0a0220.a01d5.b254@mx.google.com>
To: "Cyril Hrubis" <chrubis@suse.cz>
In-Reply-To: <20260507075006.8690-2-chrubis@suse.cz>
Date: Thu, 07 May 2026 08:29:39 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] lib: safe_file_ops: Add
 SAFE_FILE_READ_STR()
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
