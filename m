Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FCB4C3ABC3
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 11:40:39 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E03713CC2BA
	for <ltp@archiver.kernel.org>; Mon, 12 May 2025 13:40:37 +0200 (CEST)
Received: from in-5.smtp.seeweb.it (in-5.smtp.seeweb.it [217.194.8.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 888AD3CC251
 for <ltp@lists.linux.it>; Mon, 12 May 2025 13:40:21 +0200 (CEST)
Received: from smtp-out2.suse.de (smtp-out2.suse.de
 [IPv6:2a07:de40:b251:101:10:150:64:2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-5.smtp.seeweb.it (Postfix) with ESMTPS id 74B94600219
 for <ltp@lists.linux.it>; Mon, 12 May 2025 13:40:19 +0200 (CEST)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A86A21F387;
 Mon, 12 May 2025 11:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747050018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OUU+xNlRw+Njo2w1NdX0GhM1BluawBRFnwHjDUhGdZ8=;
 b=rxzwwa5b2Htc9tfyJIjZ9FrXg8AGOlGVZ2NoIdF2/rgAsZx/RUtGyptm9c+kclXN/8ZNDm
 k3X607DFX7Tr9/YmEMEOPeYuzaohvXbF2DevdCWV8rIVO0b5j86h4l4nnQ/UJVO8SA4GGK
 RA7US54Kiy4HY07ZqZvHbnHOSSoXpng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747050018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OUU+xNlRw+Njo2w1NdX0GhM1BluawBRFnwHjDUhGdZ8=;
 b=SDLszicmD8/7PUN6FdTbZAUmK/OKL36crqa5y5Tj9yjwrofjd+PCj73TZIKNEebeVjL0Yw
 5uXjSGqv78mqkdCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1747050018; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OUU+xNlRw+Njo2w1NdX0GhM1BluawBRFnwHjDUhGdZ8=;
 b=rxzwwa5b2Htc9tfyJIjZ9FrXg8AGOlGVZ2NoIdF2/rgAsZx/RUtGyptm9c+kclXN/8ZNDm
 k3X607DFX7Tr9/YmEMEOPeYuzaohvXbF2DevdCWV8rIVO0b5j86h4l4nnQ/UJVO8SA4GGK
 RA7US54Kiy4HY07ZqZvHbnHOSSoXpng=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1747050018;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OUU+xNlRw+Njo2w1NdX0GhM1BluawBRFnwHjDUhGdZ8=;
 b=SDLszicmD8/7PUN6FdTbZAUmK/OKL36crqa5y5Tj9yjwrofjd+PCj73TZIKNEebeVjL0Yw
 5uXjSGqv78mqkdCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9A7DA137D2;
 Mon, 12 May 2025 11:40:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id fjDcJCLeIWh6dAAAD6G6ig
 (envelope-from <mdoucha@suse.cz>); Mon, 12 May 2025 11:40:18 +0000
Message-ID: <f1e4aa38-793b-4007-8a68-e731bba93737@suse.cz>
Date: Mon, 12 May 2025 13:40:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: =?UTF-8?Q?Ricardo_B=2E_Marli=C3=A8re?= <rbm@suse.com>,
 Linux Test Project <ltp@lists.linux.it>
References: <20250512-fixes-msgstress01-v1-1-d335f7c131c0@suse.com>
Content-Language: en-US
From: Martin Doucha <mdoucha@suse.cz>
Autocrypt: addr=mdoucha@suse.cz; keydata=
 xsFNBGaqVbgBEACpipjj9sTO/5/DFIIYr/HiC9GEAHpmU+jzRraYh7Lcx11XDVZ00nWN5AlO
 GL+UxpvYs9cInmLGVav2gK36FxAUsxl99OCQjM45OrQHVkyDPbeZzw7NSvEblv1gaydu/YKk
 ktwuO3yzjtb5X1hiDLYULorpCYGz8CXnkkoYm79fa0g+rTivJLMaMSnO2rDcp4EsSofBE/is
 UcG4e2BIUKQE2d+ogrbHYkmbt9jQZnyipCDm61yEiNZSKR9ktbQ8IvevCpoZJu+2EFRRhDsv
 3lvNKmlJpa+MkZ/18u/OX5zZwyP5wS9SYGIAW9236R4qoFinYYlA1LeHjJtVLq2cVjIyo9Wm
 ZG5BPsKLC31H4dzGUcvBTU0D/V5dowb5Qnt0kPAb7cmKC3vNrVBgWjEwk8mwrzNj/6wUxugR
 OnFvuUljDT48su9MFsSCQtygR0qQNnuaSr1S+a0Mzd5NgOdQ3rgWV/T1YnlSjSQQAjykom2a
 nwVKhToJSFYBezItmE2raMUpToraDXa3we48HBibs7JH1PjUGMyX1ADwHg7oIQbRGLWtWWiS
 Dy9jL7rw46lEnRHm4KIvUC1jvBM1DPz5LHHRLsA0QmzmBbDMTGTKEuuUaIo9FclwNjhiSybb
 qWGF5JQZcihg/SSpTWcjucyeDyI/x6drNz/qpXSQz6Yk00MBDQARAQABzR9NYXJ0aW4gRG91
 Y2hhIDxtZG91Y2hhQHN1c2UuY3o+wsGaBBMBCABEAhsDBQkJZgGABQsJCAcCAiICBhUKCQgL
 AgQWAgMBAh4HAheAFiEEMmUpXLa1dxYwexErBwUVKaC6qJsFAmaqWFUCGQEACgkQBwUVKaC6
 qJv+WA//btgD9l5FyfsQW4qriE1nntpyuJ+rVSL/rICYOh5rK2zdpOikNdtqQ0XOQew4AuMB
 ZSONHn5GkmCTsIjLDIiGn1v88OHJ9P+FNtfdZmMyYUYRed3tgYqlIdTjAkUy/gzNuKQl26fU
 v4Yl50MIqhm/ILmlb2s+iA5W8IZSDwy4xZo886oRGYS8/ix23HuLXTMlHNZV1a1ty62tRLyq
 pIA4kX6ymLxlXoM6G3+Ie/DOSJuaa25dlSXNQhhcFYp0ytiLdr3vByKdUpPO+Cjct601+a3w
 HS/Xzt24hlMqhvtic8EPmNhNFDMosqJBTote/sTSsiUjgSAC8h2nm91+sPyr+U5c9Bdzcytl
 ZnCJOkm5iSSHQqpP/LxdRU1AiibK+BQUqAt7WjAWmneeFUskqC4Ss3GHr2yOoEro2Nbo8i1b
 RXG8F4H4GZB+osgGIDm3zejUdZ59701E4X3KEtmz8+m4hg37nudl2hIPjop/vS7wyah7J17i
 ujM/DQQflrorbv9xmcx0z/rgtwf73gYX48O3AQmh3HlpTQ2tnIojoteYujgwxMEToyBgRG7Y
 bDB40+umKnWLqN3QtKoPP9RUynWv7bTjXtwn0I7/ATw50yJqatP1dGXP/FY7zWEVyYNB5qUi
 ZpuUX95g3qtlSIqhBrR61phpu1bYaWB/IMKstSTwdCPOwU0EZqpVuAEQALHeH9zmpNzV8E3V
 SWffDMJRGeFjcJuha0wpHMUrXGmz7Mld6o8/ZXu8QXT5gM6r6UpXytN6dUfRdllgQoj2uSjg
 ZgoaDJ8HkLYjdrcipkX6IkAe8Q9i/sZvoekuwfqVgTMfwtGyl3vfgyQkX1NiNIU967MDewcT
 Krv+5qUFnnx67qLdcd2XfIo9dsxv9nqyp4AwHtZ6Sj40KCefuaVl7YpYM3H9AnfVusr56OQC
 9VBPex98OzEGsROcijVvhdIChMkZazYdy643xhJ9i5fjdg7Lxwg7IbyjlpVn8gZ2CQ4BupjT
 wLgvEi2O1yZlNWNk3JJMgZ29O/qbZYmsSXkCmuUj1GcZm+mvVdc/GFlq4d9Eb9BItYCCiMlJ
 LFWhFghaaqv/tHgBPcx+vmxO6iZhl07mw+mv3VohlCyWrbM2mb9uwpOYmVZcNxsRHAXSUthx
 9sG4Bv9Szg37D7C4pX5T5Q4OO29ss4VZflvgE3vRHQd373oxdhM5jcOCEbUKw7tTpiVRUhko
 lTvQScZMR1FletK5ieHnA06qrKCZpB+WP7xr3rYYYRVTW8qhdo7p+UnfVSzdErT6Sz35tlxg
 0wQGWbTYsBw6mk0hjaqvUS7ffRFuoVVaVQJVXLscE/nv7b+3NtK0LCFDACsZX5A2Ee0AfpKw
 WM7PJAbuI4GHc1MhhLubABEBAAHCwXwEGAEIACYWIQQyZSlctrV3FjB7ESsHBRUpoLqomwUC
 ZqpVuAIbDAUJCWYBgAAKCRAHBRUpoLqom4RUD/4xLZz0ahnRPA7Y6IRX4/bB3fDMfMlxG0Dv
 Y6USpubfUqxG61Q6P/DfOLvp5iC5OYct7Id7arA/FsQs2g2L875pNefPLzuuG/XXujJ6Vokr
 WzMy/3gnBrvcUKTiVr+wLifenDDBImQzOTsjcTBpTzX8edGMrb2jnT1+M6VEWP8bMadbTMyE
 uVTsRqzKKRPPhp8dQX7DnPzfFixvBoSbodNaBL+R432Ljl9CvXkDDLymuLyzxPdhrQ3mf02T
 jq1nHXCXFm8zC3bRvCv7k8m/PLBY956/8OPRt3ePxSFgO/Pf3FKFTKIqHDiV3dAxAO7Ibuii
 Zr5AzfbRpdA7Gt8afL/yTujen+skhuVentxwhoLw/WqqgZefK9CUXTv5A9HzXuhsgTQPPzBn
 qsL+5eFNf1QBdRa6lInbwbH0vgHZEF04mK7Ac4dsXGU+cMsHEUaNhrEBoR0cu/NFfmlwpWqO
 sOf6M5s7RKNzreVXkrlArE+x29swkXZbxFoXuahA2iykPyyCAgPz0ikRI+374jXVAtbZAAut
 HD1KfuCahogFT4upYpOUl26KquywYOGciSan4jHuqXIVCQzjYd/zOzsL7hTJiteae/oOg4m5
 i8BUUzanmo3FPwFBcjEn4nDvkw/YEo5gtQZmrxOHQAdSHdyqtFgRxu4+w3JFmnQvkResUgm3 ag==
In-Reply-To: <20250512-fixes-msgstress01-v1-1-d335f7c131c0@suse.com>
X-Spamd-Result: default: False [-8.30 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCPT_COUNT_TWO(0.00)[2]; MID_RHS_MATCH_FROM(0.00)[];
 RCVD_TLS_ALL(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
 FUZZY_BLOCKED(0.00)[rspamd.com]; TO_DN_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email, suse.cz:mid, suse.cz:email,
 imap1.dmz-prg2.suse.org:helo]
X-Virus-Scanned: clamav-milter 1.0.7 at in-5.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH] syscalls/msgstress01: Set upper bound for
 num_messages
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGksCmlmIG51bV9tZXNzYWdlcyBpcyBoaWdoZXIgdGhhbiBhdmFpbF9tZXNzYWdlcywgdGhlIHRl
c3Qgc2hvdWxkIGF0IGxlYXN0IApwcmludCBhIG1lc3NhZ2VzIHRoYXQgdGhlIGRlZmF1bHQgdmFs
dWUgd2FzIHJlZHVjZWQuIEFuZCBpZiB0aGUgbmV3IAp2YWx1ZSBpcyBsZXNzIHRoYW4gaGFsZiBv
ZiB0aGUgZGVmYXVsdCwgdGhlIG1lc3NhZ2Ugc2hvdWxkIGJlIFRXQVJOLgoKT24gMTIuIDA1LiAy
NSAxMzoyMywgUmljYXJkbyBCLiBNYXJsacOocmUgd3JvdGU6Cj4gRnJvbTogUmljYXJkbyBCLiBN
YXJsacOocmUgPHJibUBzdXNlLmNvbT4KPiAKPiBUaGUgbXNnc3RyZXNzMDEgdGVzdCBoYXMgYSB3
b3JrYXJvdW5kIHRvIGxpbWl0IHRoZSBhbW91bnQgb2YgcHJvY2Vzc2VzIGl0Cj4gd2lsbCBzcGF3
biwgYnV0IGl0IGlzIG9ubHkgdXNlZCBpZiB0aGUgb3B0aW9uIHN0cl9udW1fbWVzc2FnZXMgKC1u
KSBpcwo+IHBhc3NlZC4gVGhpcyBpcyBrbm93biB0byBiZSBwcm9ibGVtYXRpYyBpbiBsb3cgbWVt
b3J5IFNVVHMsIHNvIGFkZCBhIE1JTigpCj4gdG8gZm9yY2UgdGhlIHZhbHVlIG9mIGF2YWlsX21z
ZyBpbnRvIG51bV9tZXNzYWdlcy4KPiAKPiBTdWdnZXN0ZWQtYnk6IE1hcnRpbiBEb3VjaGEgPG1k
b3VjaGFAc3VzZS5jej4KPiBTaWduZWQtb2ZmLWJ5OiBSaWNhcmRvIEIuIE1hcmxpw6hyZSA8cmJt
QHN1c2UuY29tPgo+IC0tLQo+IEhlbGxvLAo+IAo+IGFzIGRpc2N1c3NlZCB0aHJvdWdoIEdpdGh1
YiBbMV0sIGhlcmUncyB0aGUgcHJvcG9zZWQgZml4Lgo+IAo+IFRoYW5rIHlvdSwKPiByYm0KPiAK
PiBbMV0gaHR0cHM6Ly9naXRodWIuY29tL29zLWF1dG9pbnN0L29zLWF1dG9pbnN0LWRpc3RyaS1v
cGVuc3VzZS9wdWxsLzIxOTc3Cj4gLS0tCj4gICB0ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lw
Yy9tc2dzdHJlc3MvbXNnc3RyZXNzMDEuYyB8IDIgKysKPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGlu
c2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9p
cGMvbXNnc3RyZXNzL21zZ3N0cmVzczAxLmMgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lw
Yy9tc2dzdHJlc3MvbXNnc3RyZXNzMDEuYwo+IGluZGV4IGFlNjM3ZTVkN2FkODljMTI1N2M5Y2Nl
MDE0NTEyMjQ5N2MxOWVlNjQuLjM1MjViMGIyYjk3M2IxNzRhYzhkZjA4OTU4MGE4NWMxOTA1N2Yw
NWUgMTAwNjQ0Cj4gLS0tIGEvdGVzdGNhc2VzL2tlcm5lbC9zeXNjYWxscy9pcGMvbXNnc3RyZXNz
L21zZ3N0cmVzczAxLmMKPiArKysgYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lwYy9tc2dz
dHJlc3MvbXNnc3RyZXNzMDEuYwo+IEBAIC0yNzEsNiArMjcxLDggQEAgc3RhdGljIHZvaWQgc2V0
dXAodm9pZCkKPiAgIAlpZiAodHN0X3BhcnNlX2ludChzdHJfbnVtX21lc3NhZ2VzLCAmbnVtX21l
c3NhZ2VzLCAxLCBhdmFpbF9tc2cpKQo+ICAgCQl0c3RfYnJrKFRCUk9LLCAiSW52YWxpZCBudW1i
ZXIgb2YgbWVzc2FnZXMgJyVzJyIsIHN0cl9udW1fbWVzc2FnZXMpOwo+ICAgCj4gKwludW1fbWVz
c2FnZXMgPSBNSU4oYXZhaWxfbXNnLCBudW1fbWVzc2FnZXMpOwo+ICsKPiAgIAlpZiAodHN0X3Bh
cnNlX2ludChzdHJfbnVtX2l0ZXJhdGlvbnMsICZudW1faXRlcmF0aW9ucywgMSwgTUFYTlJFUFMp
KQo+ICAgCQl0c3RfYnJrKFRCUk9LLCAiSW52YWxpZCBudW1iZXIgb2YgbWVzc2FnZXMgaXRlcmF0
aW9ucyAnJXMnIiwgc3RyX251bV9pdGVyYXRpb25zKTsKPiAgIAo+IAo+IC0tLQo+IGJhc2UtY29t
bWl0OiA0YTBlM2E4ZmE3YjU5Mjk1OGY4ZTNjZDM2NmY2M2M3OGZiYTlmMDE0Cj4gY2hhbmdlLWlk
OiAyMDI1MDUxMi1maXhlcy1tc2dzdHJlc3MwMS00MTU3Y2ViNTRiMzgKPiAKPiBCZXN0IHJlZ2Fy
ZHMsCgoKLS0gCk1hcnRpbiBEb3VjaGEgICBtZG91Y2hhQHN1c2UuY3oKU1cgUXVhbGl0eSBFbmdp
bmVlcgpTVVNFIExJTlVYLCBzLnIuby4KQ09SU08gSUlhCktyaXppa292YSAxNDgvMzQKMTg2IDAw
IFByYWd1ZSA4CkN6ZWNoIFJlcHVibGljCgotLSAKTWFpbGluZyBsaXN0IGluZm86IGh0dHBzOi8v
bGlzdHMubGludXguaXQvbGlzdGluZm8vbHRwCg==
