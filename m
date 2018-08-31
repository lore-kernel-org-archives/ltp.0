From: Cyril Hrubis <chrubis@suse.cz>
Date: Fri, 31 Aug 2018 13:46:11 +0200
Subject: [LTP] [PATCH 1/2] Make shell lib tests standalone
In-Reply-To: <20180828111844.20152-1-clanig@suse.com>
References: <20180522193430.20117-2-pvorel@suse.cz>
 <20180828111844.20152-1-clanig@suse.com>
Message-ID: <20180831114611.GB30263@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST.TST_CNT.separate.sh (95%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST.TST_CNT.sh (95%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST.getopts.sh (96%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST.sh (95%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.TST_CNT.separate.sh (96%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.TST_CNT.sh (96%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.getopts.sh (96%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA.sh (95%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA_IFS.getopts.sh (97%)
>  rename lib/newlib_tests/{ => shell}/test.TST_TEST_DATA_IFS.sh (96%)

Just small comment, I do wonder if top level lib/ directory is correct
for the shell tests since the shell library is located at testcases/lib/
(for a historical reasons). Maybe we should just create a 'test' directory
under 'testcases/lib/' instead.

-- 
Cyril Hrubis
chrubis@suse.cz
