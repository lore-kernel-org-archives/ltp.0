From: Cyril Hrubis <chrubis@suse.cz>
Date: Wed, 25 Oct 2017 10:49:41 +0200
Subject: [LTP] [PATCH 3/3] kmsg01: use lower timeout for
	test_read_block()
In-Reply-To: <2b7d8d133fa22483ab594e31aa4e3b6454eea04f.1508760897.git.jstancek@redhat.com>
References: <0994c420a161f2bf97de060396abd915502fca4f.1508760897.git.jstancek@redhat.com>
 <2b7d8d133fa22483ab594e31aa4e3b6454eea04f.1508760897.git.jstancek@redhat.com>
Message-ID: <20171025084941.GB5969@rei>
List-Id: <ltp.lists.linux.it>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: ltp@lists.linux.it

Hi!
> Test is currently expecting that read will block for ~5 seconds.
> This is a problem for busy systems, where there are many messages
> periodically generated. One example is ie31200_edac module,
> which periodically generates a message every second on debug
> kernels.

Sounds reasonable to me. Consider the whole patchset acked.

-- 
Cyril Hrubis
chrubis@suse.cz
