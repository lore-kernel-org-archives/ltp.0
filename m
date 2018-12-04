From: Li Wang <liwan@redhat.com>
Date: Tue, 4 Dec 2018 17:08:39 +0800
Subject: [LTP] [PATCH v4] fzsync: limit sampling time
In-Reply-To: <8361c9b264ceb4c212319fcb366d85a854495ffe.1543912963.git.jstancek@redhat.com>
References: <8361c9b264ceb4c212319fcb366d85a854495ffe.1543912963.git.jstancek@redhat.com>
Message-ID: <CAEemH2eLpM0UN9xOcnFQSKmx4_Wh1418sB=uL2PwiS0b0_-QMg@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: ltp@lists.linux.it

On Tue, Dec 4, 2018 at 4:46 PM Jan Stancek <jstancek@redhat.com> wrote:

> +       float rem_p = 1 - tst_timeout_remaining() / pair->exec_time_start;
> +
> +       if ((pair->exec_time_p * SAMPLING_SLICE < rem_p)
> +               && (pair->sampling > 0)) {
> +               tst_res(TINFO, "Stopped sampling at %d (out of %d) samples, "
> +                       "sampling time reached 50% of the total time limit",
> +                       pair->exec_loop, pair->min_samples);

'50%' can not be quoted correctly here, since it makes compiler regard
it as print symbol. Beside this tiny typo issue, I have no more
comment for V4.  LGTM.

../../include/tst_fuzzy_sync.h:592:3: warning: ' ' flag used with ‘%o’
gnu_printf format [-Wformat=]
   tst_res(TINFO, "Stopped sampling at %d (out of %d) samples, "
   ^
../../include/tst_fuzzy_sync.h:592:3: warning: format ‘%o’ expects a
matching ‘unsigned int’ argument [-Wformat=]

# ./shmctl05
tst_test.c:1085: INFO: Timeout per run is 0h 00m 20s
../../../../../include/tst_fuzzy_sync.h:594: INFO: Stopped sampling at
166 (out of 1024) samples, sampling time reached 5036122336437f the
total time limit

-- 
Regards,
Li Wang
