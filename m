From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 15 Nov 2016 11:32:06 +0100
Subject: [LTP] [PATCH 1/1] syscalls/clock_getres01: convert to use new
 test library API
In-Reply-To: <20161115095943.gi2iznk7x7su3r3n@dell5510>
References: <20161115095307.27985-1-pvorel@suse.cz>
 <20161115095943.gi2iznk7x7su3r3n@dell5510>
Message-ID: <20161115103205.GA13947@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > -static void setup(void)
> > -{
> > -	TEST_PAUSE;
> 
> I suppose TEST_PAUSE is somehow deprecated as it's in include/old/usctest.h.

Yep, the code even shouldn't compile if you include only tst_test.h
header.

-- 
Cyril Hrubis
chrubis@suse.cz
