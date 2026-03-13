Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAA9D105F7AE
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 14:08:36 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 204A23E529D
	for <ltp@archiver.kernel.org>; Fri, 13 Mar 2026 15:08:35 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it [217.194.8.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 422E83C2EA3
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:08:16 +0100 (CET)
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com
 [IPv6:2607:f8b0:4864:20::1042])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id ADCB51A0111E
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 15:08:15 +0100 (CET)
Received: by mail-pj1-x1042.google.com with SMTP id
 98e67ed59e1d1-3567e2b4159so1159054a91.0
 for <ltp@lists.linux.it>; Fri, 13 Mar 2026 07:08:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773410894; x=1774015694; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7EaQkHYsNR6x7dQKekKfHHgS1SBK3uTc0PRqblJilww=;
 b=LGtbMmSZbypYaFCV3Xg74xrzgBnCpfp8HTW9p0kKlcbbAcnhBALkRApLT6xEIcvVi7
 cbWkkKkp8dzENrwC9bYELILcGzG4HfCdaqlsd1mZ/7N6szSMBBQM1Jr3T0yxbKiKQ6R3
 AXhIOF4u6dVJ9NPdPLNQDf9SP1h1WmRz8dWTUIcW8CAV2qhhPP8BeOdPMJp9a5rpEwfj
 Fy3a+VSOh8RAnUAy/ilY3cmfYsyzTZLBtfeTg6HF8brMkvn9lhp1yQuisVDobzhHHz8t
 lmuApgKF8zSzlZ0sHa6tznrE8dHKoBnq5CGF8XN1QY2qKKV++eHjG///t3QA+Xc0vlCO
 qyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773410894; x=1774015694;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7EaQkHYsNR6x7dQKekKfHHgS1SBK3uTc0PRqblJilww=;
 b=kq/tieaZJRG8hhjZMeqmiqy1PigDONM5r8yt8eNjhenQNobOObQ4jNJoThGElJ/2cN
 8OvgzQdxkZYArCVQN2KpOBXtbURrM6WpyYVLJ3JygOl2HE4mb6uaftNsc17VaSE3W/Es
 /XNWRWF0E0yZE6+WUd0Xhddro8Vjh00g5sj5X1MmR+4PbjqkM44PW9Kw9GPF8JEOJ1eV
 YvjRuDLtL1Pb8T4lGrhSum3wvM3btUE0RWPCvZsT9Jaxj+f6NOgFqWEd69WqdJU2R5K/
 nvRb4glaSGQVyAZCJfS29Olk6MWUy/5SNjtVxzG25pj16GY0qcMrEzXI0sQQYJ86kmBW
 MsIQ==
X-Gm-Message-State: AOJu0YwRStvX0PspSpX/C6myekId6/MDh8T6NnF71mSxlyE+zbRdDLcQ
 6LWaHkcFXEz9iTzJu229QLao2rUE8YlqJlgVvS+fXO4HrDkxDjc80Bk=
X-Gm-Gg: ATEYQzwcy7GPPoEdNpQQlJ23sZJwaDQWHlIlcS4ephMyLPfuTqLX85EBxvvc3Xn/nBv
 LfE/nlhvYTQDbfa0/1law8EKBcfyjLNAXurQuVbqkatjZ6Ydkjq/A0cLVK7rZhBtElsRq4L5u5q
 LvcDrBmrCYKltfLogkvxZc00yPTJMwDnqr/09Ux8xryEOwMEXzD04X/pavYWhdfT3PT4j7QU2sb
 azlPS0CnOCfff4mXt4CnnqBZ3hTJtneEuiXyIZkcnRN8U1P04ES00R9HlbobzOGZ4ztIka37FIn
 L7TDNrh3+dMUb93KklALsDyyFFesmOYCwdhgQTfILRkqhWM9jZ7s6OVETNXcE04zevm53jWRHLS
 2OsSc6n5bocnNXBvGHYOP5hoCVxvn3qzNrqvO/KPluioiB0KCCLQts8g0v65QSBfvmjABPCg5Jz
 2YJ61TVahkgX1DottHAsNBlGyTBZAHm9O2gwHn2Gu49g==
X-Received: by 2002:a17:90b:4a46:b0:359:f6f8:57b8 with SMTP id
 98e67ed59e1d1-35a21e37d7cmr2920158a91.1.1773410892968; 
 Fri, 13 Mar 2026 07:08:12 -0700 (PDT)
Received: from localhost.localdomain ([59.16.109.172])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35a0f6d190csm6974559a91.14.2026.03.13.07.08.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 07:08:12 -0700 (PDT)
From: Jinseok Kim <always.starving0@gmail.com>
To: andrea.cervesato@suse.com
Date: Fri, 13 Mar 2026 23:07:48 +0900
Message-ID: <20260313140750.3799-1-always.starving0@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <69b2a1ef.050a0220.31a4ce.a1ea@mx.google.com>
References: <69b2a1ef.050a0220.31a4ce.a1ea@mx.google.com>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v4 2/2] fstat: add test for multiple file types using
 fstat
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi,

fstat() follows symbolic links and reports the type of the target file,
so it cannot be used to detect S_IFLNK.

Would it be better to drop the symlink testcase from this test?

Jinseok.

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
