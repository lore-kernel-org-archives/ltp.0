Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46693C4345F
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 07:45:37 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 90C7A3CFF47
	for <ltp@archiver.kernel.org>; Sun, 28 Apr 2024 09:45:35 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 181713CFA65
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 09:45:19 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=uniontech.com (client-ip=13.245.218.24; helo=smtpbg153.qq.com;
 envelope-from=lufei@uniontech.com; receiver=lists.linux.it)
Received: from smtpbg153.qq.com (smtpbg153.qq.com [13.245.218.24])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E1FEF10009B6
 for <ltp@lists.linux.it>; Sun, 28 Apr 2024 09:45:15 +0200 (CEST)
X-QQ-mid: bizesmtp83t1714290308t3g85n3m
X-QQ-Originating-IP: qIoWsHvjV6+U07pV1G/z03g0nXmGGg4tESQiNTcWvwQ=
Received: from localhost.localdomain ( [125.76.217.162])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Sun, 28 Apr 2024 15:45:06 +0800 (CST)
X-QQ-SSF: 01400000000000C0B000000A0000000
X-QQ-FEAT: iHZimuvw+IQH72PPgck8z3KLN0ITJ1ERIViKdxA0jhcyEz384dwgracvh1pq4
 G2D2QgsR1fbZLL1Gbrr61jYXkEC/5gCl+sRBRzpBLUYVc5vsM5mltgS+HsjTru30DUoyI5p
 toeC/jOLfMrGEuozeDy1Q79TcNxcqFA83xHYC2PKur2ZklWGaaCr1mlkNQxEEWxJKjrh89m
 NmIcaN/JI+zJ7vxDMl2PxrbqtbIgESrarKt1hFOcGkh+hPsHhQ+im3kGQKMBfnJsgZDxTzx
 l0cmjGLJSP92Z13eh1GZ349b+H60j1JewTiYJpyRitG8S7v8+LEyFRJMxlY+XEZFAbfnaLU
 Yqmqq7x
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 6492017282983714624
From: lufei <lufei@uniontech.com>
To: jstancek@redhat.com
Date: Sun, 28 Apr 2024 15:44:56 +0800
Message-Id: <20240428074457.2629906-1-lufei@uniontech.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240419070717.2506101-1-lufei@uniontech.com>
References: <20240419070717.2506101-1-lufei@uniontech.com>
MIME-Version: 1.0
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] (no subject)
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

Thanks a lot.


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
