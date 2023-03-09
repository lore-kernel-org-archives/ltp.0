Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9786FC64EC4
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 21:02:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 86A503CD8EE
	for <ltp@archiver.kernel.org>; Thu,  9 Mar 2023 22:02:17 +0100 (CET)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id A5FF93CB867
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 22:02:07 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id D2750200DB6
 for <ltp@lists.linux.it>; Thu,  9 Mar 2023 22:02:06 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 59BD22243B;
 Thu,  9 Mar 2023 21:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678395724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+AUydx3P1jFvhuxGb8BgV8jTHGtXLW0VLU+tPQOQeg=;
 b=ICsqRHJH46i5MPC90aPnQCYunQxzi1hLCSowSepyMGGRS2+TfTwvfuF66GbQNyaDm26Fmf
 4ZjCHqGbHpMlRIbb7L4sCP34DcSx2lHU63S80omY4WEMVUI6j0vnZ4i/bL5Yjpn1ezZQ3J
 stu6ACS/wA+fHoKUjebdoqGmfEgYO9s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678395724;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=N+AUydx3P1jFvhuxGb8BgV8jTHGtXLW0VLU+tPQOQeg=;
 b=TldxEtRk5C/w8N0DmzjinPdqSJfh1OPJ9jc6IA2PB6cgbxvhu5KD7ddzxA5w+XdkAiab1w
 w4vy7Gfz3olMCtDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 242931391B;
 Thu,  9 Mar 2023 21:02:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id fDSGBUxJCmSLfQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Thu, 09 Mar 2023 21:02:04 +0000
Date: Thu, 9 Mar 2023 22:02:01 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Jan Stancek <jstancek@redhat.com>
Message-ID: <20230309210201.GA451333@pevik>
References: <20230309103346.5574-1-pvorel@suse.cz>
 <20230309104418.GA6311@pevik>
 <CAASaF6xDJskSnQRpocnz8TWXGbdvmxxRkS5ZJC1em4d_0ckP6w@mail.gmail.com>
 <CAASaF6y+GqhXUc4-EZHx89nRWcxV2_hRfAzdsMhbjVM4=A_qDw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAASaF6y+GqhXUc4-EZHx89nRWcxV2_hRfAzdsMhbjVM4=A_qDw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH 1/1] endian_switch01.c: Remove useless
 TST_NO_DEFAULT_MAIN
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

PiBPbiBUaHUsIE1hciA5LCAyMDIzIGF0IDEyOjE34oCvUE0gSmFuIFN0YW5jZWsgPGpzdGFuY2Vr
QHJlZGhhdC5jb20+IHdyb3RlOgoKPiA+IE9uIFRodSwgTWFyIDksIDIwMjMgYXQgMTE6NDTigK9B
TSBQZXRyIFZvcmVsIDxwdm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gPiBIaSBKYW4sCgo+ID4g
PiBvdXQgb2YgY3VyaW9zaXR5LCB3aGF0IGlzIG1haW40KCkgdXNlZCBmb3I/Cgo+ID4gSXQncyBm
cm9tIDA4NmMxNGY3YTQ2NSAoIlRoZSBmb2xsb3dpbmcgaGFjayBmaXhlcyB0aGUKPiA+ICJlbmRp
YW5fc3dpdGNoMDEuYzoxMTU6IHdhcm5pbmc6IOKAmG1haW7igJkgdGFrZXMgb25seSB6ZXJvIG9y
IHR3bwo+ID4gYXJndW1lbnRzIiB3YXJuaW5nLiBTaWduZWQtb2ZmLWJ5OiBDQUkgUWlhbiA8Y2Fp
cWlhbkBjY2xvbS5jbj4uIikKPiA+IGJ1dCBJJ20gbm90IHN1cmUgaXQgaXMgc3RpbGwgdXNlZCB0
aGVzZSBkYXlzLgorMQoKPiA+IEFzIHlvdSBmb3VuZCBteSBtaXNwbGFjZWQgVFNUX05PX0RFRkFV
TFRfTUFJTiwgdGhhdCBzZWVtcyB0byBjb25maXJtCj4gPiB3ZSBjYW4gZG8gd2l0aG91dCBpdC4g
SSdsbCBoYXZlIGEgbG9vayBvbiBhIHBwYyBzeXN0ZW0uCgo+IFNvIEkgYWdyZWUgd2l0aCB5b3Vy
IHBhdGNoIGhlcmUuIEFuZCB0aGVuIEknZCBzdWdnZXN0IHdlIGZvbGxvdyBpdApUaGFuayB5b3Us
IEkgbWVyZ2VkIHRoaXMgcGF0Y2guCgoKPiB3aXRoIG9uZSB0aGF0IHJlcGxhY2VzIG1haW40IHdp
dGgKCj4gQEAgLTQyLDYgKzQyLDkgQEAgdm9pZCBjaGVja19sZV9zd2l0Y2hfc3VwcG9ydGVkKHZv
aWQpCj4gICAgICAgICAgICAgICAgIGV4aXQoZXJybm8pOwo+ICAgICAgICAgfQoKPiArICAgICAg
IGlmICghKGdldGF1eHZhbChBVF9IV0NBUCkgJiBQUENfRkVBVFVSRV9UUlVFX0xFKSkKPiArICAg
ICAgICAgICAgICAgdHN0X2JyayhUQ09ORiwgIlByb2Nlc3NvciBkb2VzIG5vdCBzdXBwb3J0IGxp
dHRsZS1lbmRpYW4gbW9kZSIpOwo+ICsKCj4gV2hhdCBkbyB5b3UgdGhpbms/CgpJbmRlZWQsIHRo
YXQncyBsb29rcyB0byBtZSBiZXR0ZXIuIFlvdSBjYW4gYWRkIG15IGFjayB0byB0aGUgcGF0Y2gu
CkJ1dCBwbGVhc2UgdGVzdCBpdC4KCktpbmQgcmVnYXJkcywKUGV0cgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
