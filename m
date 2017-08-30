From: Petr Vorel <pvorel@suse.cz>
Date: Wed, 30 Aug 2017 14:37:29 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/mbind: cleanup and rewrite
 mbind01 into new API
In-Reply-To: <4aff45ce-f45f-147d-e9c2-80eca59d74ec@redhat.com>
References: <20170829153509.12613-1-pvorel@suse.cz>
 <20170829153509.12613-2-pvorel@suse.cz>
 <4aff45ce-f45f-147d-e9c2-80eca59d74ec@redhat.com>
Message-ID: <20170830123729.txs276jj5aus7qne@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Jan,

thanks for your review.

> I suggest changes below on top of your v2:
> - drop HAVE_LINUX_MEMPOLICY_H, as it's not used by test
> - replace no_check_nodemask with "expected nodemask",

> - drop zero-ing of "nodemask" for MPOL_DEFAULT case, it's not needed anymore
I'm ok with all but this one. It's needed for a first case (POLICY_DESC(MPOL_DEFAULT),),
no mater whether it's first or not. So I didn't put expected_nodemask to it in my v3. Or
am I'm missing something.

> - add "static" to global variables/functions
> - print masks if comparison fails (tst_res_hexd)
> - collapse no numa and numa == v1 into single main() function


> No need to re-post if you are OK with the changes.
I understand this as you've already prepared your changes. In that case push it. Otherwise
I've got v3 which I can post.


Kind regards,
Petr
