Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02868D41C04
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 08:12:45 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 3435C3CF242
	for <ltp@archiver.kernel.org>; Thu, 11 Dec 2025 09:12:44 +0100 (CET)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C0A263C00B3
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 09:12:25 +0100 (CET)
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id D3138140074D
 for <ltp@lists.linux.it>; Thu, 11 Dec 2025 09:12:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=nl
 W8h3+CBYovlUpXj9JIk9u4tOEbYyaKqQLRDWMeANw=; b=VhEU3bIJnZc9RsI2h/
 GAZGTs8i5vgj7UiNiB5V9MxwqooZ0Qlmx+PNbjtx4CyypWWZQnq/FZ/h41PhZizH
 PZv/Uv1ra1nhVhZQyZ3gWmUXkHOvYn0+J5lNA/0Fz4bzrVRfWuMdi6Gec0rQpoSc
 wALnPqCpoLVePLgZQd3xjHULk=
Received: from localhost (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wBXX3fjfDppj1RXBA--.58468S2; 
 Thu, 11 Dec 2025 16:12:20 +0800 (CST)
From: simplemessager@163.com
To: pvorel@suse.cz,
	ltp@lists.linux.it
Date: Thu, 11 Dec 2025 16:11:29 +0800
Message-ID: <20251211081205.342673-1-simplemessager@163.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20251209195328.GB24146@pevik>
References: <20251209195328.GB24146@pevik>
MIME-Version: 1.0
X-CM-TRANSID: _____wBXX3fjfDppj1RXBA--.58468S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
 VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU7v38UUUUU
X-Originating-IP: [36.111.64.84]
X-CM-SenderInfo: hvlp1z5hph22hdjh2qqrwthudrp/xtbC8ARB2Gk6fOSuGAAA3Q
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] safe_keyctl: Skip with TCONF on EOPNOTSUPP
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

Thanks for your review.

Mingyu Li


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
