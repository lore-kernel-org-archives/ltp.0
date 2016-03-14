From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 14 Mar 2016 17:40:23 +0100
Subject: [LTP] Test library API changes
In-Reply-To: <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
References: <20160105111136.GA32659@rei.lan>
 <1752902661.22105327.1455786359593.JavaMail.zimbra@redhat.com>
 <20160218110752.GB19157@rei.lan>
 <1610317133.22142649.1455794774969.JavaMail.zimbra@redhat.com>
 <20160302144421.GC25763@rei>
 <322891927.4705109.1457010820487.JavaMail.zimbra@redhat.com>
 <20160303140054.GB3055@rei.lan> <20160310165721.GA6142@rei>
 <1172303351.8592023.1457704628083.JavaMail.zimbra@redhat.com>
Message-ID: <20160314164023.GA3364@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > * I've given up on SAFE_MACROS in cleaup for now
> > 
> >   - We may add them later, but I would like to get this merged ideally
> >     before we do another release and doing this would take some time
> 
> I think we have this problem already. tst_brk() will call tst_vbrk_(),
> which calls cleanup_ipc(), which is using SAFE_* macros. It looks like
> we'll get infinite loop if any of those fail.

This part has been fixed. Now as far as I can see tst_brk() is no longer
called from the test library cleanup code.

-- 
Cyril Hrubis
chrubis@suse.cz
