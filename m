From: Li Wang <liwang@redhat.com>
Date: Fri, 22 Jan 2021 14:40:40 +0800
Subject: [LTP] [PATCH 1/1] swapping01: make test more robust
In-Reply-To: <CAEemH2cseOGtSem9vhChygLNeYz6E0bVEu+u-UH8agLBoHJo4Q@mail.gmail.com>
References: <20210115143246.369676-1-egorenar@linux.ibm.com>
 <CAEemH2fDzPp3D6KZ_G0UDbS=eh2tWDAcy7CTt_4Yw7FUT4zGxg@mail.gmail.com>
 <87zh14rrxm.fsf@oc8242746057.ibm.com> <YAgmPjaf8iRn20x2@pevik>
 <CAEemH2cseOGtSem9vhChygLNeYz6E0bVEu+u-UH8agLBoHJo4Q@mail.gmail.com>
Message-ID: <CAEemH2e=ySuT+JEoDkF0e0TYeooeZbT0mu4D+47NLjwvsPecnA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Alex, Petr,

I'm going to apply Alex's patch after a round of testing[1].
Because giving more time waiting for swap memory to
settle is no harm to test, at least help to get rid of failures
observed on LPAR so far.

But I still think the swapping01 not very precise to some degree.
We probably need to rewrite it someday but currently, I have no better idea.

[1] Running a stress-ng to eat some available memory in the
background, then swapping01 easily hit the heavy-swap issue.
This could be proved that it influenced by deamon allocate/free
memory during testing.

# stress-ng to eat memory after starting swapping01

# ./swapping01 -i 5
tst_test.c:1263: TINFO: Timeout per run is 0h 05m 00s
swapping01.c:107: TINFO: available physical memory: 4660 MB
swapping01.c:109: TINFO: try to allocate: 6058 MB
swapping01.c:112: TINFO: memory allocated: 6058 MB
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 4738304, swap_consum(swap_free_init - swap_free_now) =
1282816
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 4746496, swap_consum(swap_free_init - swap_free_now) =
1274624
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 4616640, swap_consum(swap_free_init - swap_free_now) =
1404480
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 4191936, swap_consum(swap_free_init - swap_free_now) =
1829184
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 3339776, swap_consum(swap_free_init - swap_free_now) =
2681344
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 3070336, swap_consum(swap_free_init - swap_free_now) =
2950784
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 2763136, swap_consum(swap_free_init - swap_free_now) =
3257984
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 2377280, swap_consum(swap_free_init - swap_free_now) =
3643840
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 1876544, swap_consum(swap_free_init - swap_free_now) =
4144576
swapping01.c:135: TINFO: DEBUG-INFO: swap_free_init = 6021120,
swap_free_now = 1274432, swap_consum(swap_free_init - swap_free_now) =
4746688
swapping01.c:150: TFAIL: heavy swapping detected: 5075 MB swapped.

-- 
Regards,
Li Wang
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.linux.it/pipermail/ltp/attachments/20210122/6e44c4c4/attachment-0001.htm>
