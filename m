From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 16 Jan 2020 17:02:44 +0100
Subject: [LTP] ??? FAIL: Test report for kernel 5.4.12-rc1-5c903e1.cki
 (stable)
In-Reply-To: <cki.04B50782AB.76013V5U5A@redhat.com>
References: <cki.04B50782AB.76013V5U5A@redhat.com>
Message-ID: <20200116160244.GC558@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
This looks like max_map_count failure again.

...
<<<test_output>>>
tst_test.c:1215: INFO: Timeout per run is 0h 05m 00s
mem.c:817: INFO: set overcommit_memory to 2
mem.c:817: INFO: set max_map_count to 1024
max_map_count.c:198: PASS: 1024 map entries in total as expected.
mem.c:817: INFO: set max_map_count to 2048
max_map_count.c:198: PASS: 2048 map entries in total as expected.
mem.c:817: INFO: set max_map_count to 4096
max_map_count.c:198: PASS: 4096 map entries in total as expected.
mem.c:817: INFO: set max_map_count to 8192
max_map_count.c:198: PASS: 8192 map entries in total as expected.
mem.c:817: INFO: set max_map_count to 16384
max_map_count.c:198: PASS: 16384 map entries in total as expected.
mem.c:817: INFO: set max_map_count to 32768
max_map_count.c:198: PASS: 32768 map entries in total as expected.
mem.c:817: INFO: set max_map_count to 65536
max_map_count.c:201: FAIL: 65273 map entries in total, but expected 65536 entries
mem.c:817: INFO: set max_map_count to 1024
max_map_count.c:198: PASS: 1024 map entries in total as expected.
...

-- 
Cyril Hrubis
chrubis@suse.cz
