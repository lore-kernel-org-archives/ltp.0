From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 7 Jan 2019 14:30:56 +0100
Subject: [LTP] [PATCH 2/2] lib/tst_test.c: Restrict that tst_brk() only
 works with TBROK/TCONF
In-Reply-To: <5C10B56B.9030809@cn.fujitsu.com>
References: <1541681733-18845-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1541681733-18845-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <60497535.71361444.1541699583188.JavaMail.zimbra@redhat.com>
 <5BE4F51E.3060900@cn.fujitsu.com>
 <1919219905.71573908.1541750091092.JavaMail.zimbra@redhat.com>
 <5BE542AD.4060207@cn.fujitsu.com>
 <1931132489.71956282.1541785920854.JavaMail.zimbra@redhat.com>
 <5BE8E59B.2020703@cn.fujitsu.com> <20181211151733.GC1180@rei>
 <5C10B56B.9030809@cn.fujitsu.com>
Message-ID: <20190107133056.GA15221@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Also I'm not sure if we want to convert TFAIL to TWARN inside of test
> > cleanup. And even if we wanted that change it should most likely go in
> > in a separate patch.
> Why do we need to convert TBROK to TWARN in test cleanup?  Your fix 
> patch(commit 6440c5d)
> has avoided the Infinite loop in test cleanup, so can we just keep the 
> actual result by removing
> the existed conversion?

That is just to be backward compatible with the conventions we used to
have before we allowed for SAFE_MACROS() to be used in cleanups. Before
that most of the tests were coded so that failure in cleanup produced a
warning.

-- 
Cyril Hrubis
chrubis@suse.cz
