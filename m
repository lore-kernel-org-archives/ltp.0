Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F115C54EBC
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 19:03:48 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 442AB3CCB31
	for <ltp@archiver.kernel.org>; Tue, 10 Jan 2023 20:03:46 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 791A93CCB21
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 20:03:34 +0100 (CET)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id E77AE6007B8
 for <ltp@lists.linux.it>; Tue, 10 Jan 2023 20:03:32 +0100 (CET)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
 by mailout.nyi.internal (Postfix) with ESMTP id E0B0B5C0127;
 Tue, 10 Jan 2023 14:03:29 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
 by compute2.internal (MEProxy); Tue, 10 Jan 2023 14:03:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=owlfolio.org; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to; s=fm2; t=1673377409; x=
 1673463809; bh=Mj44sQVxFsWNB0nlfV7JFNkfTCef+C1KG4aAGPbSAIE=; b=A
 o2z+xOk8oqFh9BP/nAinLOwmwtL6fBSVzu12xjWG04ZC02mbusEcMr5lxgg3FQTT
 vyIkSRU+x057/LJ2fXjsDrElIQxEVgjcC/UndupVygU3WN5RRFbr54Zd5nemQC5/
 uQcWcjhuxTzenIM/tNZ6xlHo4E+NKS74S2o20Y71rCB6EE0vsWQCangVQOZ55c2B
 RyS1VLPi4tEd43pxOVSR0imX5eLQkgLi2EzfIwd8sOrNOEmoTsWDu9eBKX2Y2gqK
 WKCypwS5VV5hYKFKPUcn9oQV4iAWtWCK4D3V/+BELpoI0aLpC6WePHT8FtgEzR/L
 V0N1+iAvUeuzae9icJmCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673377409; x=
 1673463809; bh=Mj44sQVxFsWNB0nlfV7JFNkfTCef+C1KG4aAGPbSAIE=; b=S
 oJ+Ci33UTlpFEYbK2Y79nASVGGywjs7cGvyXOPVNsSbswD2YVc4vLjAG6JP9DovR
 5pEwcZqSbc8EJGBTyBzhS3a16Zb/rG7o7tZURa2xYCpkeNBvJ4X+F6TK2D+k+pGW
 xsAqhFC5cR2X7CFv4e5cXtKBG4WOWh1NBLy09xS8cGnfppwcYFl6qmELRFuGfAAl
 OLs8xgCPIfY3O9OPTAlolBaIMMdb64tHC6/43FxLjhNRUZZVvyvuTvYdiBLXtIAd
 pve4GTzVH1Q3inkW85ip6H217jX99ZKaVkTEuhPfpD9lhSLTKqkY7v+MImtqSgFz
 2ZD+grwPdn9UClYLp+I7g==
X-ME-Sender: <xms:gba9Y7qrvgN7efjax3jYGflxm_yUp4d1s_jp_unIvAGivXlE_oToYg>
 <xme:gba9Y1pW5smbLdSQO7Iuj_BZk1GlI-qBYEXTWh_E9bN7OJD8wB5k1CdlkXSqMpMJV
 83ak31R5ohBMHIT6IE>
X-ME-Received: <xmr:gba9Y4P4_4bM1RkYpY1jJJlUJwLL-ZnBkFVsKQwiwOFz7SpGsEnT6tb7D9zu3LOOOLZQxA5UZtd_kOqJwsGQwg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgdehkecutefuodetggdotefrodftvf
 curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
 uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
 fjughrpefkffggfgfuvfevfhfhjggtgfesthejredttdefjeenucfhrhhomhepkggrtghk
 ucghvghinhgsvghrghcuoeiirggtkhesohiflhhfohhlihhordhorhhgqeenucggtffrrg
 htthgvrhhnpeekkeehfeehudeijeelgfegffeivdfgkedvtdelteegvdeufeeivdekleej
 leevvdenucffohhmrghinhepjedvrgdrhhhofienucevlhhushhtvghrufhiiigvpedtne
 curfgrrhgrmhepmhgrihhlfhhrohhmpeiirggtkhesohiflhhfohhlihhordhorhhg
X-ME-Proxy: <xmx:gba9Y-7t6WumfphAhGQgQYNhcR9DKpeV3HEWd6fzIJjTbjzcfc-9Tg>
 <xmx:gba9Y67mCRaSjRV_Cpw0IRoLqlfwR-tIum3HO1yKeXx4Le1TrLI9fg>
 <xmx:gba9Y2goxlQFMTaqVqGxN-Yj_GoHvWZK3DrwTPR93n1TATW56awCyA>
 <xmx:gba9YwkzVFX775UKyTD9TwzNu5zQaj7JMrLCQEHYIFjyuefpauLEug>
Feedback-ID: i876146a2:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jan 2023 14:03:28 -0500 (EST)
Message-ID: <80dd5d72-33ca-5294-6e3a-d5d8f2652b91@owlfolio.org>
Date: Tue, 10 Jan 2023 14:03:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
To: Petr Vorel <pvorel@suse.cz>, Richard Palethorpe <rpalethorpe@suse.de>
References: <20230103124505.6611-1-pvorel@suse.cz>
 <20230103124505.6611-2-pvorel@suse.cz> <87lemaivkv.fsf@suse.de>
 <Y72O1pYaHt6u1FvN@pevik>
Content-Language: en-US
From: Zack Weinberg <zack@owlfolio.org>
In-Reply-To: <Y72O1pYaHt6u1FvN@pevik>
X-Virus-Scanned: clamav-milter 0.102.4 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 2/2] configure.ac: Update AC_PROG_AR related
 comment
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
Cc: autoconf@gnu.org, Mike Frysinger <vapier@gentoo.org>, ltp@lists.linux.it
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

On 2023-01-10 4:25 AM, Richard Palethorpe wrote:
>>>   AC_PROG_CC
>>> -# <= autoconf 2.61 doesn't have AC_PROG_AR, but 2.63 has it. Not sure about
>>> -# 2.62.
>>> +# autoconf >= v2.72a
> 
>> This reads like we need the def for autoconf => v2.72a. How about
> You're right.  I probably thought this is defined since v2.72a,
> thus not needed.

Please don't use 'v2.72a' in any commentary or tests.  That version 
doesn't exist yet and may never exist; if it does, it will be a 
short-lived beta test release of v2.72 that we don't want people to 
depend on.
(Autoconf uses a very old version numbering convention in which beta 
tests for release X.Y are labeled X.Ya, X.Yb, X.Yc, etc.)

Officially, AC_PROG_AR will be available as of version 2.72, and that's 
what you should reference in commentary.

 > Also it looks like that redefinition is not a problem thus
 > not wrapping with m4_ifndef([AC_PROG_AR].

Autoconf will let you do that, but it's bad practice.  What if version 
2.73 makes AC_PROG_AR expand to something other than
AC_CHECK_TOOL(AR, ar, :) ? You'd be overwriting whatever bug fix that was.

I suggest something like

# AC_PROG_AR was added in autoconf 2.72.
m4_ifndef([AC_PROG_AR],
   [AC_DEFUN([AC_PROG_AR], [AC_CHECK_TOOL(AR, ar, :)])])

 > NOTE: missing 'ar' don't fail configure (isn't the check useless
 > then?)

We don't know what you need `ar` for; it might not be appropriate to 
fail the build if it's missing.  You can do

AC_PROG_AR
AS_IF([test x$AR = x:],
   [AC_MSG_FAILURE([no usable "ar" program detected])])

if you want to fail the build.

zw

-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
