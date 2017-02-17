From: Richard Palethorpe <rpalethorpe@suse.com>
Date: Fri, 17 Feb 2017 11:36:53 +0100
Subject: [LTP] [PATCH 0/1] uname26 exploit regression test
Message-ID: <20170217113653.595ce1b4@linux-v3j5>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi,

I have essentially rewritten the following expoit to be used in the LTP:
https://www.exploit-db.com/exploits/37937/ (Metan's idea AFAIK). There are
some issues which I came across while doing this, even though it is quite an
easy exploit to recreate.

1) How should we organise the exploit tests? I see Metan has added dirtyc0w
   under that name in its own folder. Not all exploits have a fancy or unique
   name however. I have just named the uname exploit with its CVE name and put
   it in a new uname folder, but I'm not sure that is the best way either.

2) What is the appropriate runtest file for security tests? I think they
   should be separated from functional tests.

3) The exploit code from the link is licensed under GPLv3. Although I rewrote
   the LTP test from scratch, the fact I saw the exploit code raises the
   question of whether my test is a derivative work. The easiest thing to do
   would be to attribute the exploit code author and simply state that the
   test is an adaptation, but then I believe the test would need to be GPLv3.
   Of course, I can just ask the author to relicense the original under GPLv2,
   but lets assume they don't consent or can't be contacted.

4) This is maybe a question for a security/kernel mailing list, but which
   exploits are most likely to be reintroduced to the kernel? I am not sure
   that this exploit is at high risk of being reintroduced. At least not into
   mainline or any of the major distro branches.

Thank you,
Richard.

Richard Palethorpe (1):
  security: Test for uname26 exploit cve-2012-0957

 testcases/kernel/security/uname/.gitignore      |  1 +
 testcases/kernel/security/uname/Makefile        | 20 ++++++
 testcases/kernel/security/uname/cve-2012-0957.c | 86 +++++++++++++++++++++++++
 3 files changed, 107 insertions(+)
 create mode 100644 testcases/kernel/security/uname/.gitignore
 create mode 100644 testcases/kernel/security/uname/Makefile
 create mode 100644 testcases/kernel/security/uname/cve-2012-0957.c

-- 
2.11.0
