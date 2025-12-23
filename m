Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D085CE6FE30
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 20:58:57 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4A6CB3D0E9C
	for <ltp@archiver.kernel.org>; Tue, 23 Dec 2025 21:58:55 +0100 (CET)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 911943D037C
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 21:58:36 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id CA7F61000D49
 for <ltp@lists.linux.it>; Tue, 23 Dec 2025 21:58:32 +0100 (CET)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0D1C73392D;
 Tue, 23 Dec 2025 20:58:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766523511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc/kS4KDjYW+G/iO8cgwV7/u6bDcbfu8QVh6vCSmrm8=;
 b=0wotw2PLjH7ryuoAHX4rZq/cTr0vPzgFLmbDnvz/JerKZGnJU82TlKZ+i5jfschlQf2/PU
 fmtHMOMw7FIvNVJgb/7OmIwxDYX/8euqLQ+J5I0b5FcYil/99gSDVa+NAmAUDKAG5fz2j8
 hP5y10OHqWmg54jSWIuupNRZIdsdWuE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766523511;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc/kS4KDjYW+G/iO8cgwV7/u6bDcbfu8QVh6vCSmrm8=;
 b=GnBsbDQL552QOdzAAGwu5YHw9HJBXJVNbyKPgIgD3viZRREDDAqZ+WHHOour+iTWPsyJNZ
 D2wdurmFEMhFtfCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1766523510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc/kS4KDjYW+G/iO8cgwV7/u6bDcbfu8QVh6vCSmrm8=;
 b=Kp/Hq1iUAfLj2EjYNSOgZXGd3/VuuXESU0oPCCwdL4H2oHIT32OqxHh5IvU1i4ruBRI2Z6
 o0BI2rYgUDPEgrQNynLDSM60eOWAppsQtexAtflFQX6FtI9DfUcZT3tumRzASBRWAbHZFr
 SRkr/k8HOBD8m2QR59wUb5axk8fz8l0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1766523510;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wc/kS4KDjYW+G/iO8cgwV7/u6bDcbfu8QVh6vCSmrm8=;
 b=0sZdoEnOaDyzeDEYzCaZAK4N74vC7YV6/uuBYwB85vOaTdcUjIF8FPAPOFKZKBaWZH+HmQ
 va4XCUR1sydCjUAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A232E3EA63;
 Tue, 23 Dec 2025 20:58:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sIt+IXUCS2m7PwAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Tue, 23 Dec 2025 20:58:29 +0000
Date: Tue, 23 Dec 2025 21:58:23 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Vasileios Almpanis <vasileios.almpanis@virtuozzo.com>
Message-ID: <20251223205823.GB141917@pevik>
References: <20251219212717.GA15539@pevik>
 <20251222141331.121827-1-vasileios.almpanis@virtuozzo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20251222141331.121827-1-vasileios.almpanis@virtuozzo.com>
X-Spamd-Result: default: False [-3.50 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 NEURAL_HAM_SHORT(-0.20)[-0.994]; MIME_GOOD(-0.10)[text/plain];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCVD_TLS_ALL(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[virtuozzo.com:email,suse.cz:replyto,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; REPLYTO_EQ_FROM(0.00)[]
X-Virus-Scanned: clamav-milter 1.0.9 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v2 1/1] ssh-stress: disable resource penalties
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

SGkgVmFzaWxlaW9zLAoKPiBPdXIgdGVzdHMgY3JlYXRlIGEgbnVtYmVyIG9mIHNzaCBzZXNzaW9u
cyBpbiB0aGUKPiBiYWNrZ3JvdW5kIHdoaWNoIGFyZSBpbW1lZGlhdGVseSBraWxsZWQuIFNvbWUg
b2YKPiB0aGVtIGhhdmVuJ3QgZmluaXNoZWQgdGhlIGF1dGhlbnRpY2F0aW9uIHN0YWdlIHlldAo+
IGFuZCB0aGV5IGNsb3NlIHRoZSBjb25uZWN0aW9uIGluY3VycmluZyBwZW5hbHRpZXMgZnJvbQo+
IHRoZSBzc2ggZGFlbW9uLgoKPiBkZWJ1ZzE6IHNyY2xpbWl0X3BlbmFsaXNlOiBhY3RpdmUgcGVu
YWx0eSBmb3IgaXB2NCAxMC4wLjAuMS8zMgo+IGFscmVhZHkgZXhpc3RzLCAxNiBzZWNvbmRzIHJl
bWFpbmluZwoKPiBUaGVuIHdoZW4gd2UgdHJ5IHRvIHJlY29ubmVjdCB0byB0aGUgZGFlbW9uIHdl
IGFyZSBib3VuY2VkCj4gYmVjYXVzZSBvZiB0aGUgYWN0aXZlIHBlbmFsdHkgd2hpY2ggbGVhZHMg
dG8gYSBmYWlsZWQgdGVzdC4KCj4gc3NoLXN0cmVzcyAxIFRJTkZPOiBLaWxsaW5nIGFsbCBzc2gg
c2Vzc2lvbnMKPiBrZXhfZXhjaGFuZ2VfaWRlbnRpZmljYXRpb246IHJlYWQ6IENvbm5lY3Rpb24g
cmVzZXQgYnkgcGVlcgo+IENvbm5lY3Rpb24gcmVzZXQgYnkgZmQwMDoxOjE6MTo6MiBwb3J0IDU4
MzczCj4gc3NoLXN0cmVzcyAxIFRGQUlMOiBTU0ggbm90IHJlYWNoYWJsZQoKPiBGcm9tIHRoZSBz
c2hkIGxvZ3Mgd2UgY2FuIHNlZQoKPiBkZWJ1ZzE6IHNyY2xpbWl0X3BlbmFsaXNlOiBhY3RpdmUg
cGVuYWx0eSBmb3IgaXB2NCAxMC4wLjAuMS8zMgo+IGFscmVhZHkgZXhpc3RzLCAxNiBzZWNvbmRz
IHJlbWFpbmluZwoKPiBUaGlzIGZlYXR1cmUgd2FzIGFkZGVkIHRvIE9wZW5TU0ggOS44IGluIHRo
ZSAyMDI0IHJlbGVhc2UgaW4gdGhlCj4gODFjMTA5OWQyIGNvbW1pdC4gTGV0cyBkaXNhYmxlIHBl
bmFsdGllcyBmb3IgdGhlIHZlcnNpb25zIHRoYXQKPiBzdXBwb3J0IHRoZW0uCgorMSBmb3IgYSBu
aWNlIGRlc2NyaXB0aW9uIQoKPiBTaWduZWQtb2ZmLWJ5OiBWYXNpbGVpb3MgQWxtcGFuaXMgPHZh
c2lsZWlvcy5hbG1wYW5pc0B2aXJ0dW96em8uY29tPgo+IC0tLQo+IENoYW5nZXMgaW4gdjI6Cj4g
LSBSZW1vdmVkIHVubmVjZXNzYXJ5IHBhcmVudGhlc2lzIGFyb3VuZCBpZiBzdGF0ZW1lbnRzLgo+
IC0tLQo+ICB0ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3Mvc3NoL3NzaC1zdHJlc3Muc2ggfCAxMyAr
KysrKysrKysrKystCj4gIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pCgo+IGRpZmYgLS1naXQgYS90ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3Mvc3NoL3NzaC1z
dHJlc3Muc2ggYi90ZXN0Y2FzZXMvbmV0d29yay9zdHJlc3Mvc3NoL3NzaC1zdHJlc3Muc2gKPiBp
bmRleCBjMjdjMjdhMjguLmQ1ZGIyNDgzNSAxMDA3NTUKPiAtLS0gYS90ZXN0Y2FzZXMvbmV0d29y
ay9zdHJlc3Mvc3NoL3NzaC1zdHJlc3Muc2gKPiArKysgYi90ZXN0Y2FzZXMvbmV0d29yay9zdHJl
c3Mvc3NoL3NzaC1zdHJlc3Muc2gKPiBAQCAtMzksOCArMzksMTIgQEAgY2xlYW51cCgpCgo+ICBz
ZXR1cCgpCj4gIHsKPiAtCWxvY2FsIHBvcnQgcmMKPiArCWxvY2FsIHBvcnQgcmMgdmVyc2lvbiBt
YWpvciBtaW5vcgoKPiArCXZlcnNpb249JChzc2hkIC1WIDI+JjEgfCBzZWQgLW5FICdzL14uKk9w
ZW5TU0hfKFswLTldKylcLihbMC05XSspLiokL1wxIFwyL3AnIHwgaGVhZCAtbjEpCj4gKwlzZXQg
LS0gJHZlcnNpb24KPiArCW1ham9yPSQxCj4gKwltaW5vcj0kMgoKPiAgCXBvcnQ9JCh0c3Rfcmhv
c3RfcnVuIC1jICJ0c3RfZ2V0X3VudXNlZF9wb3J0IGlwdiR7VFNUX0lQVkVSfSBzdHJlYW0iKQoK
PiBAQCAtNjAsNiArNjQsMTMgQEAgSG9zdEtleSAkVFNUX1RNUERJUi9zc2hfaG9zdF9lY2RzYV9r
ZXkKPiAgSG9zdEtleSAkVFNUX1RNUERJUi9zc2hfaG9zdF9lZDI1NTE5X2tleQo+ICBFT0YKCj4g
KwlpZiBbIC1uICIkbWFqb3IiIF0gJiYgWyAtbiAiJG1pbm9yIiBdOyB0aGVuClRoaXMgY291bGQg
YmUgc2ltcGxpZmllZCBieSBhc3NpZ25pbmcgYm90aCB0byB6ZXJvLgoKPiArCQlpZiBbICIkbWFq
b3IiIC1ndCA5IF0gfHwgWyAiJG1ham9yIiAtZXEgOSBdICYmIFsgIiRtaW5vciIgLWdlIDggXTsg
dGhlbgoKVGhpcyBpcyB3cm9uZy4gSXQgc2hvdWxkIGJlIGFzIEkgc3VnZ2VzdGVkIGF0IHYxOgoK
aWYgWyAiJG1ham9yIiAtZ3QgOSBdIHx8IFsgIiRtYWpvciIgLWVxIDkgLWEgIiRtaW5vciIgLWdl
IDggXTsgdGhlbgoKb3RoZXJ3aXNlIGl0IGRvZXMgbm90IHdvcmsgZm9yID4gOS4gVXNpbmcgKCkg
aW4gdjEgd2FzIGFsc28gY29ycmVjdCwganVzdAp1bm5lY2Vzc2FyeSBjb21wbGljYXRlZC4KCklm
IHlvdSBhZ3JlZSBJIGNhbiBtZXJnZSB0aGlzOgoKc2V0dXAoKQp7Cglsb2NhbCBwb3J0IHJjIHZl
cnNpb24KCWxvY2FsIG1ham9yPTAgbWlub3I9MAoKCXZlcnNpb249JChzc2hkIC1WIDI+JjEgfCBz
ZWQgLW5FICdzL14uKk9wZW5TU0hfKFswLTldKylcLihbMC05XSspLiokL1wxIFwyL3AnIHwgaGVh
ZCAtbjEpCglzZXQgLS0gJHZlcnNpb24KCW1ham9yPSQxCgltaW5vcj0kMgoJLi4uCglpZiBbICIk
bWFqb3IiIC1ndCA5IF0gfHwgWyAiJG1ham9yIiAtZXEgOSAtYSAiJG1pbm9yIiAtZ2UgOCBdOyB0
aGVuCgkJY2F0IDw8IEVPRiA+PiBzc2hkX2NvbmZpZwpQZXJTb3VyY2VQZW5hbHRpZXMgbm8KRU9G
CglmaQoKKFNlZSBmdWxsIGRpZmYgZnJvbSB5b3VyIHYyIGJlbG93LikKLS0tCldoeT8gJiYgYW5k
IHx8IGhhdmUgZXF1YWwgcHJlY2VkZW5jZSAodW5saWtlIEMgbGlrZSBsYW5ndWFnZXMgd2hlcmUg
JiYgaGFzCmhpZ2hlciBwcmVmZXJlbmNlKToKCiQgZWNobyAxIHx8IGVjaG8gMiAmJiBlY2hvIDMK
MQozCj0+IEluIEMgbGlrZSBldmFsdWF0aW9uIGl0IHdvdWxkIGJlIGp1c3Q6CjEKCklmIHlvdSB3
b25kZXIgd2h5LCBzZWUgc2VjdGlvbiAiTGlzdHMiIGluIG1hbiBiYXNoKDEpIFsxXToKCglBIGxp
c3QgaXMgYSBzZXF1ZW5jZSBvZiBvbmUgb3IgbW9yZSBwaXBlbGluZXMgc2VwYXJhdGVkIGJ5IG9u
ZSBvZgoJdGhlIG9wZXJhdG9ycyA7LCAmLCAmJiwgb3IgfHwsIGFuZCBvcHRpb25hbGx5IHRlcm1p
bmF0ZWQgYnkgb25lIG9mCgk7LCAmLCBvciA8bmV3bGluZT4uCgoJT2YgdGhlc2UgbGlzdCBvcGVy
YXRvcnMsICYmIGFuZCB8fCBoYXZlIGVxdWFsIHByZWNlZGVuY2UsIGZvbGxvd2VkCglieSA7IGFu
ZCAmLCB3aGljaCBoYXZlIGVxdWFsIHByZWNlZGVuY2UuCgpKdXN0IHRvIGRvdWJsZSBjaGVjayB0
aGlzIGJhc2ljIGZ1bmN0aW9uYWxpdHkgd29ya3MgdGhlIHNhbWUgYWNyb3NzIFBPU0lYIHNoZWxs
CnNlZSBzZWN0aW9uICJTaG9ydC1DaXJjdWl0IExpc3QgT3BlcmF0b3JzIiBpbiBtYW4gZGFzaCgx
KSBbMl06CgoJ4oCcJibigJ0gYW5kIOKAnHx84oCdIGFyZSBBTkQtT1IgbGlzdCBvcGVyYXRvcnMu
ICDigJwmJuKAnSBleGVjdXRlcyB0aGUgZmlyc3QKCWNvbW1hbmQsIGFuZCB0aGVuIGV4ZWN1dGVz
IHRoZSBzZWNvbmQgY29tbWFuZCBpZiBhbmQgb25seSBpZiB0aGUKCWV4aXQgc3RhdHVzIG9mIHRo
ZSBmaXJzdCBjb21tYW5kIGlzIHplcm8uICDigJx8fOKAnSBpcyBzaW1pbGFyLCBidXQKCWV4ZWN1
dGVzIHRoZSBzZWNvbmQgY29tbWFuZCBpZiBhbmQgb25seSBpZiB0aGUgZXhpdCBzdGF0dXMgb2Yg
dGhlCglmaXJzdCBjb21tYW5kIGlzIG5vbnplcm8uICDigJwmJuKAnSBhbmQg4oCcfHzigJ0gYm90
aCBoYXZlIHRoZSBzYW1lCglwcmlvcml0eS4KClRoZXJlZm9yZSAxMC4xIHZlcnNpb24gd2lsbCBu
b3QgYmUgc2VsZWN0ZWQgaW4geW91ciBuZXcgY29kZToKCiQgbWFqb3I9MTAgbWlub3I9MTsgaWYg
WyAiJG1ham9yIiAtZ3QgOSBdIHx8IFsgIiRtYWpvciIgLWVxIDkgXSAmJiBbICIkbWlub3IiIC1n
ZSA4IF07IHRoZW4gZWNobyAiZm91bmQiOyBlbHNlIGVjaG8gIm5vdCBmb3VuZCI7IGZpCm5vdCBm
b3VuZAoKQnV0IHVzaW5nIGp1c3QgMnggWyBdICh0aGUgc2Vjb25kIHdpdGggIi1hIikgd2lsbCBi
ZWhhdmUgbGlrZSAKJCBtYWpvcj0xMCBtaW5vcj0xOyBpZiBbICIkbWFqb3IiIC1ndCA5IF0gfHwg
WyAiJG1ham9yIiAtZXEgOSAtYSAiJG1pbm9yIiAtZ2UgOCBdOyB0aGVuIGVjaG8gImZvbyI7IGZp
CmZvbwoKJCBtYWpvcj0xMCBtaW5vcj0xOyBpZiBbICIkbWFqb3IiIC1ndCA5IF0gfHwgWyAiJG1h
am9yIiAtZXEgOSAtYSAiJG1pbm9yIiAtZ2UgOCBdOyB0aGVuIGVjaG8gImZvdW5kIjsgZWxzZSBl
Y2hvICJub3QgZm91bmQiOyBmaQpmb3VuZAoKVXNpbmcgKCkgaW4gdjEgd2FzIGNvcnJlY3Q6CiQg
bWFqb3I9MTAgbWlub3I9MTsgaWYgWyAiJG1ham9yIiAtZ3QgOSBdIHx8IChbICIkbWFqb3IiIC1l
cSA5IF0gJiYgWyAiJG1pbm9yIiAtZ2UgOCBdKTsgdGhlbiBlY2hvICJmb3VuZCI7IGVsc2UgZWNo
byAibm90IGZvdW5kIjsgZmkKZm91bmQKCml0IGp1c3QgbG9va2VkIG1lIHVubmVjZXNzYXJ5IGNv
bXBsaWNhdGVkLCBiZWNhdXNlICggLi4uICkgZXhlY3V0ZXMgZXZhbHVhdGlvbgppbiBhIHN1YnNo
ZWxsIChzZWUgIkdyb3VwaW5nIENvbW1hbmRzIFRvZ2V0aGVyIiBpbiBkYXNoKDEpIG9yICJDb21w
b3VuZApDb21tYW5kcyIgaW4gYmFzaCgxKSkuCgpbMV0gaHR0cHM6Ly9tYW43Lm9yZy9saW51eC9t
YW4tcGFnZXMvbWFuMS9iYXNoLjEuaHRtbApbMl0gaHR0cHM6Ly9tYW43Lm9yZy9saW51eC9tYW4t
cGFnZXMvbWFuMS9kYXNoLjEuaHRtbAoKZGlmZiAtLWdpdCB0ZXN0Y2FzZXMvbmV0d29yay9zdHJl
c3Mvc3NoL3NzaC1zdHJlc3Muc2ggdGVzdGNhc2VzL25ldHdvcmsvc3RyZXNzL3NzaC9zc2gtc3Ry
ZXNzLnNoCmluZGV4IGQ1ZGIyNDgzNWQuLjE0YTRhZjgyMTMgMTAwNzU1Ci0tLSB0ZXN0Y2FzZXMv
bmV0d29yay9zdHJlc3Mvc3NoL3NzaC1zdHJlc3Muc2gKKysrIHRlc3RjYXNlcy9uZXR3b3JrL3N0
cmVzcy9zc2gvc3NoLXN0cmVzcy5zaApAQCAtMzksNyArMzksOCBAQCBjbGVhbnVwKCkKIAogc2V0
dXAoKQogewotCWxvY2FsIHBvcnQgcmMgdmVyc2lvbiBtYWpvciBtaW5vcgorCWxvY2FsIHBvcnQg
cmMgdmVyc2lvbgorCWxvY2FsIG1ham9yPTAgbWlub3I9MAogCiAJdmVyc2lvbj0kKHNzaGQgLVYg
Mj4mMSB8IHNlZCAtbkUgJ3MvXi4qT3BlblNTSF8oWzAtOV0rKVwuKFswLTldKykuKiQvXDEgXDIv
cCcgfCBoZWFkIC1uMSkKIAlzZXQgLS0gJHZlcnNpb24KQEAgLTY0LDEyICs2NSwxMCBAQCBIb3N0
S2V5ICRUU1RfVE1QRElSL3NzaF9ob3N0X2VjZHNhX2tleQogSG9zdEtleSAkVFNUX1RNUERJUi9z
c2hfaG9zdF9lZDI1NTE5X2tleQogRU9GCiAKLQlpZiBbIC1uICIkbWFqb3IiIF0gJiYgWyAtbiAi
JG1pbm9yIiBdOyB0aGVuCi0JCWlmIFsgIiRtYWpvciIgLWd0IDkgXSB8fCBbICIkbWFqb3IiIC1l
cSA5IF0gJiYgWyAiJG1pbm9yIiAtZ2UgOCBdOyB0aGVuCi0JCQljYXQgPDwgRU9GID4+IHNzaGRf
Y29uZmlnCisJaWYgWyAiJG1ham9yIiAtZ3QgOSBdIHx8IFsgIiRtYWpvciIgLWVxIDkgLWEgIiRt
aW5vciIgLWdlIDggXTsgdGhlbgorCQljYXQgPDwgRU9GID4+IHNzaGRfY29uZmlnCiBQZXJTb3Vy
Y2VQZW5hbHRpZXMgbm8KIEVPRgotCQlmaQogCWZpCiAJc3NoLWtleWdlbiAtcSAtTiAiIiAtdCBy
c2EgLWIgNDA5NiAtZiAkVFNUX1RNUERJUi9zc2hfaG9zdF9yc2Ffa2V5CiAJc3NoLWtleWdlbiAt
cSAtTiAiIiAtdCBlY2RzYSAtZiAkVFNUX1RNUERJUi9zc2hfaG9zdF9lY2RzYV9rZXkKCi0tIApN
YWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
