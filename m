From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 16 Sep 2020 10:43:56 +0200
Subject: [LTP] TPASS in new test lib
In-Reply-To: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
References: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
Message-ID: <20200916084356.GA4464@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Well, Fuego's parser only checks for PASS (probably due to the inconsistency),
> but personally I'd prefer if it was consistent. The string "TPASS" is much less
> likely to appear in unrelated output than "PASS" is.

The official runltp script checks for exit values from the test
processes, anything else, such as parsing test output, may not work
properly and will not work for at least subset of the tests that does
not use the test library.

-- 
Cyril Hrubis
chrubis@suse.cz
