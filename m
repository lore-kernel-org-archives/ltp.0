Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B2F1C3600C
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 08:19:32 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 051033CAAF5
	for <ltp@archiver.kernel.org>; Mon, 31 Mar 2025 10:19:31 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B5E183C1D37
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 10:19:14 +0200 (CEST)
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com
 [IPv6:2a00:1450:4864:20::42d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 99D061000AE4
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 10:19:13 +0200 (CEST)
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so3734155f8f.2
 for <ltp@lists.linux.it>; Mon, 31 Mar 2025 01:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743409153; x=1744013953; darn=lists.linux.it;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ygbZEWDCAdVDHl/kbUEW0EzWhRhhjf1TvIRZJBaTBIs=;
 b=kkFfI+O4qx4EuHv1yKzvqZfXEJkSi8iyz2Z/JNxy+81yUoLUGRxH+0BaH0W1yNuV62
 1xfvm5hAxIhV49H8JVqrdQ7/BPCAAF/E9LO9u42QlolEgak6Z2g+MbJdztQdfOtu2low
 HHvHa78KW+DGdoP+jJJTL1Cm6UIL+chwwotuV5MYKZuMhVWo8rmGWupkoUyC7vZCAR78
 YHx+1Jwycr4PalxA5bukhX1GBsFJtkeuZUDNWDIYCxfwqmOrI4zsDZTqphZ3V9MtO3Bk
 3qVnlWgbVNNEcuLvpsZJi3EkLzzu07XE3i+J+q/LaJXbefIl+LKuWoemBPOw6wKVRNCL
 6h5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743409153; x=1744013953;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ygbZEWDCAdVDHl/kbUEW0EzWhRhhjf1TvIRZJBaTBIs=;
 b=kPC/FxGLKOP2dQZ1MgUMuMAl07Mu0l7d7O56gLAZkmFQuyF/nQl/5rdbRyz1eWEKk5
 cRcNm/FvH8pndsgIPEXMWYg8QvFJvCeGoyViGyo/HGYkC4CnSp5zs2bTHFXuy9dy/eF/
 0L2Aia3I/8o7yDF1XJLjuVUPvJHSABxaQVUXMBmhVTX9KBsjeMo7k7Uq7x1W6LQIxbec
 60bRheFNy4+YbKWYHnFwTSgheeClB/fQ+g3VDrGRojkwmdE+8xuC0SvregyiyHYpZut0
 KtVWGM1CCl1HH2PI/a5EoSnJFwwOPATwdNp8avc41iLO1y/qgcsXqltRE4Rvm6EIX0XR
 t71g==
X-Gm-Message-State: AOJu0YwMM/AhQUjWgpjK/bTXNl7wCxjKsCdDF6D/cC45ax7PSkWQWYxk
 xzaUxVvobWHB6QEuIvFoZosqVj/1fpoObAQCAu/l+m8eSphceXW0DU2Nz7IcXw026wrqRg5yLfe
 1134=
X-Gm-Gg: ASbGncssP8684ZVR/dA4y+JAxGJz5zwhtFPrnx/o54cFCkRg/9nHNURcAFv6Nldz+js
 yBDU/O/fOXqY1QkOZTGWsxLoqYemvonPiO02fyN5BwC33bnJHLJ36i+owiUq8+m6QqxiA9x2KwC
 OQoyBx/L/sC1wfb23n7YKz2lTeCZk1H1e4tcDGMNqjRm5btjyeq0y2qkxOS7GdJ0czEMCiUgdeL
 XwJsjFedOmtVGZJ5axiuP3Lrpg9HqHq+2yEs36c8bxO6L6s9XarSz9bh7GsCymeRqje9B6RQmzy
 W/s16NU/N8d68pE8RpfBujHnIIU6ueVt67GJypddXmM6Ei5g7g==
X-Google-Smtp-Source: AGHT+IGWfl6aPm7LpRyrG1NjJLtNV9slZbniSEVFhWDlJdq5DHutuOgRIjP1oZTmbgSiaOUn6CfprA==
X-Received: by 2002:a5d:47c5:0:b0:38f:4d20:4a17 with SMTP id
 ffacd0b85a97d-39c120dec24mr6447934f8f.13.1743409152819; 
 Mon, 31 Mar 2025 01:19:12 -0700 (PDT)
Received: from localhost ([196.207.164.177])
 by smtp.gmail.com with UTF8SMTPSA id
 ffacd0b85a97d-39c0b6627bfsm10457179f8f.25.2025.03.31.01.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 31 Mar 2025 01:19:12 -0700 (PDT)
Date: Mon, 31 Mar 2025 11:19:10 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: ltp@lists.linux.it
Message-ID: <Z-pP_i-Iq4PSjoT3@stanley.mountain>
MIME-Version: 1.0
Content-Disposition: inline
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] pty: Update slave device permission check to allow 0600
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Systemd changed the default permissions for PTY slave devices from 0620
to 0600 in response to CVE-2024-28085.  Allow either 0620 or 0600 as
valid permissions.

Link: https://security-tracker.debian.org/tracker/CVE-2024-28085
Link: https://github.com/systemd/systemd/commit/a4d18914751e687c9e44f22fe4e5f95b843a45c8
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Tested-by: Anders Roxell <anders.roxell@linaro.org>

diff --git a/testcases/kernel/pty/common.h b/testcases/kernel/pty/common.h
index 51760b1d39fa..7cda16096d4d 100644
--- a/testcases/kernel/pty/common.h
+++ b/testcases/kernel/pty/common.h
@@ -54,7 +54,8 @@ static inline int open_slave(const int masterfd)
 			st.st_uid, uid);
 	}
 
-	if (st.st_mode != (S_IFCHR | 0620)) {
+	if (st.st_mode != (S_IFCHR | 0620) &&
+	    st.st_mode != (S_IFCHR | 0600)) {
 		tst_brk(TBROK, "unexpected slave device permission: %o",
 			st.st_mode);
 	}

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
