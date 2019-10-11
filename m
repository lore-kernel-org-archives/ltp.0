From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 11 Oct 2019 15:10:41 +0200
Subject: [LTP] Rename tst_test_* to tst_require_*
In-Reply-To: <1570799029.4238.15.camel@suse.de>
References: <20191011090737.17997-1-lkml@jv-coder.de>
 <20191011100604.GA11441@dell5510>
 <1570799029.4238.15.camel@suse.de>
Message-ID: <20191011131041.GA18363@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> If we use needs or require ? Hard question - when I search for synonyms
> from one or the other, I don't see a big different. Without looking on
> the impact, require sounds also more descriptive.

There is about thousand of uses of *NEEDS_FOO and *needs_foo in the new
library tests, so renaming to tst_needs_foo would be the least painful.

-- 
Cyril Hrubis
chrubis@suse.cz
