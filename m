Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDD64CD6E74
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 09:25:23 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4EA3E3CD1AF
	for <ltp@archiver.kernel.org>; Fri,  5 Jun 2026 11:25:22 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C41BF3CD1AF
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:25:06 +0200 (CEST)
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com
 [IPv6:2607:f8b0:4864:20::843])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 56602600ABE
 for <ltp@lists.linux.it>; Fri,  5 Jun 2026 11:25:06 +0200 (CEST)
Received: by mail-qt1-x843.google.com with SMTP id
 d75a77b69052e-517583cb07aso19343371cf.2
 for <ltp@lists.linux.it>; Fri, 05 Jun 2026 02:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780651505; x=1781256305; darn=lists.linux.it;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UOM0bEuuSp8yAc3oB1t9k0bAt3IL55WBBdupa3a6qyk=;
 b=Y/5cqhCj3dPeGyFBcCj3O0F2RiRgfNQYUZrdccIpcapAWwqwv5i9UfFeIGn2BhxQpM
 p3qG9wqB0J38woWKNXKRE3xz3zlDlBkvBmqwFy/oQH3mKmqBhMYGQorBJi7Ki4MKYWLl
 KCK+klJdnX6tuTg+ELuipFCT9Se8zMy9lywGo2Erx/UDD6vxe3gaj1FDfZ2tKI6hRG0P
 xAxgfQPyvXL871rZ/fUncmUxl3Bxpn31wh7O3QLdb6xiR1YRrJC5IvAsqsza3iVARmU1
 TPqgrPmRV7tQAEVXdRDGzCmsqB3hO3D7HGUsrAh2E3mjTJEe/eKYhuxowqCJZArpkK3k
 enkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780651505; x=1781256305;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=UOM0bEuuSp8yAc3oB1t9k0bAt3IL55WBBdupa3a6qyk=;
 b=iFuwDHnrE1ZA1IGN6/LuL79W0xq96dBhjib0T2UmYunMLxF6EKgjN2Wt4KjRv0ae3J
 P+YExsbag+h15AIJtV9wQSxy5F7TBIlW3cRJx2BEBJXsk8O9K77RA7yRbi2NS7Ai9xfn
 6HDm1ynj8w5A26QVTGP+lSEqjfHKDehHVfFai+ceGo+RU9pprGy4ALJBfP6qSLYYUD6a
 mGmC0yF2K4NGdw6C+7AqP3jL5vlcxhD3XqtnAJCMdj6mOq1xbyaLJgVqZqwe4GOC/1wz
 MSN2K88QJjnoj4gl+fzi6yl/+NKLcLs9cfLkqBh8uNckLwkFcCJlqnM2n5lm8UHQ3k3f
 ZPJg==
X-Gm-Message-State: AOJu0Yzh5hK5Q/Q1KkQsyrpzL0qa2OqPJGARWOMvx081f7RVn4PNgcgp
 OKW+nbguBEQF4pdfzjM+Fx8Rl/yEwDcWDBCCAIj3/0qlVSO8LvMGPuk2dvgucTUS
X-Gm-Gg: Acq92OGJHX5MukHPoM0MsYADV6u3SKToIWxX11M9A2Q4XLghIyl/RNvmPPqDHNQJ4/D
 625/5wnssfWT8r8vPgerBJ/yjqPXWvdsiAF7OkRXA8Zgg0uCBByOyFyp1OutSqkNYteKio+higo
 A6RaCN6qJMlNY5wKW8Bmpp6GCpeQgd2Q+2L58tgYNjMG1e/bzxtjmvQlNQ4m61zXPmrXNbZcoLa
 39pp9nLX5NVPD3bMZF05GvUrGSmMaDi3jb/JvQ1Su22S9HH1tycOWzju6xANggtTKu2+pwqyEGA
 IjKrlsyn6p1RmY2jQPY34qhpTIr7ogXJ89jqgeKbTyr78D725HR5AIHqIkOBbuwHZFOlu4sgPPn
 aMWYPdnG3fAO/IYIZr++dPhx0XejnnRfCFfO0eyZtj7dyciIYQxHldVT3bkZ/nzNTXLUK6jE2EJ
 0wXr/CR16c70kcEc9O9YzQ1oe6eT+hK6WhimeqmFhIQd5Qt5iGAQZzrWg7GtTHPAvjY+vJjotQw
 uXnShfK2Vi1HKusiGDAYBVtpmXhlucZtxJj7mbkRuX8TYtdnQ==
X-Received: by 2002:a05:622a:6203:b0:517:71a1:6e03 with SMTP id
 d75a77b69052e-51795b4ee95mr37284881cf.8.1780651504969; 
 Fri, 05 Jun 2026 02:25:04 -0700 (PDT)
Received: from
 runnervm3jyl0.4pdmmv4olflexdnyvwvozzkmdd.bx.internal.cloudapp.net
 ([20.83.175.146]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51775c4d7absm72772631cf.11.2026.06.05.02.25.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 02:25:04 -0700 (PDT)
From: linuxtestproject.agent@gmail.com
To: yeziwen1989@yeah.net
Date: Fri,  5 Jun 2026 09:25:03 +0000
Message-ID: <20260605092503.3886-1-linuxtestproject.agent@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605054453.64067-1-yeziwen1989@yeah.net>
References: <20260605054453.64067-1-yeziwen1989@yeah.net>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] execve05: add exit call when execve failed
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

Hi Yeguojin,

On Fri, 05 Jun 2026 13:44:53 +0800, Yeguojin wrote:
> execve05: add exit call when execve failed

Verdict: Reviewed

---
Pre-existing issues:

testcases/kernel/syscalls/execve/execve05.c

 * This tests the functionality of the execve(2) :manpage:`execve(2)` call by spawning

The plain "execve(2)" and the :manpage: role are duplicated on the same
line. The raw "execve(2)" text should be removed, leaving only the
:manpage: role.

---
Note:

The agent can sometimes produce false positives although often its
findings are genuine. If you find issues with the review, please
comment this email or ignore the suggestions.

Regards,
LTP AI Reviewer

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
