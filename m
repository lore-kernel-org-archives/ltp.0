Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB37C04FFE
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 20:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1715201500; h=mime-version :
 message-id : to : date : subject : list-id : list-unsubscribe :
 list-archive : list-post : list-help : list-subscribe : from :
 reply-to : content-type : content-transfer-encoding : sender : from;
 bh=J6oQKNFxC7qfJ4Al1Ddl2kw+fij73IEHz+EZWpqwGmQ=;
 b=Je2cu9R+irUmGBdQA9Kv8hKYKa/gMgzGHic9uKLbeeJkjL1a/uJM0Dgeuum3mZIEy5V0E
 UTDtuIETSANwzF8zsavVshkaN1YsXsAPnru8pOChOW084WZ91qVgi3vJEIz7m2k0Po/qeg3
 tn/7GhID5dbftNE2ukyY/S7NLuRuQX0=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 618CE3CE093
	for <ltp@archiver.kernel.org>; Wed,  8 May 2024 22:51:40 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 17D223C04BB
 for <ltp@lists.linux.it>; Wed,  8 May 2024 22:51:18 +0200 (CEST)
Authentication-Results: in-5.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=web.de
 (client-ip=212.227.17.11; helo=mout.web.de; envelope-from=wine.dev@web.de;
 receiver=lists.linux.it)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits)
 server-digest SHA256) (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id D0ECA600294
 for <ltp@lists.linux.it>; Wed,  8 May 2024 22:51:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1715201475; x=1715806275; i=wine.dev@web.de;
 bh=jDXQuLTN67TFK3YiOKQLwQZTc2YaoXLyb2Y8YFhGsaY=;
 h=X-UI-Sender-Class:MIME-Version:Message-ID:From:To:Subject:
 Content-Type:Date:cc:content-transfer-encoding:content-type:date:
 from:message-id:mime-version:reply-to:subject:to;
 b=cWDQ+D5p2uSnZJYahRfpNCqyw4AEc9AmRCKvm8lySStxb83Y6/5O9oahW8fUX7k/
 I9LdP8FRAulF3lafek5R8zRZtQlKpGTczaWtJOdc18L8CrnKfBfHwp8Cra0OgAFfP
 rE2HVZUs3/0FCLVU8oiaQ++aMCCnCOLoYxU/qaniVBDej2RLGH8F6zh69N8NO4D8U
 EacklFjRojXBNK1keERGP5N41s2GaZdq4aVFk/n9HWScI8MZTN09cTtET3T/Nb0Mk
 KYBzLBpLmIR60xpB1iH05VytTDfS+pEZ+sRCHiBHo6L4brPCgLtIu+4sx2VX2Fg9d
 dAqThe5hXCPJFXVBSA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [79.232.219.30] ([79.232.219.30]) by web-mail.web.de
 (3c-app-webde-bap44.server.lan [172.19.172.44]) (via HTTP); Wed, 8 May 2024
 22:51:14 +0200
MIME-Version: 1.0
Message-ID: <trinity-b402401a-a48e-41c1-ad25-f03507cdde3f-1715201474875@3c-app-webde-bap44>
To: ltp@lists.linux.it
Date: Wed, 8 May 2024 22:51:14 +0200
Importance: normal
Sensitivity: Normal
X-Priority: 3
X-Provags-ID: V03:K1:vDHClKzC9b79WIZ0yYubsXQJgyGlics2FQW/UblhORqpVG8bu/dV2KCue4a/0WTN9IDjE
 rnucITjWL/R+CDEQxzYsGNlAgAiN+fyhfyMesM1t9+o2ZlKVtXK126eDYAp13u6zmAXuvn2px+P/
 mb0XzTedhiMpjRMCkDjEhc/UeY82svjUhQGyzxCwRpIGuKfKE9ONe2Sz2OLTDClKI3b6mDUWk+gq
 zFji+ErxO4gX2SfTcK2E90ZyOnIj7hNrn65aUS3lf/wFWDVCfyaB/xu5tt8L0QmpamcoiZjtFT2o
 0s=
UI-OutboundReport: notjunk:1;M01:P0:xf79HYzk+x0=;6kFixEyP+q1+qSh9IndUaYUD+Ev
 uVNT87TittNFxT9T2Ym0jUbsT4B165Ool4qHXtC4E0mGcMQecDRg5G1GqEz0lMEaIp32ox7pW
 Tzi5x83osxjF1I4p0/Cm3MDh98DipPzycc8JPOQIL9TOGtN4nbPo+Qrxx7Wc62SpkoBBa+g4n
 M33Eku8T74vqFjgG8QUMvqqHJLfSOa4cA+tXkJPMOMALS8sWUGjwQKua5BEGbAzAHKre9ZZJQ
 sCPEiVZoa2BjUauiauIv1u69DqOu7Yp47nUwV5NMuDk9W1CqJ4+39Fptkqa27aG65pv+1YfFv
 DkY7zFmDgGliSo7+EIxUg1kS8hP+37pKK31wR0YOFDMC9X0DvmRpRUq/791/Xrf6D04/wE0C7
 7dNv6zQvdwIjnhudjwhJXBgpZ4xa+nX5622n8wEMhI98dwrH6/K8cThrE4jyuSikPCmUEqi/a
 jtWAlGXFa37esGPyuzm5NNW5UcBPAsibguxi9V9gIYVJHQuHnwyM+E3S4Pf4ywt1TPNDWXtnP
 xi/un8lxamg2zu2zi/YymqAcMpRjJ05QvO2stwW+Ih2eJd4QEOCDPYWggKOL7lsnsYyMy11+K
 UYrSLUW6oTlbTHkQljjmI2h/pm98CEHMTWdMi2sN2CLnVu2z7bPleYp6tEWEtuTvzC4iYwyy+
 7HUJoJIB+bbmTLCqiUvi6QUMpIQ0AYEm0LaRhUVuxeDyPBD4RQrq/pralsE/URM=
X-Virus-Scanned: clamav-milter 1.0.3 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: [LTP] [PATCH] open_posix_testsuite: Remove inclomplete warning
 commandline argument
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
From: Detlef Riekenberg via ltp <ltp@lists.linux.it>
Reply-To: Detlef Riekenberg <wine.dev@web.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>


The Open Posix testsuite calls the compiler with the commandline argument
"-W", but that is not a supported gcc warning option
and breaks other compiler.

This patch removes the broken "-W" commandline argument.

Fixes commit 8071ba7

References:
https://gcc.gnu.org/onlinedocs/gcc/Option-Summary.html
https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html


--
Regards ... Detlef


Signed-off-by: Detlef Riekenberg <wine.dev@web.de>

---
 testcases/open_posix_testsuite/include/mk/config.mk.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
