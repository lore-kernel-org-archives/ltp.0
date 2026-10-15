Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEB8CC6B34
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 08:39:13 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 24EC23E6A05
	for <ltp@archiver.kernel.org>; Thu, 15 Oct 2026 10:39:12 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id D08BC3E5FF7
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 10:38:54 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 5577F2009BB
 for <ltp@lists.linux.it>; Thu, 15 Oct 2026 10:38:54 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 7E7561F7D1;
 Thu, 15 Oct 2026 08:38:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792053533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNpbjqaukZ8PV3ESP9SFEFdZ8o9IZEpxvDaS69iGKJM=;
 b=pRYmxBuU6T8CBCKc4XPov5yjBDSwPWR46bM3KTnx0wTQn/+yRQqdaWEBnOjsJu/xbwHEl7
 x4zHB2AGyfo3CF3mRBuhknW2Wkm+8tezrWxWoee6KNJcePvAdlNi34rWly6Pfe4185th/G
 dghHJV/JyPZns1RSBXMWLsp4U43JXYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792053533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNpbjqaukZ8PV3ESP9SFEFdZ8o9IZEpxvDaS69iGKJM=;
 b=hxWTiN0wWCXfGDgCqDmNkC0ZqmZOSqeNhq+5WYv5pydKq0yQuO4i4n/yS1ek6Oy2drSENn
 +6jqeGE/DmxU1QBQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=pRYmxBuU;
 dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=hxWTiN0w
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1792053533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNpbjqaukZ8PV3ESP9SFEFdZ8o9IZEpxvDaS69iGKJM=;
 b=pRYmxBuU6T8CBCKc4XPov5yjBDSwPWR46bM3KTnx0wTQn/+yRQqdaWEBnOjsJu/xbwHEl7
 x4zHB2AGyfo3CF3mRBuhknW2Wkm+8tezrWxWoee6KNJcePvAdlNi34rWly6Pfe4185th/G
 dghHJV/JyPZns1RSBXMWLsp4U43JXYk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1792053533;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=KNpbjqaukZ8PV3ESP9SFEFdZ8o9IZEpxvDaS69iGKJM=;
 b=hxWTiN0wWCXfGDgCqDmNkC0ZqmZOSqeNhq+5WYv5pydKq0yQuO4i4n/yS1ek6Oy2drSENn
 +6jqeGE/DmxU1QBQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2E47D132C9;
 Thu, 15 Oct 2026 08:38:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id l3BhAR2R0GqlGQAAD6G6ig
 (envelope-from <pvorel@suse.cz>); Thu, 15 Oct 2026 08:38:53 +0000
Date: Thu, 15 Oct 2026 10:38:51 +0200
From: Petr Vorel <pvorel@suse.cz>
To: Andrea Cervesato <andrea.cervesato@suse.com>
Message-ID: <20261015083851.GA290292@pevik>
References: <as9x2R-9IQb7vjn7@toolbx>
 <27AE9564-6115-491B-AE80-D9016EA7CDB5@suse.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <27AE9564-6115-491B-AE80-D9016EA7CDB5@suse.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.71 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_RHS_NOT_FQDN(0.50)[];
 HAS_REPLYTO(0.30)[pvorel@suse.cz];
 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DKIM_TRACE(0.00)[suse.cz:+]; RCPT_COUNT_FIVE(0.00)[5];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim]; MISSING_XM_UA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; REPLYTO_EQ_FROM(0.00)[]
X-Rspamd-Queue-Id: 7E7561F7D1
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Virus-Scanned: clamav-milter 1.0.9 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [Valgrind-developers] Suggested fix for the mremap03
 syscall testcase
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
Cc: valgrind-developers@lists.sourceforge.net, Mark Wielaard <mark@klomp.org>,
 Martin Cermak <mcermak@redhat.com>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTWFydGluLCBBbmRyZWEsIAoKPiBIaSBNYXJ0aW4sCgo+IHlvdSBhcmUgcmlnaHQuIFRoYXTi
gJlzIGEgYnVnIHdlIGRpZG7igJl0IHNwb3QgZHVyaW5nIHRoZSB0ZXN0IHJld3JpdGUuIFRoYW5r
cy4KCkdvb2QgY2F0Y2gsIE1hcnRpbiwgeW91J3JlIG9mIGNvdXJzZSByaWdodCA9PiB0dXJuZWQg
aW50byBwcm9wZXIgcGF0Y2ggYW5kCm1lcmdlZC4KCnZhbGdyaW5kIC4vbXJlbWFwMDMKdHN0X3Rl
c3QuYzoxODk1OiBUSU5GTzogT3ZlcmFsbCB0aW1lb3V0IHBlciBydW4gaXMgMGggMDBtIDMwcwot
LTI5Mjc5OS0tIFZBTEdSSU5EIElOVEVSTkFMIEVSUk9SOiBWYWxncmluZCByZWNlaXZlZCBhIHNp
Z25hbCAxMSAoU0lHU0VHVikgLSBleGl0aW5nCi0tMjkyNzk5LS0gc2lfY29kZT0xOyAgRmF1bHRp
bmcgYWRkcmVzczogMHg4OyAgc3A6IDB4MTAwMmVmMmNjMAoKdmFsZ3JpbmQ6IHRoZSAnaW1wb3Nz
aWJsZScgaGFwcGVuZWQ6CiAgIEtpbGxlZCBieSBmYXRhbCBzaWduYWwKCmhvc3Qgc3RhY2t0cmFj
ZToKPT0yOTI3OTk9PSAgICBhdCAweDU4MEFFM0QzOiA/Pz8gKGluIC91c3IvbGliZXhlYy92YWxn
cmluZC9tZW1jaGVjay1hbWQ2NC1saW51eCkKPT0yOTI3OTk9PSAgICBieSAweDU4MEE3RUQ5OiA/
Pz8gKGluIC91c3IvbGliZXhlYy92YWxncmluZC9tZW1jaGVjay1hbWQ2NC1saW51eCkKPT0yOTI3
OTk9PSAgICBieSAweDU4MEEzODdBOiA/Pz8gKGluIC91c3IvbGliZXhlYy92YWxncmluZC9tZW1j
aGVjay1hbWQ2NC1saW51eCkKPT0yOTI3OTk9PSAgICBieSAweDU4MEE1OEE2OiA/Pz8gKGluIC91
c3IvbGliZXhlYy92YWxncmluZC9tZW1jaGVjay1hbWQ2NC1saW51eCkKPT0yOTI3OTk9PSAgICBi
eSAweDU4MTE1MDg4OiA/Pz8gKGluIC91c3IvbGliZXhlYy92YWxncmluZC9tZW1jaGVjay1hbWQ2
NC1saW51eCkKCkJUVyB0ZXN0Y2FzZSBhZnRlciBmaXggc3RpbGwgZmFpbHMsIGJ1dCB0aGF0J3Mg
SSBzdXBwb3NlIGp1c3QgZXhwZWN0ZWQgdmFsZ3JpbmQKYmVoYXZpb3Igb24gbW1hcChQUk9UX05P
TkUpLCByaWdodD8KCnZhbGdyaW5kIC4vbXJlbWFwMDMKPT0yOTI5NDE9PSBNZW1jaGVjaywgYSBt
ZW1vcnkgZXJyb3IgZGV0ZWN0b3IKPT0yOTI5NDE9PSBDb3B5cmlnaHQgKEMpIDIwMDItMjAyNiwg
YW5kIEdOVSBHUEwnZCwgYnkgSnVsaWFuIFNld2FyZCBldCBhbC4KPT0yOTI5NDE9PSBVc2luZyBW
YWxncmluZC0zLjI3LjEgYW5kIExpYlZFWDsgcmVydW4gd2l0aCAtaCBmb3IgY29weXJpZ2h0IGlu
Zm8KPT0yOTI5NDE9PSBDb21tYW5kOiAuL21yZW1hcDAzCj09MjkyOTQxPT0KdHN0X3Rlc3QuYzoy
MDYxOiBUSU5GTzogTFRQIHZlcnNpb246IDIwMjYwOTMwLTIwLWdkNDk0YThlMWM5Ci4uLgp0c3Rf
dGVzdC5jOjE4OTU6IFRJTkZPOiBPdmVyYWxsIHRpbWVvdXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBz
Cm1yZW1hcDAzLmM6NDI6IFRGQUlMOiBtcmVtYXAoYmFkX2FkZHIsIG1lbXNpemUsIG5ld3NpemUs
IE1SRU1BUF9NQVlNT1ZFKSBleHBlY3RlZCBFRkFVTFQ6IEVJTlZBTCAoMjIpCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
