Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2026BC43458
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 17:26:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1782494781; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=z90RMj/5GOr6aRClTwYP8wywzr1SZJUpRcYgFy8AvkM=;
 b=QENz64xucwZRu4mQIm6dH+HZ8NqnuswxUw7WCNtgW5YBmZ5y8d7aEKPLpewpIrqtpoT0n
 3IkeMn6e6cQEne8SkG9KDfjyNNr35jwuOjVp5sWHkTtSjL52SxuS8H6LFvhkqg4iFQnK/7h
 Aew2g3aiJvoyFv4IUEgWqRH53g1PfLg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 25C383E530D
	for <ltp@archiver.kernel.org>; Fri, 26 Jun 2026 19:26:21 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6BF833E234E
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 19:25:57 +0200 (CEST)
Received: from tor.source.kernel.org (tor.source.kernel.org
 [IPv6:2600:3c04:e001:324:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id DB1821400207
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 19:25:55 +0200 (CEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA084600D8
 for <ltp@lists.linux.it>; Fri, 26 Jun 2026 17:25:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 286D31F000E9;
 Fri, 26 Jun 2026 17:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782494752;
 bh=lGLDJO2DkaoO/iqoJMHUJVTdsMDZbtXvgL6v0rCdePA=;
 h=From:Date:Subject:To:Cc;
 b=L8G/kfcJ6i881oWWhTuBJh2v8IWxE9kRtuKcMUwyFR40zT7mwYQKoG+5ICTWV+bWC
 AmKJuTV1rJbp+gINgeZd4dUvXLowN8joAAzjRIGn5xDy1y6D5cpB24+tDPhrMN5PM1
 4Xvjw6f/2TaoyeAXb2xIrvh40PTqYuwpJ8n2WOJlnu8T5DGkOdn13l6J12pwloWYOy
 kH1Ocp+j3ba6Ui0eQaQ9HHsnD8PnK4/cwHHbh4OmRJ62mXNz1RQFyPJJSzfY7UM88I
 iTn46g1NWW9ZQ/jfnYqLmicwVHyfkafo6srtTidJ52YgF7OBHPnaVAURBwRGWXAy+Y
 kTjLfynPGqY2A==
Date: Fri, 26 Jun 2026 13:24:47 -0400
MIME-Version: 1.0
Message-Id: <20260626-master-v1-1-e4fcb95b232d@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMyMz3dzE4pLUIl1T0xQjSxNLk6REAzMloOKCotS0zAqwQdGxtbUAhji
 aRlgAAAA=
X-Change-ID: 20260626-master-55d29494ba06
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1609; i=jlayton@kernel.org;
 h=from:subject:message-id; bh=a7is08bAMXyk12MkATp7BlgI5nKQ+0WxV7ZiOPPTuN0=;
 b=owEBbQKS/ZANAwAKAQAOaEEZVoIVAcsmYgBqPrYbdvJFpB5Sh3gTRdzdf5/Zch1CMIPgTC+t+
 /9RZ/oQSWCJAjMEAAEKAB0WIQRLwNeyRHGyoYTq9dMADmhBGVaCFQUCaj62GwAKCRAADmhBGVaC
 FStnEAC7yY90RR+51swttaC5mOaubkJYqO1I4jPEQAAWHZ/c1WuRZEqI4ZOxPjyr53yVCcIPKZb
 AcHsxDa8rEVEJJ42wnQD8ZCbWmR7bWzsnnvWpKFY3x7YHr880rQkeoV7eidN3OO00HuxkXm0efP
 l1zYwMKck2CWvUufT1xEBYpUhBnyTQslkUubI5Xo0y1zaY3n4PezI8nRdYtvDtqRF9y7JrjRNi4
 8vXLfs7D4a4qHkKgMXeUN0H3scXje+houpT/NhF2PJ1YDqwoJ8oR9Wc7QLyC8kKLvr5B5vcqO+V
 rmZitcCo60OOofvOPom3ZCSJCbUNky4bbgzNtHHHxoixUpzEMIO0AvrmRNawIS1DUHVEN7klCX1
 7xMqtpWYvZUQMHHUpFkskNDW7jrZW9JbFbPuxjGxTfxUROxi9QY3UVwj2IBM/Uz5aYhEAxZbRlt
 J5moK+GMe1PzKX6aYJdgjGuq+/iQVdZUqAYIEf4TrhcGXckqRt+SbdvF/8iVB5Xi8LmF37bRtGb
 nVpFPa8tJp4HFRM0WQCeAMx//zOwQW4QNJYuxtuOW7cRw5i8rO6RrEcwkD7R+XsfQDQMt9dqxAV
 8Kftist3Zbeo72g5TGl6mXazm/MoRYdw6vY2jPPNjLzq0E4ryHEUw4hE/WLy+qszETMCh+gwZeh
 EkiQSI7fgi3ZSnA==
X-Developer-Key: i=jlayton@kernel.org; a=openpgp;
 fpr=4BC0D7B24471B2A184EAF5D3000E684119568215
X-Virus-Scanned: clamav-milter 1.0.9 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] ioctl10: fix the sscanf() call to handle 64-bit inode
 on 32-bit arch
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
From: Jeff Layton via ltp <ltp@lists.linux.it>
Reply-To: Jeff Layton <jlayton@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

This test started failing recently on arm32, when we switched the
kernel to displaying the full 64-bit inode number in the maps file.
Change the testcase to allow for a full 64-bit inode number on all
arches. The value it's compared to is already 64-bits, so widening
this field is all that is necessary.

Reported-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 testcases/kernel/syscalls/ioctl/ioctl10.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/testcases/kernel/syscalls/ioctl/ioctl10.c b/testcases/kernel/syscalls/ioctl/ioctl10.c
index b668c9e93889..d7e40f3c8643 100644
--- a/testcases/kernel/syscalls/ioctl/ioctl10.c
+++ b/testcases/kernel/syscalls/ioctl/ioctl10.c
@@ -35,7 +35,7 @@ struct map_entry {
 	unsigned long vm_pgoff;
 	unsigned int vm_major;
 	unsigned int vm_minor;
-	unsigned long vm_inode;
+	uint64_t vm_inode;
 	char vm_name[256];
 	unsigned int vm_flags;
 };
@@ -68,7 +68,7 @@ static void parse_maps_file(const char *filename, const char *keyword, struct ma
 
 	while (fgets(line, sizeof(line), fp) != NULL) {
 		if (fnmatch(keyword, line, 0) == 0) {
-			if (sscanf(line, "%lx-%lx %s %lx %x:%x %lu %s",
+			if (sscanf(line, "%lx-%lx %s %lx %x:%x %llu %s",
 						&entry->vm_start, &entry->vm_end, entry->vm_flags_str,
 						&entry->vm_pgoff, &entry->vm_major, &entry->vm_minor,
 						&entry->vm_inode, entry->vm_name) < 7)

---
base-commit: 534222c4f3908e9642f913399e37a66fdd266bbe
change-id: 20260626-master-55d29494ba06

Best regards,
-- 
Jeff Layton <jlayton@kernel.org>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
