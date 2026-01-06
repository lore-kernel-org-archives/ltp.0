Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D90BCDC19B
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 13:20:20 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 8F4543C1DC8
	for <ltp@archiver.kernel.org>; Tue,  6 Jan 2026 14:20:18 +0100 (CET)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 65ADF3C0F42
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 14:19:59 +0100 (CET)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 3259D60008D
 for <ltp@lists.linux.it>; Tue,  6 Jan 2026 14:19:57 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9542F5BCCE;
 Tue,  6 Jan 2026 13:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767705596; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+yez2+n6gPgMnHBSdUxvboCaqRSNGEMbZMst6rBaw0=;
 b=2Bd1AGOQCwX1sTABtnkpfLjewSIUzjpSdXWnNStNcdZ++K5iWJr6u09HJlXnFTiACVpuBb
 9q8+U4N5uF7p7ODFzHON5lJqclKxjrCRVHu+lH64NSijRMHn5oFgcRTZF6+qYdY01Xgi9M
 0rxFA2ltkSJm8fGkvTz6nSxduMDlbE0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767705596;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+yez2+n6gPgMnHBSdUxvboCaqRSNGEMbZMst6rBaw0=;
 b=PH8FC+VPMOeYF5ule76uzutgL3Q8sHEl5dRczHpWWVLf7pYLFzxhaIOAcXIsTHFQNwaEV9
 RiCb7tqVptY1JXCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Nxg1t6zC;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=+dsZxmid
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1767705595; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+yez2+n6gPgMnHBSdUxvboCaqRSNGEMbZMst6rBaw0=;
 b=Nxg1t6zCcZv0MhEWYizHRY+zpT9ack0SCiKf1n6mdBEONlbo4BadeS9OvxNOwmOHN6wIIA
 jVaAyElkbedETsMaeaTjWhDgi0xuV8aaJXV00nsV5AAsXD5ZBjAuJdA74/iy3y+vdkYbCw
 GCtBLZcJE66v5bXfa5G07vNIVAArCBM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1767705595;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=t+yez2+n6gPgMnHBSdUxvboCaqRSNGEMbZMst6rBaw0=;
 b=+dsZxmiddcc/mC3ouMlaNiZOQNZd1IwaDAuWmdHzpdqDSuRHB/yBcqBoHHRuz0IjhRifV/
 kJ4+77nbYpcDQYBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 84ADE3EA63;
 Tue,  6 Jan 2026 13:19:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cRV9H/sLXWm+NgAAD6G6ig
 (envelope-from <chrubis@suse.cz>); Tue, 06 Jan 2026 13:19:55 +0000
Date: Tue, 6 Jan 2026 14:21:06 +0100
From: Cyril Hrubis <chrubis@suse.cz>
To: Petr Vorel <pvorel@suse.cz>
Message-ID: <aV0MQv3D3hjGZK2I@yuki.lan>
References: <20251215124404.16395-1-chrubis@suse.cz>
 <20251216112709.GC307257@pevik> <aV0EcJ7TjsgULZKl@yuki.lan>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <aV0EcJ7TjsgULZKl@yuki.lan>
X-Rspamd-Queue-Id: 9542F5BCCE
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_TWO(0.00)[2];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[yuki.lan:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Virus-Scanned: clamav-milter 1.0.9 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/2] doc: Document process_state
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

SGkhCj4gPiA+IC0gKiBSIC0gcHJvY2VzcyBpcyBydW5uaW5nCj4gPiA+IC0gKiBTIC0gcHJvY2Vz
cyBpcyBzbGVlcGluZwo+ID4gPiAtICogRCAtIHByb2Nlc3Mgc2xlZXBpbmcgdW5pbnRlcnJ1cHRp
Ymx5Cj4gPiA+IC0gKiBaIC0gem9tYmllIHByb2Nlc3MKPiA+ID4gLSAqIFQgLSBwcm9jZXNzIGlz
IHRyYWNlZAo+ID4gPiArICogUG9zc2libGUgcHJvY2VzcyBzdGF0ZXM6Cj4gPiBNYXliZTogdXNl
IGxpbmsgdG8gaHR0cHM6Ly9tYW43Lm9yZy9saW51eC9tYW4tcGFnZXMvbWFuMS9wcy4xLmh0bWwg
Pwo+ID4gCj4gPiAtKiBQb3NzaWJsZSBwcm9jZXNzIHN0YXRlczoKPiA+ICsqIFBvc3NpYmxlIHBy
b2Nlc3Mgc3RhdGVzIChzZWUgOm1hbjE6YHBzYCk6Cj4gCj4gMS4gV2UgZG8gbm90IGhhdmUgbWFu
MSBkZWZpbmVkIGluIGV4bGlua3MgaW4gY29uZi5weQo+IAo+IDIuIEV2ZW4gaWYgYWRkZWQgdGhl
cmUgZXhsaW5rcyBkb2VzIG5vdCBzZWVtIHdvcmsgZnJvbSBkb2N1bWVudGF0aW9uCj4gICAgZ2Vu
ZXJhdGVkIGZyb20gaGVhZGVycwoKVGhpcyBhY3R1YWxseSB3b3Jrcywgb25jZSBJIGZpeGVkIHR5
cG8gaW4gdGhlIGNvbmYucHkgY2hhbmdlLgoKPiA+ID4gKyAqIC0gKipSKiogUHJvY2VzcyBpcyBy
dW5uaW5nLgo+ID4gPiArICogLSAqKlMqKiBQcm9jZXNzIGlzIHNsZWVwaW5nLgo+ID4gPiArICog
LSAqKkQqKiBQcm9jZXNzIHNsZWVwaW5nIHVuaW50ZXJydXB0aWJseS4KPiA+ID4gKyAqIC0gKipa
KiogWm9tYmllIHByb2Nlc3MuCj4gPiA+ICsgKiAtICoqVCoqIFByb2Nlc3MgaXMgdHJhY2VkLgo+
ID4gPiArICogLSAqKnQqKiBUcmFjaW5nIHN0b3BwZWQuCj4gPiA+ICsgKiAtICoqWCoqIFByb2Nl
c3MgaWQgZGVhZC4KPiA+IAo+ID4gUHJvY2VzcyBzdGF0ZSBpcyBvdXRkYXRlZCwgbWFuIHBzKDEp
IGxpc3RzOgo+ID4gCj4gPiAgICAgICAgICAgICAgICBEICAgIHVuaW50ZXJydXB0aWJsZSBzbGVl
cCAodXN1YWxseSBJL08pCj4gPiAgICAgICAgICAgICAgICBJICAgIGlkbGUga2VybmVsIHRocmVh
ZAo+ID4gICAgICAgICAgICAgICAgUiAgICBydW5uaW5nIG9yIHJ1bm5hYmxlIChvbiBydW4gcXVl
dWUpCj4gPiAgICAgICAgICAgICAgICBTICAgIGludGVycnVwdGlibGUgc2xlZXAgKHdhaXRpbmcg
Zm9yIGFuCj4gPiAgICAgICAgICAgICAgICAgICAgIGV2ZW50IHRvIGNvbXBsZXRlKQo+ID4gICAg
ICAgICAgICAgICAgVCAgICBzdG9wcGVkIGJ5IGpvYiBjb250cm9sIHNpZ25hbAo+ID4gICAgICAg
ICAgICAgICAgdCAgICBzdG9wcGVkIGJ5IGRlYnVnZ2VyIGR1cmluZyB0aGUgdHJhY2luZwo+ID4g
ICAgICAgICAgICAgICAgVyAgICBwYWdpbmcgKG5vdCB2YWxpZCBzaW5jZSBMaW51eCAyLjYpCj4g
PiAgICAgICAgICAgICAgICBYICAgIGRlYWQgKHNob3VsZCBuZXZlciBiZSBzZWVuKQo+ID4gICAg
ICAgICAgICAgICAgWiAgICBkZWZ1bmN0ICjigJx6b21iaWXigJ0pIHByb2Nlc3MsIHRlcm1pbmF0
ZWQKPiA+ICAgICAgICAgICAgICAgICAgICAgYnV0IG5vdCByZWFwZWQgYnkgaXRzIHBhcmVudAo+
ID4gCj4gPiBXZSBtaXNzOgo+ID4gKiBJIChmcm9tIGtlcm5lbCA0LjIsIG1heWJlIG5vdCByZWxl
dmFudCB3aGVuIHdlIHVzZSBpdCBmb3IgYSBjaGlsZCB3aGljaAo+ID4gaXMgdXNlcnNwYWNlKQo+
ID4gKiBXIChpcnJlbGV2YW50IGFzIGl0IGlzIG5vdCB2YWxpZCkKPiAKPiBJbmRlZWQgdGhlc2Ug
YXJlIG5vdCByZWxldmVudCBmb3IgdXMuCj4gCj4gPiAqIFoKPiAKPiBab21iaWUgcHJvY2VzcyBp
cyBkZXNjcmliZWQgaW4gdGhlIGxpc3QuCj4gCj4gPiBBbHNvLCBkbyB3ZSB3YW50IHNwZWNpZnkg
dGhlIHByb2Nlc3Mgc3RhdGVzIGluIGJvdGggVFNUX1BST0NFU1NfU1RBVEVfV0FJVCgpIGFuZAo+
ID4gVFNUX1RIUkVBRF9TVEFURV9XQUlUKCksIG9yIGp1c3Qgc3BlY2lmeSBpdCBpbiBvbmUgYW5k
IG1lbnRpb24gaW4gdGhlIG90aGVyIHRoYXQKPiA+IHRoZXkgc3BlY2lmeSBpdD8gKHZpYSA6cmVm
OiBvciBjOmZ1bmM6KS4KPiAKPiBBZ2Fpbiwgbm9uZSBvZiB0aGUgOnJlZjogb3IgYzpmdW5jOiBp
cyB3b3JraW5nIGluIGRvY3MgZ2VuZXJhdGUgZnJvbQo+IGhlYWRlcnMuCgpBbmQgdGhpcyBvbmUg
bmVlZHMgdG8gYmUganVzdCBUU1RfUFJPQ0VTU19TVEFURV9XQUlUKCkgdG8gYmUgcHJvY2Vzc2Vk
CmFzIGEgbGluayBpbiBoZWFkZXJzLgoKLS0gCkN5cmlsIEhydWJpcwpjaHJ1YmlzQHN1c2UuY3oK
Ci0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9s
dHAK
