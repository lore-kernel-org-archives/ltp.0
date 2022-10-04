Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B271C433FE
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 12:07:11 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2300F3CA47E
	for <ltp@archiver.kernel.org>; Tue,  4 Oct 2022 14:07:09 +0200 (CEST)
Received: from in-7.smtp.seeweb.it (in-7.smtp.seeweb.it
 [IPv6:2001:4b78:1:20::7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 0856F3C80B3
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 14:06:58 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-7.smtp.seeweb.it (Postfix) with ESMTPS id 4A14520007A
 for <ltp@lists.linux.it>; Tue,  4 Oct 2022 14:06:57 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 503C2218E9;
 Tue,  4 Oct 2022 12:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1664885217; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vm0kt+Rh3+ir+NYsA0gQB6onv0BzxIzUmyqFOMx2RBU=;
 b=qSqagbCKkhyG3A7Xn6hH4PSjpoCw175SQh8t69zAXMxUfJAhLK4HzVOpCHg2ryWeJEZQ2d
 ll3zyWE3YGE/Zg6PtF27/u5hMP5F3Efg5721tWtnuNa0saysq/4lG7HnslOBkHBHJFD3cY
 C8QfHIiPJ8scBwPtTCEQujObzN0u5Ms=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1664885217;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Vm0kt+Rh3+ir+NYsA0gQB6onv0BzxIzUmyqFOMx2RBU=;
 b=2IFoY9uW8juH17fHQn6PZZ14QIEZl//SOqXgmhGr2WbtxtQy3PFaBVNPfCAzRDEyKmPJbl
 PCuP7phrugMtfgAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 2C3BD139EF;
 Tue,  4 Oct 2022 12:06:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id wRMzCeEhPGPLNQAAMHmgww
 (envelope-from <pvorel@suse.cz>); Tue, 04 Oct 2022 12:06:57 +0000
From: Petr Vorel <pvorel@suse.cz>
To: ltp@lists.linux.it
Date: Tue,  4 Oct 2022 14:06:53 +0200
Message-Id: <20221004120653.23237-1-pvorel@suse.cz>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.102.4 at in-7.smtp.seeweb.it
X-Virus-Status: Clean
Subject: [LTP] [PATCH 1/1] doc: LTP C And Shell Test API Comparison
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

RGVsaWJlcmF0ZWx5IHB1dCBuZGFzaCAo4oCTKSBpbnN0ZWFkIG9mIFRPRE8gb24gbWlzc2luZyBm
ZWF0dXJlcywKYmVjYXVzZSBub3QgZXZlcnl0aGluZyBuZWVkcyB0byBiZSBpbXBsZW1lbnRlZC4K
ClNpZ25lZC1vZmYtYnk6IFBldHIgVm9yZWwgPHB2b3JlbEBzdXNlLmN6PgotLS0KRG8geW91IGNv
bnNpZGVyIHRoaXMgdXNlZnVsPwpJZiB5ZXMsIHNob3VsZCB0aGVyZSBiZSBsaW5rcyB0byB0aGUg
ZG9jIHNlY3Rpb24/CgpLaW5kIHJlZ2FyZHMsClBldHIKCiBkb2MvdGVzdC13cml0aW5nLWd1aWRl
bGluZXMudHh0IHwgNjQgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAxIGZpbGUg
Y2hhbmdlZCwgNjQgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL2RvYy90ZXN0LXdyaXRpbmct
Z3VpZGVsaW5lcy50eHQgYi9kb2MvdGVzdC13cml0aW5nLWd1aWRlbGluZXMudHh0CmluZGV4IDQy
MGFlOWM0My4uNzA0M2MzOTAyIDEwMDY0NAotLS0gYS9kb2MvdGVzdC13cml0aW5nLWd1aWRlbGlu
ZXMudHh0CisrKyBiL2RvYy90ZXN0LXdyaXRpbmctZ3VpZGVsaW5lcy50eHQKQEAgLTM0NCwzICsz
NDQsNjcgQEAgb2YgdGhlIHN0YWJsZSBrZXJuZWwgQUJJIHRoZSBhc3NvY2lhdGVkIHRlc3QgbXVz
dCBiZSBtb3ZlZCBvdXQgb2Ygc3RhZ2luZy4KIAogVGhpcyBpcyBwcmltYXJpbHkgdG8gaGVscCB0
ZXN0IGtlcm5lbCBSQ3MgYnkgYXZvaWRpbmcgdGhlIG5lZWQgdG8gZG93bmxvYWQKIHNlcGFyYXRl
IExUUCBwYXRjaHNldHMuCisKKzggTFRQIEMgQW5kIFNoZWxsIFRlc3QgQVBJIENvbXBhcmlzb24K
Ky0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KKworQ29tcGFyaXNvbiBvZgor
aHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9sdHAvd2lraS9DLVRlc3QtQVBJ
W0MgVGVzdCBBUEldIGFuZAoraHR0cHM6Ly9naXRodWIuY29tL2xpbnV4LXRlc3QtcHJvamVjdC9s
dHAvd2lraS9TaGVsbC1UZXN0LUFQSVtTaGVsbCBUZXN0IEFQSV0uCisKK1tvcHRpb25zPSJoZWFk
ZXIiXQorfD09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cit8ICBDIEFQSSAoJ3N0cnVjdCB0c3RfdGVz
dCcgbWVtYmVycykgfCBzaGVsbCBBUEkgKCckVFNUXyonIGVudmlyb25tZW50IHZhcmlhYmxlcykK
K3wgJy5hbGxfZmlsZXN5c3RlbXMnIHwgJ1RTVF9BTExfRklMRVNZU1RFTVMnCit8ICcuYnVmcycg
fCDigJMKK3wgJy5jYXBzJyB8IOKAkworfCAnLmNoaWxkX25lZWRzX3JlaW5pdCcgfCBub3QgYXBw
bGljYWJsZQorfCAnLmNsZWFudXAnIHwgJ1RTVF9DTEVBTlVQJworfCAnLmRldl9leHRyYV9vcHRz
JyB8ICdUU1RfREVWX0VYVFJBX09QVFMnCit8ICcuZGV2X2ZzX29wdHMnIHwgJ1RTVF9ERVZfRlNf
T1BUUycKK3wgJy5kZXZfZnNfdHlwZScgfCAnVFNUX0ZTX1RZUEUnCit8ICcuZGV2X21pbl9zaXpl
JyB8IG5vdCBhcHBsaWNhYmxlCit8ICcuZm9ybWF0X2RldmljZScgfCAnVFNUX0ZPUk1BVF9ERVZJ
Q0UnCit8ICcubWF4X3J1bnRpbWUnIHwg4oCTCit8ICcubWluX2NwdXMnIHwgbm90IGFwcGxpY2Fi
bGUKK3wgJy5taW5fa3ZlcicgfCAnVFNUX01JTl9LVkVSJworfCAnLm1pbl9tZW1fYXZhaWwnIHwg
bm90IGFwcGxpY2FibGUKK3wgJy5tbnRfZmxhZ3MnIHwgJ1RTVF9NTlRfUEFSQU1TJworfCAnLm1u
dHBvaW50JywgJy5tbnRfZGF0YScgfCAnVFNUX01OVFBPSU5UJworfCAnLm1vdW50X2RldmljZScg
fCAnVFNUX01PVU5UX0RFVklDRScKK3wgJy5uZWVkc19jZ3JvdXBfY3RybHMnIHwg4oCTCit8ICcu
bmVlZHNfY2hlY2twb2ludHMnIHwgJ05FRURTX0NIRUNLUE9JTlRTJworfCAnLm5lZWRzX2NtZHMn
IHwgJ1RTVF9ORUVEU19DTURTJworfCAnLm5lZWRzX2RldmZzJyB8IOKAkworfCAnLm5lZWRzX2Rl
dmljZScgfCAnVFNUX05FRURTX0RFVklDRScKK3wgJy5uZWVkc19kcml2ZXJzJyB8ICdUU1RfTkVF
RFNfRFJJVkVSUycKK3wgJy5uZWVkc19rY29uZmlncycgfCAnVFNUX05FRURTX0tDT05GSUdTJwor
fCAnLm5lZWRzX292ZXJsYXknIHwKK3wgJy5uZWVkc19yb2ZzJyB8IOKAkworfCAnLm5lZWRzX3Jv
b3QnIHwgJ1RTVF9ORUVEU19ST09UJworfCAnLm5lZWRzX3RtcGRpcicgfCAnVFNUX05FRURTX1RN
UERJUicKK3wgJy5vcHRpb25zJyB8ICdUU1RfUEFSU0VfQVJHUycsICdUU1RfT1BUUycKK3wgJy5y
ZXNvdXJjZV9maWxlcycgfCDigJMKK3wgJy5yZXN0b3JlX3dhbGxjbG9jaycgfCBub3QgYXBwbGlj
YWJsZQorfCAnLnNhbXBsZScgfCDigJMKK3wgJy5zYXZlX3Jlc3RvcmUnIHwg4oCTCit8ICcuc2Nh
bGwnIHwgbm90IGFwcGxpY2FibGUKK3wgJy5zZXR1cCcgfCAnVFNUX1NFVFVQJworfCAnLnNraXBf
ZmlsZXN5c3RlbXMnIHwgJ1RTVF9TS0lQX0ZJTEVTWVNURU1TJworfCAnLnNraXBfaW5fY29tcGF0
JyB8IOKAkworfCAnLnNraXBfaW5fbG9ja2Rvd24nIHwg4oCTCit8ICcuc3VwcG9ydGVkX2FyY2hz
JyB8IG5vdCBhcHBsaWNhYmxlCit8ICcudGFncycgfCDigJMKK3wgJy50YWludF9jaGVjaycgfCDi
gJMKK3wgJy50Y250JyB8ICdUU1RfQ05UJworfCAnLnRjb25mX21zZycgfCBub3QgYXBwbGljYWJs
ZQorfCAnLnRlc3QnLCAnLnRlc3RfYWxsJyB8ICdUU1RfVEVTVEZVTkMnCit8ICcudGVzdF92YXJp
YW50cycgfCDigJMKK3wgJy50aW1lb3V0JyB8ICdUU1RfVElNRU9VVCcKK3wgJy50c3RfaHVnZXBh
Z2UnIHwgbm90IGFwcGxpY2FibGUKK3wgLmZvcm1hdF9kZXZpY2UgfCAnVFNUX0RFVklDRScKK3wg
bm90IGFwcGxpY2FibGUgfCAnVFNUX05FRURTX0tDT05GSUdTX0lGUycKK3wgbm90IGFwcGxpY2Fi
bGUgfCAnVFNUX05FRURTX01PRFVMRScKK3wgbm90IGFwcGxpY2FibGUgfCAnVFNUX1BPU19BUkdT
JworfCBub3QgYXBwbGljYWJsZSB8ICdUU1RfVVNBR0UnCit8PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT0KLS0gCjIuMzcuMwoKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51
eC5pdC9saXN0aW5mby9sdHAK
