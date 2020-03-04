From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 4 Mar 2020 17:04:54 +0100
Subject: [LTP] [PATCH 1/2] lib: Add safe timerfd macros
In-Reply-To: <20200304160330.GA7516@rei>
References: <20200304151201.19117-1-pvorel@suse.cz>
 <b42e93cb-b06d-538c-a5ff-1d110ed8ce74@suse.cz>
 <20200304160330.GA7516@rei>
Message-ID: <20200304160454.GB7516@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Don't forget to clear errno when you're not using the TEST() macro.
> 
> Hmm, I'm not sure how useful is this. Generally the syscalls in libc
> have single macro definition that is used everywhere to copy the error
> from the errno variable. If that piece of code is buggy half of the test
 ^
 to the

-- 
Cyril Hrubis
chrubis@suse.cz
