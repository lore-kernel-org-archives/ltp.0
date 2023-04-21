Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BFE8C7618E
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 14:58:27 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 0FD363CBF31
	for <ltp@archiver.kernel.org>; Fri, 21 Apr 2023 16:58:23 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 05B843CBEE8
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:48 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id E98291A00A5D
 for <ltp@lists.linux.it>; Fri, 21 Apr 2023 16:57:47 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 3B4071FDE3;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1682089067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bh6rktt2WzwJDLdTt4WRuueEeoKUBdhUqhEoHEiie9w=;
 b=F5ZQ87XKLzVWsgLfpfjSRy5HR5iFyaskny9S7UNbt/L4uOXG9K+it/jUBJawfrSTVH0Ch7
 TgOqkMuDZSlBN+m11K/kzftKPv9qYNPRp9aCZqNevUBQ0/qx0qUbLZ3sKRNPOqEVkd5wOE
 MJPCK5ztG+MhwxYPYuo55oJdbd+ehkA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1682089067;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bh6rktt2WzwJDLdTt4WRuueEeoKUBdhUqhEoHEiie9w=;
 b=3keADtSRDgXuyxqe5nPEzAm1Hn0axo8h61m1PqfPj25rPy2lbcrV9xVXl3VJ8VKtHCT58C
 UEtty8LgtsINl8DQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 268A31391A;
 Fri, 21 Apr 2023 14:57:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id kPCeCGukQmRfDAAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Fri, 21 Apr 2023 14:57:47 +0000
From: Martin Doucha <mdoucha@suse.cz>
To: nstange@suse.de,
	ltp@lists.linux.it
Date: Fri, 21 Apr 2023 16:57:43 +0200
Message-Id: <20230421145746.5704-2-mdoucha@suse.cz>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230421145746.5704-1-mdoucha@suse.cz>
References: <20230421145746.5704-1-mdoucha@suse.cz>
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 2/5] KVM: Add helper function for reading x86 segment
 registers
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

U2lnbmVkLW9mZi1ieTogTWFydGluIERvdWNoYSA8bWRvdWNoYUBzdXNlLmN6PgotLS0KIGRvYy9r
dm0tdGVzdC1hcGkudHh0ICAgICAgICAgICAgICAgICAgICB8ICA3ICsrKysrKysKIHRlc3RjYXNl
cy9rZXJuZWwva3ZtL2Jvb3RzdHJhcF94ODYuUyAgICB8IDE5ICsrKysrKysrKysrKysrKysrKysK
IHRlc3RjYXNlcy9rZXJuZWwva3ZtL2Jvb3RzdHJhcF94ODZfNjQuUyB8IDE2ICsrKysrKysrKysr
KysrKysKIHRlc3RjYXNlcy9rZXJuZWwva3ZtL2luY2x1ZGUva3ZtX3g4Ni5oICB8ICA1ICsrKysr
CiA0IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS9kb2Mva3Zt
LXRlc3QtYXBpLnR4dCBiL2RvYy9rdm0tdGVzdC1hcGkudHh0CmluZGV4IGY2MjgxOTc2NC4uMGFl
ZGU1ZWVhIDEwMDY0NAotLS0gYS9kb2Mva3ZtLXRlc3QtYXBpLnR4dAorKysgYi9kb2Mva3ZtLXRl
c3QtYXBpLnR4dApAQCAtMzI5LDYgKzMyOSwxMCBAQCBzdHJ1Y3Qga3ZtX2NwdWlkIHsKIHN0cnVj
dCBrdm1fY3JlZ3MgewogCXVuc2lnbmVkIGxvbmcgY3IwLCBjcjIsIGNyMywgY3I0OwogfTsKKwor
c3RydWN0IGt2bV9zcmVncyB7CisJdWludDE2X3QgY3MsIGRzLCBlcywgZnMsIGdzLCBzczsKK307
CiAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAKIGBzdHJ1Y3QgcGFnZV90YWJsZV9lbnRyeV9wYWVg
IGlzIHRoZSBwYWdlIHRhYmxlIGVudHJ5IHN0cnVjdHVyZSBmb3IgUEFFIGFuZApAQCAtMzcwLDYg
KzM3NCw5IEBAIERldmVsb3BlcidzIE1hbnVhbCwgVm9sdW1lIDMsIENoYXB0ZXIgNCBmb3IgZXhw
bGFuYXRpb24gb2YgdGhlIGZpZWxkcy4KIC0gYHZvaWQga3ZtX3JlYWRfY3JlZ3Moc3RydWN0IGt2
bV9jcmVncyAqYnVmKWAg4oCTIENvcGllcyB0aGUgY3VycmVudCB2YWx1ZXMKICAgb2YgY29udHJv
bCByZWdpc3RlcnMgdG8gYGJ1ZmAuCiAKKy0gYHZvaWQga3ZtX3JlYWRfc3JlZ3Moc3RydWN0IGt2
bV9zcmVncyAqYnVmKWAgLSBDb3BpZXMgdGhlIGN1cnJlbnQgdmFsdWVzCisgIG9mIHNlZ21lbnQg
cmVnaXN0ZXJzIHRvIGBidWZgLgorCiAtIGB1aW50NjRfdCBrdm1fcmRtc3IodW5zaWduZWQgaW50
IG1zcilgIOKAkyBSZXR1cm5zIHRoZSBjdXJyZW50IHZhbHVlCiAgIG9mIG1vZGVsLXNwZWNpZmlj
IHJlZ2lzdGVyIGBtc3JgLgogCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2t2bS9ib290
c3RyYXBfeDg2LlMgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9ib290c3RyYXBfeDg2LlMKaW5kZXgg
M2MxN2EyYjQ3Li44OWY3M2ViYTEgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2Jv
b3RzdHJhcF94ODYuUworKysgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9ib290c3RyYXBfeDg2LlMK
QEAgLTE5Nyw2ICsxOTcsMjUgQEAga3ZtX3JlYWRfY3JlZ3M6CiAJcG9wICVlZGkKIAlyZXQKIAor
Lmdsb2JhbCBrdm1fcmVhZF9zcmVncwora3ZtX3JlYWRfc3JlZ3M6CisJcHVzaCAlZWRpCisJbW92
IDgoJWVzcCksICVlZGkKKwltb3YgJWNzLCAlYXgKKwltb3Z3ICVheCwgKCVlZGkpCisJbW92ICVk
cywgJWF4CisJbW92dyAlYXgsIDIoJWVkaSkKKwltb3YgJWVzLCAlYXgKKwltb3Z3ICVheCwgNCgl
ZWRpKQorCW1vdiAlZnMsICVheAorCW1vdncgJWF4LCA2KCVlZGkpCisJbW92ICVncywgJWF4CisJ
bW92dyAlYXgsIDgoJWVkaSkKKwltb3YgJXNzLCAlYXgKKwltb3Z3ICVheCwgMTAoJWVkaSkKKwlw
b3AgJWVkaQorCXJldAorCiBoYW5kbGVfaW50ZXJydXB0OgogCS8qIHNhdmUgQ1BVIHN0YXRlICov
CiAJcHVzaCAlZWJwCmRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVsL2t2bS9ib290c3RyYXBf
eDg2XzY0LlMgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9ib290c3RyYXBfeDg2XzY0LlMKaW5kZXgg
M2Q4YzQ5YjEwLi5lNGQxNjBiMmUgMTAwNjQ0Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2Jv
b3RzdHJhcF94ODZfNjQuUworKysgYi90ZXN0Y2FzZXMva2VybmVsL2t2bS9ib290c3RyYXBfeDg2
XzY0LlMKQEAgLTMwMyw2ICszMDMsMjIgQEAga3ZtX3JlYWRfY3JlZ3M6CiAJbW92ICVyYXgsIDI0
KCVyZGkpCiAJcmV0cQogCisuZ2xvYmFsIGt2bV9yZWFkX3NyZWdzCitrdm1fcmVhZF9zcmVnczoK
Kwltb3YgJWNzLCAlYXgKKwltb3Z3ICVheCwgKCVyZGkpCisJbW92ICVkcywgJWF4CisJbW92dyAl
YXgsIDIoJXJkaSkKKwltb3YgJWVzLCAlYXgKKwltb3Z3ICVheCwgNCglcmRpKQorCW1vdiAlZnMs
ICVheAorCW1vdncgJWF4LCA2KCVyZGkpCisJbW92ICVncywgJWF4CisJbW92dyAlYXgsIDgoJXJk
aSkKKwltb3YgJXNzLCAlYXgKKwltb3Z3ICVheCwgMTAoJXJkaSkKKwlyZXRxCisKIGhhbmRsZV9p
bnRlcnJ1cHQ6CiAJLyogcHVzaCBDUFUgc3RhdGUgKi8KIAlwdXNoICVyYnAKZGlmZiAtLWdpdCBh
L3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2luY2x1ZGUva3ZtX3g4Ni5oIGIvdGVzdGNhc2VzL2tlcm5l
bC9rdm0vaW5jbHVkZS9rdm1feDg2LmgKaW5kZXggYTY1NWM5ODM0Li5hOTRmMDU0NTEgMTAwNjQ0
Ci0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwva3ZtL2luY2x1ZGUva3ZtX3g4Ni5oCisrKyBiL3Rlc3Rj
YXNlcy9rZXJuZWwva3ZtL2luY2x1ZGUva3ZtX3g4Ni5oCkBAIC0xNTgsNiArMTU4LDEwIEBAIHN0
cnVjdCBrdm1fY3JlZ3MgewogCXVuc2lnbmVkIGxvbmcgY3IwLCBjcjIsIGNyMywgY3I0OwogfTsK
IAorc3RydWN0IGt2bV9zcmVncyB7CisJdWludDE2X3QgY3MsIGRzLCBlcywgZnMsIGdzLCBzczsK
K307CisKIGV4dGVybiBzdHJ1Y3QgcGFnZV90YWJsZV9lbnRyeV9wYWUga3ZtX3BhZ2V0YWJsZVtd
OwogZXh0ZXJuIHN0cnVjdCBpbnRyX2Rlc2NyaXB0b3Iga3ZtX2lkdFtYODZfSU5UUl9DT1VOVF07
CiBleHRlcm4gc3RydWN0IHNlZ21lbnRfZGVzY3JpcHRvciBrdm1fZ2R0W0tWTV9HRFRfU0laRV07
CkBAIC0xNzgsNiArMTgyLDcgQEAgdW5zaWduZWQgaW50IGt2bV9jcmVhdGVfc3RhY2tfZGVzY3Jp
cHRvcihzdHJ1Y3Qgc2VnbWVudF9kZXNjcmlwdG9yICp0YWJsZSwKIC8qIEZ1bmN0aW9ucyBmb3Ig
cXVlcnlpbmcgQ1BVIGluZm8gYW5kIHN0YXR1cyAqLwogdm9pZCBrdm1fZ2V0X2NwdWlkKHVuc2ln
bmVkIGludCBlYXgsIHVuc2lnbmVkIGludCBlY3gsIHN0cnVjdCBrdm1fY3B1aWQgKmJ1Zik7CiB2
b2lkIGt2bV9yZWFkX2NyZWdzKHN0cnVjdCBrdm1fY3JlZ3MgKmJ1Zik7Cit2b2lkIGt2bV9yZWFk
X3NyZWdzKHN0cnVjdCBrdm1fc3JlZ3MgKmJ1Zik7CiB1aW50NjRfdCBrdm1fcmRtc3IodW5zaWdu
ZWQgaW50IG1zcik7CiB2b2lkIGt2bV93cm1zcih1bnNpZ25lZCBpbnQgbXNyLCB1aW50NjRfdCB2
YWx1ZSk7CiAKLS0gCjIuNDAuMAoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
