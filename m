From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 3 Jun 2021 13:05:02 +0200
Subject: [LTP] [RFC] Reduce LICENCE/COPYING files
In-Reply-To: <YLeA8KOphpVg3IDP@pevik>
References: <YLeA8KOphpVg3IDP@pevik>
Message-ID: <YLi3XqA3hLh7HWqn@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I suppose it's safe to keep only single licence in testcases/open_posix_testsuite/,
> but could we keep only COPYING in the root directory and delete the rest?
> Or keep COPYING and testcases/open_posix_testsuite/COPYING only?

Do we even need these files? Isn't SPDX identifier enough these days?

-- 
Cyril Hrubis
chrubis@suse.cz
