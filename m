From: Petr Vorel <pvorel@suse.cz>
Date: Mon, 30 Mar 2020 14:37:26 +0200
Subject: [LTP] [PATCH 2/6] Use .needs_cmds
In-Reply-To: <CAEemH2c6UKHipLfc0XXH-QaAx3pVeuqnR+HoUW6hasN8mLmghw@mail.gmail.com>
References: <20200327213924.18816-1-pvorel@suse.cz>
 <20200327213924.18816-3-pvorel@suse.cz>
 <20200330113111.GD9845@yuki.lan> <20200330114838.GB23915@dell5510>
 <CAEemH2c6UKHipLfc0XXH-QaAx3pVeuqnR+HoUW6hasN8mLmghw@mail.gmail.com>
Message-ID: <20200330123726.GE23915@dell5510>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Li,

> Thanks Petr, there is still a tiny place need fix.
> Hope you can help to correct the description in the next round patch
> merging.
You were right, I pushed this before. I'm sorry, fixed now.

> +       /* NULL terminated array of required binaries */
> +       const char *const *needs_cmds;

Kind regards,
Petr
