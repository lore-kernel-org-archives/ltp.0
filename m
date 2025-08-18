Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6B61CA0ED1
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 12:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1755521827; h=message-id :
 to : date : mime-version : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : cc : content-type : content-transfer-encoding : sender :
 from; bh=MvgfO3MirhfFWV8cnjk39v5K2KxrTAE9dM07A/QAPMQ=;
 b=Jee1Mq+SDiaKSTVccLRc8tYmmJUx+BwzgYGSxieC82ixj61NZ3pGtIe90+h0khHg26gEp
 MEYa2Xu12gAPZyW31sSHg2hzpZum7r0sSnB/fAaGJpKO2J+x30zCN4OrOI+TKztRSCIgpOd
 IeXhpt7fxCOAt2TJUp8pCij+dl22b+E=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 473493CC8BE
	for <ltp@archiver.kernel.org>; Mon, 18 Aug 2025 14:57:07 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with UTF8SMTPS id 76C1B3C82CD
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 10:59:47 +0200 (CEST)
Received: from out162-62-57-64.mail.qq.com (out162-62-57-64.mail.qq.com
 [162.62.57.64])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with UTF8SMTPS id E536A6168DB
 for <ltp@lists.linux.it>; Mon, 18 Aug 2025 10:59:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1755507579; bh=cpZkW2r7ImB8kaGre3DYAw+MDS+CfRsRLGn8cyttQTk=;
 h=From:To:Cc:Subject:Date;
 b=V6OXuREdTJfSGmfAhJhOmPNWCnoYFiEh1YPvHDiXlmXKgQ33D8WBivRM30hONikeF
 7JRU4ONZmRaV5p/OCg06MdWVURQybfSUwqdfJlcJRlHnR2ltMnsnc4HyT+D9rSN5a4
 QMVvyAF3nC6ZuWpbVTnhNmUuStamoiei/swjT9bs=
Received: from b0d8a1e10007.. ([202.112.47.78])
 by newxmesmtplogicsvrszb16-1.qq.com (NewEsmtp) with SMTP
 id EE592802; Mon, 18 Aug 2025 16:59:37 +0800
X-QQ-mid: xmsmtpt1755507577tl362l24v
Message-ID: <tencent_05DE07BA6C168B5D5A26E2E54EC881EB6509@qq.com>
X-QQ-XMAILINFO: M/es4o3+cmdNKUXgeZtzh4RTvYBPNs2wWkfFSicOPBvwLk6OdmvqegHpSUheNN
 gy4hhbMfaMZF3NZdYtwECL9LFCCmnYk7jOWXjU1KSrLtduApaDmnQJ65C6CMw7pR+rwOlfFzS8ut
 CWThgW75PttdCSkoMPyVWk2twA0Ae7IF/vSA07AV7jUpkUDCNcVWJLJ/htbe4rnsur0S8Q6YZdTM
 p55NJDlG75RrGpEQGSifz8Cc+GSF5RD6zKzDdPrZOvytRycaF0yjED9Ilk0vwDVrItoccOUgDOIH
 NMOiSCLgWKOEQlbxdGk4VWOGxAd2c1MyS4JVxSMJM9m+E3Vn103XI0mKhjbvdnYciZscWkPvkDE6
 +ViFTvSb58hpqrRBvkS5yRO0aPb7SZNRh2/LUhQmrsMpdoHc6bMhao2UbDjaYkGWBzjp7ucBb9hd
 pUXJahtoPbHd2cKQigQ1nOIlM8zYboSTs1bj5P8Ax3dBtAteqDNi7OwrH0sxxQtaG8u9hyDUIbba
 36IVw6lyaGuXZnwTeqBlhZo84tcY3U2KtCXamPbhpMujVnB5AVnaoAP8xffW7EDVg1S9Q7/XPbPI
 DJj9nhPF/yStZE06w3evNolBKMnIhHRpSwVUz1lfnuoOD7FSfj4zyrA3d/ZygXUp41oO7HlxVlrG
 JMqE7jVIYjeYfz3CpnhmQELL+t6/jWo3H+IbSyFgUu5WJusOywWSEVzLPbLLi3iDM2wBezUnpHrP
 3AGPuyexmLBAjZgRQi/NwpTCW0MCBCgZkNnWKdbAVhTklk7ChBKM273NEZog6+HE6/DUo7BvcS7Z
 BoFtzJAlX+KjNFo0HbxvVjdF3HP/PVosP6oBbJUDN1Ce7et09kK4TmKqLUqQiW1T6O4JDcWdBsNX
 6wI/SZ+6ZGQST3sQwcHP2p9ynSivdxRWvwxJP9Accb1NGljDE0s1s9ZvM5YbVywSZmFVF6Xu3OdG
 JuKAWrCZEPA9PbzxVpmchT3iYPTnaWQwZ3hwnzujPoSVpalQPxpgtieEpgrcumTMOPlmeZkPF+0K
 nxJzkjDhTEV3KyACL+ojitCBcxqV/Hp6erk2ctwZhk6SudDVC0ARiAd/hZMVNgONAns16ZxlXDxA
 UazCjy
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
To: ltp@lists.linux.it
Date: Mon, 18 Aug 2025 08:58:38 +0000
X-OQ-MSGID: <20250818085837.2332368-1-791960492@qq.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Mon, 18 Aug 2025 14:56:46 +0200
Subject: [LTP] [PATCH] sigaltstack01: Fix check about alternative stack
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
From: Liheng Chen via ltp <ltp@lists.linux.it>
Reply-To: Liheng Chen <791960492@qq.com>
Cc: Liheng Chen <791960492@qq.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hi all,

This check seems should be (alt_stk < sigstk.ss_sp) || (alt_stk > (sigstk.ss_sp + SIGSTKSZ)), not &&

Kind regards,
Liheng Chen

Signed-off-by: Liheng Chen <791960492@qq.com>
---
 testcases/kernel/syscalls/sigaltstack/sigaltstack01.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
index 9a2e3a440..147659467 100644
--- a/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
+++ b/testcases/kernel/syscalls/sigaltstack/sigaltstack01.c
@@ -142,7 +142,7 @@ int main(int ac, char **av)
 			 * Check that main_stk is outside the
 			 * alternate stk boundaries.
 			 */
-			if ((alt_stk < sigstk.ss_sp) &&
+			if ((alt_stk < sigstk.ss_sp) ||
 			    (alt_stk > (sigstk.ss_sp + SIGSTKSZ))) {
 				tst_resm(TFAIL,
 					 "alt. stack is not within the "
-- 
2.34.1


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
