From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 28 Mar 2017 11:39:26 +0200
Subject: [LTP] [PATCH 2/4] Test for CVE-2016-4997 on setsockopt
In-Reply-To: <20170327180812.37a590ea@linux-v3j5>
References: <20170323162633.7e49c7ae@linux-v3j5>
 <20170327153439.GD21272@rei.lan>
 <20170327180812.37a590ea@linux-v3j5>
Message-ID: <20170328093926.GC1045@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Yes, I think that is best, but passing -m32 to the test's make target does not
> cause the LTP library to be compiled with -m32 so linking fails. I'm not sure
> how to get it to build both binaries.

I've hacked around a bit and managed to write a code that builds 32bit
library if compiler supports -m32 and also switches between 64bit or
32bit library depending on CFLAGS used to build the test. I will send it
as RFC to the LTP ML.

-- 
Cyril Hrubis
chrubis@suse.cz
