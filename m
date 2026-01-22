Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D65CD62613
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 10:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lists.linux.it;
 i=@lists.linux.it; q=dns/txt; s=picard; t=1769078536; h=mime-version :
 references : in-reply-to : date : message-id : to : subject : list-id
 : list-unsubscribe : list-archive : list-post : list-help :
 list-subscribe : from : reply-to : cc : content-type :
 content-transfer-encoding : sender : from;
 bh=oMzoDKOIewgdHd4Afv5y1Z8QZbsoDjWWyUIubBku8AM=;
 b=ouSUtgEqV4bp6s1e0yhP9em1qeNgCiwwOB9KiQUtnty3ncEIbDlmAsUjCQdaq9Yma9ME8
 Y/RWbXpJE8n9BH+8Q63xW4/PgpHJi0Bjd4c7NDT1hwhtnLgu6a1xfRgaPCy5lVo39gwl883
 vcsra+hYV1+haesgbf5h4cIspgg7+Qg=
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id B8E273CB33C
	for <ltp@archiver.kernel.org>; Thu, 22 Jan 2026 11:42:16 +0100 (CET)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 958F43C1428
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 11:41:52 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id AF844600A51
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 11:41:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769078506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eo54tp1khh5r3WPv/DgnMuxd78ytYIP5WycmTA4oMwU=;
 b=BL2IgCNAgOI/NR/rYh7d0bLqN67sr8siPlDjDoCLLLdXY6tRTjZw6PAHMuI5jKQWa9meW+
 5arCBiuTfHBmeuLASb08vnNB7vfGV+O7yUeVPlij63vIlPSST6PA7HspzhbFGIy1u6zXwk
 9mt913sOM3c+ws0wPIxVVwomC8jc3BA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-1HMawQueO-Kn7qnK4tuB7A-1; Thu, 22 Jan 2026 05:41:45 -0500
X-MC-Unique: 1HMawQueO-Kn7qnK4tuB7A-1
X-Mimecast-MFC-AGG-ID: 1HMawQueO-Kn7qnK4tuB7A_1769078504
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-42fdbba545fso1780060f8f.0
 for <ltp@lists.linux.it>; Thu, 22 Jan 2026 02:41:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769078504; x=1769683304;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Eo54tp1khh5r3WPv/DgnMuxd78ytYIP5WycmTA4oMwU=;
 b=ux7FrW9KGvoEjYGZIfoPGtAYmrHKLmdAwximMnC+0qMzSU2LJri0Cizaobed8CJcp8
 /Vo8knNs6O2JoiCyYs4C6++n+EGQtZ1qzcMAnmZFKuiztuglVskwH+NE56FcUby3Nw9B
 VUxfaJ2HY/uClIbbiooiLuD/+OVKUvaI069Av1RXhxZjvZCsC0I5qEJNwJ8vlQXoLiDc
 1ZPIJbcoOFoDoChf/qGKXQC4olvqrCRbECo0FmtNPpNPNZHfGXppBefMKm5OmpGOIlFg
 3moWxd0kXzHO9ZcsHZVjUVjIEvPBbqMzrqJS4EWy81kyEMTaFB2CGjTi+FSLOIGNnYYS
 8seA==
X-Gm-Message-State: AOJu0Yz6cz8043CQze85YeCUz6af4RbE6d9nq19/pHa3aqOQU0MlhRl+
 rsQN5j6UvoFGnFnh5VMwoIG3KKG91S/9w+KApHqBkhDQgE2CCOJBcwc2VjZModGCfrMv8/UmFb8
 oKEKGTsQeS6tll7zNwdHW1gEVlcQRFhtKFosJhuIUAGHHDXSJu3DPKmVvxMtX7YWD4xVx63V6+t
 dFpJ4qeLocKlYGT7UVLENHsv7yy8w=
X-Gm-Gg: AZuq6aL5YMSuqb3eG3KdHD+WfxIl5tjB1YycIT5aqh3Bm5RzBdV4uojoRJxbfdnAVdJ
 aVMUBDYoTQOR42OkH5I9pbLv4gVKzKWsGTwQckglw2l1BKQZDX86UGsG1IkKFYLo8bjGUACnAA4
 QoePyO6FRNRXQmQA/EYWxfRRNxHyelLTiHnveIho/VznYAKThpBbh0qldUkNiJy+nFbA==
X-Received: by 2002:a5d:588d:0:b0:431:c06:bc82 with SMTP id
 ffacd0b85a97d-435a5f6ea76mr5063255f8f.12.1769078503889; 
 Thu, 22 Jan 2026 02:41:43 -0800 (PST)
X-Received: by 2002:a5d:588d:0:b0:431:c06:bc82 with SMTP id
 ffacd0b85a97d-435a5f6ea76mr5063218f8f.12.1769078503440; Thu, 22 Jan 2026
 02:41:43 -0800 (PST)
MIME-Version: 1.0
References: <20260121090159.32686-1-liwang@redhat.com>
In-Reply-To: <20260121090159.32686-1-liwang@redhat.com>
Date: Thu, 22 Jan 2026 11:41:26 +0100
X-Gm-Features: AZwV_QjGTea4yNVDAPXYLyHSbnU-08hLQFCYJkAB_ZcQdIYFg_T4Fu5goRxGtrA
Message-ID: <CAASaF6xzdnBpn0M7q9+jp_3Hyb+gOG71S+eKQbP8YpNwKgNyNA@mail.gmail.com>
To: Li Wang <liwang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: _Dr0obAqybjFqimxibjJ1JPJlG2bH5p_QY6VO-0idls_1769078504
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] lapi/tls: remove the TLS support from i386
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
From: Jan Stancek via ltp <ltp@lists.linux.it>
Reply-To: Jan Stancek <jstancek@redhat.com>
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gV2VkLCBKYW4gMjEsIDIwMjYgYXQgMTA6MDLigK9BTSBMaSBXYW5nIHZpYSBsdHAgPGx0cEBs
aXN0cy5saW51eC5pdD4gd3JvdGU6Cj4KPiBVc2luZyBhIExUUCBuYWtlZCBjbG9uZSgpIHRvIHZl
cmlmeSB0aGF0IENMT05FX1NFVFRMUyBpcyB1bnJlbGlhYmxlCj4gd2hlbiBydW5uaW5nIDMyLWJp
dCBvbiB4ODZfNjQsIHNpbmNlIFRMUyByZXF1aXJlcyB0d28gc3RlcHM6IHdyaXRpbmcKPiB0aGUg
ZGVzY3JpcHRvciBhbmQgc3dpdGNoaW5nIHRoZSBzZWxlY3Rvci4gQnV0IENMT05FX1NFVFRMUyBv
biBpMzg2Cj4gb25seSBvdmVycmlkZXMgdGhlIGZvcm1lcjoKPgo+ICBrZXJuZWxfY2xvbmUoKQo+
ICAgICBjb3B5X3Byb2Nlc3MoKQo+ICAgICAgICBjb3B5X3RocmVhZCgpCj4gICAgICAgICAgIHNl
dF9uZXdfdGxzKCkKPiAgICAgICAgICAgICAgZG9fc2V0X3RocmVhZF9hcmVhKCkKPgo+IEluIGNv
cHlfdGhyZWFkKCksIHRoZSBjaGlsZCdzIHJlZ2lzdGVyIGZyYW1lIGlzIGNvcGllZCBmcm9tIHRo
ZSBwYXJlbnQKPiAqY2hpbGRyZWdzID0gKmN1cnJlbnRfcHRfcmVncygpOyBhbmQgb24gdGhlIDMy
LWJpdCBzaWRlIGl0IGFsc28gZG9lcwo+IHNhdmVzZWdtZW50KGdzLCBwLT50aHJlYWQuZ3MpOyBz
YXZpbmcgdGhlIGN1cnJlbnQgJWdzIGludG8gdGhyZWFkX3N0cnVjdC4KPgo+IFRvZ2V0aGVyLCB0
aGlzIG1lYW5zIHRoYXQgdW5sZXNzIHNvbWV0aGluZyBleHBsaWNpdGx5IG92ZXJ3cml0ZXMgaXQg
bGF0ZXIsCj4gdGhlIGNoaWxkJ3MgaW5pdGlhbCAlZ3Mgc2VsZWN0b3IgaXMgaW5oZXJpdGVkIGZy
b20gdGhlIHBhcmVudC4KPgo+ICAgaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYu
MTgvc291cmNlL2FyY2gveDg2L2tlcm5lbC9wcm9jZXNzLmMjTDI0Mwo+Cj4gVGhlbiwgaW4gZG9f
c2V0X3RocmVhZF9hcmVhKCksIHRoZSBrZXJuZWwgdXBkYXRlcyB0aGUgVExTIGRlc2NyaXB0b3IK
PiBzZXRfdGxzX2Rlc2MocCwgaWR4LCAmaW5mbywgMSk7IEhvd2V2ZXIsIHdoZW4gKHAgIT0gY3Vy
cmVudCksIHRoZSB4ODZfMzIgcGF0aAo+IGRvZXMgbm90IHVwZGF0ZSBvciByZWZyZXNoIGFueSBz
ZWdtZW50IHNlbGVjdG9yLiBTbyBpdCB1cGRhdGVzIHRoZSBkZXNjcmlwdG9yCj4gYnV0IGRvZXMg
bm90IHN3aXRjaCB0aGUgY2hpbGQncyAlZ3Mgc2VsZWN0b3IgdG8gdGhlIG5ldyBtb2RpZmllZF9z
ZWwuCj4KPiAgIGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L3Y2LjE4L3NvdXJjZS9h
cmNoL3g4Ni9rZXJuZWwvdGxzLmMjTDE1MAo+Cj4gVGhlcmVmb3JlLCBvbiBpMzg2LCByZWx5aW5n
IG9uIENMT05FX1NFVFRMUyBhbG9uZSBjYW4gbGVhdmUgdGhlIGNoaWxkCj4gZXhlY3V0aW5nIHdp
dGggdGhlIHBhcmVudCdzICVncyBzZWxlY3Rvciwgc28gVExTIGFjY2Vzc2VzIHN0aWxsIHJlc29s
dmUKPiB0byB0aGUgb2xkIFRMUyBiYXNlLgo+Cj4gPT09PT09PT09PT09PT09Cj4KPiBUaGUgYmVo
YXZpb3IgYWJvdmUgZXhwbGFpbnMgd2h5IGNsb25lMTAgZmFpbHMgZXZlbiBpZiB3ZSB1cGRhdGUg
dGhlIFRMUwo+IGRlc2NyaXB0b3IgYmFzZSAoZWl0aGVyIGhhcmQtY29kaW5nIG9yIHZpYSBzZXRf
dGhyZWFkX2FyZWEoKSkuCj4KPiBFeGFtcGxlICh4ODZfNjQga2VybmVsIHJ1bm5pbmcgYSAzMi1i
aXQgRUxGKToKPgo+ICAgIyB1bmFtZSAtcm0KPiAgIDYuMTkuMC1yYzIubGl3YW5nIHg4Nl82NAo+
Cj4gICAjIHJlYWRlbGYgLWggY2xvbmUxMCB8Z3JlcCBDbGFzcwo+ICAgQ2xhc3M6ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBFTEYzMgo+Cj4gICAjIC4vY2xvbmUxMAo+ICAgLi4uCj4gICBj
bG9uZTEwLmM6NDg6IFRJTkZPOiBDaGlsZCAoUElEOiA1MjYyLCBUSUQ6IDUyNjMpOiBUTFMgdmFs
dWUgc2V0IHRvOiAxMDEKPiAgIGNsb25lMTAuYzo3MjogVEZBSUw6IFBhcmVudCAoUElEOiA1MjYy
LCBUSUQ6IDUyNjIpOiBUTFMgdmFsdWUgbWlzbWF0Y2g6IGdvdCAxMDEsIGV4cGVjdGVkIDEwMAo+
Cj4gUmVwb3J0ZWQtYnk6IFdlaSBHYW8gPHdlZ2FvQHN1c2UuY29tPgo+IFNpZ25lZC1vZmYtYnk6
IExpIFdhbmcgPGxpd2FuZ0ByZWRoYXQuY29tPgoKQWNrZWQtYnk6IEphbiBTdGFuY2VrIDxqc3Rh
bmNla0ByZWRoYXQuY29tPgoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
