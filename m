From: Tommi Rantala <tt.rantala@gmail.com>
Date: Wed, 30 Jan 2019 18:22:57 +0200
Subject: [LTP] [PATCH] syscalls/setrlimit03.c: read /proc/sys/fs/nr_open
 for RLIMIT_NOFILE limit
In-Reply-To: <20190130161514.GA27751@rei>
References: <20190130150047.26307-1-tt.rantala@gmail.com>
 <20190130161514.GA27751@rei>
Message-ID: <CA+ydwtotsfNpF=g5mAiidFqr_5fc3xatOCf-B_FYs6WAt1OapA@mail.gmail.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

ke 30. tammik. 2019 klo 18.15 Cyril Hrubis (chrubis@suse.cz) kirjoitti:
> >  static void setup(void)
> >  {
> > +     if (tst_kvercmp(2, 6, 25) < 0) {
> > +             nr_open = NR_OPEN;
> > +     } else {
> > +             SAFE_FILE_SCANF("/proc/sys/fs/nr_open", "%u", &nr_open);
> > +     }
>
> Can we do here without the explicit kernel version check?
>
> What about:
>
> #define NR_OPEN_PATH "/proc/sys/fs/nr_open"
>
> ...
>
>         if (acess(NR_OPEN_PATH, F_OK))
>                 SAFE_FILE_SCANF(NR_OPEN_APTH, "%u", &nr_open);

Alright, that should work too. I'll send patch v2 tomorrow.

-Tommi
