Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68F31C433F5
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 10:13:59 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 62A063C9607
	for <ltp@archiver.kernel.org>; Mon, 17 Jan 2022 11:13:56 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id E83693C821C
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 11:13:46 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 178582002A5
 for <ltp@lists.linux.it>; Mon, 17 Jan 2022 11:13:45 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3885A1F398;
 Mon, 17 Jan 2022 10:13:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1642414425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DF/CHmziM18coFzve93Q8fS60lYPSD4ARr9gIBt4yg=;
 b=V7RBD8q2V4ACqYmh2abZwFATOzQvkjU3rvrdde3oFn8zyvISWTMEfHICNmn0v6/pPxqC5O
 +F5HlWfS5Bke/05VBDQTZbhMTRUvZEigGDClWn5ZehxocriWDIeavYW/Gib7rOGH96F7H2
 Mz3ZfJb6XLhd4WxgDIhqOJDXxYECoAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1642414425;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9DF/CHmziM18coFzve93Q8fS60lYPSD4ARr9gIBt4yg=;
 b=qfYdK6ZCTPTjSDlF1m66jSW/B0+9FENTH5L8ysDA1Xbqn5ERTAcGCKb1CgsloLtodYWAci
 cESNaD6jEgzk1pBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0AC7113CF9;
 Mon, 17 Jan 2022 10:13:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id QahFAFlB5WGVTgAAMHmgww
 (envelope-from <pvorel@suse.cz>); Mon, 17 Jan 2022 10:13:45 +0000
Date: Mon, 17 Jan 2022 11:13:43 +0100
From: Petr Vorel <pvorel@suse.cz>
To: "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
Message-ID: <YeVBV8D3jNtGAxYa@pevik>
References: <20220117090744.30354-1-pvorel@suse.cz>
 <61E534C5.6060005@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <61E534C5.6060005@fujitsu.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [COMMITTED][PATCH] ci/wiki-mirror: Fix triggering CI
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
Reply-To: Petr Vorel <pvorel@suse.cz>
Cc: "ltp@lists.linux.it" <ltp@lists.linux.it>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWHUsCgo+ID4gRllJIGJhOTliODE3MDggKCJkb2M6IEZpeCB0eXBvIG1pc3NpbmcgcyBpbiAu
YWxsX2ZpbGVzeXN0ZW1zIikKPiA+IHZlcmlmaWVkIGl0J3Mgd29ya2luZzoKCj4gPiBodHRwczov
L2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9hY3Rpb25zL3J1bnMvMTcwNzA5MDM2
NgoKPiBJIGZvdW5kIHRoaXMgcHJvYmxlbSB3aGVuIGRvYy8qIHBhdGNoIGlzbid0IHRoZSBsYXN0
IHBhdGNoIG9mIGEKPiBwYXRjaHNldC4gIEJ1dCBoZXJlIGl0IGlzIGEgc2luZ2xlIHBhdGNoLgpQ
YXRoIGNoZWNrIHdhcyByZW1vdmVkIGluIDgyMGNmZTUzOWIgKCJjaS93aWtpLW1pcnJvcjogRG9u
J3QgY2hlY2sgcGF0aCIpLgoKUGF0aHMgc2hvdWxkIGJlIHdvcmtpbmcgbm90IG9ubHkgb24gbGFz
dCBjb21taXQsIElNSE8gaXQgZXZhbHVhdGVzIGFsbCBmaWxlcyBpbgpwdXNoCmh0dHBzOi8vZG9j
cy5naXRodWIuY29tL2VuL2FjdGlvbnMvdXNpbmctd29ya2Zsb3dzL3dvcmtmbG93LXN5bnRheC1m
b3ItZ2l0aHViLWFjdGlvbnMjb25wdXNocHVsbF9yZXF1ZXN0cHVsbF9yZXF1ZXN0X3RhcmdldHBh
dGhzcGF0aHMtaWdub3JlCiJXaGVuIHVzaW5nIHRoZSBwdXNoIGFuZCBwdWxsX3JlcXVlc3QgZXZl
bnRzLCB5b3UgY2FuIGNvbmZpZ3VyZSBhIHdvcmtmbG93IHRvCnJ1biBiYXNlZCBvbiB3aGF0IGZp
bGUgcGF0aHMgYXJlIGNoYW5nZWQuIFBhdGggZmlsdGVycyBhcmUgbm90IGV2YWx1YXRlZCBmb3IK
cHVzaGVzIG9mIHRhZ3MuIgoKPT4gaXQgc2hvdWxkIGJlIHdvcmtpbmcgZXZlbiBJZiBJIHJldmVy
dCA4MjBjZmU1MzliLCBiZWNhdXNlIHJ1bm5pbmcgdGhhdAp3b3JrZmxvdyBkb2VzIG5vdCB0YWtl
IGxvbmcuCgoKVmVyaWZpY2F0aW9uIGl0J3Mgd29ya2luZyBvbiBteSBsb2NhbCByZXBvOgoKSSBw
dXNoZWQgZmV3IGNvbW1pdHMgaW4gbXkgbG9jYWwgYnJhbmNoOgpodHRwczovL2dpdGh1Yi5jb20v
cGV2aWsvbHRwL2NvbW1pdHMvdG1wCnRoZSBsYXN0IGNvbW1pdCB3YXMgb24gLmdpdGh1Yi93b3Jr
Zmxvd3Mvd2lraS1taXJyb3IueW1sIGFkZGluZzoKKyAgICBwYXRoczoKK++/vCAgICAgIC0gJ2Rv
Yy8qKicKCmNvbW1pdCBvbmx5IGluIHRoYXQgYnJhbmNoIChub3QgaW4gdXBzdHJlYW0pOgphYTdl
YzA2ZDIyICgiUmV2ZXJ0ICJjaS93aWtpLW1pcnJvcjogRG9uJ3QgY2hlY2sgcGF0aCIiKQoKT3Ro
ZXIgY29tbWl0IHdhcyBtb2RpZnlpbmcgcmVwbyB0byAncGV2aWsvbHRwJwoKaHR0cHM6Ly9naXRo
dWIuY29tL3BldmlrL2x0cC9hY3Rpb25zL3J1bnMvMTY5OTIzODI1OS93b3JrZmxvdwouLi4Kb246
CiAgcHVzaDoKICAgIGJyYW5jaGVzOgogICAgICAtIG1hc3RlcgogICAgICAtIHRtcAogICAgcGF0
aHM6CiAgICAgIC0gJ2RvYy8qKicKCmpvYnM6CiAgbWlycm9yOgogICAgcnVucy1vbjogdWJ1bnR1
LWxhdGVzdAogICAgaWY6ICR7eyBnaXRodWIucmVwb3NpdG9yeSA9PSAncGV2aWsvbHRwJyB9fQou
Li4KCmFuZCB0aGF0IHB1c2ggdHJpZ2dlcmVkIENJOgpodHRwczovL2dpdGh1Yi5jb20vcGV2aWsv
bHRwL2FjdGlvbnMvcnVucy8xNjk5MjI4OTg1CihmYWlsZWQgYmVjYXVzZSBteSBsb2NhbCByZXBv
IGRvZXMgbm90IGhhdmUgcmlnaHRzKQoKS2luZCByZWdhcmRzLApQZXRyCgotLSAKTWFpbGluZyBs
aXN0IGluZm86IGh0dHBzOi8vbGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
