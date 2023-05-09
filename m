Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B7C7C7EE22
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 14:09:50 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 2A8093CE143
	for <ltp@archiver.kernel.org>; Tue,  9 May 2023 16:09:48 +0200 (CEST)
Received: from in-4.smtp.seeweb.it (in-4.smtp.seeweb.it [217.194.8.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-384))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6DABB3CBAB1
 for <ltp@lists.linux.it>; Tue,  9 May 2023 16:09:38 +0200 (CEST)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by in-4.smtp.seeweb.it (Postfix) with ESMTPS id E82A31000444
 for <ltp@lists.linux.it>; Tue,  9 May 2023 16:09:37 +0200 (CEST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0C46521A4D;
 Tue,  9 May 2023 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
 t=1683641377; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrGBumI9oUHUJiwUirEug96saFnZjzHV4SbjCIi3nfs=;
 b=PzHVN7dZr6VrY/tfsckt/NOoGiv+F7T1e+NBWDY1Gl/5fZUsgaW2E3aRyXBb7uRYtevkoD
 M0GuAkQTllwMGJKc3Mx+qt4aRt2I7iDA41zTtPjbm8Vx4rmO/LJEajmkqgW18MCAxWFmu+
 54f6Ce2KLoLRQJ0SelMGBL7eR2iQXbE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
 s=susede2_ed25519; t=1683641377;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JrGBumI9oUHUJiwUirEug96saFnZjzHV4SbjCIi3nfs=;
 b=a4k2DpJKxt59iGAYpVA84dilFN6XLqYeEQAPId4XnB27anevNSxOhm6chm64hsr3ENnWvr
 J0Hy8LMgWYIx0MAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id EABA6139B3;
 Tue,  9 May 2023 14:09:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id eAikOCBUWmSFfwAAMHmgww
 (envelope-from <chrubis@suse.cz>); Tue, 09 May 2023 14:09:36 +0000
Date: Tue, 9 May 2023 16:10:35 +0200
From: Cyril Hrubis <chrubis@suse.cz>
To: Pengfei Xu <pengfei.xu@intel.com>
Message-ID: <ZFpUW8OAYPVViMBv@yuki>
References: <cover.1683274510.git.pengfei.xu@intel.com>
 <efa47acd652c93a54fb66e17183524b54e561533.1683274510.git.pengfei.xu@intel.com>
 <ZFo1hUZCCXbfhEXY@yuki> <ZFpTIVcGoMTKyRCD@xpf.sh.intel.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ZFpTIVcGoMTKyRCD@xpf.sh.intel.com>
X-Virus-Scanned: clamav-milter 0.102.4 at in-4.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [PATCH v1 1/1] libs: libltpnuma: Fix one fake failure
 when CXL(Compute eXpress Link) node memory is not used
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
Cc: Heng Su <heng.su@intel.com>, rpalethorpe@suse.com, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

SGkhCj4gIyAuL2dldF9tZW1wb2xpY3kwMQo+IHRzdF90ZXN0LmM6MTU2MDogVElORk86IFRpbWVv
dXQgcGVyIHJ1biBpcyAwaCAwMG0gMzBzCj4gdHN0X251bWEuYzoyMDg6IFRJTkZPOiBGb3VuZCAz
IE5VTUEgbWVtb3J5IG5vZGVzCj4gdHN0X251bWEuYzoxNjI6IFRXQVJOOiBGYWllbGQgdG8gcGFy
c2UgJy9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9ub2RlMC9tZW1pbmZvJyBNZW1Vc2VkOjY1MjIw
MjkyCj4gdHN0X251bWEuYzoxNjI6IFRXQVJOOiBGYWllbGQgdG8gcGFyc2UgJy9zeXMvZGV2aWNl
cy9zeXN0ZW0vbm9kZS9ub2RlMS9tZW1pbmZvJyBNZW1Vc2VkOjY1MTY3Nzg0Cj4gdHN0X251bWEu
YzoxNjI6IFRXQVJOOiBGYWllbGQgdG8gcGFyc2UgJy9zeXMvZGV2aWNlcy9zeXN0ZW0vbm9kZS9u
b2RlMi9tZW1pbmZvJyBNZW1Vc2VkOjQxOTQzMDQKPiBnZXRfbWVtcG9saWN5MDEuYzoxNDk6IFRD
T05GOiB0ZXN0IHJlcXVpcmVzIGF0IGxlYXN0IG9uZSBOVU1BIG1lbW9yeSBub2RlCj4gTm9kZSAw
IGFuZCAxIGNvdWxkIG5vdCBiZSB0ZXN0ZWQgd2l0aCBmb2xsb3cgcGF0Y2ggaW5zdGFsbGVkLCBz
ZWVtcyB3aGVuCj4gbm9kZTIvbWVtaW5mbyAiTWVtVXNlZDogMCLvvIxzc2NhbmYoIi4uLiVsaSIs
ICZ2YWwpIHdpbGwgcmV0dXJuIDAgaWYgb25seSAwIHZhbHVlCj4gd2lsbCBiZSBzY2FuZWQsIGFu
ZCB0aGUgd2hpbGUgbG9vcCB3aWxsIHNjYW4gdGhlIGNoYXIgb25lIGJ5IG9uZSBhbmQgaW1wYWN0
IGFsbAo+IG90aGVyIG5vZGUgbWVtaW5mbyBzY2FuIHJlc3VsdCwgaXQncyBzdHJhbmdlLgo+IAo+
IElmIHVzZWQgbXkgcGF0Y2gsIEkgZGlkbid0IG1lZXQgdGhpcyBpc3N1ZS4KCkFoLCByaWdodCB0
aGUgZmlsZSBpcyBtdWx0aWxpbmUgYW5kIHdlIG1hdGNoIG9ubHkgb25lIG9mIHRoZSBsaW5lcyBw
ZXIKaXRlcmF0aW9uLi4uCgpUaGVuIHdlIG5lZWQ6CgpkaWZmIC0tZ2l0IGEvbGlicy9saWJsdHBu
dW1hL3RzdF9udW1hLmMgYi9saWJzL2xpYmx0cG51bWEvdHN0X251bWEuYwppbmRleCBlZjRjOGU4
NzkuLmMzMjk3MDEzYiAxMDA2NDQKLS0tIGEvbGlicy9saWJsdHBudW1hL3RzdF9udW1hLmMKKysr
IGIvbGlicy9saWJsdHBudW1hL3RzdF9udW1hLmMKQEAgLTEyNyw4ICsxMjcsOCBAQCBzdGF0aWMg
aW50IG5vZGVfaGFzX2Vub3VnaF9tZW1vcnkoaW50IG5vZGUsIHNpemVfdCBtaW5fa2IpCiB7CiAg
ICAgICAgY2hhciBwYXRoWzEwMjRdOwogICAgICAgIGNoYXIgYnVmWzEwMjRdOwotICAgICAgIGxv
bmcgbWVtX3RvdGFsID0gMDsKLSAgICAgICBsb25nIG1lbV91c2VkID0gMDsKKyAgICAgICBsb25n
IG1lbV90b3RhbCA9IC0xOworICAgICAgIGxvbmcgbWVtX3VzZWQgPSAtMTsKICAgICAgICBsb25n
IGZpbGVfcGFnZXMgPSAwOwogICAgICAgIGxvbmcgbWVtX2F2YWlsOwoKQEAgLTE2MSw3ICsxNjEs
NyBAQCBzdGF0aWMgaW50IG5vZGVfaGFzX2Vub3VnaF9tZW1vcnkoaW50IG5vZGUsIHNpemVfdCBt
aW5fa2IpCgogICAgICAgIGZjbG9zZShmcCk7CgotICAgICAgIGlmICghbWVtX3RvdGFsIHx8ICFt
ZW1fdXNlZCkgeworICAgICAgIGlmIChtZW1fdG90YWwgPT0gLTEgfHwgbWVtX3VzZWQgPT0gLTEp
IHsKICAgICAgICAgICAgICAgIHRzdF9yZXMoVFdBUk4sICJGYWlsZWQgdG8gcGFyc2UgJyVzJyIs
IHBhdGgpOwogICAgICAgICAgICAgICAgcmV0dXJuIDA7CiAgICAgICAgfQoKLS0gCkN5cmlsIEhy
dWJpcwpjaHJ1YmlzQHN1c2UuY3oKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0
cy5saW51eC5pdC9saXN0aW5mby9sdHAK
