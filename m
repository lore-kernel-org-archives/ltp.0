From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 14 Jul 2021 16:27:10 +0200
Subject: [LTP] [PATCH v5 0/4] Run tests in CI
In-Reply-To: <20210714142001.20566-1-pvorel@suse.cz>
References: <20210714142001.20566-1-pvorel@suse.cz>
Message-ID: <YO70PiTdyxzTw0k2@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi all,

tested:
https://github.com/pevik/ltp/actions/runs/1030551185

One thing which bothers me is mangled output of several tests together:
https://github.com/pevik/ltp/runs/3067600696?check_suite_focus=true#step:11:554

runtest TINFO: * tst_res_hexd
/__w/ltp/ltp/lib/tst_test.c:1344: TINFO: Timeout per run is 0h 05m 00s
/__w/ltp/ltp/lib/newlib_tests/tst_res_hexd.c:13: TPASS: dump1
/__w/ltp/ltp/lib/newlib_tests/tst_res_hexd.c:13: TPASS: 48 65 6c 6c 6f 20 66 72 6f 6d 20 74 73 74 5f 72
/__w/ltp/ltp/lib/newlib_tests/tst_res_hexd.c:13: TPASS: 65 73 5f 68 65 78 64 00

runtest TINFO: * tst_strstatus
/__w/ltp/ltp/lib/tst_test.c:1344: TINFO: Timeout per run is 0h 05m 00s

Summary:
passed   35
failed   0
broken   0
skipped  0
warnings 0

Summary:
passed   1
failed   0
broken   0
skipped  0
warnings 0

Kind regards,
Petr
