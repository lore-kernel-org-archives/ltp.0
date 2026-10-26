Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1635606A31A
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 10:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=AyS6AO+N
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 1E6823E6166
	for <ltp@archiver.kernel.org>; Mon, 26 Oct 2026 11:47:42 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 3CF7A3D2387
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 11:47:26 +0100 (CET)
Received: from mta0.migadu.com (out-163.mta0.migadu.com
 [IPv6:2001:41d0:1004:224b::a3])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E658010006D3
 for <ltp@lists.linux.it>; Mon, 26 Oct 2026 11:47:23 +0100 (CET)
X-Envelope-To: ltp@lists.linux.it
DKIM-Signature: a=rsa-sha256; bh=nmQxofaYbq2Tro7RLOB36neIEVztkT/Dm1op9wfzcug=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793011642; v=1; x=1793616442;
 b=AyS6AO+NmE51g8UO2UzZXzfhFnmS+UG4ye5wRUQ30QGGFm73wYi2mXz4MFXstxvmUiY693U/
 rlcwsgmucY4iHpFehhKgDZPa9naQAM6p0HKsYJEQRzOkaKuBv1gNak1ztm1Ze2qb3xSiB7DsF6w
 Q6oPfxabhD09TxhwI8M7ZoB0=
X-Envelope-To: ltp@lists.linux.it
Received: by mta11.migadu.com with ESMTPS id 52ee54dc4b49457d;
 Mon, 26 Oct 2026 10:47:22 +0000
X-Mizu-Trace-ID: 52ee54dc4b49457d
X-Migadu-Flow: FLOW_OUT
From: Andrea Cervesato <andrea.cervesato@linux.dev>
Date: Mon, 26 Oct 2026 11:47:17 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261026-acer_maintainers-v2-1-4cf0f350fdf1@linux.dev>
X-B4-Tracking: v=1; b=H4sIALQv32oC/32NwQ6CMBBEf4Xs2RpaiBZP/ochpiyLrAnUdKHRE
 P7dgncPc3jJzJsFhAKTwCVbIFBkYT8mMIcMsHfjgxS3icHk5qRzUyiHFO6D43FKoSCqxcoWtin
 PtkNIs1egjt+78lb/WObmSThtnq3Rs0w+fPbPqLfeH33USitbWuxKV1VO51eZhY7oB6jXdf0CR
 jvpocEAAAA=
X-Change-ID: 20261023-acer_maintainers-dc9838b478fc
To: Andrew Morton <akpm@linux-foundation.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793011638; l=1796;
 i=andrea.cervesato@linux.dev; s=20251210; h=from:subject:message-id;
 bh=nmQxofaYbq2Tro7RLOB36neIEVztkT/Dm1op9wfzcug=;
 b=E6jIBQ7Lf9+R8/Eoc6Xq+FvpNy44Y2BEJ6NJvMbe0eMzXa1msWq5MzlhIXWx7waW+Nzy97r5a
 RWaOnobWqaxBABE6/iH8b1wsF7MPjWX0GfBL9B2TqCBwCPDd36A4t34
X-Developer-Key: i=andrea.cervesato@linux.dev; a=ed25519;
 pk=zKY+6GCauOiuHNZ//d8PQ/UL4jFCTKbXrzXAOQSLevI=
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2] MAINTAINERS: Update Andrea Cervesato's email for
 LTP
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
Cc: linux-kernel@vger.kernel.org, ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

I'm not working for SUSE anymore and I will use linux.dev email to
develop and maintain Linux Test Project. Also update .mailmap.

Signed-off-by: Andrea Cervesato <andrea.cervesato@linux.dev>
---
Changes in v2:
- Update author and Signed-off-by to linux.dev
- Update .mailmap
- Fix typo in commit message
- Add ltp@lists.linux.it to Cc
- Link to v1: https://lore.kernel.org/20261023-acer_maintainers-v1-1-848cf4a99a10@suse.com
---
 .mailmap    | 1 +
 MAINTAINERS | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index d73ec73e5ba9..60c198336fac 100644
--- a/.mailmap
+++ b/.mailmap
@@ -81,6 +81,7 @@ Amit Blay <quic_ablay@quicinc.com> <ablay@codeaurora.org>
 Amit Nischal <quic_anischal@quicinc.com> <anischal@codeaurora.org>
 Andi Kleen <ak@linux.intel.com> <ak@suse.de>
 Andi Shyti <andi@etezian.org> <andi.shyti@samsung.com>
+Andrea Cervesato <andrea.cervesato@linux.dev> <andrea.cervesato@suse.com>
 Andreas Herrmann <aherrman@de.ibm.com>
 Andreas Hindborg <a.hindborg@kernel.org> <a.hindborg@samsung.com>
 Andrej Shadura <andrew.shadura@collabora.co.uk>
diff --git a/MAINTAINERS b/MAINTAINERS
index 1e3f9f2751fe..13f2242150fe 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15835,7 +15835,7 @@ F:	Documentation/devicetree/bindings/i2c/i2c-mux-ltc4306.txt
 F:	drivers/i2c/muxes/i2c-mux-ltc4306.c
 
 LTP (Linux Test Project)
-M:	Andrea Cervesato <andrea.cervesato@suse.com>
+M:	Andrea Cervesato <andrea.cervesato@linux.dev>
 M:	Cyril Hrubis <chrubis@suse.cz>
 M:	Jan Stancek <jstancek@redhat.com>
 M:	Petr Vorel <pvorel@suse.cz>

---
base-commit: 6b4b543fa18757297ac756a6fe6e64f506b7844a
change-id: 20261023-acer_maintainers-dc9838b478fc

Best regards,
--  
Andrea Cervesato <andrea.cervesato@linux.dev>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
