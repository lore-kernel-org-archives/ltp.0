Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7022CD342C
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 09:41:15 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5CC023E6151
	for <ltp@archiver.kernel.org>; Wed,  6 May 2026 11:41:14 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 657083E1F3A
 for <ltp@lists.linux.it>; Wed,  6 May 2026 11:40:56 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id 45F2A60042D
 for <ltp@lists.linux.it>; Wed,  6 May 2026 11:40:55 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 683A06B6EF;
 Wed,  6 May 2026 09:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778060453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
 b=aL5LwpLm25f+jCSHF89zjz0VuA9ki5lqszXk5IL6I4a3wfTkpc2GcivWSR1LLYbkajbaWn
 k7KXX/hyLDvmNDHafG61hPbcGOID5wP5AJwNAefCNU6IDTUTAv/QDyj5BEiIs2kRvrL6iv
 YPYl8TTKwHa1wRm3S/vZjD6uzOt8gA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778060453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
 b=VFvWk+wPeu6pCc2CbmntODITOF+fFnz1futXf6rwB0A0WdwogMnskeIWEONihhe/7uve3A
 81ia8Y50DPLtrLAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1778060453; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
 b=aL5LwpLm25f+jCSHF89zjz0VuA9ki5lqszXk5IL6I4a3wfTkpc2GcivWSR1LLYbkajbaWn
 k7KXX/hyLDvmNDHafG61hPbcGOID5wP5AJwNAefCNU6IDTUTAv/QDyj5BEiIs2kRvrL6iv
 YPYl8TTKwHa1wRm3S/vZjD6uzOt8gA8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1778060453;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0uN1BlUZVrApe3cN+yNDLjsQKTQOF6IhGRc9oisQ5a4=;
 b=VFvWk+wPeu6pCc2CbmntODITOF+fFnz1futXf6rwB0A0WdwogMnskeIWEONihhe/7uve3A
 81ia8Y50DPLtrLAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4C723593A3;
 Wed,  6 May 2026 09:40:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id MbN5O6QM+2lXCgAAD6G6ig
 (envelope-from <jack@suse.cz>); Wed, 06 May 2026 09:40:52 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
 id 708F1A0790; Wed, 06 May 2026 11:40:52 +0200 (CEST)
Date: Wed, 6 May 2026 11:40:52 +0200
From: Jan Kara <jack@suse.cz>
To: ltp@lists.linux.it
Message-ID: <lvwxfhejj7q3mx3ylicvnblk4alfpb57rkx47lrdehibwegahk@lnlgbr2rgx6p>
References: <202605061511.8611e3df-lkp@intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <202605061511.8611e3df-lkp@intel.com>
X-Spamd-Result: default: False [-7.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_RHS_NOT_FQDN(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; RCPT_COUNT_SEVEN(0.00)[9];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_THREE(0.00)[3];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 RCVD_TLS_LAST(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[01.org:url, intel.com:email,
 imap1.dmz-prg2.suse.org:helo, suse.com:email]
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linus:master] [xattr]  dc0876b984: ltp.fsetxattr02.fail
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
Cc: Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 lkp@intel.com, "Darrick J. Wong" <djwong@kernel.org>,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 kernel test robot <oliver.sang@intel.com>, oe-lkp@lists.linux.dev
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkIDA2LTA1LTI2IDE1OjIzOjA2LCBrZXJuZWwgdGVzdCByb2JvdCB3cm90ZToKPiBrZXJu
ZWwgdGVzdCByb2JvdCBub3RpY2VkICJsdHAuZnNldHhhdHRyMDIuZmFpbCIgb246CgpUaGUgdGVz
dCB2ZXJpZmllcyBzZXR0aW5nIHhhdHRycyBvbiBzb2NrZXRzIGZhaWxzLi4uCgo+IGNvbW1pdDog
ZGMwODc2Yjk4NDZkM2Q0OGJiODUyODMzMjEwNmQxYjA1MTU3OGEwMiAoInhhdHRyOiBzdXBwb3J0
IGV4dGVuZGVkIGF0dHJpYnV0ZXMgb24gc29ja2V0cyIpCj4gaHR0cHM6Ly9naXQua2VybmVsLm9y
Zy9jZ2l0L2xpbnV4L2tlcm5lbC9naXQvdG9ydmFsZHMvbGludXguZ2l0IG1hc3RlcgoKLi4uIHdo
aWNoIG9idmlvdXNseSBpc24ndCB0aGUgY2FzZSBhbnltb3JlIHdpdGggdGhpcyBjb21taXQuIFdl
IG5lZWQgdG8KdXBkYXRlIHRoZSB0ZXN0IGV4cGVjdCBzdWNjZXNzIG9uIHNvY2tldHMgd2l0aCBy
ZWNlbnQga2VybmVscy4KCgkJCQkJCQkJSG9uemEKCj4gCj4gW3Rlc3QgZmFpbGVkIG9uIGxpbnVz
L21hc3RlciAgICAgIGYxYTVlNzhhNTVlYmYyYjA1Nzc3ZmQ1ZWI3MzgwMzhkZGFlNjA5ZDZdCj4g
W3Rlc3QgZmFpbGVkIG9uIGxpbnV4LW5leHQvbWFzdGVyIGI5MzAzZTZiZmY3MDY3NThjMTY3YWY2
ODZiNTMxNWFkMDAyMzNiZjhdCj4gCj4gaW4gdGVzdGNhc2U6IGx0cAo+IHZlcnNpb246IAo+IHdp
dGggZm9sbG93aW5nIHBhcmFtZXRlcnM6Cj4gCj4gCWRpc2s6IDFIREQKPiAJZnM6IGJ0cmZzCj4g
CXRlc3Q6IHN5c2NhbGxzLTA3L2ZzZXR4YXR0cjAyCj4gCj4gCj4gY29uZmlnOiB4ODZfNjQtcmhl
bC05LjQtbHRwCj4gY29tcGlsZXI6IGdjYy0xNAo+IHRlc3QgbWFjaGluZTogNCB0aHJlYWRzIDEg
c29ja2V0cyBJbnRlbChSKSBDb3JlKFRNKSBpMy0zMjIwIENQVSBAIDMuMzBHSHogKEl2eSBCcmlk
Z2UpIHdpdGggOEcgbWVtb3J5Cj4gCj4gKHBsZWFzZSByZWZlciB0byBhdHRhY2hlZCBkbWVzZy9r
bXNnIGZvciBlbnRpcmUgbG9nL2JhY2t0cmFjZSkKPiAKPiAKPiBJZiB5b3UgZml4IHRoZSBpc3N1
ZSBpbiBhIHNlcGFyYXRlIHBhdGNoL2NvbW1pdCAoaS5lLiBub3QganVzdCBhIG5ldyB2ZXJzaW9u
IG9mCj4gdGhlIHNhbWUgcGF0Y2gvY29tbWl0KSwga2luZGx5IGFkZCBmb2xsb3dpbmcgdGFncwo+
IHwgUmVwb3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDxvbGl2ZXIuc2FuZ0BpbnRlbC5jb20+
Cj4gfCBDbG9zZXM6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL29lLWxrcC8yMDI2MDUwNjE1MTEu
ODYxMWUzZGYtbGtwQGludGVsLmNvbQo+IAo+IAo+IDIwMjYtMDUtMDIgMDI6MTk6MzkgZXhwb3J0
IExUUF9SVU5USU1FX01VTD0yCj4gMjAyNi0wNS0wMiAwMjoxOTozOSBleHBvcnQgTFRQUk9PVD0v
bGtwL2JlbmNobWFya3MvbHRwCj4gMjAyNi0wNS0wMiAwMjoxOTozOSBraXJrIC1mIHRlbXBfc2lu
Z2xlX3Rlc3QgLS10bXAtZGlyIC9mcy9zZGEyL3RtcGRpcgo+IEhvc3QgaW5mb3JtYXRpb24KPiAJ
SG9zdG5hbWU6ICAgbGtwLWl2Yi1kMDQKPiAJUHl0aG9uOiAgICAgMy4xMy41IChtYWluLCBKdW4g
MjUgMjAyNSwgMTg6NTU6MjIpIFtHQ0MgMTQuMi4wXQo+IAlEaXJlY3Rvcnk6ICAvZnMvc2RhMi90
bXBkaXIva2lyay5yb290L3RtcGNhb2Vtc280Cj4gCj4gQ29ubmVjdGluZyB0byBTVVQ6IGRlZmF1
bHQKPiAKPiBTdWl0ZTogdGVtcF9zaW5nbGVfdGVzdAo+IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAo+IBtbMTszN21m
c2V0eGF0dHIwMjogG1swbRtbMTszMW1mYWlsG1swbSB8IBtbMTszM210YWludGVkG1swbSAgKDAu
MDg1cykKPiAKPiBFeGVjdXRpb24gdGltZTogMC4zNzhzCj4gCj4gRGlzY29ubmVjdGluZyBmcm9t
IFNVVDogZGVmYXVsdAo+IAo+IFRhcmdldCBpbmZvcm1hdGlvbgo+IOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgAo+IEtlcm5lbDogICBMaW51eCA3
LjAuMC1yYzErICMxIFNNUCBQUkVFTVBUX0RZTkFNSUMgVGh1IEFwciAzMCAyMToxNjo0OCBDU1Qg
MjAyNgo+IENtZGxpbmU6ICBpcD06Ojo6bGtwLWl2Yi1kMDQ6OmRoY3AKPiAgICAgICAgICAgcm9v
dD0vZGV2L3JhbTAKPiAgICAgICAgICAgUkVTVUxUX1JPT1Q9L3Jlc3VsdC9sdHAvMUhERC1idHJm
cy1zeXNjYWxscy0wN19mc2V0eGF0dHIwMi9sa3AtaXZiLWQwNC9kZWJpYW4tMTMteDg2XzY0LTIw
MjUwOTAyLmNnei94ODZfNjQtcmhlbC05LjQtbHRwL2djYy0xNC9kYzA4NzZiOTg0NmQzZDQ4YmI4
NTI4MzMyMTA2ZDFiMDUxNTc4YTAyLzAKPiAgICAgICAgICAgQk9PVF9JTUFHRT0vcGtnL2xpbnV4
L3g4Nl82NC1yaGVsLTkuNC1sdHAvZ2NjLTE0L2RjMDg3NmI5ODQ2ZDNkNDhiYjg1MjgzMzIxMDZk
MWIwNTE1NzhhMDIvdm1saW51ei03LjAuMC1yYzErCj4gICAgICAgICAgIGJyYW5jaD1pbnRlcm5h
bC10ZHgta3ZtLXVwc3RyZWFtL2NpL25leHQtMjAyNjA0MjQtNzA4MGUzMmQzZjA5ZC0yMDI2LTA0
LTI0Cj4gICAgICAgICAgIGpvYj0vbGtwL2pvYnMvc2NoZWR1bGVkL2xrcC1pdmItZDA0L2x0cC0x
SERELWJ0cmZzLXN5c2NhbGxzLTA3X2ZzZXR4YXR0cjAyLWRlYmlhbi0xMy14ODZfNjQtMjAyNTA5
MDIuY2d6LWRjMDg3NmI5ODQ2ZC0yMDI2MDUwMi0xNzQwNC0xd3lxeXl1LTEueWFtbAo+ICAgICAg
ICAgICB1c2VyPWxrcAo+ICAgICAgICAgICBBUkNIPXg4Nl82NAo+ICAgICAgICAgICBrY29uZmln
PXg4Nl82NC1yaGVsLTkuNC1sdHAKPiAgICAgICAgICAgY29tbWl0PWRjMDg3NmI5ODQ2ZDNkNDhi
Yjg1MjgzMzIxMDZkMWIwNTE1NzhhMDIKPiAgICAgICAgICAgaW50cmVtYXA9cG9zdGVkX21zaQo+
ICAgICAgICAgICBtYXhfdXB0aW1lPTE0NDAwCj4gICAgICAgICAgIExLUF9TRVJWRVI9aW50ZXJu
YWwtbGtwLXNlcnZlcgo+ICAgICAgICAgICBub2thc2xyCj4gICAgICAgICAgIHNlbGludXg9MAo+
ICAgICAgICAgICBkZWJ1Zwo+ICAgICAgICAgICBhcGljPWRlYnVnCj4gICAgICAgICAgIHN5c3Jx
X2Fsd2F5c19lbmFibGVkCj4gICAgICAgICAgIHJjdXBkYXRlLnJjdV9jcHVfc3RhbGxfdGltZW91
dD0xMDAKPiAgICAgICAgICAgbmV0LmlmbmFtZXM9MAo+ICAgICAgICAgICBwcmludGsuZGV2a21z
Zz1vbgo+ICAgICAgICAgICBwYW5pYz0tMQo+ICAgICAgICAgICBzb2Z0bG9ja3VwX3BhbmljPTEK
PiAgICAgICAgICAgbm1pX3dhdGNoZG9nPXBhbmljCj4gICAgICAgICAgIG9vcHM9cGFuaWMKPiAg
ICAgICAgICAgbG9hZF9yYW1kaXNrPTIKPiAgICAgICAgICAgcHJvbXB0X3JhbWRpc2s9MAo+ICAg
ICAgICAgICBkcmJkLm1pbm9yX2NvdW50PTgKPiAgICAgICAgICAgc3lzdGVtZC5sb2dfbGV2ZWw9
ZXJyCj4gICAgICAgICAgIGlnbm9yZV9sb2dsZXZlbAo+ICAgICAgICAgICBjb25zb2xlPXR0eTAK
PiAgICAgICAgICAgZWFybHlwcmludGs9dHR5UzAsMTE1MjAwCj4gICAgICAgICAgIGNvbnNvbGU9
dHR5UzAsMTE1MjAwCj4gICAgICAgICAgIHZnYT1ub3JtYWwKPiAgICAgICAgICAgcncKPiAgICAg
ICAgICAga2VlcF9pbml0cmRzPS9vc2ltYWdlL3BrZy9kZWJpYW4tMTMteDg2XzY0LTIwMjUwOTAy
LmNnei9sdHAteDg2XzY0LTkyZWEwNjM5ZS0xXzIwMjYwMzAxLmNnego+IE1hY2hpbmU6ICB1bmtu
b3duCj4gQXJjaDogICAgIHg4Nl82NAo+IFJBTTogICAgICA2ODk5MTg4IGtCCj4gU3dhcDogICAg
IDAga0IKPiBEaXN0cm86ICAgZGViaWFuIDEzCj4gCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gICAgICAg
VEVTVCBTVU1NQVJZCj4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gU3VpdGU6ICAgdGVtcF9zaW5nbGVfdGVz
dAo+IFJ1bnRpbWU6IDAuMDg1cwo+IFJ1bnM6ICAgIDEKPiAKPiBSZXN1bHRzOgo+ICAgICBQYXNz
ZWQ6ICAgNgo+ICAgICBGYWlsZWQ6ICAgMQo+ICAgICBCcm9rZW46ICAgMAo+ICAgICBTa2lwcGVk
OiAgMAo+ICAgICBXYXJuaW5nczogMAo+IAo+IBtbMTszMW1GYWlsdXJlczobWzBtCj4gICAgIOKA
oiBmc2V0eGF0dHIwMgo+IAo+IFNlc3Npb24gc3RvcHBlZAo+IAo+IAo+IAo+IFRoZSBrZXJuZWwg
Y29uZmlnIGFuZCBtYXRlcmlhbHMgdG8gcmVwcm9kdWNlIGFyZSBhdmFpbGFibGUgYXQ6Cj4gaHR0
cHM6Ly9kb3dubG9hZC4wMS5vcmcvMGRheS1jaS9hcmNoaXZlLzIwMjYwNTA2LzIwMjYwNTA2MTUx
MS44NjExZTNkZi1sa3BAaW50ZWwuY29tCj4gCj4gCj4gCj4gLS0gCj4gMC1EQVkgQ0kgS2VybmVs
IFRlc3QgU2VydmljZQo+IGh0dHBzOi8vZ2l0aHViLmNvbS9pbnRlbC9sa3AtdGVzdHMvd2lraQo+
IAotLSAKSmFuIEthcmEgPGphY2tAc3VzZS5jb20+ClNVU0UgTGFicywgQ1IKCi0tIApNYWlsaW5n
IGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
