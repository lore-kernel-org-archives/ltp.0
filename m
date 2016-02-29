From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 29 Feb 2016 12:00:42 +0100
Subject: [LTP] FW: LTP test coverage ?
In-Reply-To: <A5742185B24D384D94B12AC758A6D91701BF3F15@BGSMSX101.gar.corp.intel.com>
References: <A5742185B24D384D94B12AC758A6D91701BF3EA7@BGSMSX101.gar.corp.intel.com>
 <A5742185B24D384D94B12AC758A6D91701BF3F15@BGSMSX101.gar.corp.intel.com>
Message-ID: <20160229110042.GA8422@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Does LTP covers Ethernet and NAND components on Yocto Linux.

What exactly do you mean by "covers" here?

There are network testcases in LTP and there are filesystem tests that
will utilize both. But you are looking for something that would test the
device drivers directly then the answer is no.

-- 
Cyril Hrubis
chrubis@suse.cz
