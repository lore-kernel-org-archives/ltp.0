From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Jan 2019 12:23:11 +0100
Subject: [LTP] [PATCH v6 ltp] Add Intel umip(User Mode Instruction
 Prevention) basic function tests
In-Reply-To: <20190117144444.11427-1-pengfei.xu@intel.com>
References: <20190117144444.11427-1-pengfei.xu@intel.com>
Message-ID: <20190123112311.GC1787@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Pushed with a few changes, thanks!

* added the kconfig requirement to the tst_test structure
* the whole test is now in #ifdef __x86_64__
  (otherwise the asm statements would fail to compile on other
  architectures)
* moved the runtest entry to kernel_misc
  (in order to avoid having runtest files with just one entry)

-- 
Cyril Hrubis
chrubis@suse.cz
