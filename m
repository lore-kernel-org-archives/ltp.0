From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 18 Aug 2020 20:30:19 +0200
Subject: [LTP] [PATCHv2 1/2] lib/tst_kvercmp: Add support to get
 distname for different OS in tst_kvcmp_distname
In-Reply-To: <CAMy_GT9kZbvC9=t9e2J4nrfW+vMHzK-DH2bU3=ZbkJepk4TrEQ@mail.gmail.com>
References: <20200818100422.27775-1-po-hsu.lin@canonical.com>
 <20200818100422.27775-2-po-hsu.lin@canonical.com>
 <20200818152941.GG27964@yuki.lan>
 <CAMy_GT9kZbvC9=t9e2J4nrfW+vMHzK-DH2bU3=ZbkJepk4TrEQ@mail.gmail.com>
Message-ID: <20200818183019.GH27964@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> oh indeed, the delimiter in strtok will become null character anyway.
> I think just tok = distname can do the trick here.
> I will send v3 tomorrow.

I can easily fix that before I push the patch, no need for v3.

-- 
Cyril Hrubis
chrubis@suse.cz
