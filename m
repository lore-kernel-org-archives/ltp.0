From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 20 Jul 2016 17:00:05 +0200
Subject: [LTP] [PATCH v2 2/2] syscalls/perf_event_open{01,
 02}: Reduce size of idle loop
In-Reply-To: <1468947264-5812-2-git-send-email-yuriy.kolerov@synopsys.com>
References: <1468947264-5812-1-git-send-email-yuriy.kolerov@synopsys.com>
 <1468947264-5812-2-git-send-email-yuriy.kolerov@synopsys.com>
Message-ID: <20160720150005.GA2221@rei.scz.novell.com>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
Both pushed, thanks.

FYI: I'm getting a rare failures for perf_event_open02 on Linux 4.6.3 on
     Core i3 (ratio is a bit higher than the test expects it to be) but
     that is regradless of this patch and looks like the number of iterations
     does not play any role in this. I will have to look closer at this
     later.

-- 
Cyril Hrubis
chrubis@suse.cz
