Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A082C3DA59
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 04:04:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1721102654; h=to : date :
 message-id : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=2codCf2D71HdraMdLZwnKzdcYOZJzh7bHZPXXKvorlk=;
 b=liZQtrBEDz3oB8ltpzW5azMUK07EX88+F5lQYGcg3agkyRWAYZyjbcy1lSo+lu/J1I18z
 SulSzRyQnCEilbudQgZh+EnhAKhZ5q6bbS/2XzZ85bLnXtW10CQfXRBgjkWsw5dS98efRn7
 gLvBiQrxJ4XwMb+R2vl4v7ZuP+EiW4c=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 581D93D1A6B
	for <ltp@archiver.kernel.org>; Tue, 16 Jul 2024 06:04:14 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 8E4053D1A35
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 06:03:52 +0200 (CEST)
Authentication-Results: in-4.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=fujitsu.com (client-ip=207.54.90.49;
 helo=esa3.hc1455-7.c3s2.iphmx.com; envelope-from=maxj.fnst@fujitsu.com;
 receiver=lists.linux.it)
Received: from esa3.hc1455-7.c3s2.iphmx.com (esa3.hc1455-7.c3s2.iphmx.com
 [207.54.90.49])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 5FB921000453
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 06:03:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj2;
 t=1721102631; x=1752638631;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=1y9wJ2W9VZyK4A2/M55zKAKbzEpqz8Kf5xvjTzBponk=;
 b=QqYuyXg9e+SDGtZjh9Z4n3VoTf6H8jmBqVA249eA+ZLtwEx6uuV0xZUv
 xDWF9QnTsfkFtLkIa5KT+z5nLzps9MM0y3apCC9cJIK9bbXR+s+bKowGx
 /M80DyVujYUp0J0Ydco54gu6R2AAplqqKVSCBkgVaSYbaK64WM+8p9yv6
 Wc1SOY4Ihzszl0yNS3nCUzrBA5RHo0DF1dH8Dq04q8XNnAilH5nYf3ZCP
 8b23Yk4oyx8/2p9oOWSiFqxwD783ArsWCENrFCDD4dX1LrEpPnRiy0Xdi
 CbaVKJ1VEBdF6GDijbLFqzIjXl0Ea3SQGI97sudhYQuuo9W8OUl0NhvoN w==;
X-IronPort-AV: E=McAfee;i="6700,10204,11134"; a="167296372"
X-IronPort-AV: E=Sophos;i="6.09,211,1716217200"; d="scan'208";a="167296372"
Received: from unknown (HELO yto-r1.gw.nic.fujitsu.com) ([218.44.52.217])
 by esa3.hc1455-7.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Jul 2024 13:03:47 +0900
Received: from yto-m1.gw.nic.fujitsu.com (yto-nat-yto-m1.gw.nic.fujitsu.com
 [192.168.83.64])
 by yto-r1.gw.nic.fujitsu.com (Postfix) with ESMTP id B18ABDB3D1
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 13:03:45 +0900 (JST)
Received: from kws-ab3.gw.nic.fujitsu.com (kws-ab3.gw.nic.fujitsu.com
 [192.51.206.21])
 by yto-m1.gw.nic.fujitsu.com (Postfix) with ESMTP id DA3B9CFB9D
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 13:03:44 +0900 (JST)
Received: from edo.cn.fujitsu.com (edo.cn.fujitsu.com [10.167.33.5])
 by kws-ab3.gw.nic.fujitsu.com (Postfix) with ESMTP id 3F5DC2007CAB6
 for <ltp@lists.linux.it>; Tue, 16 Jul 2024 13:03:44 +0900 (JST)
Received: from localhost (unknown [10.167.226.69])
 by edo.cn.fujitsu.com (Postfix) with ESMTP id CCB0A1A000A;
 Tue, 16 Jul 2024 12:03:43 +0800 (CST)
To: ltp@lists.linux.it
Date: Tue, 16 Jul 2024 12:03:25 +0800
Message-Id: <20240716040325.3478-1-maxj.fnst@fujitsu.com>
X-Mailer: git-send-email 2.18.1
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-TM-AS-Product-Ver: IMSS-9.1.0.1417-9.0.0.1002-28532.004
X-TM-AS-User-Approved-Sender: Yes
X-TMASE-Version: IMSS-9.1.0.1417-9.0.1002-28532.004
X-TMASE-Result: 10--1.824400-10.000000
X-TMASE-MatchedRID: alNhoJufFSTlWiNI/3lAD07nLUqYrlslFIuBIWrdOeOU8ftiyKjZrXlb
 NLJMhGkte+eZU8eiw0Zvp+b/wK4TT1lDiuV7LjH+lRdhw/BBzad9LQinZ4QefGWCfbzydb0g0A1
 Hg37ql8OHMiaOuNkkbWrz/G/ZSbVq+gtHj7OwNO2I3adjBtsMrFSojO6HIvXr4NGMt9ovwAKOlO
 jJnS6HQYvVn77VQDy4abIzby4Zk07BtUhG9fVh8i3lSBpGgz3Z2RTbaA39X4/Ay8f+BLTSlLIlR
 0CP+9uuvukFcYgGbHWubInJ6UnEoYlgGwbvE/hr
X-TMASE-SNAP-Result: 1.821001.0001-0-1-22:0,33:0,34:0-0
X-Virus-Scanned: clamav-milter 1.0.3 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] getcpu: Convert docs to docparse
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
From: Ma Xinjian via ltp <ltp@lists.linux.it>
Reply-To: Ma Xinjian <maxj.fnst@fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogTWEgWGluamlhbiA8bWF4ai5mbnN0QGZ1aml0c3UuY29tPgotLS0KIHRl
c3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvZ2V0Y3B1L2dldGNwdTAxLmMgfCA3ICsrKysrKy0KIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKCmRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGNwdS9nZXRjcHUwMS5jIGIvdGVzdGNhc2Vz
L2tlcm5lbC9zeXNjYWxscy9nZXRjcHUvZ2V0Y3B1MDEuYwppbmRleCA5ODQyYzg5OTkuLmI2YTNl
MjM3MCAxMDA2NDQKLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9nZXRjcHUvZ2V0Y3B1
MDEuYworKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2dldGNwdS9nZXRjcHUwMS5jCkBA
IC0xLDggKzEsMTMgQEAKIC8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxh
dGVyCiAvKgogICogQ29weXJpZ2h0IMKpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMg
IENvcnAuLCAyMDA3LCAyMDA4CisgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwg
MjAwOS0yMDI0CisgKgorICovCisKKy8qXAorICogW0Rlc2NyaXB0aW9uXQogICoKLSAqIFRlc3Qg
RGVzY3JpcHRpb246CiAgKiAgVGhlIHRlc3QgcHJvY2VzcyBpcyBhZmZpbmVkIHRvIGEgQ1BVLiBJ
dCB0aGVuIGNhbGxzIGdldGNwdSBhbmQKICAqICBjaGVja3MgdGhhdCB0aGUgQ1BVIGFuZCBub2Rl
IChpZiBzdXBwb3J0ZWQpIG1hdGNoIHRoZSBleHBlY3RlZAogICogIHZhbHVlcy4KLS0gCjIuMTgu
MQoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
