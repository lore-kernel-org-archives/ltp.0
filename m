Return-Path: <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from picard.linux.it (picard.linux.it [213.254.12.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFB68C5CFC1
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 08:06:51 +0000 (UTC)
Received: from picard.linux.it (localhost [IPv6:::1])
	by picard.linux.it (Postfix) with ESMTP id 5D01C3C53A6
	for <ltp@archiver.kernel.org>; Mon, 17 Aug 2026 10:06:49 +0200 (CEST)
Received: from in-2.smtp.seeweb.it (in-2.smtp.seeweb.it [217.194.8.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (secp384r1))
 (No client certificate requested)
 by picard.linux.it (Postfix) with ESMTPS id 6932D3C2B4E
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 10:06:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by in-2.smtp.seeweb.it (Postfix) with ESMTPS id E55CE600128
 for <ltp@lists.linux.it>; Mon, 17 Aug 2026 10:06:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786953992; x=1818489992;
 h=date:from:to:cc:subject:message-id:references:
 mime-version:content-transfer-encoding:in-reply-to;
 bh=f/rXjySSi5uRPJpLKDv9hpZIFg7DNCLQ8L1n0hDN3cw=;
 b=b7XhjV8YllEximxUwcyZTyVY526FZm7s3Fju0ch6g/or+lxEgbkZZaSh
 WosELG6FF8ZJlyd2IcaAxfF9k6lUyPLY4NyNlfYsaK5bV9iFG7n9CzLCL
 1D8K5316ror/35qOWbGfQJkPohGenI7Rk4QHEB2XVFSP+Z2DbKtaZFXR4
 nJTwfJmt2qC7gxwfb/H82x4S4F0luv32KFXqZujlXqNZN0HICDYAsB+2g
 OSKvXfy5a5qZziPh//R6h3oAE//uHs4TSn4Ta9UolxwU/6RVBw+FrISNy
 uknINYUcIT1B6atXxfEvioJGc37Q00h5kei+JnDv3DHLPoHegjbsHRBLv A==;
X-CSE-ConnectionGUID: c4iF0ccUTNC5QES2atdrNg==
X-CSE-MsgGUID: XrnS2A2HQSGXpwN2LZ84Mw==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="87278719"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="87278719"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 01:06:29 -0700
X-CSE-ConnectionGUID: 5IBla2NOQm2AKJgdRpraAw==
X-CSE-MsgGUID: 7JJYIwm8STGZSrp3DaNFjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="268331176"
Received: from ly-workstation.sh.intel.com (HELO ly-workstation)
 ([10.239.182.64])
 by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 01:06:27 -0700
Date: Mon, 17 Aug 2026 16:06:24 +0800
From: kernel test rebot <yi1.lai@intel.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>
Message-ID: <aoLBAPxcXXG+i90Q@ly-workstation>
References: <202608170325.fbd7c808-lkp@intel.com>
 <bf700b2d-4593-41ee-bac2-6438b65e3720@tu-dortmund.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf700b2d-4593-41ee-bac2-6438b65e3720@tu-dortmund.de>
X-Virus-Scanned: clamav-milter 1.0.9 at in-2.smtp.seeweb.it
X-Virus-Status: Clean
Subject: Re: [LTP] [linux-next:master] [tun/tap & vhost] d00c7369ef:
 ltp.ioctl03.fail
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
Cc: lkp@intel.com, netdev@vger.kernel.org,
 Tim Gebauer <tim.gebauer@tu-dortmund.de>, yi1.lai@intel.com,
 oe-lkp@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>, ltp@lists.linux.it
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: ltp-bounces+ltp=archiver.kernel.org@lists.linux.it
Sender: "ltp" <ltp-bounces+ltp=archiver.kernel.org@lists.linux.it>

T24gTW9uLCBBdWcgMTcsIDIwMjYgYXQgMDk6Mzk6MjZBTSArMDIwMCwgU2ltb24gU2NoaXBwZXJz
IHdyb3RlOgo+IE9uIDgvMTcvMjYgMDM6MzQsIGtlcm5lbCB0ZXN0IHJvYm90IHdyb3RlOgo+ID4g
Cj4gPiAKPiA+IEhlbGxvLAo+ID4gCj4gPiBrZXJuZWwgdGVzdCByb2JvdCBub3RpY2VkICJsdHAu
aW9jdGwwMy5mYWlsIiBvbjoKPiA+IAo+ID4gY29tbWl0OiBkMDBjNzM2OWVmMjRhYzhlMDM4M2Rl
MGZkOGVmMzM4NGRlMjBiY2ZhICgidHVuL3RhcCAmIHZob3N0LW5ldDogc3RvcCB0YWlsLWRyb3Ag
d2hlbiBJRkZfQkFDS1BSRVNTVVJFIGlzIHNldCIpIGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvY2dp
dC9saW51eC9rZXJuZWwvZ2l0L25leHQvbGludXgtbmV4dC5naXQgbWFzdGVyCj4gPiAKPiA+IFt0
ZXN0IGZhaWxlZCBvbiBsaW51eC1uZXh0L21hc3RlciA0NDc3YTc4Mzc0YTU3YzM4MDliMTcyYWQz
MGNjZWFiZGE0OGM0N2M2XQo+ID4g4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA
4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSA4pSACj4gPiAgICAgICBURVNUIFNVTU1B
UlkKPiA+IOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKUgOKU
gOKUgOKUgOKUgOKUgOKUgOKUgOKUgAo+ID4gU3VpdGU6ICAgc3lzY2FsbHMtMDMKPiA+IFJ1bnRp
bWU6IDNtIDRzCj4gPiBSdW5zOiAgICAxODYKPiA+IAo+ID4gUmVzdWx0czoKPiA+ICAgICBQYXNz
ZWQ6ICAgMjE3NAo+ID4gICAgIEZhaWxlZDogICAxCj4gPiAgICAgQnJva2VuOiAgIDAKPiA+ICAg
ICBTa2lwcGVkOiAgMjIyCj4gPiAgICAgV2FybmluZ3M6IDAKPiA+IAo+ID4gIFsxOzMxbUZhaWx1
cmVzOiBbMG0KPiA+ICAgICDigKIgaW9jdGwwMwo+IAo+IFRoZSBzYW1lIGhhcm1sZXNzIHJlcG9y
dCBhcyBiZWZvcmU6Cj4gCj4gaW9jdGwwMy5jIGRvZXMgbm90IGtub3cgYWJvdXQgSUZGX0JBQ0tQ
UkVTU1VSRSB3aGljaCBpcyBpbnRyb2R1Y2VkIGhlcmUsCj4gY29uc2VxdWVudGx5IGl0IGZhaWxz
Lgo+IFNlZSBbMV0gd2hlcmUgaXQgY29tcGFyZXMgVFVOIGZlYXR1cmVzIHdpdGgga25vd25fZmxh
Z3MuCj4gCj4gVGhhbmtzLgoKVGhhbmtzIGZvciB0aGUgcmVzcG9uc2UuIEkganVzdCBub3RpY2Vk
IHRoYXQgaXQncyByZXBvcnRlZCBiZWZvcmUuIFNvcnJ5CmZvciB0aGUgZHVwbGljYXRpb24uCgo+
IAo+IFsxXSBMaW5rOiBodHRwczovL2dpdGh1Yi5jb20vbGludXgtdGVzdC1wcm9qZWN0L2x0cC9i
bG9iL21hc3Rlci90ZXN0Y2FzZXMva2VybmVsL3N5c2NhbGxzL2lvY3RsL2lvY3RsMDMuYyNMODIK
PiAKCi0tIApNYWlsaW5nIGxpc3QgaW5mbzogaHR0cHM6Ly9saXN0cy5saW51eC5pdC9saXN0aW5m
by9sdHAK
