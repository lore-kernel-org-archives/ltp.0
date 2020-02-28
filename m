From: Petr Vorel <pvorel@suse.cz>
Date: Fri, 28 Feb 2020 09:46:41 +0100
Subject: [LTP] [PATCH 1/4] Avoid using tst_res(TBROK)
In-Reply-To: <CAEemH2fQ_oc8iEaKQV9pJgbfeOoq3yT7hqcGCmWK2JwMeRkzCQ@mail.gmail.com>
References: <20200227163922.317-1-pvorel@suse.cz>
 <CAEemH2fQ_oc8iEaKQV9pJgbfeOoq3yT7hqcGCmWK2JwMeRkzCQ@mail.gmail.com>
Message-ID: <20200228084641.GA8041@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> This patch looks good.
Thanks, I'll add your ack.

> But something wrong in patch applying, you probably need to do git rebase:).
>     error: patch failed:
> testcases/kernel/syscalls/gettimeofday/gettimeofday02.c:48
>     error: testcases/kernel/syscalls/gettimeofday/gettimeofday02.c: patch
> does not apply

I've also noticed (my night push conflicted).
I've rebased it in my LTP fork.
https://github.com/pevik/ltp/commits/tst_res-allowed-flags

I didn't want to sent v2 until we agree about docs
(or I could push this rebased one if others ack it).

Kind regards,
Petr
