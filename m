Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45ABC6FA8B
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 08:14:55 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 6FD3A3CAD4C
	for <ltp@archiver.kernel.org>; Thu, 22 Sep 2022 10:14:52 +0200 (CEST)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id CC15D3C93EF
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 10:14:42 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id D9E051A01468
 for <ltp@lists.linux.it>; Thu, 22 Sep 2022 10:14:41 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6388D2199B;
 Thu, 22 Sep 2022 08:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1663834479; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmA4hBUoNQYnsBUKrftK9/+tDshBw7Z3FPxeRljnBRI=;
 b=q5YmYp//jLVxd+BAAsjeG5KPnYWCkDAbePzZifZXg44ng4jvh/Npbtzf1TtiG676/8tcqy
 JBu+23qZvtJArQDg76WthAgsxQL3XJNLKI5n6/6TvozSGl0/K77zTH1uOvIvavtkxdpKeq
 QJBBk4fVn30ykpBQ3u67akHv2n15zwI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1663834479;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QmA4hBUoNQYnsBUKrftK9/+tDshBw7Z3FPxeRljnBRI=;
 b=OJzt4H8ZoymJ1Vev8QIvi0p5wHzwSX2af7O35r3ZT22NnX6ghD1oTLdFkYgMC9HsC+1tZ2
 qenh6fuYgU8Xg4BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4A7AF13AA5;
 Thu, 22 Sep 2022 08:14:39 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id p5MdEW8ZLGMRXQAAMHmgww
 (envelope-from <mdoucha@suse.cz>); Thu, 22 Sep 2022 08:14:39 +0000
Message-ID: <b1a19673-de0b-d6e0-0434-3eb457aaf69d@suse.cz>
Date: Thu, 22 Sep 2022 10:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Content-Language: en-US
To: Li Wang <liwang@redhat.com>
References: <20220921155006.13360-1-mdoucha@suse.cz>
 <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
From: Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <CAEemH2eoxjDha9Ldu9shqO6MUUFfvT3dkFExAHGyH-38E5drVg@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] tst_supported_fs: Implement checking paths
 against skiplist
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
Cc: LTP List <ltp@lists.linux.it>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gMjIuIDA5LiAyMiA2OjE2LCBMaSBXYW5nIHdyb3RlOgo+ICAgICAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgaWYgKHNraXBsaXN0KSB7Cj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoGlmICh0c3RfZnNfaW5fc2tpcGxpc3QoYXJndltvcHRpbmRdLCAoY29uc3QgY2hh
ciAqIGNvbnN0Kilza2lwbGlzdCkpCj4gICAgIC3CoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoHRzdF9icmsoVENPTkYsICIlcyBpcyBza2lwcGVkIiwgYXJndltv
cHRpbmRdKTsKPiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaWYgKHRz
dF9mc19pbl9za2lwbGlzdChmc25hbWUsIChjb25zdCBjaGFyICogY29uc3QqKXNraXBsaXN0KSkK
PiAgICAgK8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdHN0
X2JyayhUQ09ORiwgIiVzIGlzIHNraXBwZWQiLCBmc25hbWUpOwo+IAo+IAo+IFRDT05GIGRvZXMg
bm90IG1lYW5zIHJldHVybiAxLCB3ZSBtaWdodCBuZWVkIGV4cGxpY2l0bHkgJ3JldHVybiAxJyBo
ZXJlLgoKWWVzLCBidXQgdGhhdCdzIGEgcHJvYmxlbSB3aGljaCBhbHJlYWR5IGV4aXN0ZWQgYmVm
b3JlIG15IHBhdGNoIGFuZCAKYWZmZWN0cyB0aGUgb3RoZXIgc2luZ2xlLUZTIGNoZWNrcyBhcyB3
ZWxsLiBUaGUgZml4IHNob3VsZCBnbyBpbnRvIGEgCnNlcGFyYXRlIHBhdGNoIGFmdGVyIHJlbGVh
c2UuCgotLSAKTWFydGluIERvdWNoYSAgIG1kb3VjaGFAc3VzZS5jegpRQSBFbmdpbmVlciBmb3Ig
U29mdHdhcmUgTWFpbnRlbmFuY2UKU1VTRSBMSU5VWCwgcy5yLm8uCkNPUlNPIElJYQpLcml6aWtv
dmEgMTQ4LzM0CjE4NiAwMCBQcmFndWUgOApDemVjaCBSZXB1YmxpYwoKCi0tIApNYWlsaW5nIGxp
c3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
