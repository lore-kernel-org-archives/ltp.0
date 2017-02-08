From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 8 Feb 2017 15:12:51 +0100
Subject: [LTP] [PATCH v2] getrandom02: relax check for returned data
In-Reply-To: <886b49c2db9b9b6f65f7d92a2e91dbf3943e9607.1486562481.git.jstancek@redhat.com>
References: <886b49c2db9b9b6f65f7d92a2e91dbf3943e9607.1486562481.git.jstancek@redhat.com>
Message-ID: <20170208141250.GE16139@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> "nb * 0.1" can easily fail for nb < 20, since all we need
> are 2 identical bytes. Worst case (nb == 19) is almost
> identical to "birthday problem", but with smaller pool.
> Chance of hitting 2 identical bytes in pool of 19
> is close to 50%.
> 
> Adjust formula to allow small repetitions in small pools.
> Chance we fail now should be pretty unlikely, ~10^-16.
> 
> Signed-off-by: Jan Stancek <jstancek@redhat.com>

Acked.

-- 
Cyril Hrubis
chrubis@suse.cz
