From: Cyril Hrubis <chrubis@suse.cz>
Date: Thu, 8 Oct 2015 22:25:33 +0200
Subject: [LTP] inotify06 test causing kernel panic
In-Reply-To: <CANKSX+G1QKMqRF8TzSxGQAe=i+VQFAqmL8qpBTdaup1pSzivww@mail.gmail.com>
References: <CANKSX+G1QKMqRF8TzSxGQAe=i+VQFAqmL8qpBTdaup1pSzivww@mail.gmail.com>
Message-ID: <20151008202533.GA11505@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> on latest available LTP release there is one newly added test
> `inotify06 `. Which is causing kernel panic. Is the test targeted to
> >4.0 kernel? Can anyone confirm.

If you look at the test source it clearly says that it's regression test
for a bug in inotify that has been fixed in kernel 4.2 and that older
kernels are buggy and will likely panic.

-- 
Cyril Hrubis
chrubis@suse.cz
