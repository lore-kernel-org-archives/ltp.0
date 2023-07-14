Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 194F4EB64DA
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 13:17:21 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 580293CD7CC
	for <ltp@archiver.kernel.org>; Fri, 14 Jul 2023 15:17:19 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id B83AD3C036A
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:51:20 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 80511100053B
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 13:51:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689335477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hHYKpItuEcJuo5Jv3chYxiDW/iXWwzUQH5pKsFYaAmw=;
 b=L8wnRMNZifC1c53LgoWHxnbCJh1MMmoT0syjf1FsvnXsxjlyVtmlqIh/o2AmLISRskG2ig
 LvYiJg0dqg45ABDf6DLB5ardQJLKq2giywjEwmiZk/ktsxt+VNeb3GnunjUtKZUsf51YAG
 ihmaNLzejGUL8AhfUSYv0sIdN8Mk3rQ=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-126-j8ggFNjTM3mZkpuWpvwMpw-1; Fri, 14 Jul 2023 07:51:16 -0400
X-MC-Unique: j8ggFNjTM3mZkpuWpvwMpw-1
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-4409ff60c89so306916137.2
 for <ltp@lists.linux.it>; Fri, 14 Jul 2023 04:51:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689335476; x=1691927476;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hHYKpItuEcJuo5Jv3chYxiDW/iXWwzUQH5pKsFYaAmw=;
 b=ITgwvuyPZagZ7h/y2AXNvyaKYKZRygYbAcaYqulRobwZXgSZWG+UDd7uYDQNIsVoL+
 Cf8UdtBgXLuoeIJsZ+WlkwPVgPLCqPg1fnd3dwbynCmP2MhBACR9Wn3gGbQ+gaICp3zz
 O+sp+6FVDrqwYmywQaB2FpcTinFo68qg7cZbUP1QZSor3BqdCUb5uqUI957a4AgPelPf
 qzvyQ+ZcWheJCT1toLB0fWuVNMzWFCba7Jo5VahVIxffZOyROGF3ykQtA97wBaS+BZgV
 Z9YfXFqSmRxUbPwMHOlppZ7jrTHNAeWJFzMQqyLL4M4QAyKw+gDMqXRa8vWZ2QCaImz3
 5VrQ==
X-Gm-Message-State: ABy/qLaWglsA1gjbWzsbRTrqj1+5uIbsAYimLK0SUCSMne7Vac9uaKP6
 sk68Qr39m3YfBgfrJGKq4CbNe0y9GExU6pwQuWqeGi09TMSotkEyHVRu27PSCF8IhwmYMbcDMu/
 eMJr/1gdYCDRQEJNuRm+7leJTeH7gSUMNfoz4JH50
X-Received: by 2002:a05:6102:356d:b0:443:6a86:7cdb with SMTP id
 bh13-20020a056102356d00b004436a867cdbmr2336849vsb.26.1689335475696; 
 Fri, 14 Jul 2023 04:51:15 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEjAug34qhiq9imIKX0hj5b4gr40mdR/NGOFzRruEDaaBApIulRCMsngeXKHA4c6mKq6RlNDiK1p89T/CJQsZ8=
X-Received: by 2002:a05:6102:356d:b0:443:6a86:7cdb with SMTP id
 bh13-20020a056102356d00b004436a867cdbmr2336824vsb.26.1689335475401; Fri, 14
 Jul 2023 04:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <202307132107.2ce4ea2f-oliver.sang@intel.com>
 <20230713150923.GA28246@lst.de> <ZLAZn_SBmoIFG5F5@yuki>
In-Reply-To: <ZLAZn_SBmoIFG5F5@yuki>
From: Jan Stancek <jstancek@redhat.com>
Date: Fri, 14 Jul 2023 13:50:58 +0200
Message-ID: <CAASaF6xbgSf+X+SF8wLjFrsMA4=XxHti0SXDZQP1ZqdGYp4aUQ@mail.gmail.com>
To: Cyril Hrubis <chrubis@suse.cz>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.1 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Mailman-Approved-At: Fri, 14 Jul 2023 15:16:55 +0200
Subject: Re: [LTP] [linus:master] [iomap] 219580eea1: ltp.writev07.fail
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
Cc: "Darrick J. Wong" <djwong@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Andreas Gruenbacher <agruenba@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
 Matthew Wilcox <willy@infradead.org>, cluster-devel@redhat.com,
 Ilya Dryomov <idryomov@gmail.com>, Miklos Szeredi <mszeredi@redhat.com>,
 Chao Yu <chao@kernel.org>, linux-fsdevel@vger.kernel.org,
 Al Viro <viro@zeniv.linux.org.uk>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Xiubo Li <xiubli@redhat.com>,
 Trond Myklebust <trond.myklebust@hammerspace.com>, ltp@lists.linux.it,
 lkp@intel.com, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>, linux-kernel@vger.kernel.org,
 linux-xfs@vger.kernel.org, kernel test robot <oliver.sang@intel.com>,
 Anna Schumaker <anna@kernel.org>, oe-lkp@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gVGh1LCBKdWwgMTMsIDIwMjMgYXQgNTozOOKAr1BNIEN5cmlsIEhydWJpcyA8Y2hydWJpc0Bz
dXNlLmN6PiB3cm90ZToKPgo+IEhpIQo+ID4gSSBjYW4ndCByZXByb2R1Y2UgdGhpcyBvbiBjdXJy
ZW50IG1haW5saW5lLiAgSXMgdGhpcyBhIHJvYnVzdCBmYWlsdXJlCj4gPiBvciBmbGFwcGluZyB0
ZXN0PyAgRXNwZWNpYWxsIGFzIHRoZSBGQUlMIGNvbmRpdGlvbnMgbG9vayByYXRoZXIKPiA+IHVu
cmVsYXRlZC4KCkl0J3MgY29uc2lzdGVudGx5IHJlcHJvZHVjaWJsZSBmb3IgbWUgb24geGZzIHdp
dGggSEVBRCBhdDoKZWIyNmNiYjFhNzU0ICgiTWVyZ2UgdGFnICdwbGF0Zm9ybS1kcml2ZXJzLXg4
Ni12Ni41LTInIG9mCmdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgva2VybmVsL2dp
dC9wZHg4Ni9wbGF0Zm9ybS1kcml2ZXJzLXg4NiIpCgo+Cj4gQWN0dWFsbHkgdGhlIHRlc3QgaXMg
c3BvdCBvbiwgdGhlIGRpZmZlcmVuY2UgaXMgdGhhdCBwcmV2aW91c2x5IHRoZQo+IGVycm9yIHdh
cyByZXR1cm5lZCBmb3JtIHRoZSBpb21hcF9maWxlX2J1ZmZlcmVkX3dyaXRlKCkgb25seSBpZiB3
ZQo+IGZhaWxlZCB3aXRoIHRoZSBmaXJzdCBidWZmZXIgZnJvbSB0aGUgaW92LCBub3cgd2UgYWx3
YXlzIHJldHVybiB0aGUKPiBlcnJvciBhbmQgd2UgZG8gbm90IGFkdmFuY2UgdGhlIG9mZnNldC4K
Pgo+IFRoZSBjaGFuZ2UgdGhhdCBicm9rZSBpdDoKPgo+IGRpZmYgLS1naXQgYS9mcy9pb21hcC9i
dWZmZXJlZC1pby5jIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYwo+IGluZGV4IDA2MzEzM2VjNzdm
NC4uNTUwNTI1YTUyNWM0IDEwMDY0NAo+IC0tLSBhL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMKPiAr
KysgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jCj4gQEAgLTg2NCwxNiArODY0LDE5IEBAIGlvbWFw
X2ZpbGVfYnVmZmVyZWRfd3JpdGUoc3RydWN0IGtpb2NiICppb2NiLCBzdHJ1Y3QgaW92X2l0ZXIg
KmksCj4gICAgICAgICAgICAgICAgIC5sZW4gICAgICAgICAgICA9IGlvdl9pdGVyX2NvdW50KGkp
LAo+ICAgICAgICAgICAgICAgICAuZmxhZ3MgICAgICAgICAgPSBJT01BUF9XUklURSwKPiAgICAg
ICAgIH07Cj4gLSAgICAgICBpbnQgcmV0Owo+ICsgICAgICAgc3NpemVfdCByZXQ7Cj4KPiAgICAg
ICAgIGlmIChpb2NiLT5raV9mbGFncyAmIElPQ0JfTk9XQUlUKQo+ICAgICAgICAgICAgICAgICBp
dGVyLmZsYWdzIHw9IElPTUFQX05PV0FJVDsKPgo+ICAgICAgICAgd2hpbGUgKChyZXQgPSBpb21h
cF9pdGVyKCZpdGVyLCBvcHMpKSA+IDApCj4gICAgICAgICAgICAgICAgIGl0ZXIucHJvY2Vzc2Vk
ID0gaW9tYXBfd3JpdGVfaXRlcigmaXRlciwgaSk7Cj4gLSAgICAgICBpZiAoaXRlci5wb3MgPT0g
aW9jYi0+a2lfcG9zKQo+ICsKPiArICAgICAgIGlmICh1bmxpa2VseShyZXQgPCAwKSkKPiAgICAg
ICAgICAgICAgICAgcmV0dXJuIHJldDsKPiAtICAgICAgIHJldHVybiBpdGVyLnBvcyAtIGlvY2It
PmtpX3BvczsKPiArICAgICAgIHJldCA9IGl0ZXIucG9zIC0gaW9jYi0+a2lfcG9zOwo+ICsgICAg
ICAgaW9jYi0+a2lfcG9zICs9IHJldDsKPiArICAgICAgIHJldHVybiByZXQ7Cj4gIH0KPgo+IEkg
c3VwcG9zZSB0aGF0IHdlIHNob3VkbCBmaXggaXMgd2l0aCBzb21ldGhpbmcgYXM6Cj4KPiBkaWZm
IC0tZ2l0IGEvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyBiL2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMK
PiBpbmRleCBhZGI5MmNkYjI0YjAuLmJmYjM5ZjdiYzMwMyAxMDA2NDQKPiAtLS0gYS9mcy9pb21h
cC9idWZmZXJlZC1pby5jCj4gKysrIGIvZnMvaW9tYXAvYnVmZmVyZWQtaW8uYwo+IEBAIC04NzIs
MTEgKzg3MiwxMiBAQCBpb21hcF9maWxlX2J1ZmZlcmVkX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9j
Yiwgc3RydWN0IGlvdl9pdGVyICppLAo+ICAgICAgICAgd2hpbGUgKChyZXQgPSBpb21hcF9pdGVy
KCZpdGVyLCBvcHMpKSA+IDApCj4gICAgICAgICAgICAgICAgIGl0ZXIucHJvY2Vzc2VkID0gaW9t
YXBfd3JpdGVfaXRlcigmaXRlciwgaSk7Cj4KPiArICAgICAgIGlvY2ItPmtpX3BvcyArPSBpdGVy
LnBvcyAtIGlvY2ItPmtpX3BvczsKPiArCj4gICAgICAgICBpZiAodW5saWtlbHkocmV0IDwgMCkp
Cj4gICAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gLSAgICAgICByZXQgPSBpdGVyLnBvcyAt
IGlvY2ItPmtpX3BvczsKPiAtICAgICAgIGlvY2ItPmtpX3BvcyArPSByZXQ7Cj4gLSAgICAgICBy
ZXR1cm4gcmV0Owo+ICsKPiArICAgICAgIHJldHVybiBpdGVyLnBvcyAtIGlvY2ItPmtpX3BvczsK
ClJlcGxhY2luZyAicmV0IiB3aXRoICJpdGVyLnBvcyAtIGlvY2ItPmtpX3BvcyIgaGVyZSBkb2Vz
bid0IGxvb2sKZXF1aXZhbGVudCB0byBvcmlnaW5hbCwKYmVjYXVzZSB5b3UgYWxyZWFkeSB1cGRh
dGVkICJpb2NiLT5raV9wb3MiIGZldyBsaW5lcyBhYm92ZS4KCldvdWxkbid0IGl0IGJlIGVub3Vn
aCB0byBicmluZyB0aGUgb2xkIGNvbmRpdGlvbiBiYWNrPwoKZGlmZiAtLWdpdCBhL2ZzL2lvbWFw
L2J1ZmZlcmVkLWlvLmMgYi9mcy9pb21hcC9idWZmZXJlZC1pby5jCmluZGV4IGFkYjkyY2RiMjRi
MC4uN2NjOWY3Mjc0ODgzIDEwMDY0NAotLS0gYS9mcy9pb21hcC9idWZmZXJlZC1pby5jCisrKyBi
L2ZzL2lvbWFwL2J1ZmZlcmVkLWlvLmMKQEAgLTg3Miw3ICs4NzIsNyBAQCBpb21hcF9maWxlX2J1
ZmZlcmVkX3dyaXRlKHN0cnVjdCBraW9jYiAqaW9jYiwKc3RydWN0IGlvdl9pdGVyICppLAogICAg
ICAgIHdoaWxlICgocmV0ID0gaW9tYXBfaXRlcigmaXRlciwgb3BzKSkgPiAwKQogICAgICAgICAg
ICAgICAgaXRlci5wcm9jZXNzZWQgPSBpb21hcF93cml0ZV9pdGVyKCZpdGVyLCBpKTsKCi0gICAg
ICAgaWYgKHVubGlrZWx5KHJldCA8IDApKQorICAgICAgIGlmICh1bmxpa2VseShpdGVyLnBvcyA9
PSBpb2NiLT5raV9wb3MpKQogICAgICAgICAgICAgICAgcmV0dXJuIHJldDsKICAgICAgICByZXQg
PSBpdGVyLnBvcyAtIGlvY2ItPmtpX3BvczsKICAgICAgICBpb2NiLT5raV9wb3MgKz0gcmV0OwoK
KHdpdGggaHVuayBhYm92ZSBhcHBsaWVkKQojIC4vd3JpdGV2MDcKdHN0X3Rlc3QuYzoxNTI2OiBU
SU5GTzogVGltZW91dCBwZXIgcnVuIGlzIDBoIDAwbSAzMHMKd3JpdGV2MDcuYzo1MDogVElORk86
IHN0YXJ0aW5nIHRlc3Qgd2l0aCBpbml0aWFsIGZpbGUgb2Zmc2V0OiAwCndyaXRldjA3LmM6OTQ6
IFRJTkZPOiB3cml0ZXYoKSBoYXMgd3JpdHRlbiA2NCBieXRlcwp3cml0ZXYwNy5jOjEwNTogVFBB
U1M6IGZpbGUgaGFzIGV4cGVjdGVkIGNvbnRlbnQKd3JpdGV2MDcuYzoxMTY6IFRQQVNTOiBvZmZz
ZXQgYXQgNjQgYXMgZXhwZWN0ZWQKd3JpdGV2MDcuYzo1MDogVElORk86IHN0YXJ0aW5nIHRlc3Qg
d2l0aCBpbml0aWFsIGZpbGUgb2Zmc2V0OiA2NQp3cml0ZXYwNy5jOjk0OiBUSU5GTzogd3JpdGV2
KCkgaGFzIHdyaXR0ZW4gNjQgYnl0ZXMKd3JpdGV2MDcuYzoxMDU6IFRQQVNTOiBmaWxlIGhhcyBl
eHBlY3RlZCBjb250ZW50CndyaXRldjA3LmM6MTE2OiBUUEFTUzogb2Zmc2V0IGF0IDEyOSBhcyBl
eHBlY3RlZAp3cml0ZXYwNy5jOjUwOiBUSU5GTzogc3RhcnRpbmcgdGVzdCB3aXRoIGluaXRpYWwg
ZmlsZSBvZmZzZXQ6IDQwOTYKd3JpdGV2MDcuYzo5NDogVElORk86IHdyaXRldigpIGhhcyB3cml0
dGVuIDY0IGJ5dGVzCndyaXRldjA3LmM6MTA1OiBUUEFTUzogZmlsZSBoYXMgZXhwZWN0ZWQgY29u
dGVudAp3cml0ZXYwNy5jOjExNjogVFBBU1M6IG9mZnNldCBhdCA0MTYwIGFzIGV4cGVjdGVkCndy
aXRldjA3LmM6NTA6IFRJTkZPOiBzdGFydGluZyB0ZXN0IHdpdGggaW5pdGlhbCBmaWxlIG9mZnNl
dDogNDA5Nwp3cml0ZXYwNy5jOjk0OiBUSU5GTzogd3JpdGV2KCkgaGFzIHdyaXR0ZW4gNjQgYnl0
ZXMKd3JpdGV2MDcuYzoxMDU6IFRQQVNTOiBmaWxlIGhhcyBleHBlY3RlZCBjb250ZW50CndyaXRl
djA3LmM6MTE2OiBUUEFTUzogb2Zmc2V0IGF0IDQxNjEgYXMgZXhwZWN0ZWQKCgoKCj4gIH0KPiAg
RVhQT1JUX1NZTUJPTF9HUEwoaW9tYXBfZmlsZV9idWZmZXJlZF93cml0ZSk7Cj4KPgo+IC0tCj4g
Q3lyaWwgSHJ1YmlzCj4gY2hydWJpc0BzdXNlLmN6Cj4KPiAtLQo+IE1haWxpbmcgbGlzdCBpbmZv
OiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+CgoKLS0gCk1haWxpbmcgbGlz
dCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo=
