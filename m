Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C39F8CCA472
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 11:34:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1759836879; h=mime-version :
 message-id : date : references : in-reply-to : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=lwtsiR4bCiYSSyV7F+qQxe5QCXp3HUqCLIEmNHUR9Nw=;
 b=VrlHs0fmqZm/b7rAfzL/MHbg34MRROWDifpE6tMgUiDHy9DntvkYQghrFur8lAP1fqoE0
 P35VYKoDGVa4Z04oUJDmJM1Vrcy8LkNv6RMsNrCKWCM5MrX9Ow1jnNg3jAwwfyg6OCF6bgT
 dO97DYWPtbAq/d+omL5tdHBHj0d8DvI=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 58F223CE3E8
	for <ltp@archiver.kernel.org>; Tue,  7 Oct 2025 13:34:39 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 531603CCE5F
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 20:00:21 +0200 (CEST)
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 9E51B60025F
 for <ltp@lists.linux.it>; Mon,  6 Oct 2025 20:00:20 +0200 (CEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 03BF644659;
 Mon,  6 Oct 2025 18:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D087FC4CEF5;
 Mon,  6 Oct 2025 18:00:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759773616;
 bh=4oQM312+pd6+1kpC4XhmpsurK9XSGqTTsWN0CjZ8lq4=;
 h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
 b=O2yuGutB4qL5lsb4SdXQAtzJxblp7OLs5ozdOvhZYN3EEd27ojLWaNCTVyYL4eo7X
 NRX8fL7Yvj6ODvFH3L+keK20OWxGZEIasa2yEcp7qpsm2iJc+omRu4PEznFN0Wieo4
 dbDgNz0D2x3kIJq/foX2Zlht8KGTkYklOft0mekxFdKV0hb5fUWZQsJDtCcoQaEFL4
 /MK1omnuizEJm3aanHWZ26UllzGSAok1o0oGINyA0XcpO+KVpP8MMlvASsGqb7/Zrl
 egY2pfpFi8Xbm1GYBJSjK8/12SgnStNjcdaWr6ltXlnwYaY/vewT44dmjNrcaZOwGX
 HLQte2R/SgXlg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
 by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id
 AE17839D0C1A; Mon,  6 Oct 2025 18:00:07 +0000 (UTC)
MIME-Version: 1.0
Message-Id: <175977360652.1498132.2436692293138075252.git-patchwork-notify@kernel.org>
Date: Mon, 06 Oct 2025 18:00:06 +0000
References: <20250930232957.14361-1-mjguzik@gmail.com>
In-Reply-To: <20250930232957.14361-1-mjguzik@gmail.com>
To: Mateusz Guzik <mjguzik@gmail.com>
X-Virus-Scanned: clamav-milter 1.0.7 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Tue, 07 Oct 2025 13:33:40 +0200
Subject: Re: [LTP] [f2fs-dev] [PATCH] f2fs: don't call iput() from
 f2fs_drop_inode()
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
From: patchwork-bot+f2fs--- via ltp <ltp@lists.linux.it>
Reply-To: patchwork-bot+f2fs@kernel.org
Cc: brauner@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
 oliver.sang@intel.com, oe-lkp@lists.linux.dev, josef@toxicpanda.com,
 ltp@lists.linux.it
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

Hello:

This patch was applied to jaegeuk/f2fs.git (dev)
by Jaegeuk Kim <jaegeuk@kernel.org>:

On Wed,  1 Oct 2025 01:29:57 +0200 you wrote:
> iput() calls the problematic routine, which does a ->i_count inc/dec
> cycle. Undoing it with iput() recurses into the problem.
> 
> Note f2fs should not be playing games with the refcount to begin with,
> but that will be handled later. Right now solve the immediate
> regression.
> 
> [...]

Here is the summary with links:
  - [f2fs-dev] f2fs: don't call iput() from f2fs_drop_inode()
    https://git.kernel.org/jaegeuk/f2fs/c/8ec5fc1ff77e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



-- 
Mailing list info: https://lists.linux.it/listinfo/ltp
