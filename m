From: Cyril Hrubis <chrubis@suse.cz>
Date: Mon, 8 Feb 2021 16:30:15 +0100
Subject: [LTP] [PATCH v2 1/5] tst_mallinfo.c: Add a common print helper
 for mallinfo
In-Reply-To: <CAEemH2dwK-mabPKHKboFePgrABHDNe35XD-8ed4cjgp3yr7cLg@mail.gmail.com>
References: <CAEemH2eiTY7YgSYLr6_skK6PaRZb2_GchbmHUJKVuW7btA15rQ@mail.gmail.com>
 <1612440762-22389-1-git-send-email-xuyang2018.jy@cn.fujitsu.com>
 <CAEemH2f_mvjt4couA++RcOf9bAMO8fnqapkgG59Qvs9Ud-2SHw@mail.gmail.com>
 <601CF76D.8020705@cn.fujitsu.com>
 <CAEemH2dwK-mabPKHKboFePgrABHDNe35XD-8ed4cjgp3yr7cLg@mail.gmail.com>
Message-ID: <YCFZB1/VMSsfxyPA@yuki.lan>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> > Just want to avoid random makefile. I am not sure which way is better.
> > Let's listen advise from other maintainers.

Given that its only one single function I would just put it into a
header as a static inline function.

Also mallopt is glibc specific so I guess that it makes sense to keep it
in a separate header.

-- 
Cyril Hrubis
chrubis@suse.cz
