Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D37FC3DA4A
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 07:02:31 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id E74E03D21D9
	for <ltp@archiver.kernel.org>; Fri, 16 Aug 2024 09:02:29 +0200 (CEST)
Received: from in-6.smtp.seeweb.it (in-6.smtp.seeweb.it [217.194.8.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 1C03A3D20EA
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 09:02:15 +0200 (CEST)
Authentication-Results: in-6.smtp.seeweb.it; spf=pass (sender SPF authorized)
 smtp.mailfrom=redhat.com (client-ip=170.10.133.124;
 helo=us-smtp-delivery-124.mimecast.com; envelope-from=liwan@redhat.com;
 receiver=lists.linux.it)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-6.smtp.seeweb.it (Postfix) with ESMTPS id 09BBA140026A
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 09:02:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723791733;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iUvL5MWl3jxf6i0j2LlWbieNqYpfCbiy1MkYjTh01/8=;
 b=MiEr8KMpWjCYCmB/4fKtdVaJVesqV3B5OWf2Y2jfIUbnbISK+Ylq/gjpslWkCEqpVAr9s3
 LeBTCmGfvDlkkSUEZkG9M8/yWjSwh5m0t2pQwUN6tcAM2XVW3J67pIdlguvBu9HsLgDiYq
 Fsh7pVAG9AKyCvAmflIFFY4RSrMwyxg=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-WhC6zikTPA-M6o0cieCJ_w-1; Fri, 16 Aug 2024 03:02:07 -0400
X-MC-Unique: WhC6zikTPA-M6o0cieCJ_w-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-6c8f99fef10so1739450a12.3
 for <ltp@lists.linux.it>; Fri, 16 Aug 2024 00:02:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723791726; x=1724396526;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iUvL5MWl3jxf6i0j2LlWbieNqYpfCbiy1MkYjTh01/8=;
 b=Cob4NYKCqObIpInXjJPVjVc6xWpZcFd2DNwsif7Vg9GxWi6CuPwqicjY97anCwMj9M
 X+qjYljWqT89hpduRODIdt7q2aFJYmtfLqWCAXBPpThhV8sknqK2y/zT6MO6MmBhcw+H
 G3/eeYPLStENSN7qFuJBzo+NJdV4booWyuKTuNYp3hUJGId1Klsq+ZIuyEWR4vRkgnUI
 ubFX4yxKIYVUOylvzTihNfVFQ6vO9N2lmwTEI0D5d3VdS+IMPdR9UvVhZ5LGp+OaFUsl
 xB02uW7bE3Qe48IQV+PBfcVRkhc36xFZYMbtmpbhTfEUhb65tceVoZFMbIPX+AweGCCM
 iu8Q==
X-Gm-Message-State: AOJu0YzR20FEbqHxtL497It6HWDSNFOpzB4poQMMS/dKJoapqAowFApi
 BHhSbmhd1a0aJs5ihuWAppsgNDmjgvM56tW5WuBnOuCV/4sMfgxvs+REeHN6hucRzCIFoDNNgue
 CNXpbNMlCw+i241KuwOxM1L/FJcIW09cPgiLx9l8HXrZha4rur++F/tgBnABRqILGczF/GUx6BI
 EbwmkevFBl0eSyjlwpNTJnIZ/pTfK8yDbGqyNl
X-Received: by 2002:a05:6a21:8cc5:b0:1c8:b145:29cd with SMTP id
 adf61e73a8af0-1c904fb4950mr2779805637.24.1723791725964; 
 Fri, 16 Aug 2024 00:02:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFiQ20AySKx+cewNnm3Hz6+IWXSAlhITJLrPPyNa/itsR3/9zo6k31QhNXgU9fjwfz9BpiU82LvRL5qGV7DoAc=
X-Received: by 2002:a05:6a21:8cc5:b0:1c8:b145:29cd with SMTP id
 adf61e73a8af0-1c904fb4950mr2779786637.24.1723791725603; Fri, 16 Aug 2024
 00:02:05 -0700 (PDT)
MIME-Version: 1.0
References: <20240816045342.185737-1-ice_yangxiao@163.com>
 <20240816045342.185737-2-ice_yangxiao@163.com>
In-Reply-To: <20240816045342.185737-2-ice_yangxiao@163.com>
From: Li Wang <liwang@redhat.com>
Date: Fri, 16 Aug 2024 15:01:53 +0800
Message-ID: <CAEemH2dZk3b2nxO7F87ag8XJiHqxvqr1u0eWv5nxwr59FkRpdQ@mail.gmail.com>
To: Xiao Yang <ice_yangxiao@163.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 1.0.3 at in-6.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH 2/2] syscalls/mseal01.c: Use the correct "'" for
 JSON
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
Cc: ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gRnJpLCBBdWcgMTYsIDIwMjQgYXQgMTI6NTTigK9QTSBYaWFvIFlhbmcgPGljZV95YW5neGlh
b0AxNjMuY29tPiB3cm90ZToKCj4gRml4IHRoZSBmb2xsb3dpbmcgd2FybmluZ3MgZnJvbSBtZXRh
ZGF0YS9tZXRhcGFyc2U6Cj4gZGF0YV9zdG9yYWdlLmg6MzI1OiBXQVJOSU5HOiBpbnZhbGlkIGNo
YXJhY3RlciBmb3IgSlNPTjogZmZmZmZmZTIKPiBkYXRhX3N0b3JhZ2UuaDozMjU6IFdBUk5JTkc6
IGludmFsaWQgY2hhcmFjdGVyIGZvciBKU09OOiBmZmZmZmY4MAo+IGRhdGFfc3RvcmFnZS5oOjMy
NTogV0FSTklORzogaW52YWxpZCBjaGFyYWN0ZXIgZm9yIEpTT046IGZmZmZmZjk5Cj4KPiBTaWdu
ZWQtb2ZmLWJ5OiBYaWFvIFlhbmcgPGljZV95YW5neGlhb0AxNjMuY29tPgo+CgpSZXZpZXdlZC1i
eTogTGkgV2FuZyA8bGl3YW5nQHJlZGhhdC5jb20+CgotLS0KPiAgdGVzdGNhc2VzL2tlcm5lbC9z
eXNjYWxscy9tc2VhbC9tc2VhbDAxLmMgfCAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBhL3Rlc3RjYXNlcy9rZXJuZWwv
c3lzY2FsbHMvbXNlYWwvbXNlYWwwMS5jCj4gYi90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL21z
ZWFsL21zZWFsMDEuYwo+IGluZGV4IDYyY2ZkZDZhNi4uMDA0NTRhNzY2IDEwMDY0NAo+IC0tLSBh
L3Rlc3RjYXNlcy9rZXJuZWwvc3lzY2FsbHMvbXNlYWwvbXNlYWwwMS5jCj4gKysrIGIvdGVzdGNh
c2VzL2tlcm5lbC9zeXNjYWxscy9tc2VhbC9tc2VhbDAxLmMKPiBAQCAtMTYsNyArMTYsNyBAQAo+
ICAgKiAtIG1vZGlmeWluZyBhIFZNQSB2aWEgbW1hcChNQVBfRklYRUQpCj4gICAqIC0gbXByb3Rl
Y3QoKSBhbmQgcGtleV9tcHJvdGVjdCgpCj4gICAqIC0gZGVzdHJ1Y3RpdmUgbWFkdmljZSgpIGJl
aGF2aW9ycyAoZS5nLiBNQURWX0RPTlRORUVEKSBmb3IgYW5vbnltb3VzCj4gbWVtb3J5LAo+IC0g
KiAgIHdoZW4gdXNlcnMgZG9u4oCZdCBoYXZlIHdyaXRlIHBlcm1pc3Npb24gdG8gdGhlIG1lbW9y
eQo+ICsgKiAgIHdoZW4gdXNlcnMgZG9uJ3QgaGF2ZSB3cml0ZSBwZXJtaXNzaW9uIHRvIHRoZSBt
ZW1vcnkKPiAgICoKPiAgICogQW55IG9mIHRoZSBkZXNjcmliZWQgYWN0aW9ucyBpcyByZWNvZ25p
emVkIHZpYSBFUEVSTSBlcnJuby4KPiAgICoKPiAtLQo+IDIuNDUuMgo+Cj4KPiAtLQo+IE1haWxp
bmcgbGlzdCBpbmZvOiBodHRwczovL2xpc3RzLmxpbnV4Lml0L2xpc3RpbmZvL2x0cAo+CgoKLS0g
ClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5s
aW51eC5pdC9saXN0aW5mby9sdHAK
