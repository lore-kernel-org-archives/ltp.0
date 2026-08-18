Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61CEFC5DF70
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 08:07:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787040433; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=YwykXcZvoW29jWEPQDFjjO0bfuu8zKUiwVaDzBPHrik=;
 b=Yb/+CLxWBG1p/jxSJIiwPk4tbyu2Sqp7GtDuzaAopvP1MOkffQiRaQo8ejTKsDD57Qhzi
 s8tM8LfO61hj1WT7MNKTdMHAt9cyGIvzz8h/MaW6H78YBHgFkx3uteOFZLHYk70zyPLjG5L
 4fWqwbOlZXfPyl8oXCL9qAgHKy0JkBE=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5E4F23CC25D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 10:07:13 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C8FFA3CBDC7
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 10:06:51 +0200 (CEST)
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 23CFB1400C4C
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 10:06:51 +0200 (CEST)
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-495590dde14so53348025e9.0
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 01:06:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1787040410; x=1787645210; darn=lists.linux.it;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7jXhlp/p3dadyqU0/gdEYNc4BiZ9sPRZFfJf4J5V/+g=;
 b=J7ka5kpeELAUYKW58JF67zh4xcYYvIczXlcWjBx+1NNMfLTHXlq5lfXo0+QT5gZF3v
 NT7VwIiCXDM8GeUenomrIPVuIRi0+n8bWGbn+m8DAd8Srlxu3e1FfNxRytB5B7jGLol5
 9l0hmBbhD7+cE+MokDuc22hoa6BgKJGj+OHKIHeK22nCx6jtWgLVRs1rj/1f5OFUe2qQ
 NA8Dy2T6oT/6M3se4MHKIunir1lwsQpp2N7guQbpWHqYiVOk04CI49y1deyFKMJxh2vt
 0deA3CAgRdUOO7AOxWs9/fGGLHR+uY7UXbee0LpmWc8Bys0+eTPN1/Iko0re4ju10OFi
 C7fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787040410; x=1787645210;
 h=date:content-transfer-encoding:content-type:subject:in-reply-to:cc
 :to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7jXhlp/p3dadyqU0/gdEYNc4BiZ9sPRZFfJf4J5V/+g=;
 b=ZVR6gHEEc7PJ2HhRqS0/+LHqdBZLRDLtqnXA4N/S1g5jkyoz1uQORTcROcCrTr5ZJC
 qQHx6yXIQNVZTc+cJuVJIP5ElpZMDd3Wm/u1vfD4PWH0pph7op+ZBkKZF0Tt0/WZ/FsV
 e5A3qQP6yxkVaoTJklrk1HUonOum4H4o+TvDjjB79+0WnMQ1swFqaPRGbe8byOSDcRqX
 +8WapFOzreOp2i98Mb8P6eCjuDvs2VSoHUqufWnfrjtW4EPJjIHre4JCcpGBeM9EZPTP
 T2SL82tIpMpZ39Ub1BUUbS/zeL0YOx0J7YHk2wd0ozfF+5eYI8EIVDK/zTXR5W67HrEo
 0MBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RojQ0YNwjZ43E14Q5oKwATXnZzcrE2uVaE3uJvC+/5xC5xCLT0XxA/kcfuSZY3dPY/npSQ=@lists.linux.it
X-Gm-Message-State: AOJu0YwrowUzakGyhmCzmrrmNXVYb4djW6FIpiT9fSFinX6uRF6huds3
 yBtG9ytv4X6DyZ0UpVrjdwat9bTdrJzbe/mmlaLeO74Y5Bi6FsEzslK4n9L602G8aYyWSXSRiBO
 fg7vkQSI=
X-Gm-Gg: AR+sD13W71sseUGvud/JZFdHDbzwguya6lTcRNlp/FMsN1RksX7QnnoOEANIz18s38L
 cesQEKT63dl+iOWzXbEl34ZE8bXH4qVYPlD2jBO8ykR5qFS8cxGiI2kuI9WKKA5Y4b0R6vRwY5q
 IuoOYP9zEae7/Ltkn60aJd2EoI3PKkieicfjfn8CkA3gQrDSTTH36ksNWS39KQwDwlKQvek4czT
 ijqnqtY/LbmOnEI0xszghi2BO+dc5zy35vT65Vd0Wewot7UAmY8C9VJKCDxYVi2+b2Q+M54QR6e
 Z4la/pkhJvlmxUhnAWCldBly+rh7Vfz2P5pmKb5qYeBrL9+OFZXO1mvcLUEM4p+jqPQYGpBJ1wr
 8vMISnRe61ad9hmWIBYYOYKQKnZsOPEEkbYlDoUG6JIopwLIbPKXSFQCIlZXHnhLM2VlMlvHNTv
 RwUebYP/0jMnhbO08uKzkRvuSv9ioqUElJLVeuO07+iLJlMtwbU7QsAl0IlSZeNPLBOx4hJKM=
X-Received: by 2002:a05:600c:3b8e:b0:499:a660:f926 with SMTP id
 5b1f17b1804b1-499a660facemr6665415e9.11.1787040410442; 
 Tue, 18 Aug 2026 01:06:50 -0700 (PDT)
Received: from 192.168.1.121 ([176.206.179.213])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4999d10ba73sm114920305e9.13.2026.08.18.01.06.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Aug 2026 01:06:49 -0700 (PDT)
Message-ID: <6a841299.4892158b.c254a.03dd@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260811053554.GA1613289@pevik>
Date: Tue, 18 Aug 2026 08:06:49 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] cve/sctphantom: Add reproducer for
 CVE-2026-64564
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

> Good, it can be removed before merge.

Merged, Thanks!

Removed TEST() as suggested.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
