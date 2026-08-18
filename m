Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B680CC5DF7D
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1787078918; h=mime-version :
 date : message-id : to : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=53Z1Ouctc3y5EXkCyPjegLGf93QMhRycIhxmfz+ObBA=;
 b=Qn6R+FumBOiPdr9gthRX7uKSfoqp1O0DbBc/Sw+7Cf0UuXnhZkqXYPEMKdYPqV77dnYA9
 c1HrXiaHHfVCeFY7ovHFX1ZZwJEyWvwsq1OId7RGLtGQUP9cTCuHa4S1T4xnbOVrql2NiNt
 5h2oe5T2cePqqYPTPWupf3Ta9qzFnn0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 09DE23CCDD4
	for <ltp@archiver.kernel.org>; Tue, 18 Aug 2026 20:48:38 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 24E863CC708
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 18:54:15 +0200 (CEST)
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com
 [IPv6:2607:f8b0:4864:20::834])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6EBDB600810
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 18:54:14 +0200 (CEST)
Received: by mail-qt1-x834.google.com with SMTP id
 d75a77b69052e-51c10ed63c0so272821cf.1
 for <ltp@lists.linux.it>; Tue, 18 Aug 2026 09:54:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787072053; cv=none;
 d=google.com; s=arc-20260327;
 b=oJkqYiqPfxl/G78oIto5/Y1T6CebYBP5accwhXOmNM276upy3RnM0NrWNTZ0EoVf3Q
 8gDBkrM6MUCKsE84lD/SyserkgwtMRM7t+/arFlmu14MvnIPrRGPyf0ei5ux9pj2GHpN
 A9mKO8jfaEO2DJ0GOFCXRBNe2x8vZXZZPG8GB2JqYtFE3ecoSbm5zC+v24Rd7KN2f+se
 q9N7AAjc9Uu9xs3ux2ibGSJeTt3541XPSl3Wmn2yhq6QQflHni4k8Az2dpOKe9rHjE79
 /9AxA9fy3QEuqvaEwZkl1Mc9akEfvjq/x5wzJYcaS4GoecB0UkAD2LHpxyAc9TI5e4te
 hLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=to:subject:message-id:date:from:reply-to:mime-version
 :dkim-signature;
 bh=HFxi/DJ41WbCDHsUhyYL8fpRk12IUpfB9o+b6DYwsrk=;
 fh=MKsfrWBG6YfiFYjqRhfDZ8kd+0tmvrKUc5gXcb9qw9k=;
 b=AWfUFHifjvxnTl/MlcNH1Z60BJbFWOZucBaDZZFaOwO3KyXvCMsAb0HOqPWswLLYkq
 zj1q/e2jVtA7mcLzpNC9g9gYughBzzVYteoh2LnBYlIiPlZ26n+CLlJ96rRf6AKj2XyZ
 Xy+6htW/0XIv0OPML/1rycYC0azxrTLeCO0JIimqOPwed2CgWVVzpND8uVNbtdfUXE/8
 sxQZCgGN20QRxOtbCs2eiw1mUwtHgKL8dF1AfnE0P9Id/WphnRTF8GCymx6MY4u2ryrQ
 3uuqC9a6ilcV3x0VlYpGlpeQYzj27K0ZTIkrmiJc4sV8k1KBlD3iQq3qyndERqxaquvp
 WGEg==; darn=lists.linux.it
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787072053; x=1787676853; darn=lists.linux.it;
 h=content-type:to:subject:message-id:date:from:reply-to:mime-version
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=HFxi/DJ41WbCDHsUhyYL8fpRk12IUpfB9o+b6DYwsrk=;
 b=bBf/jCJMS6Iz3CCr9IF16HRsIlZUAt0muq9d5G+NSAkgmgmWPuye9KeFnYHu3eRuz8
 /wIr5S1u/6XvIqjx8vb2ExJw78FsB84cLv6ZRKZl3v96RmUES3ZqvpHwep/30X3J6vAn
 ESSRbElQyLcjcy6IW7I5G3xsCp897Br569P6h1sYG2JlnwOTijNohQNHsA/gPZGWzzmP
 oNXsikSBVCkp6CeH2cboTr0Ag2idmvSHHD6CO0ik6cduG1BYTreA8dKSN5iHZlbatrie
 TNz9TZintjVguCP+3aEmlar5NYgxp1vUYFB6YkZNpTbGD2ht62Pi8BTu6xmZ2uEtjA4k
 fS6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787072053; x=1787676853;
 h=content-type:to:subject:message-id:date:from:reply-to:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=HFxi/DJ41WbCDHsUhyYL8fpRk12IUpfB9o+b6DYwsrk=;
 b=hJpTX7SGo9j5i388yuXn/9OSZe37G6iXI9Mtf2Z8jXN6kqwdYFBg5sE1+rODwJzjWM
 YfLXFzJdHbs1aYxuDGDASP63qDsnou4CD2clBwDBzZO3Zx28I9r0cx8WEpdRJ6lSBhSp
 tLADeZgBNofn0jYJEfZEIvJI0E+0rw39ndR9K5N9FK6SCDW9iVwaEZ/bO93cXqb/vb5I
 OWWywLQgX6Vk4tZKPdN8qS9BnQ11jpNW7wDiHFOIJf3PlMB/nAGyZulN8vQGGgvXdANj
 iOIFtnITJymp95E5mYrxAY0x97CpFfbuedeBK+3M9H2pADPns3NxamJ8X+we6ZGoG6JO
 leRw==
X-Gm-Message-State: AOJu0YzcgEsmHvyZEdoLgmMzFYhwG4YsqMib7nriLtvqPmQ8pAi3Aw5G
 gx6A25Pkp8/6VZ01zO8MOpKhvv2cg9KyXTeIYXGW4zJPjSxkGW0Yd9iXMPRXoFAiRIzZ1bfBZoJ
 vKPgh6jCMR2OLHk58fNIj8FGLZd45U33ZBnWjC0d15m2KYTEMlO76AFFn+lc=
X-Gm-Gg: AR+sD13IG6suZ4OjxxB3mXLjgBea9zzZAa2YYmPzK0sxQ2msKUQzLLR5nZWVT0EMFpf
 eheaUfm3VpK6VppQAXpJL7VOeEVLfJFriJWc4BXuGuE4leAQpGdQt3n3eJaNOF+kg5KiAQkgm7y
 AbNMhjd45a8fhefHh5aY/itoouvFxp/4yPi42zjf6OPwr0Xnvf1UCs3MPUl19LVFK5sHnU5c4CX
 hgaxwht8ix9Nfo2EH0zgRsCeipvxknV2v8q4ieENqCyK5glwSnSunaQwBJpkDZBGhw79C6d6Pqz
 xX9+0CimmHhcGu9dyMj/8c7/8wAkBNmovZTmP0B52Fn+7+FFENzOJeFlePR/iw==
X-Received: by 2002:a05:622a:5585:b0:51c:6b7:d3de with SMTP id
 d75a77b69052e-52dc47e6548mr17606831cf.5.1787072052317; Tue, 18 Aug 2026
 09:54:12 -0700 (PDT)
MIME-Version: 1.0
Date: Tue, 18 Aug 2026 22:24:01 +0530
X-Gm-Features: AcwNN1Wc5uJeOs86oSYVfJ1OtONdQjRjWP45RC0shxWgNAHVL19AcpWkpeHc5_E
Message-ID: <CAGJyJpsBXuD0p7Cb9W3oE-cOi8Vzew9y2RhvmDE0y79YH_oWkA@mail.gmail.com>
To: ltp@lists.linux.it
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 18 Aug 2026 20:48:18 +0200
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] inode01: Configure 4KB cluster size on exfat to
 prevent ENOSPC
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
From: "Kinshu Agrawal \(xWF\) via ltp" <ltp@lists.linux.it>
Reply-To: kinshu@xwf.google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

In the multi-process scenario, inode01 creates 10,920 objects (files
and directories) across 5 parallel workers.

On Android, mkfs.exfat (exfatprogs) defaults to a 128KB cluster size
on volumes <= 32GB. On a 512MB test volume, this provides only 4,080
clusters, causing the test to run out of clusters and fail with ENOSPC.

Fix this by configuring exfat to format with a 4KB cluster size (-c 4K)
via the struct tst_fs mkfs_opts field.

Signed-off-by: Kinshu Agrawal <kinshu@google.com>
---
 testcases/kernel/fs/inode/inode01.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/testcases/kernel/fs/inode/inode01.c
b/testcases/kernel/fs/inode/inode01.c
index d41ff2c62..7fccaaf95 100644
--- a/testcases/kernel/fs/inode/inode01.c
+++ b/testcases/kernel/fs/inode/inode01.c
@@ -255,6 +255,10 @@ static struct tst_test test = {
  .mntpoint = MNTPOINT,
  .mount_device = 1,
  .all_filesystems = 1,
+ .filesystems = (struct tst_fs[]) {
+ {.type = "exfat", .mkfs_opts = (const char *const[]) {"-c", "4K", NULL}},
+ {}
+ },
  .needs_root = 1,
  .dev_min_size = 512,
  .forks_child = 1,
--

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
