Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1354C001DB
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 14:48:30 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 32F093CD5FE
	for <ltp@archiver.kernel.org>; Mon, 14 Aug 2023 16:48:29 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 517433CBBE8
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 16:48:09 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 6169C6007AC
 for <ltp@lists.linux.it>; Mon, 14 Aug 2023 16:48:08 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 835D01F8B8;
 Mon, 14 Aug 2023 14:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1692024488; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMlSeJVekKFmQDckElmI9xTi99kohKqaDcHx9fklr5w=;
 b=dk3e+H+0yTW6ktiBbajzOIDRY1EeolmxgrkHD3d8Xgciom59oEX8vAGGXLv54sMbvA+PGm
 dVGytI/xbYvhxMAhMeBpAPy4yt0DjFgwgVWH3nAXyPSGLfPZkV5NkQr2e4zO0Juo9Npuu6
 pPysqaF/lCxkF0A0U96WD9YVgFTo5kM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1692024488;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZMlSeJVekKFmQDckElmI9xTi99kohKqaDcHx9fklr5w=;
 b=WZnC8mPYsNRt2Im9u815ZqjFFjzB1iHZK1vQWcBIYqDKfcE+CSevPrVntokbU7wGy40IRc
 YgR+WfQbQQr8rKBA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6E0B2138EE;
 Mon, 14 Aug 2023 14:48:08 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id BVHcGKg+2mTABAAAMHmgww
 (envelope-from <chrubis@suse.cz>); Mon, 14 Aug 2023 14:48:08 +0000
Date: Mon, 14 Aug 2023 16:49:07 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Yang Xu <xuyang2018.jy@fujitsu.com>
Message-ID: <ZNo-4xc1oQf7aJ2k@yuki>
References: <1692012648-1970-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1692012648-1970-3-git-send-email-xuyang2018.jy@fujitsu.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1692012648-1970-3-git-send-email-xuyang2018.jy@fujitsu.com>
X-Virus-Scanned: clamav-milter 1.0.1 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v3 3/3] syscalls/setgroups03: Convert to new API
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gKyAqIDA1LzIwMDIgUG9ydGVkIGJ5IEFuZHLEgsKpIE1lcmxpZXIKICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF4KSSBzdXBwb3NlIHRoYXQgdGhpcyBpcyB0aGUgbGluZSB0aGF0IGNv
bmZ1c2VzIHlvdXIgZW1haWwgY2xpZW50IG9yIG1haWwKc2VydmVyIHNvIHRoYXQgd2UgZW5kIHVw
IHdpdGggaW52YWxpZCBlbmNvZGluZy4KCkkndmUgbWFuYWdlZCB0byBoYW5kIGVkaXQgdGhlIHBh
dGNoIHNvIHRoYXQgaXQgYXBwbGllcyBhbmQgSSd2ZSByZXBsYWNlZAp0aGUgaW52YWxpZCBzZXF1
ZW5jZSB3aXRoIGFzY2lpICdlJyBjaGFyYWN0ZXIuCgpJJ3ZlIGFsc28gZml4ZWQgdGhlIHNhZmUg
YnVmZmVycyBwYXJ0LiBUaGUgZ2xpc3QzIGlzIHN1cHBvc2VkIHRvIGJlIHNldAp0byBiYWQgYWRk
cmVzLCBpdCBkb2VzIG5vdCBtYWtlIHNlbnNlIHRvIGFsbG9jYXRlIGl0IGFzIGEgc2FmZSBidWZm
ZXIgYXQKYWxsIGFuZCB0aGVuIHJlcGxhY2UgdGhlIHZhbHVlIGluIHNldHVwLiBUaGUgZ2xpc3Qx
IGhhcyB0byBiZSBhbGxvY2F0ZWQKd2l0aCBhIHByb3BlciBzaXplIGluc3RlYWQgb2YgYWxsb2Nh
dGVkIHdpdGggU0FGRV9NQUxMT0MoKS4gQW5kIHRoZQpnbGlzdDIgY2FuIGJlIGp1c3Qgc2luZ2xl
IGVudHJ5IGp1c3QgbGlrZSBpbiB0aGUgc2Vjb25kIHRlc3QsIGJ1dCBzaG91bGQKYmUgaW5pdGlh
bGl6ZWQgcHJvcGVybHksIHRoZSBib251cyBwb2ludCBpcyB0aGF0IHdlIGdldCByaWQgb2YgdGhl
CkdJRDE2X0NIRUNLKCkgdGhhdCB3YXkgYXMgd2VsbC4KClB1c2hlZCB3aXRoIGZvbGxpbmcgZGlm
ZiwgdGhhbmtzLgoKZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0Z3Jv
dXBzL3NldGdyb3VwczAzLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldGdyb3Vwcy9z
ZXRncm91cHMwMy5jCmluZGV4IGQwMzMxYjIxNi4uZmJmOGRlMGJiIDEwMDY0NAotLS0gYS90ZXN0
Y2FzZXMva2VybmVsL3N5c2NhbGxzL3NldGdyb3Vwcy9zZXRncm91cHMwMy5jCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwvc3lzY2FsbHMvc2V0Z3JvdXBzL3NldGdyb3VwczAzLmMKQEAgLTQsNyArNCw3
IEBACiAgKiBDb3B5cmlnaHQgKGMpIEludGVybmF0aW9uYWwgQnVzaW5lc3MgTWFjaGluZXMgIENv
cnAuLCAyMDAxCiAgKiBDb3B5cmlnaHQgKGMpIExpbnV4IFRlc3QgUHJvamVjdCwgMjAwMy0yMDIz
CiAgKiAwNy8yMDAxIFBvcnRlZCBieSBXYXluZSBCb3llcgogICogMDUvMjAwMiBQb3J0ZWQgYnkg
QW5kcmUgTWVybGllcgogICovCgogLypcCkBAIC0zNiw3ICszNiw3IEBAIHN0YXRpYyBzdHJ1Y3Qg
dGNhc2UgewogICAgICAgIGludCBleHBfZXJybm87CiB9IHRjYXNlc1tdID0gewogICAgICAgIHtO
R1JPVVBTICsgMSwgJmdsaXN0MSwgRUlOVkFMfSwKLSAgICAgICB7TkdST1VQUywgJmdsaXN0Miwg
RVBFUk19LAorICAgICAgIHsxLCAmZ2xpc3QyLCBFUEVSTX0sCiAgICAgICAge05HUk9VUFMsICZn
bGlzdDMsIEVGQVVMVH0sCiB9OwoKQEAgLTU2LDMyICs1NiwyMCBAQCBzdGF0aWMgdm9pZCB2ZXJp
Znlfc2V0Z3JvdXBzKHVuc2lnbmVkIGludCBpKQoKIHN0YXRpYyB2b2lkIHNldHVwKHZvaWQpCiB7
Ci0gICAgICAgZ2xpc3QxID0gU0FGRV9NQUxMT0MoKE5HUk9VUFMgKyAxKSAqIHNpemVvZihHSURf
VCkpOwotCiAgICAgICAgdXNlcl9pbmZvID0gU0FGRV9HRVRQV05BTShURVNUVVNFUik7Ci0gICAg
ICAgR0lEMTZfQ0hFQ0sodXNlcl9pbmZvLT5wd19naWQsIGdldHB3bmFtKTsKLSAgICAgICBnbGlz
dDIgPSAoR0lEX1QgKikmKHVzZXJfaW5mby0+cHdfZ2lkKTsKLQorICAgICAgIGdsaXN0MlswXSA9
IDQyOwogICAgICAgIGdsaXN0MyA9IHRzdF9nZXRfYmFkX2FkZHIoTlVMTCk7CiB9Cgotc3RhdGlj
IHZvaWQgY2xlYW51cCh2b2lkKQotewotICAgICAgIGlmIChnbGlzdDEpCi0gICAgICAgICAgICAg
ICBmcmVlKGdsaXN0MSk7Ci19Ci0KIHN0YXRpYyBzdHJ1Y3QgdHN0X3Rlc3QgdGVzdCA9IHsKICAg
ICAgICAudGVzdCA9IHZlcmlmeV9zZXRncm91cHMsCiAgICAgICAgLnRjbnQgPSBBUlJBWV9TSVpF
KHRjYXNlcyksCiAgICAgICAgLmJ1ZnMgPSAoc3RydWN0IHRzdF9idWZmZXJzIFtdKSB7Ci0gICAg
ICAgICAgICAgICB7JmdsaXN0MSwgLnNpemUgPSBzaXplb2YoR0lEX1QpfSwKKyAgICAgICAgICAg
ICAgIHsmZ2xpc3QxLCAuc2l6ZSA9IHNpemVvZihHSURfVCkgKiAoTkdST1VQUyArIDEpfSwKICAg
ICAgICAgICAgICAgIHsmZ2xpc3QyLCAuc2l6ZSA9IHNpemVvZihHSURfVCl9LAotICAgICAgICAg
ICAgICAgeyZnbGlzdDMsIC5zaXplID0gc2l6ZW9mKEdJRF9UKX0sCiAgICAgICAgICAgICAgICB7
JnVzZXJfaW5mbywgLnNpemUgPSBzaXplb2Yoc3RydWN0IHBhc3N3ZCl9LAogICAgICAgICAgICAg
ICAge30sCiAgICAgICAgfSwKICAgICAgICAuc2V0dXAgPSBzZXR1cCwKLSAgICAgICAuY2xlYW51
cCA9IGNsZWFudXAsCiAgICAgICAgLm5lZWRzX3Jvb3QgPSAxLAogfTsKCi0tIApDeXJpbCBIcnVi
aXMKY2hydWJpc0BzdXNlLmN6CgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8vbGlzdHMu
bGludXguaXQvbGlzdGluZm8vbHRwCg==
