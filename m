Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CB52C3DA4A
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 09:59:18 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id ED3223D22E1
	for <ltp@archiver.kernel.org>; Thu, 22 Aug 2024 11:59:16 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it [217.194.8.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 447FF3CD809
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 11:59:01 +0200 (CEST)
Authentication-Results: in-7.smtp.seeweb.it;
 spf=pass (sender SPF authorized) smtp.mailfrom=suse.cz
 (client-ip=195.135.223.131; helo=smtp-out2.suse.de;
 envelope-from=chrubis@suse.cz; receiver=lists.linux.it)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 677C2201100
 for <ltp@lists.linux.it>; Thu, 22 Aug 2024 11:58:59 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 1DC001FB8A;
 Thu, 22 Aug 2024 09:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724320739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riUrnHQkvsSFC5buUTSzE0p3p/3G4YXRAl7ySWRgGvw=;
 b=LyrLfE7JnNcvmQyuB1p5hGzpqfh3hazjc3dO/yXIaU1yEj+oIVbSjrjfUHXBt41XBhg+j6
 I49brJJO1fJOIcDG24VBx7gGHTaMgudHBbRaT0b8fLVUzvp73kSm1hANOmUfyGViwkwhrq
 n6jBfQFO+rcc+s8sC49H4XThbkU5deY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724320739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riUrnHQkvsSFC5buUTSzE0p3p/3G4YXRAl7ySWRgGvw=;
 b=bzN7TA+DaD/y7u+GrLcCrZjzVIrzGJi8Oczk5ZYkGJ59sITalsc4z6gXlLkIt/8QEDR15x
 PgSeMnFtw5NDDWCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=LyrLfE7J;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=bzN7TA+D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1724320739; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riUrnHQkvsSFC5buUTSzE0p3p/3G4YXRAl7ySWRgGvw=;
 b=LyrLfE7JnNcvmQyuB1p5hGzpqfh3hazjc3dO/yXIaU1yEj+oIVbSjrjfUHXBt41XBhg+j6
 I49brJJO1fJOIcDG24VBx7gGHTaMgudHBbRaT0b8fLVUzvp73kSm1hANOmUfyGViwkwhrq
 n6jBfQFO+rcc+s8sC49H4XThbkU5deY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1724320739;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=riUrnHQkvsSFC5buUTSzE0p3p/3G4YXRAl7ySWRgGvw=;
 b=bzN7TA+DaD/y7u+GrLcCrZjzVIrzGJi8Oczk5ZYkGJ59sITalsc4z6gXlLkIt/8QEDR15x
 PgSeMnFtw5NDDWCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E3E3113297;
 Thu, 22 Aug 2024 09:58:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id A/g0N+ILx2ZNCQAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Thu, 22 Aug 2024 09:58:58 +0000
Date: Thu, 22 Aug 2024 11:57:52 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Geetika <geetika@linux.ibm.com>
Message-ID: <ZscLoGfAQc_XhhAj@yuki.lan>
References: <20240421102420.97060-1-geetika@linux.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20240421102420.97060-1-geetika@linux.ibm.com>
X-Rspamd-Queue-Id: 1DC001FB8A
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; FUZZY_BLOCKED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_TWO(0.00)[2];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.3 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] Add hugeshmmisc01,
 migrated shm-getraw.c from libhugetlbfs
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

SGkhCj4gIHJ1bnRlc3QvaHVnZXRsYiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAg
MiArCj4gIHRlc3RjYXNlcy9rZXJuZWwvbWVtLy5naXRpZ25vcmUgICAgICAgICAgICAgICB8ICAg
MSArCj4gIC4uLi9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvTWFrZWZpbGUgICB8ICAg
OSArKwo+ICAuLi4vbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1pc2MwMS5jICAgfCAx
MzQgKysrKysrKysrKysrKysrKysrCj4gIDQgZmlsZXMgY2hhbmdlZCwgMTQ2IGluc2VydGlvbnMo
KykKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVn
ZXNobW1pc2MvTWFrZWZpbGUKPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IHRlc3RjYXNlcy9rZXJuZWwv
bWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1pc2MwMS5jCj4gCj4gZGlmZiAtLWdpdCBh
L3J1bnRlc3QvaHVnZXRsYiBiL3J1bnRlc3QvaHVnZXRsYgo+IGluZGV4IDI5OWMwN2FjOS4uZWEx
OGY2ZWY2IDEwMDY0NAo+IC0tLSBhL3J1bnRlc3QvaHVnZXRsYgo+ICsrKyBiL3J1bnRlc3QvaHVn
ZXRsYgo+IEBAIC01NSwzICs1NSw1IEBAIGh1Z2VzaG1nZXQwMSBodWdlc2htZ2V0MDEgLWkgMTAK
PiAgaHVnZXNobWdldDAyIGh1Z2VzaG1nZXQwMiAtaSAxMAo+ICBodWdlc2htZ2V0MDMgaHVnZXNo
bWdldDAzIC1pIDEwCj4gIGh1Z2VzaG1nZXQwNSBodWdlc2htZ2V0MDUgLWkgMTAKPiArCj4gK2h1
Z2VzaG1taXNjMDEgaHVnZXNobW1pc2MwMQo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMva2VybmVs
L21lbS8uZ2l0aWdub3JlIGIvdGVzdGNhc2VzL2tlcm5lbC9tZW0vLmdpdGlnbm9yZQo+IGluZGV4
IGM5NmZlOGJmYy4uNDkzNjc5YWU2IDEwMDY0NAo+IC0tLSBhL3Rlc3RjYXNlcy9rZXJuZWwvbWVt
Ly5naXRpZ25vcmUKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS8uZ2l0aWdub3JlCj4gQEAg
LTQ3LDYgKzQ3LDcgQEAKPiAgL2h1Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDIKPiAgL2h1
Z2V0bGIvaHVnZXNobWdldC9odWdlc2htZ2V0MDMKPiAgL2h1Z2V0bGIvaHVnZXNobWdldC9odWdl
c2htZ2V0MDUKPiArL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1pc2MwMQo+ICAva3NtL2tz
bTAxCj4gIC9rc20va3NtMDIKPiAgL2tzbS9rc20wMwo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMv
a2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1taXNjL01ha2VmaWxlIGIvdGVzdGNhc2VzL2tlcm5l
bC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9NYWtlZmlsZQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0
Cj4gaW5kZXggMDAwMDAwMDAwLi44NDcxNWM3YjUKPiAtLS0gL2Rldi9udWxsCj4gKysrIGIvdGVz
dGNhc2VzL2tlcm5lbC9tZW0vaHVnZXRsYi9odWdlc2htbWlzYy9NYWtlZmlsZQo+IEBAIC0wLDAg
KzEsOSBAQAo+ICsjIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCj4g
KyMgQ29weXJpZ2h0IChDKSAyMDA5LCBDaXNjbyBTeXN0ZW1zIEluYy4KPiArIyBOZ2llIENvb3Bl
ciwgSnVseSAyMDA5Cj4gKwo+ICt0b3Bfc3JjZGlyICAgICAgICAgICAgICA/PSAuLi8uLi8uLi8u
Li8uLgo+ICsKPiAraW5jbHVkZSAkKHRvcF9zcmNkaXIpL2luY2x1ZGUvbWsvdGVzdGNhc2VzLm1r
Cj4gK2luY2x1ZGUgJChhYnNfc3JjZGlyKS8uLi9NYWtlZmlsZS5pbmMKPiAraW5jbHVkZSAkKHRv
cF9zcmNkaXIpL2luY2x1ZGUvbWsvZ2VuZXJpY19sZWFmX3RhcmdldC5tawo+IGRpZmYgLS1naXQg
YS90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2VzaG1taXNjL2h1Z2VzaG1taXNjMDEu
YyBiL3Rlc3RjYXNlcy9rZXJuZWwvbWVtL2h1Z2V0bGIvaHVnZXNobW1pc2MvaHVnZXNobW1pc2Mw
MS5jCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQKPiBpbmRleCAwMDAwMDAwMDAuLjE1ODY3ZjI1MQo+
IC0tLSAvZGV2L251bGwKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL21lbS9odWdldGxiL2h1Z2Vz
aG1taXNjL2h1Z2VzaG1taXNjMDEuYwo+IEBAIC0wLDAgKzEsMTM0IEBACj4gKy8vIFNQRFgtTGlj
ZW5zZS1JZGVudGlmaWVyOiBMR1BMLTIuMS1vci1sYXRlcgo+ICsvKgo+ICsgKiBDb3B5cmlnaHQg
KEMpIDIwMDUtMjAwNiBEYXZpZCBHaWJzb24gJiBBZGFtIExpdGtlLCBJQk0gQ29ycG9yYXRpb24u
Cj4gKyAqLwo+ICsKPiArLypcCj4gKyAqW0Rlc2NyaXBpdG9uXQo+ICsgKgo+ICsgKiBPcmlnaW46
IGh0dHBzOi8vZ2l0aHViLmNvbS9saWJodWdldGxiZnMvbGliaHVnZXRsYmZzL2Jsb2IvbWFzdGVy
L3Rlc3RzL3NobS1nZXRyYXcuYwo+ICsgKgo+ICsgKiBUaGUgdGVzdCBjcmVhdGVzIGEgc2hhcmVk
IG1lbW9yeSBzZWdtZW50LCB0aGVuIGF0dGFjaGVzIGl0IHRvIHRoZSBwcm9jZXNz4oCZcyBhZGRy
ZXNzIHNwYWNlLgo+ICsgKiBJdCB3cml0ZXMgYSBzdHJpbmcgdG8gdGhlIHNoYXJlZCBtZW1vcnkg
ZnJvbSByYXcgZGV2aWNlIGFuZCBkZXRhY2hlcyB0aGUgc2hhcmVkIG1lbW9yeQo+ICsgKiBzZWdt
ZW50IGFuZCBmaW5hbGx5IHJlbW92ZXMgaXQuCj4gKyAqIFRoZSBwdXJwb3NlIG9mIHRoaXMgdGVz
dCBpcyB0byBlbnN1cmUgdGhhdCB0aGUgc2hhcmVkIG1lbW9yeSBzdWJzeXN0ZW0gaXMgd29ya2lu
ZyBjb3JyZWN0bHkKPiArICogd2l0aCBodWdlcGFnZXMuIEl0IGNoZWNrcyB0aGF0IHNoYXJlZCBt
ZW1vcnkgc2VnbWVudHMgY2FuIGJlIGNyZWF0ZWQsIGF0dGFjaGVkLCB3cml0dGVuIHRvLAo+ICsg
KiByZWFkIGZyb20sIGRldGFjaGVkLCBhbmQgcmVtb3ZlZCB3aXRob3V0IGVycm9ycwo+ICsgKgo+
ICsgKi8KPiArCj4gKyNpbmNsdWRlIDxzdGRpby5oPgo+ICsjaW5jbHVkZSA8c3RkbGliLmg+Cj4g
KyNpbmNsdWRlIDxzdHJpbmcuaD4KPiArI2luY2x1ZGUgPHVuaXN0ZC5oPgo+ICsjaW5jbHVkZSA8
c3lzL21tYW4uaD4KPiArI2luY2x1ZGUgPGVycm5vLmg+Cj4gKyNpbmNsdWRlIDxhc3NlcnQuaD4K
PiArI2luY2x1ZGUgPHN5cy90eXBlcy5oPgo+ICsjaW5jbHVkZSA8c3lzL3NobS5oPgo+ICsjaW5j
bHVkZSA8c3lzL3R5cGVzLmg+Cj4gKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgo+ICsjaW5jbHVkZSA8
dW5pc3RkLmg+Cj4gKyNpbmNsdWRlIDxmY250bC5oPgo+ICsKPiArI2luY2x1ZGUgImh1Z2V0bGIu
aCIKPiArI2luY2x1ZGUgInRzdF9zYWZlX3N5c3ZfaXBjLmgiCj4gKwo+ICsjZGVmaW5lIE1OVFBP
SU5UICJodWdldGxiZnMvIgo+ICsjZGVmaW5lIFNBRkVfRlJFRShwKSB7IGlmIChwKSB7IGZyZWUo
cCk7IChwKSA9IE5VTEw7IH0gfQoKUGxlYXNlIGRvIG5vdCBkbyB0aGlzLgoKPiArI2RlZmluZSBO
Ul9IVUdFUEFHRVMgMgo+ICsKPiArc3RhdGljIGludCBzaG1pZCA9IC0xOwo+ICtzdGF0aWMgc2l6
ZV90IHNpemU7Cj4gK3N0YXRpYyBzaXplX3QgaTsKPiArc3RhdGljIHNpemVfdCByZXQ7Cj4gKwo+
ICtzdGF0aWMgdm9sYXRpbGUgY2hhciAqc2htYWRkcjsKPiArc3RhdGljIGNoYXIgKmJ1ZmZlcjsK
PiArc3RhdGljIGludCByYXdfZmQ7Cj4gK3N0YXRpYyBsb25nIGhwYWdlX3NpemU7Cj4gK3N0YXRp
YyBpbnQgZmQ7Cj4gKwo+ICtzdGF0aWMgdm9pZCBzZXR1cCh2b2lkKQo+ICt7Cj4gKwlocGFnZV9z
aXplID0gdHN0X2dldF9odWdlcGFnZV9zaXplKCk7Cj4gKwlmZCA9IHRzdF9jcmVhdF91bmxpbmtl
ZChNTlRQT0lOVCwgMCk7CgpXZSBkbyBub3QgdXNlIHRoaXMgZmQgZm9yIGFueXRoaW5nIGluIHRo
ZSB0ZXN0IHNpbmNlIHdlIGFyZSBnZXR0aW5nCmh1Z2VwYWdlcyBmcm9tIFNITSBpbnN0ZWFkLiBU
aGVyZSBpcyBubyBwb2ludCBpbiBtb3VudGluZyB0aGUgaHVnZXRsYmZzCmVpdGhlci4KCj4gK30K
PiArCj4gK3N0YXRpYyB2b2lkIGNsZWFudXAodm9pZCkKPiArewo+ICsJaWYgKHNobWlkID49IDAp
Cj4gKwkJU0FGRV9TSE1DVEwoc2htaWQsIElQQ19STUlELCBOVUxMKTsKPiArCWlmIChmZCA+IDAp
Cj4gKwkJU0FGRV9DTE9TRShmZCk7Cj4gK30KPiArCj4gK3N0YXRpYyB2b2lkIGNoZWNrX2h1Z2V0
bGJfc2htX2dyb3VwKHZvaWQpCj4gK3sKPiArCWNoYXIgZ2lkX2J1ZmZlcls2NF0gPSB7MH07Cj4g
KwlnaWRfdCBodWdldGxiX3NobV9ncm91cDsKPiArCWdpZF90IGdpZCA9IGdldGdpZCgpOwo+ICsJ
dWlkX3QgdWlkID0gZ2V0dWlkKCk7Cj4gKwo+ICsJLyogcm9vdCBpcyBhbiBleGNlcHRpb24gKi8K
PiArCWlmICh1aWQgPT0gMCkKPiArCQlyZXR1cm47CgpUaGUgdGVzdCBoYXMgLm5lZWRzX3Jvb3Qg
PSAxIGluIHRzdF90ZXN0IHNvIHRoaXMgaXMgYWx3YXlzIHRydWUuCgo+ICsJZmQgPSBTQUZFX09Q
RU4oIi9wcm9jL3N5cy92bS9odWdldGxiX3NobV9ncm91cCIsIE9fUkRPTkxZKTsKPiArCXJldCA9
IFNBRkVfUkVBRCgwLCBmZCwgJmdpZF9idWZmZXIsIHNpemVvZihnaWRfYnVmZmVyKSk7Cj4gKwlo
dWdldGxiX3NobV9ncm91cCA9IGF0b2koZ2lkX2J1ZmZlcik7Cj4gKwlTQUZFX0NMT1NFKGZkKTsK
PiArCWlmIChodWdldGxiX3NobV9ncm91cCAhPSBnaWQpCj4gKwkJdHN0X2JyayhUQ09ORiwgIkRv
IG5vdCBoYXZlIHBlcm1pc3Npb24gdG8gdXNlIFNITV9IVUdFVExCIik7Cj4gK30KPiArCj4gK3N0
YXRpYyB2b2lkIHJ1bl90ZXN0KHZvaWQpCj4gK3sKPiArCWNoZWNrX2h1Z2V0bGJfc2htX2dyb3Vw
KCk7Cj4gKwlidWZmZXIgPSBTQUZFX01BTExPQyhocGFnZV9zaXplKnNpemVvZihjaGFyKSk7CiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBeCgkJCQkJVGhpcyBpcyAxIGJ5
IGRlZmluaXRpb24KCkFuZCB0aGVyZSBpcyBubyBwb2ludCBpbiBtdWx0aXBseWluZyBhIG51bWJl
ciBieSAxLi4uCgpBbHNvIHRoZSBidWZmZXIgc2hvdWxkIGJlIGFsbG9jYXRlZCBvbmNlIGluIHRo
ZSB0ZXN0IHNldHVwIGFuZCBmcmVlZApvbmNlIGluIHRoZSB0ZXN0IGNsZWFudXAuCgoKPiArCXJh
d19mZCA9IFNBRkVfT1BFTigiL2Rldi9mdWxsIiwgT19SRE9OTFkpOwo+ICsJc2l6ZSA9IGhwYWdl
X3NpemUgKiBOUl9IVUdFUEFHRVM7Cj4gKwl0c3RfcmVzKFRJTkZPLCAiUmVxdWVzdGluZyAlenUg
Ynl0ZXNcbiIsIHNpemUpOwo+ICsKPiArCXNobWlkID0gc2htZ2V0KDIsIHNpemUsIFNITV9IVUdF
VExCfElQQ19DUkVBVHxTSE1fUnxTSE1fVyk7CgpZb3Ugc2hvdWxkbid0IGhhcmRjb2RlIGtleXMg
aW4gdGhlIHRlc3RzIGxpa2UgdGhpcy4KCkkgZ3Vlc3MgdGhhdCBzaW5jZSB3ZSBhcmUgbm90IGFj
dHVhbGx5IHNoYXJpbmcgdGhlIG1lbW9yeSB3aXRoIG90aGVyCnByb2Nlc3NlcyB3ZSBjYW4gYXMg
d2VsbCBwYXNzIElQQ19QUklWQVRFIGFzIGEga2V5IGluc3RlYWQuCgo+ICsJaWYgKHNobWlkIDwg
MCkgewo+ICsJCXRzdF9yZXMoVEZBSUwgfCBURVJSTk8sICJzaG1nZXQoKSBmYWlsZWQgd2l0aCBl
cnJvciAiKTsKPiArCQlnb3RvIHdpbmR1cDsKPiArCX0gZWxzZQo+ICsJCXRzdF9yZXMoVElORk8s
ICJzaG1pZDogMHgleFxuIiwgc2htaWQpOwoKWW91IHNob3VsZCBqdXN0IHVzZSBTQUZFX1NITUdF
VCgpIGluc3RlYWQgdGhpcy4KCj4gKwlzaG1hZGRyID0gc2htYXQoc2htaWQsIDAsIFNITV9STkQp
Owo+ICsJaWYgKHNobWFkZHIgPT0gTUFQX0ZBSUxFRCkgewo+ICsJCXRzdF9yZXMoVEZBSUwgfCBU
RVJSTk8sICJzaG1hdCgpIGZhaWxlZCB3aXRoIGVycm9yICIpOwo+ICsJCWdvdG8gd2luZHVwOwo+
ICsJfSBlbHNlCj4gKwkJdHN0X3JlcyhUSU5GTywgInNobWFkZHI6ICVwXG4iLCBzaG1hZGRyKTsK
CkFuZCB3ZSBoYXZlIFNBRkVfU0hNQVQoKSBhcyB3ZWxsLgoKPiArCS8qIFJlYWQgYSBwYWdlIGZy
b20gZGV2aWNlIGFuZCB3cml0ZSB0byBzaG0gc2VnbWVudCAqLwo+ICsJZm9yIChpID0gMDsgaSA8
IHNpemU7IGkgKz0gaHBhZ2Vfc2l6ZSkgewo+ICsJCWlmICghcmVhZChyYXdfZmQsIGJ1ZmZlciwg
aHBhZ2Vfc2l6ZSkpIHsKPiArCQkJdHN0X3JlcyhURkFJTCB8IFRFUlJOTywgIkNhbid0IHJlYWQg
ZnJvbSByYXcgZGV2aWNlISIpOwo+ICsJCQlnb3RvIHdpbmR1cDsKPiArCQl9Cj4gKwkJbWVtY3B5
KChjaGFyICopKHNobWFkZHIgKyBpKSwgYnVmZmVyLCBocGFnZV9zaXplKTsKCkkgZG8gbm90IHNl
ZSB0aGUgcG9pbnQgb2YgdGhpcy4gV2UgcmVhZCBmcm9tIGEgZGV2aWNlIGludG8gYSByZWd1bGFy
CmJ1ZmZlciB3ZSBnb3QgZnJvbSBtYWxsb2MoKSBhbmQgdGhlbiBjb3B5IGl0IHRvIHRoZSBTSE0g
bWVtb3J5LgoKQXMgZmFyIGFzIEkgY2FuIHRlbGwgZnJvbSB0aGUgcG9pbnQgb2YgdGhpcyB0ZXN0
IHRoaXMgaXMgbm8gZGlmZmVyZW50CnRoYW4gYWN0dWFsbHkgZG9pbmcgbWVtc2V0KCkgdG8gemVy
byB0aGUgYnVmZmVyIGluc3RlYWQuCgpJdCB3b3VsZCBiZSBhIGRpZmZlcmVudCBzdG9yeSBpZiB3
ZSBwYXNzZWQgdGhlIFNITSBidWZmZXIgdG8gdGhlIHJlYWQKc3lzY2FsLCB0aGF0IHdvdWxkIG1l
YW4gdGhhIHRoZSBzaG0gYnVmZmVyIGlzIGFjdHVhbGx5IHBhc3NlZCBkb3duIHRvCnRoZSBrZXJu
ZWwuIEFuZCB0aGlzIHNlZW1zIHRvIGJlIHdyaXR0ZW4gaW4gdGhlIHRlc3QgZGVzY3JpcHRpb24g
dG9vOgoKIkl0IHdyaXRlcyBhIHN0cmluZyB0byB0aGUgc2hhcmVkIG1lbW9yeSBmcm9tIHJhdyBk
ZXZpY2UuLi4iCgo+ICsJfQo+ICsKPiArCWlmIChzaG1kdCgoY29uc3Qgdm9pZCAqKXNobWFkZHIp
ICE9IDApIHsKPiArCQl0c3RfcmVzKFRGQUlMIHwgVEVSUk5PLCAic2htZHQoKSBmYWlsZWQiKTsK
PiArCQlnb3RvIHdpbmR1cDsKPiArCX0KCkFuZCB3ZSBoYXZlIFNBRkVfU0hNRFQoKSB0b28uCgo+
ICsJdHN0X3JlcyhUUEFTUywgIlRlc3QgUGFzc2VkISIpOwo+ICt3aW5kdXA6Cj4gKwlTQUZFX0ZS
RUUoYnVmZmVyKTsKPiArfQo+ICsKPiArc3RhdGljIHN0cnVjdCB0c3RfdGVzdCB0ZXN0ID0gewo+
ICsJLm5lZWRzX3Jvb3QgPSAxLAo+ICsJLm1udHBvaW50ID0gTU5UUE9JTlQsCj4gKwkubmVlZHNf
aHVnZXRsYmZzID0gMSwKPiArCS5zZXR1cCA9IHNldHVwLAo+ICsJLmNsZWFudXAgPSBjbGVhbnVw
LAo+ICsJLnRlc3RfYWxsID0gcnVuX3Rlc3QsCj4gKwkuaHVnZXBhZ2VzID0gezIsIFRTVF9ORUVE
U30sCj4gK307Cj4gLS0gCj4gMi4zOS4zIChBcHBsZSBHaXQtMTQ2KQo+IAo+IAo+IC0tIAo+IE1h
aWxpbmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAoKLS0g
CkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0
cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
