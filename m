Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47519C25B6B
	for <ltp@archiver.kernel.org>; Wed, 25 Oct 2023 23:51:44 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id A780B3CF4D2
	for <ltp@archiver.kernel.org>; Thu, 26 Oct 2023 01:51:42 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CA7463CC2D1
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:51:30 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id B6F891400457
 for <ltp@lists.linux.it>; Thu, 26 Oct 2023 01:51:29 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id D143D1FD61;
 Wed, 25 Oct 2023 23:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1698277888;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cgpv7RCYVb3F3vsPAi68zXxopGp3hyfwF2Bc+YO6ZGk=;
 b=MG7hmM2YQq0bfh+sJaUI2uX2NeHJgbS801rAYnnx113ZyMwOxO9jk+JrASQtromBCuHSWv
 2RFvht3u9xwBcSGfpC77UTkfI2icNA63/VgIZb1dAfU1ktm0wvsff+uBRFuVv27bXMsvRl
 damAirWunhIteLPNm4MXcZWSn2evV3E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1698277888;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Cgpv7RCYVb3F3vsPAi68zXxopGp3hyfwF2Bc+YO6ZGk=;
 b=05cVrPc/9Nl2cW9Cp8U/fcrroxJ27WubDLMPwEZXAcaGgR4mIZ9Pn6xHeaDg8rVxtZmEkF
 RaL3vp0sUIyd82Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id BA600138E9;
 Wed, 25 Oct 2023 23:51:28 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id OGdOLACqOWVXXQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Wed, 25 Oct 2023 23:51:28 +0000
Date: Thu, 26 Oct 2023 01:51:27 +0200
From: Petr Vorel <pvorel@suse.cz>
To: "Yang Xu (Fujitsu)" <xuyang2018.jy@fujitsu.com>,
 "ltp@lists.linux.it" <ltp@lists.linux.it>
Message-ID: <20231025235127.GA540370@pevik>
References: <1697021709-22916-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20231012095515.GA618148@pevik>
 <807b574c-35f6-c84d-91ef-229385e8009a@fujitsu.com>
 <20231013061217.GA688129@pevik>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20231013061217.GA688129@pevik>
X-Virus-Scanned: clamav-milter 1.0.1 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/3] link03: Convert docs to docparse
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgWHUsCgpBbHNvLCB3aGlsZSB5b3UgYXJlIGF0IGl0LCBjb3VsZCB5b3UgcGxlYXNlIGZpeCB0
aGVzZSB3YXJuaW5ncz8KCiQgbWFrZSBsaW5rMDMKCmxpbmswMy5jOiBJbiBmdW5jdGlvbiDigJht
YWlu4oCZOgpsaW5rMDMuYzoxMDQ6MjI6IHdhcm5pbmc6IOKAmCVk4oCZIGRpcmVjdGl2ZSB3cml0
aW5nIGJldHdlZW4gMSBhbmQgMTAgYnl0ZXMgaW50byBhIHJlZ2lvbiBvZiBzaXplIGJldHdlZW4g
MSBhbmQgMjU1IFstV2Zvcm1hdC1vdmVyZmxvdz1dCiAgMTA0IHwgICAgc3ByaW50ZihsbmFtZSwg
IiVzJWQiLCBmbmFtZSwgaSk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgICAgXn4KbGluazAz
LmM6MTA0OjE5OiBub3RlOiBkaXJlY3RpdmUgYXJndW1lbnQgaW4gdGhlIHJhbmdlIFsxLCAyMTQ3
NDgzNjQ2XQogIDEwNCB8ICAgIHNwcmludGYobG5hbWUsICIlcyVkIiwgZm5hbWUsIGkpOwogICAg
ICB8ICAgICAgICAgICAgICAgICAgIF5+fn5+fgpsaW5rMDMuYzoxMDQ6NDogbm90ZTog4oCYc3By
aW50ZuKAmSBvdXRwdXQgYmV0d2VlbiAyIGFuZCAyNjUgYnl0ZXMgaW50byBhIGRlc3RpbmF0aW9u
IG9mIHNpemUgMjU1CiAgMTA0IHwgICAgc3ByaW50ZihsbmFtZSwgIiVzJWQiLCBmbmFtZSwgaSk7
CiAgICAgIHwgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn4KbGluazAzLmM6MTIz
OjIyOiB3YXJuaW5nOiDigJglZOKAmSBkaXJlY3RpdmUgd3JpdGluZyBiZXR3ZWVuIDEgYW5kIDEw
IGJ5dGVzIGludG8gYSByZWdpb24gb2Ygc2l6ZSBiZXR3ZWVuIDEgYW5kIDI1NSBbLVdmb3JtYXQt
b3ZlcmZsb3c9XQogIDEyMyB8ICAgIHNwcmludGYobG5hbWUsICIlcyVkIiwgZm5hbWUsIGkpOwog
ICAgICB8ICAgICAgICAgICAgICAgICAgICAgIF5+CmxpbmswMy5jOjEyMzoxOTogbm90ZTogZGly
ZWN0aXZlIGFyZ3VtZW50IGluIHRoZSByYW5nZSBbMSwgMjE0NzQ4MzY0Nl0KICAxMjMgfCAgICBz
cHJpbnRmKGxuYW1lLCAiJXMlZCIsIGZuYW1lLCBpKTsKICAgICAgfCAgICAgICAgICAgICAgICAg
ICBefn5+fn4KbGluazAzLmM6MTIzOjQ6IG5vdGU6IOKAmHNwcmludGbigJkgb3V0cHV0IGJldHdl
ZW4gMiBhbmQgMjY1IGJ5dGVzIGludG8gYSBkZXN0aW5hdGlvbiBvZiBzaXplIDI1NQogIDEyMyB8
ICAgIHNwcmludGYobG5hbWUsICIlcyVkIiwgZm5hbWUsIGkpOwogICAgICB8ICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+CmxpbmswMy5jOjEzODoyMjogd2FybmluZzog4oCYJWTi
gJkgZGlyZWN0aXZlIHdyaXRpbmcgYmV0d2VlbiAxIGFuZCAxMCBieXRlcyBpbnRvIGEgcmVnaW9u
IG9mIHNpemUgYmV0d2VlbiAxIGFuZCAyNTUgWy1XZm9ybWF0LW92ZXJmbG93PV0KICAxMzggfCAg
ICBzcHJpbnRmKGxuYW1lLCAiJXMlZCIsIGZuYW1lLCBpKTsKICAgICAgfCAgICAgICAgICAgICAg
ICAgICAgICBefgpsaW5rMDMuYzoxMzg6MTk6IG5vdGU6IGRpcmVjdGl2ZSBhcmd1bWVudCBpbiB0
aGUgcmFuZ2UgWzEsIDIxNDc0ODM2NDZdCiAgMTM4IHwgICAgc3ByaW50ZihsbmFtZSwgIiVzJWQi
LCBmbmFtZSwgaSk7CiAgICAgIHwgICAgICAgICAgICAgICAgICAgXn5+fn5+CmxpbmswMy5jOjEz
ODo0OiBub3RlOiDigJhzcHJpbnRm4oCZIG91dHB1dCBiZXR3ZWVuIDIgYW5kIDI2NSBieXRlcyBp
bnRvIGEgZGVzdGluYXRpb24gb2Ygc2l6ZSAyNTUKICAxMzggfCAgICBzcHJpbnRmKGxuYW1lLCAi
JXMlZCIsIGZuYW1lLCBpKTsKCiQgbWFrZSBjaGVjay1saW5rMDMKQ0hFQ0sgdGVzdGNhc2VzL2tl
cm5lbC9zeXNjYWxscy9saW5rL2xpbmswMy5jCmxpbmswMy5jOjE6IFdBUk5JTkc6IE1pc3Npbmcg
b3IgbWFsZm9ybWVkIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyIHRhZyBpbiBsaW5lIDEKbGluazAz
LmM6MzM6IEVSUk9SOiBkbyBub3QgaW5pdGlhbGlzZSBzdGF0aWNzIHRvIDAKbGluazAzLmM6NTU6
IEVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgdXNlIHRhYnMgd2hlcmUgcG9zc2libGUKbGluazAz
LmM6OTA6IEVSUk9SOiBjb2RlIGluZGVudCBzaG91bGQgdXNlIHRhYnMgd2hlcmUgcG9zc2libGUK
bGluazAzLmM6MTAwOiBFUlJPUjogY29kZSBpbmRlbnQgc2hvdWxkIHVzZSB0YWJzIHdoZXJlIHBv
c3NpYmxlCgpUaGFua3MhCgpLaW5kIHJlZ2FyZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5m
bzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
