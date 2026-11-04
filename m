Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70D606A328
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 11:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.linux.it header.i=@lists.linux.it header.a=rsa-sha256 header.s=picard header.b=Qh1E7w2S;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=sPFubdfT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1793790048; h=message-id :
 to : date : in-reply-to : references : mime-version : subject :
 list-id : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : content-type :
 content-transfer-encoding : sender : from;
 bh=BQZsILamiTNbvVu8MGLA3Kcr7pqb2wC/VnHOM1K0Z24=;
 b=Qh1E7w2S3BJAvs0GlTWMi6/u772qEIp0wTYZEmbs6DMa7NZCxYtsXWqLYipwn0jO51VO4
 YKSiaKM08m5pf1w/8ihXgE3qSmCs46KRdo6um11qQhWGVneEaNlQxOV0WGZTqvOMB52AB+B
 b6QgPu1yS4SvfBkiolKRtDePwrjj+J0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B5B813CB577
	for <ltp@archiver.kernel.org>; Wed,  4 Nov 2026 12:00:48 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D35883C636C
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:00:28 +0100 (CET)
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.43])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id D420860090A
 for <ltp@lists.linux.it>; Wed,  4 Nov 2026 12:00:26 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1793790025; bh=DlViKePaaZRf6gal/uNHMh7K7fcceouaxG05sXECVdI=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=sPFubdfT/3ByMX6UTEXZ/x8G/BiKPisq4bdky9NUhTcZZoOr67VX6ofdukBjX52SB
 z7+VlI0/1FzYkFgHkRo7rPOQ8OYcVPE9kaY7tjxrCJCKsOr1cWyDsnBqbwO3ehJWlt
 ONUWFH1v1VWqN1xwSGI1/ZUECYWfWDT/umIbouxc=
Received: from LAPTOP-KQCD4QBN.localdomain ([123.121.145.87])
 by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
 id 15B4472; Wed, 04 Nov 2026 19:00:21 +0800
X-QQ-mid: xmsmtpt1793790023tdguwyjd5
Message-ID: <tencent_0DA2996E2044C0D5F00BCBE70D8B860A8407@qq.com>
X-QQ-XMAILINFO: MqswyhUqVe0CspYBBrRkRRZ4JNxgsHg0EYHzpHOgOHZvlN31Ge5DkJeVbFPALW
 xyAn3spdNFRU/ZhNH0yebmYmMdmPLlPdUSgCId3K3/WWiQ/GCAwBXbvEjChTglM+B7qKbPfB4VlA
 4Ip+e43ERzzQkvgIgWCRGKhK4duvhWNANOc25yhDRm5ogPzDxFr+9iVSwboHLHwOAulpGBT0lBLH
 WqsxrY6n4VufrPgn0g0N506hCYofpCjcRNk/01RMOO3lhdeUAgzf6NsSXAtNk/al7ztAC9cOvWXc
 rLrdqZDrccfCdKVb0wWrmeBu0DDSrfHE71YCvKYLP+58q5XODKHPvDYI05aK7brZ+hlM1F0VrUV2
 qoUUmxLXmaRWUKd3NV7qWG8E/6mUxG9kKhzAarQyB4yLkarVyFvXekIFGeksNJAotFi0JvZCK+VK
 2PEp43waudgLzq2UGxMLQl+L8AZVXl5aJ5Ife1x3G18PVHVVJ2UDnE8A74uTMs7rSBsu7UZaLSLJ
 Ds/JEFUpraz88BYakNo7FJmD+O/BloJ4P5oXJV1d5QC2YayGwo2R/8oLDYT6CFj6xVEl6qP7mM8K
 89Eg2K8WqFDYlgjW8/Kh7Xe54AGUa2G77xj5N8WC8ijR9pyklGQvVVLoZe/Em2kCoaGlQpeFezXW
 QjC0oJC7CUuRCxIj9cYmRHq+dfuyrZ5elhy3w6X32z1tvdARc+feFwgtPrdkLMmOxJhShjvQyFBE
 MxOYQG7XtiJsuiBD2N+DQIQXDai3TVONS9RNAsTcLqJK2hUuZFgWXbflYji7CGWcpoANXi58pAKY
 3HDEd6VMLimXdKIPdD2Tax5HcWfJeZt9RNaXi0Kwlrt4bO2EeGtr2giwLOIWn0lhddCL57YxqaRE
 um0O9Qns7SFBNSSH8CAtKe1OpYZGgAl9MyovMtbEljnmRAyLie/kCFs+Demo2mnQKkvcc0qJCVBH
 ssqecHZLTBViXo671WDVuPP4ZYkfJIzRQ1W6ifL6OW11P/M/wcTReOdqlm0o8R+VOAQNJsO0gcLp
 tqgss5i9vJ4U1rSSJRGHLQEdvmmIGJwKAje0BmtGPm6e0TKHw4ty9ntEm3ZJnGRBwtxE3fOWhNlg
 KHkvUj89wCqrEg6Ro=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
To: ltp@lists.linux.it
Date: Wed,  4 Nov 2026 19:00:20 +0800
X-OQ-MSGID: <20261104110021.7870-2-2063309626@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104110021.7870-1-2063309626@qq.com>
References: <20261104110021.7870-1-2063309626@qq.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Status: No, score=-17.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_REPLYTO_END_DIGIT,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 1/2] lib: Validate sysconf() return values in the
 safe wrapper
X-BeenThere: ltp@lists.linux.it
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux Test Project <ltp.lists.linux.it>
List-Archive: <http://lists.linux.it/pipermail/ltp/>
List-Post: <mailto:ltp@lists.linux.it>
List-Help: <mailto:ltp-request@lists.linux.it?subject=help>
List-Subscribe: <https://lists.linux.it/listinfo/ltp>,
 <mailto:ltp-request@lists.linux.it?subject=subscribe>
From: Wenyuan Li via ltp <ltp@lists.linux.it>
Reply-To: Wenyuan Li <2063309626@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

sysconf() returns -1 either on error (with errno set) or to signal that
the queried option has no definite limit. Any value below -1 is not a
legal return value, so report it as a test environment error instead of
handing it back to the caller unchecked.

For _SC_PAGESIZE also reject values that cannot describe a page size:
-1 without errno (this name has no "indeterminate limit" semantics), 0,
and values that are not a power of two. The generic -1 && !errno path is
deliberately left as TINFO because it is valid for other names such as
_SC_OPEN_MAX.

Audited all 49 SAFE_SYSCONF() call sites in the tree:

  _SC_PAGESIZE            32
  _SC_PAGE_SIZE            7   (glibc alias of _SC_PAGESIZE)
  _SC_CLK_TCK              4
  _SC_OPEN_MAX             3
  _SC_NPROCESSORS_CONF     2
  _SC_NPROCESSORS_ONLN     1

None of them relies on a value below -1 and none expects _SC_PAGESIZE
to be indeterminate, so the new checks only fire on a broken test
environment. The three _SC_OPEN_MAX callers, e.g. the loop bound in
tst_ns_create.c, are exactly why the generic -1 && !errno branch must
stay untouched.

Suggested-by: Cyril Hrubis <chrubis@suse.cz>
Signed-off-by: Wenyuan Li <2063309626@qq.com>
---
 lib/safe_macros.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/safe_macros.c b/lib/safe_macros.c
index 187550041..40c5f292f 100644
--- a/lib/safe_macros.c
+++ b/lib/safe_macros.c
@@ -700,6 +700,26 @@ long safe_sysconf(const char *file, const int lineno,
 		}
 	}
 
+	if (rval < -1)
+		tst_brkm_(file, lineno, TBROK, cleanup_fn,
+			"sysconf(%d) returned invalid value %ld", name, rval);
+
+	if (name == _SC_PAGESIZE) {
+		/* A -1 with errno set was already reported above. */
+		if (rval == -1)
+			tst_brkm_(file, lineno, TBROK, cleanup_fn,
+				"sysconf(_SC_PAGESIZE) returned -1 without errno");
+
+		if (!rval)
+			tst_brkm_(file, lineno, TBROK, cleanup_fn,
+				"sysconf(_SC_PAGESIZE) returned 0");
+
+		if (rval > 0 && (rval & (rval - 1)))
+			tst_brkm_(file, lineno, TBROK, cleanup_fn,
+				"sysconf(_SC_PAGESIZE) returned %ld, expected a power of two",
+				rval);
+	}
+
 	return rval;
 }
 
-- 
2.43.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
