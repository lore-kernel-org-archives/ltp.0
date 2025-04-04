Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E9E2C36010
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 18:15:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 097533CB341
	for <ltp@archiver.kernel.org>; Fri,  4 Apr 2025 20:15:19 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 984533CAD8B
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 20:14:27 +0200 (CEST)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=gotplt.org (client-ip=23.83.222.68;
 helo=giant.ash.relay.mailchannels.net; envelope-from=siddhesh@gotplt.org;
 receiver=lists.linux.it)
Received: from giant.ash.relay.mailchannels.net
 (giant.ash.relay.mailchannels.net [23.83.222.68])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D00D41A00CAC
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 20:14:25 +0200 (CEST)
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
Received: from relay.mailchannels.net (localhost [127.0.0.1])
 by relay.mailchannels.net (Postfix) with ESMTP id F0E177834DA
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 18:14:23 +0000 (UTC)
Received: from pdx1-sub0-mail-a298.dreamhost.com
 (trex-6.trex.outbound.svc.cluster.local [100.97.44.91])
 (Authenticated sender: dreamhost)
 by relay.mailchannels.net (Postfix) with ESMTPA id 9748378307E
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 18:14:23 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1743790463; a=rsa-sha256;
 cv=none;
 b=LwvC6olHEkAopv3SAkMK8Wc4TAlbVsrHas+HPZUYd1y5uVtiuUJ8754cMEMtz46KfepscC
 P2EHwiWoW2wl9m3AdScvqqdAoQJBZ+vFsh7CpHRHOtzSmpCFxMEFBDvsXEcRTG2z3ikHsq
 dcNt04Z2gb7rN74LTIIh+Y/w6m3eREbe6KPZNnci+JJKyoaaIv17gt6YEXjMyzEYO82mP6
 +BloeWJcZE5bhNUNW/KPUQSalsZZ+eX51IZlEu+Gdks0ewOqH8mMrojbSjZIGCY2ahIITf
 Iu58XgAPcUCFBywV+APd2jZBrZyuT+4grOXLtDa7/p6zXgdSp6ljM107Rt455Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net; s=arc-2022; t=1743790463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:dkim-signature;
 bh=S+BdIlIAQbr04fZDzptdXqKAsTSY8skbUtVG1dKlVkw=;
 b=sPWGidluGoU712pRSufVY1hJcZTOwrFqEQ8p2FSEa/58gl3OG6BfXrXV+SSjcDrwr1/esi
 p8zQSKtelNlz3w8NIkVNlIBWncWYlpCToCHhs+pmgPEDk7JH6Ie7Ft1EUqHB2Y00OLoR8A
 Nfj7Fl0zckJUrTD9d2p4J2p2EO6nOzh8orMFMgYMI/1aYTmQiD7/PVcB18CPT/e7qcOU07
 J35Bed+MNFbGvAWZJ5vzkIHqbWVllX5Gty1SwOUaJdDdLnbHuU1HnjUQPD8YGsdaqKPsVi
 /8onliCsardbIHolXWr/areGbeUaERsvWuqmSX8bL7hU7dX6E0j7tQEIqeRcsA==
ARC-Authentication-Results: i=1; rspamd-6c88b8f79f-thj5h;
 auth=pass smtp.auth=dreamhost smtp.mailfrom=siddhesh@gotplt.org
X-Sender-Id: dreamhost|x-authsender|siddhesh@gotplt.org
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|siddhesh@gotplt.org
X-MailChannels-Auth-Id: dreamhost
X-Reign-Sponge: 655d85b417dcd989_1743790463824_430335682
X-MC-Loop-Signature: 1743790463824:1900937486
X-MC-Ingress-Time: 1743790463824
Received: from pdx1-sub0-mail-a298.dreamhost.com (pop.dreamhost.com
 [64.90.62.162]) (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
 by 100.97.44.91 (trex/7.0.3); Fri, 04 Apr 2025 18:14:23 +0000
Received: from fedora.redhat.com (unknown [38.23.181.90])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 (Authenticated sender: siddhesh@gotplt.org)
 by pdx1-sub0-mail-a298.dreamhost.com (Postfix) with ESMTPSA id 4ZTmvz0HmKzFG
 for <ltp@lists.linux.it>; Fri,  4 Apr 2025 11:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gotplt.org;
 s=dreamhost; t=1743790463;
 bh=S+BdIlIAQbr04fZDzptdXqKAsTSY8skbUtVG1dKlVkw=;
 h=From:To:Subject:Date:Content-Transfer-Encoding;
 b=w3XCz7lmnG3gjWE7+e941ejeYSn+bEMSR9r+Iv1KjohnfJyN6p6MJs3aohcQJWqBe
 DAvCakDhnPeyzvZGR8RPIrWwf96ruC4szCQ/bNcZVD/LfROd6n/oGnb+ZIfw3ZSbeW
 APSr677Yb/rZ4gt1+2vNd4wihik+8DqX4gBdgEZuK63Whfiyv9W1GFW85H4NLQsncx
 ZiCQjLeGQ9VEMY1yFJdiPMtkDqvhxnIDxqBAtb60HOl1sl1Ux2W/ADrURcdofy/ClW
 uhkMjWElRtK8j+lFZFQGdXbEkwR7IPoTyefbJamDZz1/PB0DlofrN+0RnPTmqh09qA
 6LnS3WMRwAOgg==
From: Siddhesh Poyarekar <siddhesh@gotplt.org>
To: ltp@lists.linux.it
Date: Fri,  4 Apr 2025 14:14:04 -0400
Message-ID: <20250404181406.2385612-1-siddhesh@gotplt.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402170718.1710388-1-siddhesh@gotplt.org>
References: <20250402170718.1710388-1-siddhesh@gotplt.org>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH v2 0/2] cve-2015-3290: Disable AVX
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Here's v2 of the patch, this time also with an addition to the test
matrix so that github actions also tests on centos10, which has gcc
defaulting to x86-64-v3.

Test results without the flags, where centos10 fails:
https://github.com/siddhesh/ltp/actions/runs/14271015950/job/40004000177#step:10:658

Test results with the flags where all tests succeed:
https://github.com/siddhesh/ltp/actions/runs/14271210435

Siddhesh Poyarekar (2):
  cve-2015-3290: Disable AVX for x86_64
  Add centos10 to test matrix

 .github/workflows/ci-docker-build.yml | 5 +++++
 testcases/cve/Makefile                | 6 ++++++
 2 files changed, 11 insertions(+)

-- 
2.49.0


-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
