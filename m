From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 20 Nov 2020 14:04:35 +0100
Subject: [LTP] [PATCH v3] getdents: update to the new api,
 don't mix libc and kernel types
In-Reply-To: <OF2A463655.07C868E8-ONC1258626.00412BF5-C1258626.0041A363@avm.de>
References: <20201119130046.GA12628@yuki.lan> <20201118135852.GA13912@yuki.lan>
 <OFFFCF0315.CB01D2B7-ONC125861F.003C7A03-C1258622.0045EF86@avm.de>
 <OFFDAAA0B7.3C11EE41-ONC1258625.002F2EA3-C1258625.002FFCAE@avm.de>
 <OF2A463655.07C868E8-ONC1258626.00412BF5-C1258626.0041A363@avm.de>
Message-ID: <20201120130435.GA20520@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a minor changes, thanks.

* Removed the GPL license text since it's replaced by the SPDX identifier

* Formatted the test description into asciidoc and changed the comment
  so that it's picked up by documentation parser

* Checked explictily for -1 return value in negative test

* Made use of TERROR flags instead of usings strerror() to print errnos

-- 
Cyril Hrubis
chrubis@suse.cz
