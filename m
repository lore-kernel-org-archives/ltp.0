From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 26 Jul 2016 11:32:06 +0200
Subject: [LTP] [PATCH] Fix clock_nanosleep01 overall test status
In-Reply-To: <20160725071737.GA22484@issan.sis.pasteur.fr>
References: <20160725071737.GA22484@issan.sis.pasteur.fr>
Message-ID: <20160726093206.GA12226@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Please find a small patch that fix the clock_nanosleep01 overall test
> status. It removes the TERRNO flag which will wrongly report the last
> test error ...

Not that this is wrong but I would rather see the test print one
PASS/FAIL per each do_test() call.

And ideally get rid of the excessive and obvious comments (in a separate
patch) as well.

-- 
Cyril Hrubis
chrubis@suse.cz
