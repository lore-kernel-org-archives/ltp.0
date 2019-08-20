From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 20 Aug 2019 13:23:40 +0200
Subject: [LTP] [PATCH v2 00/11] Introduce guarded buffers
In-Reply-To: <CAEemH2daVNZM+Jf2+vooouRFfSpjWTgfT9+KneAikE5ncLys_A@mail.gmail.com>
References: <20190812143941.8119-1-chrubis@suse.cz>
 <CAEemH2daVNZM+Jf2+vooouRFfSpjWTgfT9+KneAikE5ncLys_A@mail.gmail.com>
Message-ID: <20190820112340.GA23164@rei.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I helped to compile & run the whole patch v2 on some platforms[1], the
> test result looks pretty good.
> 
> Just a tiny issue was found in test_guarded_buf.c, since the .bufs
> does not ending with a {}, so sometimes it gets segmental fault from:
>         $ cat tst_buffers.c  -n
>         115 for (i = 0; bufs[i].ptr; i++) {
> 
> And I will keep going to review the patchset in the next few days.
> Will let you know if I can find more issues.

Have you found anything else or can I push the patchset?

-- 
Cyril Hrubis
chrubis@suse.cz
