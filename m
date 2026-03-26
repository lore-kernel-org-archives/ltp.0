Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D413610A62D5
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 13:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774532504; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=RWBj789HCSiUrKB8R4V2KKfYWo3b/dWdN6e1tu5kcT0=;
 b=Z3OSXiNWY/p6mkSPtO6WaQLEZubvwgBxKpqIO7WevgsvB6Huh2HV2fI4Hw7LuIEnrGTzd
 9k6jA7HX/oX8+OPg6sxFnOEJP1zfYKDm0/75H6fVPgwAY1/iWWTSLIxAKXZXalnrt5ny1Ru
 r6dwJfcWjEaVTTEZvdkpYG+UtAzIRrk=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 503E23CC65E
	for <ltp@archiver.kernel.org>; Thu, 26 Mar 2026 14:41:44 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D25133C3212
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 14:41:20 +0100 (CET)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 09D9D1A01200
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 14:41:20 +0100 (CET)
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-486ff3a0fc1so9705505e9.2
 for <ltp@lists.linux.it>; Thu, 26 Mar 2026 06:41:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774532479; x=1775137279; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=c4NgjQRPU/MhljQCim9b2aXq2Xt91z0SE+ldM/FH66bGmb6CWHlecby1Ns4smgalY9
 mXdCJwqD1cXD5pt63+kOxrGMGpQI9HnN86wHgFY7kPZmLn+tBicyk+8yXVkRW8hb2so0
 ENYlZgvq0zVJ3ulNejKhjFXk0VdHYe+Z0ibcHqRJzTrD0ZO2Hgc20lJk7EyPo8hHgJbW
 MNn+o2pHoz95AJGPIhchFiFJA4PkgxeihRuEMAp5exDy7HN0LuObJPFPuHJoBs0nyLjT
 4tT0q93q0MxVqI0QXs4QPgo6ZDo1se4by/pt4zt+dTc8lSBqyVAYx8P4DBoXDegJGIc+
 Ciag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774532479; x=1775137279;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nIYZV4wIwN0c0BMAf0MMCsM9Xjm5KWqPcbqWD98uGZ0=;
 b=Vy1rFU/wd88DVRLSCrgrnYuLZ7uZLIhF81fL3BOy/bh0N1qa8SUT0O7VzWlm3wr7Ax
 WPo0SWcaoi6Ll0LZUoAchF6e9Zyof5jy44IMPmImvOjl+1IyR+5FPfAO6K/PgVEEfCor
 P6pzX1qmVLRGg5WZChGy6oK2ZEaLmHgq5Q9wnLJO6deAitQNPAiFge6j59YfixlmQEmz
 fw1qn+jUMY1tOSlg0Fci09pu+Ij+NJ9GcQBp5Twt4Z7PRuiw0f1BjFW4DoD8OT/tG8wu
 1JLuEE0MzA22m8QkMMqATz78OS8DFdqPZgqIEWpGcdJPehy8oLaj2DdJErRMS0fUE1Tm
 F6dA==
X-Gm-Message-State: AOJu0YxaqD7La/FyQq3yWEetfZcymPn8QWIEklRDXi7Xx2dt8U/mM/Es
 rLciEx6LNxwqFr+fu7o5e71NoluJH491vj4RYrGJVXvMKNViNG/IUw1XaxFF7Erote4=
X-Gm-Gg: ATEYQzyM+nKI9C8ZHCC+iAEP/eLanYMos1nGNLgCxRA+sT9xeAxUrK1sEwhgX17SFv+
 UQ3EiYPc6CLFgcHKmcJBh7+nxi4PdSiMbfzpzfcMEj9YSV8VdrrYnqItSAmrS60yQfdpzlKI6rM
 sDqt6kRV286kLRPUvxdM9JuC+er57+Sd9Fa2wOzwxOezJjXGNkXUAU1KSpF1+aHwmn+q40ZKw+X
 g130hPY6mEXGmeTRLgDSGvWhslIU4fWOF7yNxDSfX7X7rvqsdIIwvDPrCpoeiDfXJ5MJBx8nK2Q
 UVUP7VXGnSoVjzz2J03CKcLWIGa76ESfaN8xLRqgLx+k/9FhBClzr5NtMcMz9jNHD60X6WbEL+E
 12G6zC/40yZ75RQnqfRe5Inw7b5zRka12W2e318dIMj6AVpSE7HrE63bUJ6j2uiuj9NQ06p9qRL
 afm2tgazYl+rMq9zJFSBKvppLJIdz6dKZ8+Ve+EzDh
X-Received: by 2002:a05:600c:c086:b0:485:2fc5:3a5 with SMTP id
 5b1f17b1804b1-48716056385mr80942055e9.26.1774532479327; 
 Thu, 26 Mar 2026 06:41:19 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48722c6b495sm71804925e9.2.2026.03.26.06.41.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Mar 2026 06:41:18 -0700 (PDT)
Message-ID: <69c5377e.050a0220.cd726.a50e@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260318132639.18818-2-pvorel@suse.cz>
Date: Thu, 26 Mar 2026 13:41:18 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/2] runpwtests03.sh: Replace modprobe -l to lsmod
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
Cc: ltp@lists.linux.it, automated-testing@lists.yoctoproject.org
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
