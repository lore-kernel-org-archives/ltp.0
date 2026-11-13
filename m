Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47E9D606A895
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=W0w28TAj;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=tuta.io header.i=@tuta.io header.a=rsa-sha256 header.s=s1 header.b=HubjXEvG
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1794572716; h=date : to :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=xGAnwnV9aiePO+U7GY6c/V4ZUQiRDSmUh/2CiTsE4mo=;
 b=W0w28TAjbBSf2zdCAaxer8yLGbPoACkOdcWBwcKK5CrSZxC4MI+Y60MvrPNWNWuh7DTcR
 Qm3fexQ01E9GCooFbgTQAkUnCJPZfHjBAxM809MM4yJcHz7BbnGQnPi75RAPv7j46apvmz9
 Zq7Huw1hjzbarXiO1Z3PHFMMbFPcp8g=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 54B123E94F1
	for <ltp@archiver.kernel.org>; Fri, 13 Nov 2026 13:25:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C689D3C2026
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 13:24:55 +0100 (CET)
Received: from mail.w14.tutanota.de (mail.w14.tutanota.de [185.205.69.214])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 8644C601291
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 13:24:55 +0100 (CET)
Received: from tutadb.w10.tutanota.de (w10.api.tuta.com [IPv6:fd:ac::d:10])
 by mail.w14.tutanota.de (Postfix) with ESMTP id ABE3F1A838860
 for <ltp@lists.linux.it>; Fri, 13 Nov 2026 13:24:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1794572694; 
 s=s1; d=tuta.io;
 h=From:From:To:To:Subject:Subject:Content-Description:Content-ID:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Cc:Cc:Date:Date:In-Reply-To:MIME-Version:MIME-Version:Message-ID:Message-ID:Reply-To:References:Sender;
 bh=v3rP8yiYS8Yne8kDR8JbRWvLHSeUkayZMRdKJJOHc/Y=;
 b=HubjXEvGWdGcrOUHQ9lod8jo1j9mcHzl1iRdNSKhQnYYPwJLE40KNOFCTFOA0Tuj
 NoACrDPBE0SFj8+I7F3+ATjagb2fpR3c6pU3Xznc8lqjJrIJIto/dBUEEmBqEEl1uMn
 bjuj/nF/is1nCJwMU5RBtqXneJ1wWhuvKqqH6FThNlyRHXthWfnzBv3jtuxPH/Pa967
 bVuSAC5LlBWNy42FCh1A+WMLY3N0RKnKg0K66HKQr2hEVtd01vocrBARyJ0pfb35HvI
 Ik2AMHLdIkcRw1BMjOyh1dp/i0U6J9XsW6RcrDr47j9nFPTmNQ1UhuIBZmvOzzk2abT
 nx6RkouQvw==
Date: Fri, 13 Nov 2026 13:24:54 +0100 (CET)
To: "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <P6JrYDI--F-9@tuta.io>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Feedback-ID: 0127f977f5e13e8051b46c6e7f57d0f95a0470d24b79d7c31d07fdf611cc427ab823e0f4692a810119c92d8768973a9281:TurnOnPrivacy!:tutamail
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] syscalls/fanotify26: Add the linux-git tags of the
 overlayfs fixes
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Edvard Conrad via ltp <ltp@lists.linux.it>
Reply-To: Edvard Conrad <edvard@tuta.io>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

The directory and listing cases need two overlayfs fixes, both in
v7.4-rc2: commit 323899b4ed23 ("ovl: inherit FMODE_NONOTIFY when
opening directory realfiles") and commit 9ff338af0e00 ("ovl: inherit
FMODE_NONOTIFY when reading directory layers").

Record them next to c3d355f427ce, so that a failure points at the
missing kernel commit rather than at the test.

Signed-off-by: Edvard Conrad <edvard@tuta.io>
---
 testcases/kernel/syscalls/fanotify/fanotify26.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/testcases/kernel/syscalls/fanotify/fanotify26.c b/testcases/kernel/syscalls/fanotify/fanotify26.c
index 015eb4a62..b59ef3c16 100644
--- a/testcases/kernel/syscalls/fanotify/fanotify26.c
+++ b/testcases/kernel/syscalls/fanotify/fanotify26.c
@@ -282,6 +282,8 @@ static struct tst_test test = {
 	},
 	.tags = (const struct tst_tag[]) {
 		{"linux-git", "c3d355f427cea70fbe31b49e21f1915dbf37f2e6"},
+		{"linux-git", "323899b4ed233d5b6e2fc160c16fbf39cf0317da"},
+		{"linux-git", "9ff338af0e002fe217cfa16b1289b76f6b21fc72"},
 		{}
 	}
 };
-- 
2.56.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
