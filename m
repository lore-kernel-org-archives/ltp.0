Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FAA5C5321D
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 08:02:46 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id D1C6F3D273E
	for <ltp@archiver.kernel.org>; Mon, 26 Aug 2024 10:02:44 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1A2513D2183
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 10:37:52 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=hust.edu.cn (client-ip=162.243.161.220;
 helo=zg8tmtyylji0my4xnjeumjiw.icoremail.net;
 envelope-from=jingyisong@hust.edu.cn; receiver=lists.linux.it)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net
 (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
 by in-7.smtp.seeweb.it (Postfix) with ESMTP id 9EE76200348
 for <ltp@lists.linux.it>; Fri, 23 Aug 2024 10:37:48 +0200 (CEST)
Received: from hust.edu.cn (unknown [172.16.0.52])
 by app2 (Coremail) with SMTP id HwEQrAB3IBVJSshmp4CQAA--.14023S2;
 Fri, 23 Aug 2024 16:37:29 +0800 (CST)
Received: from pride-PowerEdge-R740.. (unknown [222.20.126.129])
 by gateway (Coremail) with SMTP id _____wD3SBxCSshmh_WNAA--.15651S2;
 Fri, 23 Aug 2024 16:37:29 +0800 (CST)
From: Jingyi Song <jingyisong@hust.edu.cn>
To: ltp@lists.linux.it
Date: Fri, 23 Aug 2024 16:37:19 +0800
Message-ID: <20240823083720.1545566-1-jingyisong@hust.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-CM-TRANSID: HwEQrAB3IBVJSshmp4CQAA--.14023S2
Authentication-Results: app2; spf=neutral smtp.mail=jingyisong@hust.ed
	u.cn;
X-Coremail-Antispam: 1UD129KBjvdXoW7XF43Cw4rtF4fAF17GF47twb_yoW3ZrcEka
 18Xa4fuFyjy3y8Aws5AF4Ivrs5uw43AF1jyFnrGF43Ja47XrZrJFZ7Kas7Ja1rZF43CFyI
 qanxuw4ftrZIgjkaLaAFLSUrUUUUbb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUIcSsGvfJTRUUUb3AYjsxI4VWxJwAYFVCjjxCrM7CY07I20VC2zVCF04k26cxKx2IY
 s7xG6rWj6s0DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI
 8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJwA2z4x0Y4vE
 x4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzx
 vE52x082IY62kv0487Mc804VCY07AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG
 6I80ewAv7VACjcxG62k0Y48FwI0_Gr1j6F4UJwAv7VCjz48v1sIEY20_GFW3Jr1UJwAv7V
 CY1x0262k0Y48FwI0_Gr1j6F4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vI
 r41l42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8uFyUJr1UMxC20s026xCaFV
 Cjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWl
 x4CE17CEb7AF67AKxVWUXVWUAwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r
 1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_
 JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCT
 nIWIevJa73UjIFyTuYvjxUIiFxUUUUU
X-CM-SenderInfo: rpsqjjixsrilo6kx23oohg3hdfq/
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 26 Aug 2024 10:02:30 +0200
Subject: [LTP] [PATCH] doc: add `--recurse-submodules` when cloning the repo
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
Cc: Jingyi Song <jingyisong@hust.edu.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

User could run syscalls testing suite with
`./kirk -f ltp -r syscalls`,
but they may not be aware of the submodule `kirk`.
So I add the `--recurse-submodules` option.

Signed-off-by: Jingyi Song <jingyisong@hust.edu.cn>
---
 doc/users/quick_start.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/doc/users/quick_start.rst b/doc/users/quick_start.rst
index 4a48745be..1581b1f0c 100644
--- a/doc/users/quick_start.rst
+++ b/doc/users/quick_start.rst
@@ -17,7 +17,7 @@ Basics requirements to build LTP are the following:
 
 .. code-block:: console
 
-   $ git clone https://github.com/linux-test-project/ltp.git
+   $ git clone --recurse-submodules https://github.com/linux-test-project/ltp.git
    $ cd ltp
    $ make autotools
    $ ./configure
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
