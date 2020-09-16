From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Sep 2020 10:54:05 +0200
Subject: [LTP] TPASS in new test lib
In-Reply-To: <20200916071106.GB1433@dell5510>
References: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200916071106.GB1433@dell5510>
Message-ID: <20200916085405.GB4464@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Although leaving this to Cyril (although having T prefix or not is quite
> cosmetic, he had a reason to omit it).  Also there is ongoing rewrite of tests
> still using legacy API to use new API, thus the inconsistency will disappear in
> the long term.
> 
> IMHO: don't care that much about legacy API, but synchronize new C and shell
> API.

I do not care that much here, but I do not think that we should expect
exact test output unless we have specified it somewhere.

-- 
Cyril Hrubis
chrubis@suse.cz
