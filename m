Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22876C28B28
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 02:41:00 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 4D0AA3CA1F5
	for <ltp@archiver.kernel.org>; Mon, 10 Mar 2025 03:40:58 +0100 (CET)
Received: from in-3.smtp.seeweb.it (in-3.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id BB9913C93F9
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 03:40:42 +0100 (CET)
Authentication-Results: in-3.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.129.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-3.smtp.seeweb.it (Postfix) with ESMTPS id 8B40D1A001B9
 for <ltp@lists.linux.it>; Mon, 10 Mar 2025 03:40:39 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741574438;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7UB+slpVaMETe8L9xoIZDUlQwkYlh6yXG+gUd1PNf1w=;
 b=UurbUDRYooYiOJerlUSaBV/cqBUvmMaMeY/gGj3fORHNNjY7fJInTiWxzcy4gptjDwUKtl
 J05Bwu5mbgAlZrboQeuvsu2O6T1biIqw+y0SjYsfOR7kTaaTDiYB+hZmhbOovh+1rQCd4x
 i1izkgqd8whzG9w9NJsRdpbtzLm9XyQ=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-41-SiHdbicmOsCxNJknWJEDBg-1; Sun, 09 Mar 2025 22:40:36 -0400
X-MC-Unique: SiHdbicmOsCxNJknWJEDBg-1
X-Mimecast-MFC-AGG-ID: SiHdbicmOsCxNJknWJEDBg_1741574435
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-2ff53a4754aso10846504a91.2
 for <ltp@lists.linux.it>; Sun, 09 Mar 2025 19:40:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741574435; x=1742179235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7UB+slpVaMETe8L9xoIZDUlQwkYlh6yXG+gUd1PNf1w=;
 b=ub3z4fpnWrnSPCtFVZXI3L5NUjevE+pKGbZMdlpDT6ketmSA08qDXb0jmDhe6ff4PN
 7EFhvppyiOT42WsKaHvm379NGR4wJNON1LXLk1BKSBJvMXPagU96hquY3Sb6Sfg8F8OY
 Q+3C/hWtQteGkinvLsvywLcanf7GvJDpvFXk+bNulsqQ4ZtEx+vEZhMmB1zgS5yhNq4s
 FdcD8W7Bg3+Djoc3gz8nmjnX/W1/0kgLDnIWvLIPlkzK9U9HwdhJHPpFjnHRt0Wtgbc/
 9h70q/UhC1SsI/cePP31M8CK1r/QmIRbrf1LgVzfsJQTGlrZTnm1tSIeikp4OOke547g
 5LoQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrBsjG2yDJG/fd+P2ekHNLUG66VkB+xbfHD8vU0BggdewDVAeSDd8Ro86cHr0i75BLOjA=@lists.linux.it
X-Gm-Message-State: AOJu0YzlhGeA7wfMCLI0Xosht27kBIjs4Sv+GDYmGtsbrPy9FAJx4HPs
 VVonK3Y/xl1Q6Lz8OLGS1G85Mv8ttSe2fOs17cALGLlwv4eZXz6bBAHgwRvB1ClRRxP/dsestHD
 pceiCutczhOpOVgBSDwIb27VSIR72mSXXwHyfWwJ5uXjNY+U0S+ZYbC1Qud+/b71fnLXBqJqyzp
 iKkGbLoiw2bipBEytHP0XUfXc=
X-Gm-Gg: ASbGnctsZDdcnWNwNCAnHgZxPzGIT3ZTx6+3aA5+sGOnDxdcogGs4G9RVA6QSApGKlN
 ucC85NGewdIclsyIWWPIhjyDoi+Cq1nAyQqnKHTsn22rN2zqf3ZHB2BF3Bq7rjYvp1etLnCEKCA
 ==
X-Received: by 2002:a17:90b:164f:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2ff7ce596edmr18440504a91.6.1741574434924; 
 Sun, 09 Mar 2025 19:40:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKlqSgGw7LHvf2cdBkmQYKGxugfxr0HW8caSiSXSfU8xsJfQX7eSa0/x2a1u/mJLuzmzzgHAtdL8fAKoIloGE=
X-Received: by 2002:a17:90b:164f:b0:2ee:45fd:34f2 with SMTP id
 98e67ed59e1d1-2ff7ce596edmr18440484a91.6.1741574434543; Sun, 09 Mar 2025
 19:40:34 -0700 (PDT)
MIME-Version: 1.0
References: <20231027174322.710674-1-pvorel@suse.cz>
 <CAEemH2fuA+YfFGNzSResMprEeT8+zhO1S_2Kscc14d2T828YYw@mail.gmail.com>
 <20231030072819.GA9167@pevik>
 <CAEemH2eUQxxQAh-Ln_hyzu_C_AL36fXsjbKZJqC3rcHsASgQgQ@mail.gmail.com>
 <20231030142055.GA21733@pevik> <20250307234554.GA347736@pevik>
In-Reply-To: <20250307234554.GA347736@pevik>
From: Li Wang <liwang@redhat.com>
Date: Mon, 10 Mar 2025 10:40:22 +0800
X-Gm-Features: AQ5f1Jq3Ps3mN5Oi50lwlSFojPCsVe6Ati8-grRuxV8HeF3-lvsvz2j_t3Gdd6Q
Message-ID: <CAEemH2dRoh_NpQyXNbhKB999hGmNuca2WNr3rg23HpR598O65Q@mail.gmail.com>
To: Petr Vorel <pvorel@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: kbOQ2M11QzEhei6IJj1xqguz1ZOWwWMDKDAB3gORgvs_1741574435
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-3.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 1/1] compat_16.mk: Cleanup INTERMEDIATE object
 syntax
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
Cc: ltp@lists.linux.it,
 Stanislav Kholmanskikh <stanislav.kholmanskikh@bell-sw.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gU2F0LCBNYXIgOCwgMjAyNSBhdCA3OjQ24oCvQU0gUGV0ciBWb3JlbCA8cHZvcmVsQHN1c2Uu
Y3o+IHdyb3RlOgoKPiBIaSBMaSwKPgo+ID4gPiA+ID4gPiAtJV8xNjogQ1BQRkxBR1MgKz0gLUQk
KERFRl8xNik9MQo+Cj4gPiA+ID4gTm90IHJlbGF0ZWQgdG8gdGhpcyBlZmZvcnQ6IHNob3VsZG4n
dCB3ZSBjb252ZXJ0IGFsbCBDUFBGTEFHUyB0bwo+IENGTEFHUz8KPiA+ID4gPiBPciB0aGUKPiA+
ID4gPiBMVFAgYnVpbGQgc3lzdGVtIGl0IGp1c3QgcHJlcGFyZWQgdG8gdGhlIGNyYXp5IGlkZWFz
IGFib3V0IHVzaW5nCj4gQysrPyA6KQo+Cj4KPiA+ID4gTm8sIEkgZG9uJ3QgdGhpbmsgc28uIEkg
Z3Vlc3MgeW91IG1lbW9yaWVzIGl0IGNvbmZ1c2VkIHdpdGggQ1hYRkxBR1MKPiA6KS4KPgo+ID4g
PiBGWUk6Cj4KPiA+ID4gQ1BQRkxBR1MgKEMgUHJlUHJvY2Vzc29yIEZsYWdzKSBhcmUgb3B0aW9u
cyBmb3IgdGhlIEMgcHJlcHJvY2Vzc29yLAo+ID4gPiB3aGljaCBpcyB0aGUgZmlyc3Qgc3RhZ2Ug
b2YgY29tcGlsYXRpb24gd2hlcmUgbWFjcm8gc3Vic3RpdHV0aW9uCj4gb2NjdXJzLAo+ID4gPiBh
bmQgY29uZGl0aW9uYWwgY29tcGlsYXRpb24gZGlyZWN0aXZlcyBhcmUgcHJvY2Vzc2VkLiBUaGVz
ZSBmbGFncyBhcmUKPiBvZnRlbgo+ID4gPiB1c2VkIHRvIHNwZWNpZnkgYWRkaXRpb25hbCBpbmNs
dWRlIGRpcmVjdG9yaWVzLgo+ID4gPiAgICAgZS5nLiBDUFBGTEFHUz0iLUkvc29tZS9pbmNsdWRl
L3BhdGgiCj4KPiA+ID4gQ0ZMQUdTIChDIENvbXBpbGVyIEZsYWdzKSBhcmUgb3B0aW9ucyBmb3Ig
dGhlIEMgY29tcGlsZXIuIFRoZXNlCj4gPiA+IGZsYWdzIGFyZSBvZnRlbiB1c2VkIHRvIHNwZWNp
ZnkgdmFyaW91cyBjb21waWxlciBzZXR0aW5ncywgc3VjaCBhcwo+ID4gPiBvcHRpbWl6YXRpb24g
bGV2ZWwsIHdhcm5pbmdzIGxldmVsLCBhbmQgZGVidWdnaW5nIGluZm9ybWF0aW9uLgo+ID4gPiAg
ICAgZS5nLiAgQ0ZMQUdTPSItTzIgLWcgLVdhbGwiCj4KPiA+ID4gQ1hYRkxBR1MgKEMrKyBDb21w
aWxlciBGbGFncykgYXJlIG9wdGlvbnMgZm9yIHRoZSBDKysgY29tcGlsZXIuCj4gPiA+IEl0IGNh
biBiZSB1c2VkIHRvIGRlZmluZSBvcHRpb25zIGxpa2Ugb3B0aW1pemF0aW9uIGxldmVscywgZGVi
dWdnaW5nCj4gPiA+IGluZm9ybWF0aW9uLCB3YXJuaW5nIGxldmVscywgYW5kIG1vcmUuCj4gPiA+
ICAgICBlLmcuICBDWFhGTEFHUz0iLU8yIC1nIC1XYWxsIgo+Cj4gPiBBaCwgeW91J3JlIHJpZ2h0
LiBUaGFua3MhCj4KPiA+ID4gPiA+IFNlZW1zIHdlIG5lZWQgdG8ga2VlcCB0aGlzIG9uZSBsaW5l
LCBvdGhlcndpc2UgaXQgY2FuJ3QgdHJhbnNmZXIKPiB0aGUKPiA+ID4gPiA+ICdUU1RfVVNFX0NP
TVBBVDE2X1NZU0NBTEw9MScgbWFjcm8gaW4gdGhlIGNvbXBpbGF0aW9uLgo+Cj4gPiA+ID4gQWgs
IHRoYW5rcyEKPgo+ID4gPiA+ID4gVGhlIHJlc3QgbG9va3MgZ29vZCB0byBtZS4KPiA+ID4gPiA+
IFJldmlld2VkLWJ5OiBMaSBXYW5nIDxsaXdhbmdAcmVkaGF0LmNvbT4KPgo+ID4gPiA+IEJUVyBJ
J20gZ29pbmcgdG8gcHVzaCBpdCB3aXRoIHlvdSBhcyBhbiBhdXRob3IgKyB3aXRoIHlvdXIKPiBT
aWduZWQtb2ZmLWJ5Ogo+ID4gPiA+IHRhZwo+ID4gPiA+ICh5b3UncmUgZWZmZWN0aXZlbHkgdGhl
IGF1dG9yIG9mIHRoZSBjb2RlKSBhbmQgd2l0aCBteSBSQlQuCj4KPgo+ID4gPiBTdXJlLCB0aGFu
a3MgZm9yIGRvaW5nIHRoaXMgZm9yIG1lLgo+Cj4gPiBZdy4KPgo+IEZpbmFsbHkgbWVyZ2VkIDop
Lgo+IChPYnZpb3VzbHkgSSBmb3Jnb3QgdG8gbWVyZ2UgYmFjayB0aGVuIGFsdGhvdWdoIEkgc2V0
IHRoaXMgaW4gcGF0Y2h3b3JrIGFzCj4gYWNjZXB0ZWQuKQo+CgpXZWxsLCB0aGFua3MhISBJJ20g
d29uZGVyaW5nIGhvdyB5b3UgZmluZCB0aGlzIG9uZSBiZWluZyBtaXNzZWQsIGl0J3MgYmVlbgpz
byBsb25nOikuCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzog
aHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
