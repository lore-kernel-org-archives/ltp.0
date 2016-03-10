From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 10 Mar 2016 17:57:21 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <20160303140054.GB3055@rei.lan>
References: <20160105111136.GA32659@rei.lan> <20160216211958.GC2515@rei.lan>
 <1799339064.21851637.1455719961718.JavaMail.zimbra@redhat.com>
 <20160217155406.GA12574@rei>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
 <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan>
Message-ID: <20160310165721.GA6142@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Up to date version is at usuall place:

https://github.com/metan-ucw/ltp


Changes are:

* Now we use env variable for SHM path

  - I was thinking about setting it to the /proc path if proc is mounted
    but that way we would have to keep the fd open (and it would occupy
    fd=3) and I think that the less resources the library occupy the
    better

* The rest of the default test options -I and -C are now working

* I've given up on SAFE_MACROS in cleaup for now

  - We may add them later, but I would like to get this merged ideally
    before we do another release and doing this would take some time

* All relevant parts of test-writing-guidelines should be now rewritten

  - There are couple of functions that still take cleanup as fist
    parameter and that are not exported to the new library but that
    should be all that is missing


Anything else that should be done before we can merge it?

-- 
Cyril Hrubis
chrubis@suse.cz
