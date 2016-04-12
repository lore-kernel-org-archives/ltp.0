From: Cyril Hrubis <chrubis@suse.cz>
Date: Tue, 12 Apr 2016 17:58:52 +0200
Subject: [LTP] [PATCH-v2] getrusage03: check available memory and move
 initial allocation out test loop
In-Reply-To: <1460023301-25626-1-git-send-email-jcsistemas2001@gmail.com>
References: <1460023301-25626-1-git-send-email-jcsistemas2001@gmail.com>
Message-ID: <20160412155852.GC2917@rei.suse.cz>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> +	tst_resm(TINFO, "Available memory: %ldMB\n", get_available_memory_mb());
                                                 ^
				The tst_resm() and tst_brkm() functions
				adds newline at the end of output
				automatically. The '\n' here would
				produce empty lines in output.


-- 
Cyril Hrubis
chrubis@suse.cz
