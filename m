From: Jan Stancek <jstancek@redhat.com>
Date: Mon, 4 Feb 2019 04:05:25 -0500 (EST)
Subject: [LTP] [PATCH v2] mtest06/mmap1: rewrite to newlib
In-Reply-To: <CA+G9fYv1707K7G0x3cFVC9HXtwuwMVZLUp+6-qe6+14pi0sNhw@mail.gmail.com>
References: <0e62adebbb4e5c8e3aa28440f860234b937d3e56.1543219161.git.jstancek@redhat.com>
 <20181129134411.GA22216@rei.lan>
 <2002461812.80702248.1543571192512.JavaMail.zimbra@redhat.com>
 <CA+G9fYv1707K7G0x3cFVC9HXtwuwMVZLUp+6-qe6+14pi0sNhw@mail.gmail.com>
Message-ID: <789893356.100703597.1549271125534.JavaMail.zimbra@redhat.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it




----- Original Message -----
> FYI,
> 
> mtest06/mmap1.c fails intermittently on arm64 devices due to timeout reason.
> The current timeout set as 15 minutes
> export LTP_TIMEOUT_MUL=3
> 
> Test case output:
> -----------------------
> tst_test.c:1085: INFO: Timeout per run is 0h 15m 00s
> tst_test.c:1085: INFO: Timeout per run is 0h 09m 00s
> mmap1.c:234: INFO: [3] mapped: 15000, sigsegv hit: 11375, threads spawned: 6
> mmap1.c:237: INFO: [3] repeated_reads: 67, data_matched: 3440667
> mmap1.c:234: INFO: [6] mapped: 30000, sigsegv hit: 21256, threads spawned: 12
> mmap1.c:237: INFO: [6] repeated_reads: 2530, data_matched: 8455962
> mmap1.c:234: INFO: [9] mapped: 40000, sigsegv hit: 28215, threads spawned: 16
> mmap1.c:237: INFO: [9] repeated_reads: 4413, data_matched: 11314629
> mmap1.c:234: INFO: [12] mapped: 55000, sigsegv hit: 38454, threads spawned:
> 22
> mmap1.c:237: INFO: [12] repeated_reads: 9285, data_matched: 15892633
> mmap1.c:234: INFO: [15] mapped: 60000, sigsegv hit: 42462, threads spawned:
> 24
> mmap1.c:237: INFO: [15] repeated_reads: 11993, data_matched: 16723333
> mmap1.c:234: INFO: [18] mapped: 65000, sigsegv hit: 46272, threads spawned:
> 26
> mmap1.c:237: INFO: [18] repeated_reads: 11993, data_matched: 18043857
> mmap1.c:234: INFO: [21] mapped: 80000, sigsegv hit: 58736, threads spawned:
> 32
> mmap1.c:237: INFO: [21] repeated_reads: 14467, data_matched: 20310080
> mmap1.c:234: INFO: [24] mapped: 85000, sigsegv hit: 62747, threads spawned:
> 34
> mmap1.c:237: INFO: [24] repeated_reads: 14467, data_matched: 21065412
> mmap1.c:234: INFO: [27] mapped: 95000, sigsegv hit: 67177, threads spawned:
> 38
> mmap1.c:237: INFO: [27] repeated_reads: 14467, data_matched: 26278412
> mmap1.c:234: INFO: [30] mapped: 110000, sigsegv hit: 75318, threads spawned:
> 44
> mmap1.c:237: INFO: [30] repeated_reads: 18749, data_matched: 32880471
> mmap1.c:234: INFO: [33] mapped: 130000, sigsegv hit: 86435, threads spawned:
> 52
> mmap1.c:237: INFO: [33] repeated_reads: 20987, data_matched: 41628336
> mmap1.c:234: INFO: [36] mapped: 150000, sigsegv hit: 95359, threads spawned:
> 60
> mmap1.c:237: INFO: [36] repeated_reads: 20987, data_matched: 52762236
> mmap1.c:234: INFO: [39] mapped: 175000, sigsegv hit: 107473, threads spawned:
> 70
> mmap1.c:237: INFO: [39] repeated_reads: 20987, data_matched: 65170250
> mmap1.c:234: INFO: [42] mapped: 195000, sigsegv hit: 115860, threads spawned:
> 78
> mmap1.c:237: INFO: [42] repeated_reads: 24446, data_matched: 76553410
> mmap1.c:234: INFO: [45] mapped: 220000, sigsegv hit: 130868, threads spawned:
> 88
> mmap1.c:237: INFO: [45] repeated_reads: 28657, data_matched: 86358966
> mmap1.c:234: INFO: [48] mapped: 245000, sigsegv hit: 145435, threads spawned:
> 98
> mmap1.c:237: INFO: [48] repeated_reads: 34613, data_matched: 96820804
> mmap1.c:234: INFO: [51] mapped: 260000, sigsegv hit: 154934, threads
> spawned: 104
> mmap1.c:237: INFO: [51] repeated_reads: 38042, data_matched: 102281865
> mmap1.c:234: INFO: [54] mapped: 280000, sigsegv hit: 168403, threads
> spawned: 112
> mmap1.c:237: INFO: [54] repeated_reads: 44799, data_matched: 108884699
> mmap1.c:234: INFO: [57] mapped: 305000, sigsegv hit: 188132, threads
> spawned: 122
> mmap1.c:237: INFO: [57] repeated_reads: 48995, data_matched: 113829351
> mmap1.c:234: INFO: [60] mapped: 315000, sigsegv hit: 196457, threads
> spawned: 126
> mmap1.c:237: INFO: [60] repeated_reads: 51657, data_matched: 115444681
> mmap1.c:234: INFO: [63] mapped: 330000, sigsegv hit: 208077, threads
> spawned: 132
> mmap1.c:237: INFO: [63] repeated_reads: 51657, data_matched: 118910807
> mmap1.c:234: INFO: [66] mapped: 335000, sigsegv hit: 211847, threads
> spawned: 134
> mmap1.c:237: INFO: [66] repeated_reads: 51657, data_matched: 119936305
> mmap1.c:234: INFO: [69] mapped: 355000, sigsegv hit: 225809, threads
> spawned: 142
> mmap1.c:237: INFO: [69] repeated_reads: 58357, data_matched: 125691672
> mmap1.c:234: INFO: [72] mapped: 365000, sigsegv hit: 233748, threads
> spawned: 146
> mmap1.c:237: INFO: [72] repeated_reads: 63594, data_matched: 127682094
> mmap1.c:234: INFO: [75] mapped: 375000, sigsegv hit: 240935, threads
> spawned: 150
> mmap1.c:237: INFO: [75] repeated_reads: 65813, data_matched: 130436913
> mmap1.c:234: INFO: [78] mapped: 395000, sigsegv hit: 256994, threads
> spawned: 158
> mmap1.c:237: INFO: [78] repeated_reads: 68240, data_matched: 134313071
> mmap1.c:234: INFO: [81] mapped: 400000, sigsegv hit: 260739, threads
> spawned: 160
> mmap1.c:237: INFO: [81] repeated_reads: 68240, data_matched: 135483078
> mmap1.c:234: INFO: [84] mapped: 405000, sigsegv hit: 263510, threads
> spawned: 162
> mmap1.c:237: INFO: [84] repeated_reads: 68240, data_matched: 137744513
> mmap1.c:234: INFO: [87] mapped: 415000, sigsegv hit: 271049, threads
> spawned: 166
> mmap1.c:237: INFO: [87] repeated_reads: 70071, data_matched: 140167936
> mmap1.c:234: INFO: [90] mapped: 430000, sigsegv hit: 282504, threads
> spawned: 172
> mmap1.c:237: INFO: [90] repeated_reads: 74335, data_matched: 143263860
> mmap1.c:234: INFO: [93] mapped: 435000, sigsegv hit: 286623, threads
> spawned: 174
> mmap1.c:237: INFO: [93] repeated_reads: 76581, data_matched: 144114430
> mmap1.c:234: INFO: [96] mapped: 445000, sigsegv hit: 292401, threads
> spawned: 178
> mmap1.c:237: INFO: [96] repeated_reads: 78725, data_matched: 148160778
> mmap1.c:234: INFO: [99] mapped: 450000, sigsegv hit: 296192, threads
> spawned: 180
> mmap1.c:237: INFO: [99] repeated_reads: 78725, data_matched: 149328825
> mmap1.c:234: INFO: [102] mapped: 460000, sigsegv hit: 304280, threads
> spawned: 184
> mmap1.c:237: INFO: [102] repeated_reads: 78725, data_matched: 151183014
> mmap1.c:234: INFO: [105] mapped: 465000, sigsegv hit: 308364, threads
> spawned: 186
> mmap1.c:237: INFO: [105] repeated_reads: 78725, data_matched: 152036389
> Test timeouted, sending SIGKILL!
> tst_test.c:1125: INFO: If you are running on slow machine, try
> exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:1126: BROK: Test killed! (timeout?)
> 
> Test results comparison,
> https://qa-reports.linaro.org/lkft/linux-mainline-oe/tests/ltp-mm-tests/mtest06
> 
> Any chance to minimize the test run time ?

Default is 3 minutes, but it appears to be getting stuck before that.
In [1], the output stopped after ~12-15 seconds, followed by timeout.

So either timeout arrived early (which seems unlikely) or test was stuck on something.

[1] https://qa-reports.linaro.org/lkft/linux-mainline-oe/build/v5.0-rc5/testrun/594677/log

