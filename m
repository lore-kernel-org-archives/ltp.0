From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 14 Jun 2017 15:49:39 +0200
Subject: [LTP] [PATCH] dio: reduce the number of cycles
In-Reply-To: <20170614111610.GC17436@eguan.usersys.redhat.com>
References: <20170614033830.12736-1-liwang@redhat.com>
 <20170614111610.GC17436@eguan.usersys.redhat.com>
Message-ID: <20170614134939.GB7604@rei.suse.de>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> I tested diotest30 with 100 iterations and it still could reproduce the
> bug I was seeing on 4.10 kernel quite reliably (even if not 100%), so
> 
> Acked-by: Eryu Guan <eguan@redhat.com>

What's the reliability after the patch btw? What is the actual
percentage of undetected failures for at least 10 runs of the test?

-- 
Cyril Hrubis
chrubis@suse.cz
