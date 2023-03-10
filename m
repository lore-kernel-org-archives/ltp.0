Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9043C64EC4
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 11:43:06 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 647193CD818
	for <ltp@archiver.kernel.org>; Fri, 10 Mar 2023 12:43:03 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id C2C263C2A67
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 12:42:53 +0100 (CET)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id C45021A011D9
 for <ltp@lists.linux.it>; Fri, 10 Mar 2023 12:42:52 +0100 (CET)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E962B21D22;
 Fri, 10 Mar 2023 11:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1678448571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWUREeiforPR2CMuGQCyt8tj/0QVdtUYGpVg6DZtsDI=;
 b=fHKniJpe2HCJDIpKkl9axH02yarDYEa5+R7K8Hw81sg6OG2CrqXkVexUAh3nJJgCzZP2Fa
 T/mqATiZAxlhv7v+AmFX8HEmBdv9V6WUWOgxVOc1C8lqBtdi7ft4K+q53vZsoirWfnDSr7
 mstfhufPFsPnVmXhBEZ1Dz91TS9TRz0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1678448571;
 h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
 cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LWUREeiforPR2CMuGQCyt8tj/0QVdtUYGpVg6DZtsDI=;
 b=DZzBBqY0TVQiMdYZyJxrV38B6aeyvYyjFiktCyKKClXuH/Lz1WYaGKlSlJ3hnVaEmd4qRr
 dj78DTNAIYGSdyDQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A2F4B134F7;
 Fri, 10 Mar 2023 11:42:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id LtOJJbsXC2SABQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Fri, 10 Mar 2023 11:42:51 +0000
Date: Fri, 10 Mar 2023 12:42:49 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Li Wang <liwang@redhat.com>
Message-ID: <20230310114249.GB22294@pevik>
References: <20230226192554.669332-1-fontaine.fabrice@gmail.com>
 <Y/yTyk9rYYsPJyVA@yuki>
 <CAEemH2fLFYu8=ZRBbu0xgmfYh4=XHJSu07R+4=-qX_1ESVza0w@mail.gmail.com>
 <20230310093117.GA8713@pevik>
 <CAEemH2eBqt1_ZTY3GCRfgx4EQdWiJJepA_wVGpSg6=pYubHddw@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAEemH2eBqt1_ZTY3GCRfgx4EQdWiJJepA_wVGpSg6=pYubHddw@mail.gmail.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] configure.ac: fix mount_attr detection
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
Cc: ltp@lists.linux.it, Fabrice Fontaine <fontaine.fabrice@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkgTGksCgo+IE9uIEZyaSwgTWFyIDEwLCAyMDIzIGF0IDU6MzHigK9QTSBQZXRyIFZvcmVsIDxw
dm9yZWxAc3VzZS5jej4gd3JvdGU6Cgo+ID4gSGkgYWxsLAoKPiA+IC4uLgo+ID4gPiA+IEkgd29u
ZGVyIGlmIHdlIGNhbiBnZXQgdGhpcyB3aG9sZSBtZXNzIG9mIHR3byBkaWZmZXJlbnQgZmFsbGJh
Y2sKPiA+IGhlYWRlcnMKPiA+ID4gPiBzaW1wbGlmaWVkLiBMb29raW5nIGF0IHRoZSBnbGliYyBp
bXBsZW1lbnRhdGlvbiBpdCBzZWVtcyB0byBpbmNsdWRlCj4gPiA+ID4gImxpbnV4L21vdW50Lmgi
IGlmIGl0IGRvZXMgZXhpc3QuIFNvIG1vc3QgcmVhc29uYWJsZSBzb2x1dGlvbiB3b3VsZCBkbwo+
ID4gPiA+IHRoZSBzYW1lIEkgZ3Vlc3Mgd2hpY2ggd2UgZGlkIGJlZm9yZSB0aGUgY29tbWl0IHlv
dSByZWZlcmVuY2UuCgoKPiA+ID4gVGhpcyBpcyBpbmRlZWQgY29ycmVjdCBpZiBvbmx5IGZhY2Ug
dGhlIGxhdGVzdCBHbGliYywgYnV0IHRoYXQgbWlnaHQgaGF2ZQo+ID4gPiBwcm9ibGVtcyB3aGVu
IGJ1aWxkaW5nIExUUCBvbiBhIG1pZGRsZSB2ZXJzaW9uIG9mIEdsaWJjL0tlcm5lbC1oZWFkZXJz
Lgo+ID4gPiBUaGUgYnVnIEkgbWVudGlvbmVkIGluIHRoZSBsYXN0IGVtYWlsIHdhcyBmaXhlZCBz
aW5jZSBnbGliYy0yLjM3fjQyNi4KPiA+IERvIHlvdSBrbm93IHdoaWNoIGV4YWN0IGNvbW1pdCBo
YXMgZml4ZWQgaXQ/IEl0J2QgaGVscCB1cyB0byByZWFsaXplIHdoZW4KPiA+IHRoaXMKPiA+IGZp
eCBpcyBub3QgbmVlZGVkIGFueSBtb3JlIChpdCdkIGJlIGdvb2QgdG8gcHV0IGl0IGludG8gdGhl
IGNvbW1pdAo+ID4gbWVzc2FnZSkuCgoKPiBJIG1lYW4gdGhpcyBjb21taXQ6Cj4gaHR0cHM6Ly9n
aXRodWIuY29tL2tyYWovZ2xpYmMvY29tbWl0Lzc3NDA1OGQ3Mjk0MjI0OWY3MWQ3NGU3ZjJiNjM5
Zjc3MTg0MTYwYTYKClRoYW5rcyBmb3IgaW5mby4gRml4IGZyb20gMi4zNywgaXQgd2FzIGFsc28g
Y2hlcnJ5IHBpY2tlZCB0byByZWxlYXNlLzIuMzYvbWFzdGVyCmJyYW5jaCwgYnV0IG5vdCB0byBi
cmFuY2hlcyBmb3Igb2xkZXIgcmVsZWFzZXMgKDIuMzUgYW5kIDIuMzQpLgoKSSBzdXBwb3NlIHRo
ZXJlIHdpbGwgYmUgYWx3YXlzIHNvbWUgdG9vbGNoYWluL2Rpc3RybyB3aXRoIG9sZGVyIGdsaWJj
IHdpdGhvdXQKdGhpcyBmaXgsIHRodXMgSSdkIG1lcmdlIGl0IG5vdywgYW5kIG1hZGUgc2ltcGxp
ZmljYXRpb24gQ3lyaWwgc3VnZ2VzdGVkCnNvbWV0aW1lcyBuZXh0IHllYXIuCgpLaW5kIHJlZ2Fy
ZHMsClBldHIKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9s
aXN0aW5mby9sdHAK
