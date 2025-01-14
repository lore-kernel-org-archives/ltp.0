Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16424E77188
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 22:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1736894620; h=date :
 mime-version : message-id : to : subject : list-id : list-unsubscribe
 : list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=3ESAtv1H0HO9pVF0t/5x4lbx/tIi7YuJkGARRhBvUE0=;
 b=SN0bXX3PyQfo9N8yoOcAGcivOwt8a1/No9eKVy/zTXJfBlpwjs846rlbcNiY/KG3Vqe9Z
 obJdcbJSOO+gpydFQ46K3xjrj4PjVpzcuz45hEAZy3j+Z72y/Atr69vlQkZn+Rla/b4JFm2
 PYuf4mvK7uSRFRjkaAjTEczkLOwk1/w=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 89DAA3C7B58
	for <ltp@archiver.kernel.org>; Tue, 14 Jan 2025 23:43:40 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 27DAC3C7B2F
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:43:18 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 132C062B20A
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 23:43:17 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-3863c36a731so4468884f8f.1
 for <ltp@lists.linux.it>; Tue, 14 Jan 2025 14:43:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736894596; x=1737499396;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yluFdNpKqF12PY6UxrsSQGCOvF++qsKwo5hz0eehjPY=;
 b=WwCoWHaRJn1kHytlFDEJEirBXSO1IPE7+efJsS5hF884FKjU9Kq4PT7TMb9mi14Tai
 ZER8TT6m8fSaGHEKGk++QHIE/nQZ5uZ/oxXRglkY+Dnj/+VD2JtQZtW2ePl5BG1Y+onq
 7aDK/RS/UupYZmwD8qtLf1nhSUaAFVYldioV7f9PWfoX1tEs/5/7GusWVGcXDvHYw95e
 2/TI8hWor//mcqfwhWGqdEs2/RBbbrWuAPecS0FHq+sK1S9SxqMDsHL5o4sq/FENImsn
 F/cZl48nW2w3cvm0nZrLmAPet03GE+rAII4LKWyBLAuIB7nmBnUp8e2hkh7cKRlljkqx
 FX5w==
X-Gm-Message-State: AOJu0YxnenBSGvdbDLuKEuut5F4MOXzW7IeMo0tGD/Suvbk9murztbOH
 UuuuI7ZuwyBsgCZuw4mz7tLdrQC+6FjVDw+9NuOT4DFoDuDYJ/XiQhdRSOe0ukt3xi01q2yI48N
 U
X-Gm-Gg: ASbGnctTnEb2DoA9EmT/ekqBdhOul5oBYnH4wAY+t+FSy0a4AqI5Ar7zA/H57JaU9Pn
 5wdCbqfwqkPe/kKKcbZHKD8QRcAVxPo4QBg2YhZxL9CXmwXhf6KKF6i73g4m8mnNKWL6IzfpcGn
 zVP0zW5nh1vqnuS2TVAvHqFKdRwKSD5qVIKPSfoMuZVNTyQxvMbqpsWcHFzM4iDn4efUy3DszP3
 bjLjE3Yw/2r17Ydv8FPy5ChzFSGFkuf83A3NHTJjw==
X-Google-Smtp-Source: AGHT+IFryBkbWEkwDNGB8+uojW04kasFUN7PdeGZ/QJ4BEBfNV68U16waroXTJAEk0mdqJ9kIAjWGw==
X-Received: by 2002:a05:6000:2a2:b0:38a:8906:6b66 with SMTP id
 ffacd0b85a97d-38a89066f45mr27085791f8f.38.1736894596489; 
 Tue, 14 Jan 2025 14:43:16 -0800 (PST)
Received: from localhost ([177.95.18.53]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2ad809af716sm5689304fac.34.2025.01.14.14.43.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 14:43:14 -0800 (PST)
Date: Tue, 14 Jan 2025 19:43:10 -0300
MIME-Version: 1.0
Message-Id: <20250114-fix_b4-config-v1-1-e03eff794599@suse.com>
X-B4-Tracking: v=1; b=H4sIAH3ohmcC/x2M0QqDMAxFf0XyvEBbOxj7lSEj7aLmYXUkIoL47
 8t23w7ccw4wVmGDe3eA8iYmS3OIlw7qTG1ilJczpJCuIcaMo+zPkrEubZQJI5Vb7lPwEbjzUfb
 Dv/cYnAsZY1Fqdf5V3mQrK5znF+VoBAh4AAAA
X-Change-ID: 20250114-fix_b4-config-1ab84320000a
To: Linux Test Project <ltp@lists.linux.it>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1091; i=rbm@suse.com;
 h=from:subject:message-id; bh=kQJN/aWanCSkk5v40A0EKZanP9Gp64df40ffwbzJUVA=;
 b=owEBbQKS/ZANAwAIAckLinxjhlimAcsmYgBnhuh+C3RRxp8bzpd/syKd51MgM1EBuH9XMXLVw
 BVyEwenDS2JAjMEAAEIAB0WIQQDCo6eQk7jwGVXh+HJC4p8Y4ZYpgUCZ4bofgAKCRDJC4p8Y4ZY
 pgI8EACl/0yyal2lF06ozazEw2pl8YZ4tYXuoGxkp5LI1/q4JCjNq1Fr3k2welZQWUHA+Ckr6oW
 glkWWujhCNhXmJ4PVe7c/dunzSJp8UJl0+0AOJRHmal2h0Qnn2w6gRNy/ZC4QpLV4UySltDhrHg
 9/Ehd3NUsUmhwFxeNx8LuewFbyznLS3SAM0MXJjI38/iMM0YWyL81jVlS/DWahmxpyy1NhTCqwO
 P4hWXepwT6/kljtU7aKzOPbJGRoIiQoelavjqROME9d5PCUHDHDDPeynAlfVqPDiCAXDHvBY5jV
 UFkIRQp0m8IIktHmwvmyfLwTx26UNF1PphdvNOgpoXm4uvl6grYmbEouM766JLUf0h7HH+8E19k
 4J/pUln/fsDxX7zn1oa7lC38861ls09204X7cLUcA8dmuA96aV8QkV/bu88N8PrXMCRjnwH0DXa
 nE5YtJzQHt3TAmuxrCDlcnlbTQmesRODyOBG0eu7usG1JD0KEltc/LqISgOftm+WtJ6kVAAMRJm
 XjqFqI3vwli98P31xc/kbxgTa/uEsqlYDOGDgmLqDJOuDchPxVq0ihjhyLw00I4XmixclL/JEs2
 hnND96UYhjXSIBlS6AA+MipsJJ2xN3/91SkaNdXMUUMnWcUokrdviekb3MYC6kBDGXTrzlKsKi0
 mCYDHiUrQfBw2Lw==
X-Developer-Key: i=rbm@suse.com; a=openpgp;
 fpr=030A8E9E424EE3C0655787E1C90B8A7C638658A6
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH] .b4-config: Add checkpatch.pl default commands
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
From: "Ricardo B. Marliere via ltp" <ltp@lists.linux.it>
Reply-To: "Ricardo B. Marliere" <rbm@suse.com>
Cc: "Ricardo B. Marliere" <rbm@suse.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

From: Ricardo B. Marliere <rbm@suse.com>

Blend b4 default checkpatch.pl flags with the ones defined in
include/mk/env_post.mk in .b4-config so that a contributor may use `b4 prep
--check` and `b4 am --check` in his workflow.

Signed-off-by: Ricardo B. Marliere <rbm@suse.com>
---
 .b4-config | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.b4-config b/.b4-config
index 2efdf2273240dcf57bd5cab174ff6c7a1952dd5b..5a16bd64ec98b91e17386c0eadc7ef0de54d86f3 100644
--- a/.b4-config
+++ b/.b4-config
@@ -4,3 +4,6 @@
     send-series-to = Linux Test Project <ltp@lists.linux.it>
     pw-url = https://patchwork.ozlabs.org/
     pw-project = ltp
+    prep-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --showfile --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
+    am-perpatch-check-cmd = ./scripts/checkpatch.pl -q --terse --no-summary --mailback --no-tree --ignore CONST_STRUCT,VOLATILE,SPLIT_STRING
+

---
base-commit: 6fe8aa186559784f0394cd449cba6c53342790ec
change-id: 20250114-fix_b4-config-1ab84320000a

Best regards,
-- 
Ricardo B. Marliere <rbm@suse.com>


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
