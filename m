From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 10 Oct 2018 14:06:44 +0200
Subject: [LTP] [PATCH] futex/futex_wake04.c: fix issues with hugepages
 and usleep
In-Reply-To: <74eefcb6-34d2-46e6-8611-0dbdc4cd3ed9@linaro.org>
References: <6903290a-523f-7130-b64f-d1a73b601c38@linaro.org>
 <20181009210602.23261-1-rafael.tinoco@linaro.org>
 <20181010104317.GB1990@rei>
 <74eefcb6-34d2-46e6-8611-0dbdc4cd3ed9@linaro.org>
Message-ID: <20181010120644.GB1093@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Can you please split this into separate patches? Generally it's
> > considered a good practice to split unrelated changes like these.
> 
> Yes, will do. Ignore my last sentence in the other e-mail on the same 
> thread (about this patch). Will post 2 patches "v2".

There were some minor comments, if you agree with them I can amend the
patches you send before pushing them...

-- 
Cyril Hrubis
chrubis@suse.cz
