From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Sep 2020 14:49:22 +0200
Subject: [LTP] TPASS in new test lib
In-Reply-To: <87sgbgy946.fsf@suse.de>
References: <CY4PR13MB117565A7BA2A8371A3B94ED9FD200@CY4PR13MB1175.namprd13.prod.outlook.com>
 <20200916071106.GB1433@dell5510> <20200916085405.GB4464@yuki.lan>
 <87sgbgy946.fsf@suse.de>
Message-ID: <20200917124922.GC2352@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> It would be possible to output something like TAP and allow it to be set
> at compile time.
> 
> Infact it should be possible to print JSON, xUnit or whatever
> snippets. We could also print the meta data for each test at the
> begining which would work quite well with structured formats.

The only donwside would be that we have converted less than half of the
test to the new test library, so generating any structured format will
not fly for more than half of the testcases.

-- 
Cyril Hrubis
chrubis@suse.cz
