From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 1 Jun 2017 10:01:39 +0200
Subject: [LTP] [RFC] [PATCH] syscalls: Add timer measurement library
In-Reply-To: <1567856045.24503314.1496227892308.JavaMail.zimbra@redhat.com>
References: <20170526123354.8564-1-chrubis@suse.cz>
 <775099814.23313843.1496073205696.JavaMail.zimbra@redhat.com>
 <20170530121501.GC24720@rei.lan>
 <502320923.23716336.1496150233908.JavaMail.zimbra@redhat.com>
 <20170531083045.GA2276@rei.lan>
 <1567856045.24503314.1496227892308.JavaMail.zimbra@redhat.com>
Message-ID: <20170601080139.GA4765@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> What if we modified lib/tst_test.c to make calls to timerlib where needed?
> User would just include tst_test.h as before, but instead of test_all
> he sets sampling_func in tst_test struct.

I was trying to avoid that so that we do not overcomplicate the already
complex tst_test.c but the changes does not look that scary at all. I
will try to prepare v2 patch.

-- 
Cyril Hrubis
chrubis@suse.cz
