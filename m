From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 29 Aug 2018 19:30:12 +0200
Subject: [LTP] [PATCH 1/2] Make shell lib tests standalone
In-Reply-To: <20180829172448.GA2960@dell5510>
References: <20180522193430.20117-2-pvorel@suse.cz>
 <20180828111844.20152-1-clanig@suse.com>
 <20180829172448.GA2960@dell5510>
Message-ID: <20180829173011.GA15171@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Christian,

> $ sed -ne '/^# output:/,$ p;' lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh | sed '1d'
> # test 1 TPASS: Test 1 passed with data 'foo:bar:d'
> # test 2 TPASS: Test 2 passed with data 'foo:bar:d'
> # test 3 TPASS: Test 1 passed with data 'dd'
> # test 4 TPASS: Test 2 passed with data 'dd'

Sorry, this is the correct command:
$ sed -ne '/^# output:/,$ p;' lib/newlib_tests/shell/test.TST_TEST_DATA.TST_CNT.separate.sh | sed '1d; s/^# //'
test 1 TPASS: Test 1 passed with data 'foo:bar:d'
test 2 TPASS: Test 2 passed with data 'foo:bar:d'
test 3 TPASS: Test 1 passed with data 'dd'
test 4 TPASS: Test 2 passed with data 'dd'

But I bet other will be against keeping the output into the file.

+ It'd be nice to describe, how testing works - how to modify the output
(in README.md or at least in commit message).

Kind regards,
Petr
