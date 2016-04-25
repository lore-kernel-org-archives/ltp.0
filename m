From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 25 Apr 2016 15:04:03 +0200
Subject: [LTP] Issue with the reporting of failed tests
In-Reply-To: <571E0226.3020104@free.fr>
References: <5718D4CA.5010607@free.fr> <5718E81B.6060101@free.fr>
 <20160421153041.GA25307@rei> <5718F4EE.2060009@free.fr>
 <571907A2.10208@free.fr> <571A274A.60707@free.fr>
 <571DCF8D.30306@free.fr> <571E0226.3020104@free.fr>
Message-ID: <20160425130403.GA20158@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I do see an improvement now: no more duplicates. However, it seems
> 2 tests are missing from result-failed: aio01, aio02.

I've tested that fflush(NULL) is enough to fix this and pushed patch
with just that. Thanks.

-- 
Cyril Hrubis
chrubis@suse.cz
