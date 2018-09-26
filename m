From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 26 Sep 2018 17:01:12 +0200
Subject: [LTP] [RFC PATCH 3/3] Remove cron tests
In-Reply-To: <20180924085150.17555-4-pvorel@suse.cz>
References: <20180924085150.17555-1-pvorel@suse.cz>
 <20180924085150.17555-4-pvorel@suse.cz>
Message-ID: <20180926150111.GC5524@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> + remove admin_tools runtest file which run them (as a part of EAL2
> testsuite).

Can we get rid of the at_allow01 and at_deny01 tests as well?

Other than that this patchset looks good to me.

-- 
Cyril Hrubis
chrubis@suse.cz
