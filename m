From: Richard Palethorpe <rpalethorpe@suse.de>
Date: Tue, 12 Sep 2017 11:39:29 +0200
Subject: [LTP] LTP release
In-Reply-To: <20170907105921.GB775@rei.lan>
References: <20170907105921.GB775@rei.lan>
Message-ID: <87vakoz25q.fsf@our.domain.is.not.set>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hello,

Cyril Hrubis writes:

> Hi!
> It's about a time we should start preparing for another release.
>
> As usuall let's start with pointing out patches that should be part of
> it, then we will proceed with freezing the repo and round of pre-release
> testing, etc.
>
> -- 
> Cyril Hrubis
> chrubis@suse.cz

As you might expect, I am very keen to get the long lived thread support
for fuzzy sync into this release:

 tst_atomic: Add load, store and use __atomic builtins   
 tst_atomic: Add atomic store and load tests   
 fzsync: Add long running thread support and deviation stats   
 fzsync: Add functionality test for library   
 Convert cve-2016-7117 test to use long running threads   
 Convert cve-2014-0196 to use long running threads   
 Convert cve-2017-2671 to use long running threads   

Also the following patches would be nice:

 lib: Add personality fallback and SAFE macro   
 CVE-2012-0957: Use SAFE_PERSONALITY   
 Test for CVE-2016-10044 mark AIO pseudo-fs noexec   

 thp01: Find largest arguments size   

 Add test for CVE-2017-7308 on a raw socket's ring buffer   

 madvise07: Increase probability of testing a supported page type   

-- 
Thank you,
Richard.
