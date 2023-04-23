Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C197C77B73
	for <ltp@archiver.kernel.org>; Sun, 23 Apr 2023 06:46:58 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 82EDA3CBD0D
	for <ltp@archiver.kernel.org>; Sun, 23 Apr 2023 08:46:56 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 059143CB318
 for <ltp@lists.linux.it>; Sun, 23 Apr 2023 08:46:46 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id 677D2100049C
 for <ltp@lists.linux.it>; Sun, 23 Apr 2023 08:46:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682232403;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jc5gUnWdMB0zugVRpghZTVjUOFFxSeGbmPkaDFUmLBc=;
 b=IpCwviF1k4mCdRhwhj+w6IlCM5pNdGqvhQl/OqUD8ejn0ZNjNHGyKlU0fpIn0Nm974cs9U
 YZDiiWj3TUj3vhFZ8MdlCR6OVcXFcpE5JgYf6u3V8R3vyn2c7/3j5/U9XW6lOcV/OnsxhQ
 JM1v1Ow2/kuvfpgrCRPRRpb/u17wp3M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-463-k0Gs33OpNtSreu9eN2XKog-1; Sun, 23 Apr 2023 02:46:40 -0400
X-MC-Unique: k0Gs33OpNtSreu9eN2XKog-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f08900db79so10837455e9.2
 for <ltp@lists.linux.it>; Sat, 22 Apr 2023 23:46:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682232399; x=1684824399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jc5gUnWdMB0zugVRpghZTVjUOFFxSeGbmPkaDFUmLBc=;
 b=JAc29d35pO0mwXWWuhUe5vifBptShLBy5BI/kcqPt3n9sVGCgnFlCYWt4IKSRxxLRW
 wPTKXkWdKGvvADdJSc2N/H3wwtm0FkVsaUSzqfeOVySyNdKBbcLOAQ0KLZ510K9/mnJv
 YHlssAIz2JyBVcKVi5IrsiofdQ4F6v404qq0IWNDm4QTL3fbWArIJZ6a7Qz/NtmjWFw2
 Xt5W51LUx9RHJkLt5jxVJJHbDuCx/mnKerdMGBpPsengEAFuW8s1nqThHq5WxCq+6Ewf
 oF6FygE6lqP0ku28zn5fJtMsZd1Fe8ZqdQ0Zz+KBbamINlXAHWCiSvDIEePznCPdRr9K
 5VZg==
X-Gm-Message-State: AAQBX9dPIkCQahB7gvRVCdggXWvZdI4AMparMhhUAubDrAfZ58S7DFvj
 nfJVH7QFzJeUzHA5RTSwdswYgwxf61nOZfdwbDma0U8NDuZIaHEUSHNTBgzO2yydwW1PTUhjEkK
 fSNLZtAM0G+kmd4H8Z7kDtIkD9q8=
X-Received: by 2002:a7b:c3d8:0:b0:3f1:7972:429d with SMTP id
 t24-20020a7bc3d8000000b003f17972429dmr5286615wmj.18.1682232399744; 
 Sat, 22 Apr 2023 23:46:39 -0700 (PDT)
X-Google-Smtp-Source: AKy350Y0Td43Qxx2V/3THZdKys/MqCxyYvmriU2VPtLBisYaXPmxJa6r8sjbJHhFZbHQfPxViCIuijEpXVK37AUrTdU=
X-Received: by 2002:a7b:c3d8:0:b0:3f1:7972:429d with SMTP id
 t24-20020a7bc3d8000000b003f17972429dmr5286605wmj.18.1682232399438; Sat, 22
 Apr 2023 23:46:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230421012642.16625-1-wegao@suse.com>
 <20230422135337.12087-1-wegao@suse.com>
 <20230422135337.12087-3-wegao@suse.com>
In-Reply-To: <20230422135337.12087-3-wegao@suse.com>
From: Li Wang <liwang@redhat.com>
Date: Sun, 23 Apr 2023 14:46:28 +0800
Message-ID: <CAEemH2fDJD=HpDQMGxkHQS_Of9bt99724no+cqmZiUPgyV2vCQ@mail.gmail.com>
To: Wei Gao <wegao@suse.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
X-Content-Filtered-By: Mailman/MimeDel 2.1.29
Subject: Re: [LTP] [PATCH v9 2/2] tst_cgroup.c: Add a cgroup pseudo
 controller
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

SGkgV2VpLAoKT24gU2F0LCBBcHIgMjIsIDIwMjMgYXQgOTo1NOKAr1BNIFdlaSBHYW8gdmlhIGx0
cCA8bHRwQGxpc3RzLmxpbnV4Lml0PiB3cm90ZToKCj4gRm9yIG5ldyB0ZXN0IGNhc2Ugc3VjaCBh
cyBraWxsMDEuYyBubyBuZWVkIHNwZWNpZmljIGNvbnRyb2xsZXIsIGl0IGp1c3QKPiBuZWVkIExU
UCBjZ3JvdXAgbGlicmFyeSBzdGFydCB3b3JrLCBzbyB3ZSBuZWVkIGFkZCBhICJjZ3JvdXAiIHBz
ZXVkbwo+IGNvbnRyb2xsZXIuCj4KPiBTaWduZWQtb2ZmLWJ5OiBXZWkgR2FvIDx3ZWdhb0BzdXNl
LmNvbT4KPiAtLS0KPiAgbGliL3RzdF9jZ3JvdXAuYyB8IDQ3ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrLS0tLS0tLS0tLS0tLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCAzMiBpbnNlcnRp
b25zKCspLCAxNSBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9saWIvdHN0X2Nncm91cC5j
IGIvbGliL3RzdF9jZ3JvdXAuYwo+IGluZGV4IDc3NTc1NDMxZC4uZWQzZTA3NThmIDEwMDY0NAo+
IC0tLSBhL2xpYi90c3RfY2dyb3VwLmMKPiArKysgYi9saWIvdHN0X2Nncm91cC5jCj4gQEAgLTk0
LDkgKzk0LDEwIEBAIGVudW0gY2dyb3VwX2N0cmxfaW5keCB7Cj4gICAgICAgICBDVFJMX01JU0Ms
Cj4gICAgICAgICBDVFJMX1BFUkZFVkVOVCwKPiAgICAgICAgIENUUkxfREVCVUcsCj4gLSAgICAg
ICBDVFJMX1JETUEKPiArICAgICAgIENUUkxfUkRNQSwKPiArICAgICAgIENUUkxfUFNFVURPCj4g
IH07Cj4gLSNkZWZpbmUgQ1RSTFNfTUFYIENUUkxfUkRNQQo+ICsjZGVmaW5lIENUUkxTX01BWCBD
VFJMX1BTRVVETwo+CgpJIHZvdGUgZm9yIGNvbnNpZGVyaW5nIHVzZSBvZiAnQ1RSTF9CQVNFJyAo
c3VnZ2VzdGVkIGJ5IENyeWlsKSwKYmVjYXVzZSBoZXJlIHdlIGluZGVlZCB1c2UgdGhlIGJhc2lj
IGZ1bmN0aW9uYWxpdHkgb2YgQ2dyb3VwVgogYnV0IG5vdCBhIHBzZXVkbyBjb250cm9sbGVyLgoK
T3RoZXJ3aXNlLCB0aGUgcmVzdCBsb29rcyBnb29kIHRvIG1lLgoKPT09PT09PT09PT09PT09PT09
PT09PT0KCkBDcnlpbCwgQFJpY2hhcmQKCkFwYXJ0IGZyb20gdGhhdCwgdGhlcmUgaXMgYW5vdGhl
ciBwcm9ibGVtIHdpdGggdGhlIHRlc3QgbG9naWMKb2YgdGhpcyBsaWJyYXJ5LCB0aGF0IGl0IHBv
dGVudGlhbGx5IG1peGVkIENncm91cCBWMSBhbmQgVjIKdG9nZXRoZXIgdG8gYmUgbW91bnRlZCBh
dCB0aGUgc2FtZSB0aW1lLiBUaGUgc2NlbmFyaW8KaGFwcGVucyBvbmNlIHNvbWVvbmUganVzdCBy
ZXF1ZXN0cyBDVFJMX0JBU0UKKG9yIGNvbnRyb2xsZXJzIG5vdCBtb3VudGVkKSBvbiBhIFYxLW1v
dW50ZWQgc3lzdGVtLgoKVXBzdHJlYW0gYWx3YXlzIG9iamVjdGVkIHRvIGVuYWJsaW5nIENncm91
cCBsaWtlIHRoYXQsCndoaWNoIGJyaW5ncyBtYW55IHVuZXhwZWN0ZWQgaXNzdWUgZHVyaW5nIHRo
ZSB0ZXN0LgoKU28gSSB3b3VsZCBzdHJvbmdseSBzdWdnZXN0IGF2b2lkaW5nIExUUCBtb3VudCBW
MSZWMgpldmVuIGlmIHRoZXJlIGlzIG5vIG92ZXJsYXAgaW4gY29udHJvbGxlcnMuCgpXaGljaCBz
aG91bGQgYmUgYWNoaWV2ZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaDoKKGRvY3VtZW50IHNob3VsZCBi
ZSB1cGRhdGVkIGFzIHdlbGwpCgotLS0gYS9saWIvdHN0X2Nncm91cC5jCisrKyBiL2xpYi90c3Rf
Y2dyb3VwLmMKQEAgLTgyOCwxMyArODI4LDE0IEBAIHZvaWQgdHN0X2NnX3JlcXVpcmUoY29uc3Qg
Y2hhciAqY29uc3QgY3RybF9uYW1lLAogICAgICAgIGlmIChjdHJsLT5jdHJsX3Jvb3QpCiAgICAg
ICAgICAgICAgICBnb3RvIG1rZGlyczsKCi0gICAgICAgaWYgKCFjZ3JvdXBfdjJfbW91bnRlZCgp
ICYmIG9wdGlvbnMtPm5lZWRzX3ZlciAhPSBUU1RfQ0dfVjEpCisgICAgICAgaWYgKCFjZ3JvdXBf
djJfbW91bnRlZCgpICYmIG9wdGlvbnMtPm5lZWRzX3ZlciAhPSBUU1RfQ0dfVjEKKyAgICAgICAg
ICAgICAgICAgICAgICAgJiYgIWNncm91cF92MV9tb3VudGVkKCkpCiAgICAgICAgICAgICAgICBj
Z3JvdXBfbW91bnRfdjIoKTsKCiAgICAgICAgaWYgKGN0cmwtPmN0cmxfcm9vdCkKICAgICAgICAg
ICAgICAgIGdvdG8gbWtkaXJzOwoKLSAgICAgICBpZiAob3B0aW9ucy0+bmVlZHNfdmVyICE9IFRT
VF9DR19WMikKKyAgICAgICBpZiAob3B0aW9ucy0+bmVlZHNfdmVyICE9IFRTVF9DR19WMiAmJiAh
Y2dyb3VwX3YyX21vdW50ZWQoKSkKICAgICAgICAgICAgICAgIGNncm91cF9tb3VudF92MShjdHJs
KTsKCiAgICAgICAgaWYgKHBzZXVkbykKCgoKLS0gClJlZ2FyZHMsCkxpIFdhbmcKCi0tIApNYWls
aW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5mby9sdHAK
