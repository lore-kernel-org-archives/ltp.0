From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 22 Aug 2017 16:50:04 +0200
Subject: [LTP] Test case float_trigo Reading dsin error
In-Reply-To: <9b9cf670-cc80-1083-3401-c2191d227f5b@de.bosch.com>
References: <9b9cf670-cc80-1083-3401-c2191d227f5b@de.bosch.com>
Message-ID: <20170822145003.GA26138@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I have faced recently an issue with an imx6 target which is running 
> kernel version "3.14" for the below tests:
> 
> float_bessel
> float_exp_log
> float_power
> float_trigo
> 
> these tests are failing and giving an error of thread termination "No 
> such file or directory". Please find a log below. any reason why that 
> happened and how can this be solved ?
> 
> target:/opt/ltp/testcases/bin# ./float_trigo
> float_trigo 1 TPASS : Test passed
> float_trigo 1 TFAIL : main.c:292: thread 100 (sin) terminated
> unsuccessfully 0 errors/0 loops
> FAIL: sin: reading dsin, No such file or directory
> float_trigo 2 TFAIL : main.c:292: thread 101 (sin) terminated
> unsuccessfully 0 errors/0 loops
> FAIL: sin: reading dsin, No such file or directory
> float_trigo 3 TFAIL : main.c:292: thread 102 (sin) terminated
> unsuccessfully 0 errors/0 loops
> FAIL: sin: reading dsin, No such file or directory
> float_trigo 4 TFAIL : main.c:292: thread 103 (sin) terminated
> unsuccessfully 0 errors/0 loops
> FAIL: sin: reading dsin, No such file or directory
> ....
> ....
> ....
> float_trigo 40 TFAIL : main.c:292: thread 139 (tan) terminated
> unsuccessfully 0 errors/0 loops
> FAIL: tan: reading dtan, No such file or directory
> float_trigo 41 TFAIL : main.c:41: Test failed
> 
> I have no idea why the generation of files such asin, atan, acos works 
> but doesn't work for dsin and dtan ?

Looks like it starts to fail in the middle of the test, that is really
strange. Have you checked that gensin and gentan binaries are working
fine (create non-empty rsin and dsin as well as rtan and dtan
files)?

-- 
Cyril Hrubis
chrubis@suse.cz
