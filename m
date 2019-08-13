From: Li Wang <liwang@redhat.com>
Date: Tue, 13 Aug 2019 17:53:47 +0800
Subject: [LTP] [PATCH v2 00/11] Introduce guarded buffers
In-Reply-To: <20190812143941.8119-1-chrubis@suse.cz>
References: <20190812143941.8119-1-chrubis@suse.cz>
Message-ID: <CAEemH2daVNZM+Jf2+vooouRFfSpjWTgfT9+KneAikE5ncLys_A@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi Cyril,

I helped to compile & run the whole patch v2 on some platforms[1], the
test result looks pretty good.

Just a tiny issue was found in test_guarded_buf.c, since the .bufs
does not ending with a {}, so sometimes it gets segmental fault from:
        $ cat tst_buffers.c  -n
        115 for (i = 0; bufs[i].ptr; i++) {

And I will keep going to review the patchset in the next few days.
Will let you know if I can find more issues.

[1] (x86_64 + kernel-5.3.0-rc3), (aarch64 + kernel-4.18.0),
(rassberryPi + 4.14.78)

-- 
Regards,
Li Wang
