From: Martin Doucha <mdoucha@suse.cz>
Date: Tue, 14 Apr 2020 12:05:51 +0200
Subject: [LTP] LTP testcase analysis
In-Reply-To: <MAXPR0101MB14684E021A23A6B00ED69DC0EEDA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
References: <MAXPR0101MB14684E021A23A6B00ED69DC0EEDA0@MAXPR0101MB1468.INDPRD01.PROD.OUTLOOK.COM>
Message-ID: <dbe77a95-1f43-8d74-5c8d-a06e465d3cca@suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

On 14. 04. 20 10:45, Pankaj Vinadrao Joshi wrote:
> Hi,
> i am running LTP on x86 with 5.4.3 kernel.i gave $ ./runltp command to
> run the complete LTP but found some failures,like
> oom01,futex_wait05,select04 etc.
> 
> When i tried to run single test some of them turns into PASS which
> earlier got failed.like oom01 was failed then i gave coomand $./runltp
> -s oom01 and after that it got pass.
> 
> why it could be happened,any specific reason,if you know please suggest??

The most common errors for futex_wait and select tests are "$SYSCALL
slept too long". These errors usually happen when you run the test in a
VM on overloaded host because the VM doesn't get enough CPU time to wake
the test process up within time limit.

OOM tests have issues in the mlock() test case. OOM killer is blocked by
mlock() which usually results in the parent shell being killed instead
of the expected OOM victim. This is a known kernel bug with some denial
of service potential but so far nobody came up with a fix that wouldn't
create memory corruption bugs.

That's all I can tell you without seeing the actual test output.

-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
