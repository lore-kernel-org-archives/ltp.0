From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 4 Jun 2018 13:40:39 +0200
Subject: [LTP] [PATCH] pty/pty02: new test for hang involving
 EXTPROC|ICANON	terminal mode
In-Reply-To: <793542157.23379871.1527773742485.JavaMail.zimbra@redhat.com>
References: <20180513000101.13027-1-ebiggers3@gmail.com>
 <793542157.23379871.1527773742485.JavaMail.zimbra@redhat.com>
Message-ID: <20180604114039.GB3362@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I'm running into compilation errors on older distros (RHEL5/6)
> with this test:
> 
> pty02.c: In function ???do_test???:
> pty02.c:34: error: ???EXTPROC??? undeclared (first use in this function)
> pty02.c:34: error: (Each undeclared identifier is reported only once
> pty02.c:34: error: for each function it appears in.)
> make: *** [pty02] Error 1
> 
> We should probably ifdef the test, because adding define to LAPI
> still makes it fail:
> 
> tst_test.c:1015: INFO: Timeout per run is 0h 05m 00s
> pty02.c:44: BROK: tcsetattr() failed: EINVAL

Or we can return TCONF on EINVAL since EINVAL means unsupported value
anyway...

-- 
Cyril Hrubis
chrubis@suse.cz
