From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 11 Dec 2018 16:17:34 +0100
Subject: [LTP] [PATCH 2/2] lib/tst_test.c: Restrict that tst_brk() only
 works with TBROK/TCONF
In-Reply-To: <5BE8E59B.2020703@cn.fujitsu.com>
References: <1541681733-18845-1-git-send-email-yangx.jy@cn.fujitsu.com>
 <1541681733-18845-2-git-send-email-yangx.jy@cn.fujitsu.com>
 <60497535.71361444.1541699583188.JavaMail.zimbra@redhat.com>
 <5BE4F51E.3060900@cn.fujitsu.com>
 <1919219905.71573908.1541750091092.JavaMail.zimbra@redhat.com>
 <5BE542AD.4060207@cn.fujitsu.com>
 <1931132489.71956282.1541785920854.JavaMail.zimbra@redhat.com>
 <5BE8E59B.2020703@cn.fujitsu.com>
Message-ID: <20181211151733.GC1180@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> You are right, and i will send a v3 patch as you suggested.

Are you going to send v3?

I think that we really should increase counters on tst_brk(), that was
an oversight when I designed the library.

However summing up TBROK and TFAIL under results->failed does not look
right to me.

Also I'm not sure if we want to convert TFAIL to TWARN inside of test
cleanup. And even if we wanted that change it should most likely go in
in a separate patch.

-- 
Cyril Hrubis
chrubis@suse.cz
