Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9D25F54AAF
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 13:10:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1774357819; h=message-id :
 to : in-reply-to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : mime-version : content-type :
 content-transfer-encoding : sender : from;
 bh=kVKbHXjaeYCt6cxkZAqV4rPG3xHJ9aHFngZeAyz1xZI=;
 b=Jrq1/zdLH/g9PI4rN5H/+AbmvoX9JkeTeu3+rCwZXeCJOdvMTgmFHm3QTJExFYKAO2hqr
 7iO+pzA/EEK49KytJIfXz/ylKD1LBSjvKOzuZmraPIj9wpK8rg+epuSfES5W1toj9C1+TD3
 zB/f55n+4eE2lkN8iwvUWXGTyHskVms=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 61BB13E5540
	for <ltp@archiver.kernel.org>; Tue, 24 Mar 2026 14:10:19 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B44103DADA3
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:09:55 +0100 (CET)
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 736AC200CFC
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 14:09:55 +0100 (CET)
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-43b48ac2727so946985f8f.3
 for <ltp@lists.linux.it>; Tue, 24 Mar 2026 06:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1774357795; x=1774962595; darn=lists.linux.it;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=ZiW+ifZ/2VvbATZDohvut1+98RcXe5sY7SLNf5zUOH8=;
 b=ZOs7C9mThK1fBTDdGFrhUkHuJOuG5swWimTy691kCBkZ5y5qxCZWDJwlPM+mmmuu7Q
 Tz+CK6JdgaR0Hz0gaLqOWQzUuNCRXGrsWb4kzG0qqrzqWLCv6I/a/du+3K4sJR1pEYjJ
 TYNlVcrosrgpfjnj65rmLC2gTsyU5iOvDovr6NfVswZimgGVjCAJK5d/pb5nGLg5iT9V
 rnOWOgO8ikfQTVeu5b8T8bmpgBNf0tuFRrHhAOHOzxqpXXvH7zCK8icAFlmqTBFvpy/d
 QtxCdk5QUIEK4A/+a5+VE7pA+A9dSuEhjHadxf74O8cmRxmb6U98dErlWyZ+v0LYCVS4
 JvwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774357795; x=1774962595;
 h=date:content-transfer-encoding:subject:in-reply-to:cc:to:from
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZiW+ifZ/2VvbATZDohvut1+98RcXe5sY7SLNf5zUOH8=;
 b=Q00heM0V38Pti0q/DzHVQ+cyAk1CsuO/WZJENVHnAzCj+1Oy0HDvcaV0ordbKrZJPq
 YR5yM1al/q22jT1AuF9sjbn7dmnMQ8bdImY+S76UyNi3UkokF6d81rEwgE19mb+NyyC6
 QCWc3TzRKVPQK2dco3xbKxXJXSMMBbDNip0TLmmxde/YXVcAjYqI12KGbzUPKPzhjQEw
 aiW4r/ATYTdmXsz2lV4nr0x9nxoItf7TXo8wa/9MPJqjGh6Fe2vyLcIY4hLXBrntKrHP
 EWcGagioXl0t0yGmcO3R063CA61wmSmfprt6tsAUBFJpRc2KnLfZhBjUXbwLi8vjVbPY
 Bv1A==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5OR6P2Upr1HS6cYDBiqJs5hVU+yJxVqMh9crqly2ALXqDAUqonIYyOF8RvY0M1hPETn8=@lists.linux.it
X-Gm-Message-State: AOJu0YxnDPQGY/WVZh/64zBhyTE8Bquxh0IvufQCXqoc1XU0LttBs7Do
 eXG+lx26SKCYx+pXEq0zjuo6kpp0anwl8H8J+rMqr40qpYFx1W+RGFOmzTd1BPCVrwwgJym9O2g
 9BAmU0GA=
X-Gm-Gg: ATEYQzxVeVEIxiayxqAL8J1g+9tUirtBd0oVgNBQjft/fmRwd7KUzDE6E0gYc9IYCT5
 Lgx79OPiKd7j4HDU3mwSQZrAo74YdSXNmDK1kZMIA2PaJhstR1Z0me/RCNCXDSHWnOgN99DteYe
 jYhGuqrzJ11+wRnSO06xlYBCtk9fnZmlMDs1K8fhdmcvstCCQnzjKqMR+QzGmN9zmyCMc+vlcen
 J2kmDKzCF65/X7VoB/G9QGzBPhY45ljWf7WsQsEH783LOckZ9JQTN3l4pR1lvPR3bt13Ax1/uwp
 UtXCgrXQ8fOU9fx9X2aaiHJOmn5lSWh5gSUrlsfO523Z4sYyWz/anYUOPFMOello+SU7P+1Fg3b
 WvrMVExwNXb0qJ1FdSIoQpr1AKpqieuqmqMiwNpDm+YtHJGbGuOvHc2C/nEfDnfigmv2nt9hRtN
 x84nPnArCTBaFNZk6uNpVwFd1H3jtOXMT/AxVwhb5U
X-Received: by 2002:a5d:588c:0:b0:439:ba57:5001 with SMTP id
 ffacd0b85a97d-43b642878b8mr25274531f8f.44.1774357794662; 
 Tue, 24 Mar 2026 06:09:54 -0700 (PDT)
Received: from localhost.localdomain ([88.128.90.14])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b6471a297sm37023075f8f.37.2026.03.24.06.09.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 06:09:54 -0700 (PDT)
Message-ID: <69c28d22.df0a0220.10593c.e983@mx.google.com>
To: "Petr Vorel" <pvorel@suse.cz>
In-Reply-To: <20260324082047.GA36627@pevik>
Date: Tue, 24 Mar 2026 13:09:53 +0000
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] dio_read: fix infinite loop when readsize >=
 filesize
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

Thanks for the review.

Merged.

--
Andrea Cervesato
SUSE QE Automation Engineer Linux
andrea.cervesato@suse.com

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
