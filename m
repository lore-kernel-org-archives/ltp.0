From: Petr Vorel <pvorel@suse.cz>
Date: Tue, 20 Apr 2021 10:20:20 +0200
Subject: [LTP] [PATCH 1/1] zram01.sh: Skip tmpfs
In-Reply-To: <CAEemH2fD45RCJwKYtrTj7H3vZaBHU=Y2e2zu8V1YepnOKOSC1A@mail.gmail.com>
References: <20210420061759.22457-1-pvorel@suse.cz>
 <CAEemH2fD45RCJwKYtrTj7H3vZaBHU=Y2e2zu8V1YepnOKOSC1A@mail.gmail.com>
Message-ID: <YH6OxLLHL9fGB2wd@pevik>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Hi Petr,

> This patch looks good.

> Reviewed-by: Li Wang <liwang@redhat.com>
Thanks a lot, I'll merge it shortly.

> I am now thinking, does that make sense to add FS skiplist to
> tst_test.sh just like we have done for C lib?
Yes. I was planning to do that since it's needed by more tests.
But I'll merge this to get it fixed now.
Feel free to work on that (just let me know if you do).

Kind regards,
Petr
