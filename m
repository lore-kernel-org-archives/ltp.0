From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 17 Mar 2016 17:06:06 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160315092226.GA26279@rei.lan>
References: <20160105111136.GA32659@rei.lan> <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
 <20160314125153.GB600@rei.lan> <20160314160036.GA2511@rei.lan>
 <870463953.9758877.1458032315296.JavaMail.zimbra@redhat.com>
 <20160315092226.GA26279@rei.lan>
Message-ID: <20160317160606.GA31815@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
I've rethinked the thread safety and LTP library and rewrote the
documentation, there are no changes to the library as the ideal place to
deal with thread safety is the user supplied cleanup.

Can you please review:

https://github.com/metan-ucw/ltp/blob/master/doc/test-writing-guidelines.txt#L732

There is also a new test at:

https://github.com/metan-ucw/ltp/blob/master/lib/newlib_tests/test08.c

-- 
Cyril Hrubis
chrubis@suse.cz
