From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 7 Feb 2018 22:42:27 +0100
Subject: [LTP] X15: LTP getrandom02 Test timeouted, sending SIGKILL
In-Reply-To: <CA+G9fYuOYvXra+qKLYuJqHaNKYortPG0Quka=j8Me9RVztoobQ@mail.gmail.com>
References: <CA+G9fYuOYvXra+qKLYuJqHaNKYortPG0Quka=j8Me9RVztoobQ@mail.gmail.com>
Message-ID: <20180207214227.GB19939@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> LTP getrandom02 Test timeouted, sending SIGKILL on x15 running 4.4 kernel.
> 
> tst_test.c:934: INFO: Timeout per run is 0h 15m 00s
> getrandom02.c:72: PASS: getrandom returned 256
> getrandom02.c:72: PASS: getrandom returned 6
> getrandom02.c:72: PASS: getrandom returned 256
> Test timeouted, sending SIGKILL!
> tst_test.c:984: INFO: If you are running on slow machine, try
> exporting LTP_TIMEOUT_MUL > 1
> tst_test.c:985: BROK: Test killed! (timeout?)

Looking at the result the machine under test seem to be low at entropy
we got 6 bytes with the first use of GRND_RANDOM instead of 256 and it
timeouted the second time we try to read some random bytes.

The problem here is that the machine does not have enough entropy
sources to produce random bytes and given that it wasn't able to
generate any in 15 minutes may as well be a kernel bug.

-- 
Cyril Hrubis
chrubis@suse.cz
