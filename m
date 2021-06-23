From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 23 Jun 2021 13:18:11 +0200
Subject: [LTP] [PATCH 1/2] syscalls/msgstress03: fix fork failure on
 small memory systems
In-Reply-To: <7e086a3e-afd5-7b54-e04f-2db7893f3778@canonical.com>
References: <20210622111440.74722-1-krzysztof.kozlowski@canonical.com>
 <YNMOr/9X8J3NaAMZ@yuki>
 <7e086a3e-afd5-7b54-e04f-2db7893f3778@canonical.com>
Message-ID: <YNMYc6EiyQrvl7Ss@yuki>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > This is quite generic functionality so we may as well put it into the
> > include/tst_pid.h and lib/tst_pid.c as tst_get_pids_limit().
> 
> Sure, I can move it there.
> 
> > And we do already have tst_get_free_pids_() in there so we can substract
> > that as well if applicable to make it a bit more precise.
> 
> I can just merge the code into tst_get_free_pids_(). It's basically the
> same purpose - how many processes can we have more.

Yes actually that would make a lot of sense.

-- 
Cyril Hrubis
chrubis@suse.cz
